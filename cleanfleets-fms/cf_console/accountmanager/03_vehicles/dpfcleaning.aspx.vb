﻿Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports System.Data.OleDb
Imports Telerik.Web.UI
Imports System.IO
Imports System.Collections.Generic
Imports System.Threading
Imports Ionic.Zip
Imports Inspironix
Imports Inspironix.DB
Imports System.Globalization
Imports System.Text
Imports System.Drawing
Imports System.Web.Configuration
Imports WebSupergoo.ABCpdf11
Imports WebSupergoo.ABCpdf11.Operations
Imports WebSupergoo.ABCpdf11.Objects 'Added this Imports line on 9/19/2019
Public Class dpfcleaning
    Inherits BaseWebForm

    Dim InsertAccountCount As Integer
    Dim InsertTerminalCount As Integer
    Dim InsertOpacityTestsCount As Integer
    Dim UpdateOpacityTestsCount As Integer
    Dim InsertMileageLogCount As Integer
    Dim UpdateMileageLogCount As Integer
    Dim hasErrors As Boolean = False
    Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
    Dim FileRepositoryFolder As String = WebConfigurationManager.AppSettings("FileRepositoryFolder")
    Dim TempFileRepositoryFolder As String = "~/includes/filemanager/temp/"
    Const TEMP_FOLDER As String = "~/cf_console/accountmanager/temp/"
    Const SIGPATH As String = "~/signatures/"

    ' opacitytestsimport_PreRender
    Private Sub opacitytestsimport_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        dvImportFile.Visible = Not hasErrors
    End Sub

    Protected Property myDataTable As DataTable
        Get
            Return ViewState("myDataTable")
        End Get
        Set(value As DataTable)
            ViewState("myDataTable") = value
        End Set
    End Property

    Protected Property EditingRecord As Integer
        Get
            Return ViewState("EditingRecord")
        End Get
        Set(value As Integer)
            ViewState("EditingRecord") = value
        End Set
    End Property

    ' gv_Text_RowDataBound
    Protected Sub gv_Text_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim OpacityTestsImportStatus As String = DataBinder.Eval(e.Row.DataItem, "OpacityTestsImportStatus")

            Select Case OpacityTestsImportStatus
                Case "pending"
                    e.Row.BackColor = Drawing.Color.Yellow
                Case "error"
                    e.Row.BackColor = Drawing.Color.IndianRed
                Case Else
                    'e.Row.Visible = False
            End Select

            Dim Account As String = CInt(DataBinder.Eval(e.Row.DataItem, "IDProfileAccount"))
            Dim Terminal As String = CInt(DataBinder.Eval(e.Row.DataItem, "IDProfileTerminal"))
            Dim Vehicle As Guid = Guid.Empty
            Dim VehicleGuidStr As String = DataBinder.Eval(e.Row.DataItem, "IDVehicles").ToString()

            If Guid.TryParse(VehicleGuidStr, Vehicle) = False Then
                'throw new FormatException(VehicleGuidStr)
            End If

            Dim IDSignature As New Guid(DataBinder.Eval(e.Row.DataItem, "IDSignature").ToString())

            If Not hasErrors Then
                e.Row.FindControl("btnSelectAccount").Visible = False
                e.Row.FindControl("btnSelectTerminal").Visible = False
                e.Row.FindControl("btnSelectUnit").Visible = False
                e.Row.FindControl("btnSelectSignature").Visible = False
            ElseIf Account <= 0 Then
                e.Row.FindControl("btnSelectAccount").Visible = True
                e.Row.FindControl("btnSelectTerminal").Visible = False
                e.Row.FindControl("btnSelectUnit").Visible = False
                e.Row.FindControl("btnSelectSignature").Visible = False
            ElseIf Terminal <= 0 Then
                e.Row.FindControl("btnSelectAccount").Visible = False
                e.Row.FindControl("btnSelectTerminal").Visible = True
                e.Row.FindControl("btnSelectUnit").Visible = False
                e.Row.FindControl("btnSelectSignature").Visible = False
            ElseIf IDSignature = Guid.Empty Then
                e.Row.FindControl("btnSelectAccount").Visible = False
                e.Row.FindControl("btnSelectTerminal").Visible = False
                e.Row.FindControl("btnSelectUnit").Visible = False
                e.Row.FindControl("btnSelectSignature").Visible = True
            ElseIf Vehicle = Guid.Empty Then
                e.Row.FindControl("btnSelectAccount").Visible = False
                e.Row.FindControl("btnSelectTerminal").Visible = False
                e.Row.FindControl("btnSelectUnit").Visible = True
                e.Row.FindControl("btnSelectSignature").Visible = False
                CType(e.Row.FindControl("btnSelectUnit"), Button).Text = "Select Unit"
            ElseIf Vehicle <> Guid.Empty Then
                e.Row.FindControl("btnSelectAccount").Visible = False
                e.Row.FindControl("btnSelectTerminal").Visible = False
                e.Row.FindControl("btnSelectUnit").Visible = True
                e.Row.FindControl("btnSelectSignature").Visible = False
                CType(e.Row.FindControl("btnSelectUnit"), Button).Text = "Change Unit"
            End If
        End If
    End Sub

    ' btnImport_Click
    Protected Sub btnImport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnImport.Click
        Dim filespec1 As String = ""
        Dim AttachOptionStr As String = ""
        Dim AttachOption As Boolean = True

        If Page.IsValid Then
            Messages.Text = ""
            If Not Directory.Exists(Server.MapPath(TEMP_FOLDER)) Then
                Directory.CreateDirectory(Server.MapPath(TEMP_FOLDER))
            End If

            filespec1 = Path.Combine(Server.MapPath(TEMP_FOLDER), Membership.GetUser().UserName.ToLower() & "_DPFCleaningRecordImport" & Path.GetExtension(fu_ImportFile.FileName))
            fu_ImportFile.SaveAs(filespec1)

            AttachOptionStr = rbl_AttachToDBRecord.SelectedValue

            If AttachOptionStr > "" Then
                AttachOption = (AttachOptionStr = "1")
            End If

            importOpacityTests(filespec1, AttachOption)

            'If Not hasErrors Then
            '	Messages.Text &= String.Format("Created {0} new Opacity Tests.<br />Updated {1} Opacity Tests<br />", InsertOpacityTestsCount, UpdateOpacityTestsCount)
            'Else
            '	Messages.Text = "Records could not be imported. Please fix all issues before completing.<br />"
            '	Messages.Text &= "Records with one of these missing values have been highlighted in red and were not imported.<br /><br />"
            '	Messages.Text &= "Records highlighted in yellow are pending.<br />"
            '	Messages.Text &= "Records highlighted in red have one or more problems.<br />"
            'End If
        End If
    End Sub

    ' btnPDFReport_Click
    Protected Sub btnPDFReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPDFReport.Click
        Response.Redirect(ViewState("PDFReportPath"))
    End Sub

    Protected Sub importOpacityTests(ByVal TXTFileSpec As String, ByVal AttachToDBRecord As Boolean)
        Dim ScannerName As String = ""
        Dim myDataSet As New DataSet()
        'Dim col As DataColumn  --WARNINGS commented out by due to not being used Sam 2/20
        'Dim Contents As String  --WARNINGS commented out by due to not being used Sam 2/20

        ' Added by Andrew on 9/3/2019.

        Dim theSrc As String = TXTFileSpec
        Dim theDst As String = ""

        ' End of what was Added by Andrew on 9/3/2019.

        ' Verify the file is legit
        If Path.GetExtension(TXTFileSpec).ToLower() <> ".pdf" Then
            Throw New ArgumentException("Unrecognized file type.")
        End If

        If Not File.Exists(TXTFileSpec) Then
            Throw New ArgumentException("File does not exist.")
        End If

        ' Read from the file
        'Contents = File.ReadAllText(TXTFileSpec)

        ' Added by Andrew on 9/3/2019.

        Using theDoc As New Doc()

            ' Dim rect As XRect = New XRect() Added this line On 9/10/2019.
            ' rect.String = "10 10 200 100" Added this line On 9/10/2019.

            'Dim Rects_String_Array As String()
            'Dim See_Rect_String As String

            theDoc.Read(theSrc)

            Dim thisForm As XForm
            Dim theField As Field
            Dim theFieldString As String
            Dim FieldNamesArray() As String
            Dim CombinedFieldNames As String
            Dim theFieldValue As String
            Dim CombinedFieldValues As String

            CombinedFieldNames = ""
            CombinedFieldValues = ""
            thisForm = theDoc.Form

            FieldNamesArray = thisForm.GetFieldNames()

            Dim PDF_Field_Names() As String
            PDF_Field_Names = {"MultipleCleanings", "DocCleaned", "EnterDate", "InvoiceNumber", "PONumber", "Company", "VINNumber", "Make", "Model", "Plate", "Miles", "Hours", "FilterMake", "SerialNumber", "Substrate", "PartNumber", "WTResults", "CleaningTech", "Notes", "Condition", "DPFInitWeight", "DPFFinalWeight", "DPFWeightDiff", "DOCInitWeight", "DOCFinalWeight", "DOCWeightDiff", "DPFInitFR", "DPFFinalFR", "DPFFRDiff"}

            Dim j As Integer
            j = 0

            Dim DPF_Dictionary As New Dictionary(Of String, String)()

            For Each theFieldString In FieldNamesArray

                theField = thisForm.Item(theFieldString)
                theFieldValue = theField.Value

                DPF_Dictionary.Add(PDF_Field_Names(j), theFieldValue)

                j = j + 1

            Next

            'CombinedFieldNames = CombinedFieldNames & ", " & theFieldString
            'CombinedFieldValues = CombinedFieldValues & ", " & theFieldValue

            'viewtextvariable_theField.Visible = True
            'viewtextvariable_theField.InnerHtml = CombinedFieldNames

            'viewtextvariable_theFieldValues.Visible = True
            'viewtextvariable_theFieldValues.InnerHtml = CombinedFieldValues

            'Dim DPF_Dictionary As New Dictionary(Of String, String)()
            'Dim FieldValueVar As String

            'theField = thisForm.Item("Date")
            'theFieldValue = theField.Value
            'DPF_Dictionary.Add("Date", theFieldValue)
            'FieldValueVar = DPF_Dictionary.Item("Date")
            'viewtextvariable_theField.Visible = True
            'viewtextvariable_theField.InnerHtml = FieldValueVar

            'theField = thisForm.Item("Date 2")
            'theFieldValue = theField.Value
            'DPF_Dictionary.Add("WO#", theFieldValue)

            'theField = thisForm.Item("Date 3")
            'theFieldValue = theField.Value
            'DPF_Dictionary.Add("Company", theFieldValue)

            'theField = thisForm.Item("Date 6")
            'theFieldValue = theField.Value
            'DPF_Dictionary.Add("VIN/UNIT#", theFieldValue)

            'theField = thisForm.Item("Date 7")
            'theFieldValue = theField.Value
            'DPF_Dictionary.Add("Make", theFieldValue)

            'theField = thisForm.Item("Date 8")
            'theFieldValue = theField.Value
            'DPF_Dictionary.Add("Model", theFieldValue)

            'FieldValueVar = DPF_Dictionary.Item("Cleaning_Date")

            'viewtextvariable_theFieldValues.Visible = True
            'viewtextvariable_theFieldValues.InnerHtml = "Cleaning Date: " & FieldValueVar

            'viewtextvariable_theFieldValues.Visible = True
            'viewtextvariable_theFieldValues.InnerHtml = FieldValueVar

            'Dim pair_string As String
            'pair_string = ""

            'For Each pair As KeyValuePair(Of String, String) In DPF_Dictionary

            '    pair_string = pair_string & ", " & pair.Key & ": " & pair.Value

            'Next

            'viewtextvariable_theFieldValues.Visible = True
            'viewtextvariable_theFieldValues.InnerHtml = pair_string

            'viewtextvariable_theField.Visible = True
            'viewtextvariable_theField.InnerHtml = DPF_Dictionary("")

            Dim connection_string As String

            ' Making changes to CleanFleets for database from 
            'in preparation for a migration from DEV to Production; Andrew - 12/10/2019.
            'Push made and reverting back; Andrew - 12/10/2019.

            connection_string = ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString

            Dim DPF_conn As New SqlConnection(connection_string)

            If DPF_conn.State = ConnectionState.Closed Then

                DPF_conn.Open()

            End If

            Dim pre_comm_field_name_string As String
            pre_comm_field_name_string = ""

            For Each pair As KeyValuePair(Of String, String) In DPF_Dictionary

                pre_comm_field_name_string = pre_comm_field_name_string & ", " & pair.Key

            Next

            Dim comm_field_name_string() As String
            comm_field_name_string = Split(pre_comm_field_name_string, ", ", 2)

            Dim final_comm_field_name_string As String
            final_comm_field_name_string = comm_field_name_string(1)

            Dim combined_comm_string As String

            'Changing the table from CF_DPF_Final to CF_DPF_Final_Final due to their being an existing CF_DPF_Final table in CleanFleets that
            'was not editable. This is for the purpose of moving from development to production; Andrew - 12/10/2019.
            'Push made and reverting back; Andrew - 12/10/2019.

            combined_comm_string = "DECLARE @UNIQUEID UNIQUEIDENTIFIER" & " SET @UNIQUEID = NEWID() " & "INSERT INTO CF_DPF_Final (IDDPF, " & final_comm_field_name_string & ") VALUES(@UNIQUEID, "


            Dim pre_comm_field_value_string As String
            pre_comm_field_value_string = ""

            For Each pair As KeyValuePair(Of String, String) In DPF_Dictionary

                pre_comm_field_value_string = pre_comm_field_value_string & ", @" & pair.Key

            Next

            Dim comm_field_value_string() As String
            comm_field_value_string = Split(pre_comm_field_value_string, ", ", 2)

            Dim final_comm_field_value_string As String
            final_comm_field_value_string = comm_field_value_string(1)


            Dim complete_comm_string As String
            complete_comm_string = combined_comm_string & final_comm_field_value_string & ")"

            'viewtextvariable_theField.Visible = True
            'viewtextvariable_theField.InnerHtml = complete_comm_string

            Dim DPF_comm As SqlCommand

            'DPF_comm = New SqlCommand("DECLARE @UNIQUEID UNIQUEIDENTIFIER" & " SET @UNIQUEID = NEWID() " & "INSERT INTO CF_DPF_Final (IDDPF, VINNumber, Plate) " & "VALUES(@UNIQUEID, @VINNumber, @Plate)", DPF_conn)

            'For Each pair As KeyValuePair(Of String, String) In DPF_Dictionary

            '    Dim temp_field_name_string As String
            '    temp_field_name_string = pair.Key

            '    Dim temp_field_value_string As String
            '    temp_field_value_string = pair.Value

            '    If (temp_field_name_string = "EnterDate" Or temp_field_name_string = "ModifiedDate") Then

            '        Dim temp_date_split() As String
            '        temp_date_split = Split(temp_field_value_string, "/")

            '        For i = 1 To UBound(temp_date_split)

            '            If (Len(temp_date_split(i - 1)) < 2) Then

            '                temp_date_split(i - 1) = "0" & temp_date_split(i - 1)

            '            End If

            '        Next

            '        temp_field_value_string = temp_date_split(2) & "-" & temp_date_split(1) & "-" & temp_date_split(0)
            '        DPF_comm.Parameters.Add("@" & temp_field_name_string, SqlDbType.DateTime)
            '        DPF_comm.Parameters("@" & temp_field_name_string).Value = temp_field_value_string


            '    ElseIf temp_field_name_string = "InvoiceNumber" Then

            '        Convert.ToInt32(temp_field_value_string)
            '        DPF_comm.Parameters.Add("@" & temp_field_name_string, SqlDbType.Int)
            '        DPF_comm.Parameters("@" & temp_field_name_string).Value = temp_field_value_string


            '    ElseIf temp_field_name_string = "Miles" Or temp_field_name_string = "Hours" Or temp_field_name_string = "SerialNumber" Or temp_field_name_string = "PartNumber" Or temp_field_name_string = "DPFInitWeight" Or temp_field_name_string = "DPFFinalWeight" Or temp_field_name_string = "DPFWeightDiff" Or temp_field_name_string = "DOCInitWeight" Or temp_field_name_string = "DOCFinalWeight" Or temp_field_name_string = "DOCWeightDiff" Then

            '        If InStr(temp_field_value_string, ",") > 0 Then

            '            Dim temp_holder As String
            '            temp_holder = ""

            '            For i = 1 To Len(temp_field_value_string)

            '                If Mid(temp_field_value_string, i, 1) <> "," Then

            '                    temp_holder = temp_holder & Mid(temp_field_value_string, i, 1)

            '                End If

            '            Next

            '            temp_field_value_string = temp_holder
            '            Convert.ToInt32(temp_field_value_string)
            '            DPF_comm.Parameters.Add("@" & temp_field_name_string, SqlDbType.Int)

            '        End If

            '        Convert.ToInt32(temp_field_value_string)
            '        DPF_comm.Parameters.Add("@" & temp_field_name_string, SqlDbType.Int)
            '        DPF_comm.Parameters("@" & temp_field_name_string).Value = temp_field_value_string


            '    ElseIf temp_field_name_string = "DPFInitFR" Or temp_field_name_string = "DPFFinalFR" Or temp_field_name_string = "DPFFRDiff" Then

            '        Dim temp_holder As String
            '        temp_holder = ""

            '        Dim temp_count As Integer
            '        temp_count = 0

            '        Dim decimal_point_position As Integer

            '        For i = 1 To Len(temp_field_value_string)

            '            If IsNumeric((Mid(temp_field_value_string, i, 1))) = True Or Mid(temp_field_value_string, i, 1) = "." Then

            '                temp_holder = temp_holder & Mid(temp_field_value_string, i, 1)

            '                temp_count = temp_count + 1

            '            End If

            '        Next

            '        If (decimal_point_position > 4) Then

            '            DecimalValueTooLarge.Visible = True
            '            DecimalValueTooLarge.InnerHtml = "The decimal value you entered is larger than the allowed precision."

            '        Else

            '            If (InStr(temp_holder, ".") > 0) Then

            '                decimal_point_position = InStr(temp_holder, ".")

            '                If (temp_count - decimal_point_position > 1) Then

            '                    If (Int(Mid(temp_holder, decimal_point_position + 2, 1)) >= 5) Then

            '                        Mid(temp_holder, decimal_point_position + 1, 1) = Str(Int(Mid(temp_holder, decimal_point_position + 1, 1)) + 1)

            '                    End If

            '                    temp_holder = temp_holder.Remove(temp_count - 1)

            '                    DecimalValueTooLarge.Visible = True
            '                    DecimalValueTooLarge.InnerHtml = "The number of digits after the decimal point was greater than 1, so the value has been rounded."

            '                End If

            '            End If

            '        End If

            '        temp_field_value_string = temp_holder
            '        Convert.ToDecimal(temp_field_value_string, New CultureInfo("en-US"))
            '        DPF_comm.Parameters.Add("@" & temp_field_name_string, SqlDbType.Decimal)
            '        DPF_comm.Parameters("@" & temp_field_name_string).Value = temp_field_value_string

            '    ElseIf (temp_field_name_string = "DocCleaned" Or temp_field_name_string = "MultipleCleanings") Then

            '        If (temp_field_value_string = "Off") Then

            '            temp_field_value_string = "N"

            '        Else

            '            temp_field_value_string = "Y"

            '        End If

            '        DPF_comm.Parameters.Add("@" & temp_field_name_string, SqlDbType.Char, 1)
            '        DPF_comm.Parameters("@" & temp_field_name_string).Value = temp_field_value_string

            '    ElseIf (temp_field_name_string = "Notes" Or temp_field_name_string = "Condition") Then

            '        DPF_comm.Parameters.Add("@" & temp_field_name_string, SqlDbType.VarChar)
            '        DPF_comm.Parameters("@" & temp_field_name_string).Value = temp_field_value_string

            '        'Else

            '        '    DPF_comm.Parameters.Add("@" & temp_field_name_string, SqlDbType.VarChar, 50)
            '        '    DPF_comm.Parameters("@" & temp_field_name_string).Value = temp_field_value_string
            '        'DPF_comm.Parameters.AddWithValue("@" & temp_field_name_string, temp_field_value_string)

            '    End If

            'Next

            '********** FYI ---> passing a varchar(50) in the Add.Parameters part of the Decimal conditions failed,
            ' but adjusting the size to 10 worked; I think because 50 is too large.
            ' I have to think more on why this is a problem.

            'Changing the table from CF_DPF_Final to CF_DPF_Final_Final due to their being an existing CF_DPF_Final table in CleanFleets that
            'was not editable. This is for the purpose of moving from development to production; Andrew - 12/10/2019.
            'Push made and reverting back; Andrew - 12/10/2019.

            DPF_comm = New SqlCommand("DECLARE @UNIQUEID UNIQUEIDENTIFIER DECLARE @FINALENTERDATE DATETIME DECLARE @FINALIDVEHICLES UNIQUEIDENTIFIER DECLARE @FINALIDVEHICLESSTRING VARCHAR(50) DECLARE @FINALIDPROFILEACCOUNT VARCHAR(50) DECLARE @FINALDPFINITFR DECIMAL(3,1) DECLARE @FINALDPFFINALFR DECIMAL(3,1) DECLARE @FINALDPFFRDiff DECIMAL(3,1) DECLARE @FINALINVOICENUMBER VARCHAR(50) DECLARE @FINALCOMPANY VARCHAR(MAX) DECLARE @FINALPONUMBER VARCHAR(50) DECLARE @FINALMAKE VARCHAR(50) DECLARE @FINALMODEL VARCHAR(50) DECLARE @FINALFILTERMAKE VARCHAR(50) DECLARE @FINALSUBSTRATE VARCHAR(50) DECLARE @FINALNOTES VARCHAR(MAX) DECLARE @FINALMILES INTEGER DECLARE @FINALHOURS INTEGER DECLARE @FINALPARTNUMBER INTEGER DECLARE @FINALDPFINITWEIGHT INTEGER DECLARE @FINALDPFFINALWEIGHT INTEGER DECLARE @FINALDPFWEIGHTDIFF INTEGER DECLARE @FINALDOCINITWEIGHT INTEGER DECLARE @FINALDOCFINALWEIGHT INTEGER DECLARE @FINALDOCWEIGHTDIFF INTEGER" & " SET @UNIQUEID = NEWID() SET @FINALENTERDATE = CONVERT(DATETIME, @EnterDate, 101) SET @FINALIDVEHICLES = (SELECT TOP 1 CF_Vehicles.IDVehicles FROM CF_Vehicles WHERE CF_Vehicles.ChassisVIN = @VINNumber) SET @FINALIDVEHICLESSTRING = CONVERT(VARCHAR(50), @FINALIDVEHICLES) SET @FINALIDProfileAccount = (SELECT TOP 1 CF_Profile_Terminal.IDProfileAccount FROM CF_Vehicles INNER JOIN CF_Profile_Fleet ON CF_Profile_Fleet.IDProfileFleet = CF_Vehicles.IDProfileFleet INNER JOIN CF_Profile_Terminal ON CF_Profile_Terminal.IDProfileTerminal = CF_Profile_Fleet.IDProfileTerminal WHERE CF_Vehicles.IDVehicles = @FINALIDVEHICLES) IF @DPFInitFR <> '' BEGIN SET @FINALDPFINITFR = CONVERT(DECIMAL(3,1), @DPFInitFR) END IF @DPFFinalFR <> '' BEGIN SET @FINALDPFFINALFR = CONVERT(DECIMAL(3,1), @DPFFinalFR) END IF @DPFFRDiff <> '' BEGIN SET @FINALDPFFRDiff = CONVERT(DECIMAL(3,1), @DPFFRDiff) END IF @InvoiceNumber <> '' BEGIN SET @FINALINVOICENUMBER = @InvoiceNumber END IF @PONumber <> '' BEGIN SET @FINALPONUMBER = @PONumber END IF @Company <> '' BEGIN SET @FINALCOMPANY = @Company END IF @Make <> '' BEGIN SET @FINALMAKE = @Make END IF @Model <> '' BEGIN SET @FINALMODEL = @Model END IF @FilterMake <> '' BEGIN SET @FINALFILTERMAKE = @FilterMake END IF @SubStrate <> '' BEGIN SET @FINALSUBSTRATE = @SubStrate END IF @Notes <> '' BEGIN SET @FINALNOTES = @Notes END IF @Miles <> '' BEGIN SET @FINALMILES = CONVERT(INTEGER, @Miles) END IF @Hours <> '' BEGIN SET @FINALHOURS = CONVERT(INTEGER, @Hours) END IF @PartNumber <> '' BEGIN SET @FINALPARTNUMBER = CONVERT(INTEGER, @PartNumber) END IF @DPFInitWeight <> '' BEGIN SET @FINALDPFINITWEIGHT = CONVERT(INTEGER, @DPFInitWeight) END IF @DPFFinalWeight <> '' BEGIN SET @FINALDPFFINALWEIGHT = CONVERT(INTEGER, @DPFFinalWeight) END IF @DPFWeightDiff <> '' BEGIN SET @FINALDPFWEIGHTDIFF = CONVERT(INTEGER, @DPFWeightDiff) END IF @DOCInitWeight <> '' BEGIN SET @FINALDOCINITWEIGHT = CONVERT(INTEGER, @DOCInitWeight) END IF @DOCFinalWeight <> '' BEGIN SET @FINALDOCFINALWEIGHT = CONVERT(INTEGER, @DOCFinalWeight) END IF @DOCWeightDiff <> '' BEGIN SET @FINALDOCWEIGHTDIFF = CONVERT(INTEGER, @DOCWeightDiff) END " & "INSERT INTO CF_DPF_Final (IDDPF, EnterDate, ModifiedDate, IDVehicles, IDProfileAccount, InvoiceNumber, VINNumber, PONumber, Company, Make, Model, Plate, Miles, Hours, FilterMake, SerialNumber, PartNumber, Substrate, Condition, DPFInitWeight, DPFFinalWeight, DPFWeightDiff, DOCInitWeight, DOCFinalWeight, DOCWeightDiff, DPFInitFR, DPFFinalFR, DPFFRDiff, WTResults, CleaningTech, DocCleaned, MultipleCleanings, Notes) " & "VALUES(@UNIQUEID, @FINALENTERDATE, GETDATE(), @FINALIDVEHICLESSTRING, @FINALIDPROFILEACCOUNT, @FINALINVOICENUMBER, @VINNumber, @FINALPONUMBER, @FINALCOMPANY, @FINALMAKE, @FINALMODEL, @Plate, @FINALMILES, @FINALHOURS, @FINALFILTERMAKE, @SerialNumber, @FINALPARTNUMBER, @FINALSUBSTRATE, @Condition, @FINALDPFINITWEIGHT, @FINALDPFFINALWEIGHT, @FINALDPFWEIGHTDIFF, @FINALDOCINITWEIGHT, @FINALDOCFINALWEIGHT, @FINALDOCWEIGHTDIFF, @FINALDPFINITFR, @FINALDPFFINALFR, @FinalDPFFRDiff, @WTResults, @CleaningTech, @DocCleaned, @MultipleCleanings, @FINALNOTES)", DPF_conn)

            ' IF @PONumber <> '' BEGIN SET @FINALPONUMBER = @PONumber END IF @Make <> '' BEGIN SET @FINALMAKE = @Make END IF @Model <> '' BEGIN SET @FINALMODEL = @Model END IF @FilterMake <> '' BEGIN SET @FINALFILTERMAKE = @FilterMake END IF @SubStrate <> '' BEGIN SET @FINALSUBSTRATE = @SubStrate END IF @Condition <> '' BEGIN SET @FINALCONDITION = @Condition END IF @WTResults <> '' BEGIN SET @FINALWTRESULTS = @WTResults END IF @CleaningTech <> '' BEGIN SET @FINALCLEANINGTECH = @CleaningTech IF @Notes <> '' BEGIN SET @FINALNOTES = @Notes END

            ' PONumber, Make, Model, FilterMake, SubStrate, Condition, WTResults, CleaningTech, Notes,

            ' @FINALPONUMBER, @FINALMAKE, @FINALMODEL, @FINALFILTERMAKE, @FINALSUBSTRATE, @FINALCONDITION, @FINALWTRESULTS, @FINALCLEANINGTECH, @FINALNOTES,

            'Dim Plate As String
            'Plate = DPF_Dictionary.Item("Plate")
            'Dim VINNumber As String
            'VINNumber = DPF_Dictionary.Item("VINNumber")

            Dim query_execution_flag As Boolean
            query_execution_flag = True

            SuccessfulImportPrompt.Visible = False

            PlateValidationPrompt.Visible = False
            VINNumberValidationPrompt.Visible = False
            DecimalValidationPrompt.Visible = False
            DateValidationPrompt.Visible = False
            WOValidationPrompt.Visible = False
            MilesHoursValidationPrompt.Visible = False
            SerialNumberValidationPrompt.Visible = False
            PartNumberValidationPrompt.Visible = False
            DPFInitWeightValidationPrompt.Visible = False
            DPFFinalWeightValidationPrompt.Visible = False
            DPFWeightDiffValidationPrompt.Visible = False
            DOCInitWeightValidationPrompt.Visible = False
            DOCFinalWeightValidationPrompt.Visible = False
            DOCWeightDiffValidationPrompt.Visible = False
            PONumberValidationPrompt.Visible = False
            ConditionValidationPrompt.Visible = False
            WTResultsValidationPrompt.Visible = False
            CleaningTechValidationPrompt.Visible = False

            For Each pair As KeyValuePair(Of String, String) In DPF_Dictionary

                Dim temp_var_key As String
                Dim temp_var_val As String

                temp_var_key = pair.Key
                temp_var_val = pair.Value

                If (temp_var_key = "VINNumber" Or temp_var_key = "Plate") Then

                    Dim format_temp_string As String = "^[0-9]+$"
                    Dim compare_temp As New Regex(format_temp_string)

                    Dim format_plate_string As String = "^[A-Z0-9]+$"
                    Dim compare_plate As New Regex(format_plate_string)

                    Dim format_VIN_string As String = "^[A-Z0-9]+\/?[0-9]+$"
                    Dim compare_VIN As New Regex(format_VIN_string)

                    If (compare_plate.IsMatch(temp_var_val) = True And temp_var_key = "Plate") Then

                        DPF_comm.Parameters.Add("@" & temp_var_key, SqlDbType.VarChar, 50)
                        DPF_comm.Parameters("@" & temp_var_key).Value = temp_var_val

                    ElseIf (temp_var_key = "VINNumber") Then

                        If (InStr(temp_var_val, "/") > 0) Then

                            If (compare_VIN.IsMatch(temp_var_val) = True) Then

                                temp_var_val = Left(temp_var_val, InStr(temp_var_val, "/") - 1)

                                DPF_comm.Parameters.Add("@" & temp_var_key, SqlDbType.VarChar, 50)
                                DPF_comm.Parameters("@" & temp_var_key).Value = temp_var_val

                                ' What do you want to do with the Unit#?

                            Else

                                VINNumberValidationPrompt.Visible = True
                                VINNumberValidationPrompt.InnerHtml = "The provided VIN/Unit# is not valid."

                                query_execution_flag = False

                                ' What about Unit#?

                            End If

                        Else

                            If (compare_plate.IsMatch(temp_var_val) = True) Then

                                DPF_comm.Parameters.Add("@" & temp_var_key, SqlDbType.VarChar, 50)
                                DPF_comm.Parameters("@" & temp_var_key).Value = temp_var_val

                            Else

                                VINNumberValidationPrompt.Visible = True
                                VINNumberValidationPrompt.InnerHtml = "The provided VIN/Unit# is not valid."

                                query_execution_flag = False

                            End If

                        End If

                    Else

                        PlateValidationPrompt.Visible = True
                        PlateValidationPrompt.InnerHtml = "The license plate number provided is not valid."

                        query_execution_flag = False

                    End If

                ElseIf (temp_var_key = "EnterDate") Then

                    Dim temp_date_split() As String
                    temp_date_split = Split(temp_var_val, "/")

                    Dim Valid_Date As Boolean
                    Valid_Date = True

                    If (UBound(temp_date_split) = 2) Then

                        For i = 1 To UBound(temp_date_split) + 1

                            If (i - 1 < 2) Then

                                If (Len(temp_date_split(i - 1)) > 0) And Len(temp_date_split(i - 1)) <= 2 Then

                                    If (Len(temp_date_split(i - 1)) < 2) Then

                                        temp_date_split(i - 1) = "0" & temp_date_split(i - 1)

                                    End If

                                Else

                                    Valid_Date = False

                                    DateValidationPrompt.Visible = True
                                    DateValidationPrompt.InnerHtml = "The date provided is not in the correct format (MM/DD/YYYY)."

                                    Exit For

                                End If

                            Else

                                If Not (Len(temp_date_split(i - 1)) = 4) Then

                                    Valid_Date = False

                                    DateValidationPrompt.Visible = True
                                    DateValidationPrompt.InnerHtml = "The date provided is not in the correct format (MM/DD/YYYY)."

                                    Exit For

                                End If

                            End If

                        Next

                    Else

                        Valid_Date = False

                        DateValidationPrompt.Visible = True
                        DateValidationPrompt.InnerHtml = "The date provided is not in the correct format (MM/DD/YYYY)."

                    End If

                    If (Valid_Date = True) Then

                        temp_var_val = temp_date_split(0) & "/" & temp_date_split(1) & "/" & temp_date_split(2)

                        DPF_comm.Parameters.Add("@" & temp_var_key, SqlDbType.DateTime)
                        DPF_comm.Parameters("@" & temp_var_key).Value = temp_var_val

                    Else

                        query_execution_flag = False

                    End If

                ElseIf (temp_var_key = "DPFInitFR" Or temp_var_key = "DPFFinalFR" Or temp_var_key = "DPFFRDiff") Then

                    Dim temp_holder As String
                    temp_holder = ""

                    Dim numeric_count As Integer
                    numeric_count = 0

                    Dim decimal_count As Integer
                    decimal_count = 0

                    Dim decimal_point_position As Integer

                    For i = 1 To Len(temp_var_val)

                        If IsNumeric((Mid(temp_var_val, i, 1))) = True Or Mid(temp_var_val, i, 1) = "." Then

                            temp_holder = temp_holder & Mid(temp_var_val, i, 1)

                            If (IsNumeric((Mid(temp_var_val, i, 1))) = True) Then

                                numeric_count = numeric_count + 1

                            ElseIf (Mid(temp_var_val, i, 1) = ".") Then

                                decimal_count = decimal_count + 1

                            End If

                        End If

                    Next

                    If (numeric_count > 3) Then

                        DecimalValidationPrompt.Visible = True
                        DecimalValidationPrompt.InnerHtml = "The " & temp_var_key & " value you entered is larger than the allowed precision, no more than a total maximum of 4 characters (digits and decimal point)."

                        query_execution_flag = False

                    ElseIf (decimal_count > 1) Then

                        DecimalValidationPrompt.Visible = True
                        DecimalValidationPrompt.InnerHtml = "There is more than one decimal point in the " & temp_var_key & " value provided."

                        query_execution_flag = False

                        'ElseIf (decimal_count = Len(temp_holder) And temp_holder > 0) Then

                        '    DecimalValidationPrompt.Visible = True
                        '    DecimalValidationPrompt.InnerHtml = "The value provided only contains (a) decimal point(s)."

                        '    query_execution_flag = False

                    ElseIf (Len(temp_var_val) <> Len(temp_holder)) Then

                        DecimalValidationPrompt.Visible = True
                        DecimalValidationPrompt.InnerHtml = "There is an existing character in the provided " & temp_var_key & " value that is not numeric or a decimal point, please enter again."

                        query_execution_flag = False

                    Else

                        If (InStr(temp_holder, ".") > 0) Then

                            decimal_point_position = InStr(temp_holder, ".")

                            If (Len(temp_holder) - decimal_point_position > 1) Then

                                'If (Int(Mid(temp_holder, decimal_point_position + 2, 1)) >= 5) Then

                                '    Mid(temp_holder, decimal_point_position + 1, 1) = Str(Int(Mid(temp_holder, decimal_point_position + 1, 1)) + 1)

                                'End If

                                'temp_holder = temp_holder.Remove(decimal_point_position + 1)

                                'DecimalValidationPrompt.Visible = True
                                'DecimalValidationPrompt.InnerHtml = "The number of digits after the decimal point was greater than 1, so the " & temp_var_key & " value has been rounded."

                                'temp_var_val = temp_holder

                                DecimalValidationPrompt.Visible = True
                                DecimalValidationPrompt.InnerHtml = "The provided value contains several digits to the right of the decimal point, accepted values can only have one digit to the right of the decimal point."

                                query_execution_flag = False

                            ElseIf ((Len(temp_holder) - decimal_point_position) = 0 And numeric_count = 3) Then

                                DecimalValidationPrompt.Visible = True
                                DecimalValidationPrompt.InnerHtml = "The value contains a decimal point following three digits and therefore is not acceptable."

                                query_execution_flag = False

                            Else

                                DPF_comm.Parameters.Add("@" & temp_var_key, SqlDbType.VarChar, 10)
                                DPF_comm.Parameters("@" & temp_var_key).Value = temp_var_val

                            End If

                        Else

                            If (numeric_count = 3) Then

                                DecimalValidationPrompt.Visible = True
                                DecimalValidationPrompt.InnerHtml = "The provided value is not allowed, it must contain no more than 3 digits and an appropriately placed decimal point."

                                query_execution_flag = False

                            Else

                                DPF_comm.Parameters.Add("@" & temp_var_key, SqlDbType.VarChar, 10)
                                DPF_comm.Parameters("@" & temp_var_key).Value = temp_var_val

                            End If

                        End If

                    End If

                ElseIf (temp_var_key = "DocCleaned" Or temp_var_key = "MultipleCleanings") Then

                    If (temp_var_val = "Off") Then

                        temp_var_val = "N"

                    Else

                        temp_var_val = "Y"

                    End If

                    DPF_comm.Parameters.Add("@" & temp_var_key, SqlDbType.Char, 1)
                    DPF_comm.Parameters("@" & temp_var_key).Value = temp_var_val

                ElseIf (temp_var_key = "InvoiceNumber") Then

                    Dim format_string As String = "^[0-9]*$"
                    Dim compare As New Regex(format_string)

                    If (compare.IsMatch(temp_var_val) = True) Then

                        DPF_comm.Parameters.Add("@" & temp_var_key, SqlDbType.VarChar, 50)
                        DPF_comm.Parameters("@" & temp_var_key).Value = temp_var_val

                    Else

                        WOValidationPrompt.Visible = True
                        WOValidationPrompt.InnerHtml = "The WO# provided in the DPF Cleaning record PDF is not valid."

                        query_execution_flag = False

                    End If

                ElseIf (temp_var_key = "Miles" Or temp_var_key = "Hours") Then

                    Dim format_string As String = "^[0-9]*$"
                    Dim compare As New Regex(format_string)

                    If (compare.IsMatch(temp_var_val) = True) Then

                        DPF_comm.Parameters.Add("@" & temp_var_key, SqlDbType.VarChar, -1)
                        DPF_comm.Parameters("@" & temp_var_key).Value = temp_var_val

                    Else

                        MilesHoursValidationPrompt.Visible = True
                        MilesHoursValidationPrompt.InnerHtml = "The " & temp_var_key & " provided in the DPF Cleaning record PDF is not valid."

                        query_execution_flag = False

                    End If

                ElseIf (temp_var_key = "PartNumber") Then

                    Dim format_string_Part As String = "^[0-9]*$"
                    Dim compare_Part As New Regex(format_string_Part)

                    If (compare_Part.IsMatch(temp_var_val)) Then

                        DPF_comm.Parameters.Add("@" & temp_var_key, SqlDbType.VarChar, -1)
                        DPF_comm.Parameters("@" & temp_var_key).Value = temp_var_val

                    Else

                        PartNumberValidationPrompt.Visible = True
                        PartNumberValidationPrompt.InnerHtml = "The part number is not valid, it should be a positive integer or blank."

                        query_execution_flag = False

                    End If

                ElseIf (temp_var_key = "SerialNumber") Then

                    Dim format_string_Serial As String = "^[A-Z0-9]*$"
                    Dim compare_Serial As New Regex(format_string_Serial)

                    If (compare_Serial.IsMatch(temp_var_val)) Then

                        DPF_comm.Parameters.Add("@" & temp_var_key, SqlDbType.VarChar, -1)
                        DPF_comm.Parameters("@" & temp_var_key).Value = temp_var_val

                    Else

                        SerialNumberValidationPrompt.Visible = True
                        SerialNumberValidationPrompt.InnerHtml = "The serial number is not valid, it should be a positive integer or blank."

                        query_execution_flag = False

                    End If

                ElseIf (temp_var_key = "DPFInitWeight" Or temp_var_key = "DPFFinalWeight" Or temp_var_key = "DPFWeightDiff" Or temp_var_key = "DOCInitWeight" Or temp_var_key = "DOCFinalWeight" Or temp_var_key = "DOCWeightDiff") Then

                    Dim format_string As String = "^[0-9]*$"
                    Dim compare As New Regex(format_string)

                    If (compare.IsMatch(temp_var_val)) Then

                        DPF_comm.Parameters.Add("@" & temp_var_key, SqlDbType.VarChar, 10)
                        DPF_comm.Parameters("@" & temp_var_key).Value = temp_var_val

                    Else

                        If (temp_var_key = "DPFInitWeight") Then

                            DPFInitWeightValidationPrompt.Visible = True
                            DPFInitWeightValidationPrompt.InnerHtml = "The DPF Initial Weight value is not valid, it should be a positive integer or blank."

                            query_execution_flag = False

                        ElseIf (temp_var_key = "DPFFinalWeight") Then

                            DPFFinalWeightValidationPrompt.Visible = True
                            DPFFinalWeightValidationPrompt.InnerHtml = "The DPF Final Weight value is not valid, it should be a positive integer or blank."

                            query_execution_flag = False

                        ElseIf (temp_var_key = "DPFWeightDiff") Then

                            DPFWeightDiffValidationPrompt.Visible = True
                            DPFWeightDiffValidationPrompt.InnerHtml = "The DPF Weight Difference value is not valid, it should be a positive integer or blank."

                            query_execution_flag = False

                        ElseIf (temp_var_key = "DOCInitWeight") Then

                            DOCInitWeightValidationPrompt.Visible = True
                            DOCInitWeightValidationPrompt.InnerHtml = "The DOC1 Initial Weight value is not valid, it should be a positive integer or blank."

                            query_execution_flag = False

                        ElseIf (temp_var_key = "DOCFinalWeight") Then

                            DOCFinalWeightValidationPrompt.Visible = True
                            DOCFinalWeightValidationPrompt.InnerHtml = "The DOC1 Final Weight value is not valid, it should be a positive integer or blank."

                            query_execution_flag = False

                        ElseIf (temp_var_key = "DOCWeightDiff") Then

                            DOCWeightDiffValidationPrompt.Visible = True
                            DOCWeightDiffValidationPrompt.InnerHtml = "The DOC1 Weight Difference value is not valid, it should be a positive integer or blank."

                            query_execution_flag = False

                        End If

                    End If

                ElseIf (temp_var_key = "PONumber") Then

                    Dim format_string As String = "^[0-9]*$"
                    Dim compare As New Regex(format_string)

                    Dim format_string_2 As String = "^[A-Z0-9]*$"
                    Dim compare_2 As New Regex(format_string_2)

                    If (compare.IsMatch(temp_var_val) = True Or compare_2.IsMatch(temp_var_val) = True) Then

                        DPF_comm.Parameters.Add("@" & temp_var_key, SqlDbType.VarChar, 50)
                        DPF_comm.Parameters("@" & temp_var_key).Value = temp_var_val

                    Else

                        PONumberValidationPrompt.Visible = True
                        PONumberValidationPrompt.InnerHtml = "The PO# provided in the DPF Cleaning record PDF is not valid."

                        query_execution_flag = False

                    End If

                ElseIf (temp_var_key = "WTResults" Or temp_var_key = "CleaningTech" Or temp_var_key = "Condition") Then

                    Dim format_string As String = "^[A-Z]+$"
                    Dim compare As New Regex(format_string)

                    Dim format_string_space As String = "^[A-Z]+\s?[A-Z]+$"
                    Dim compare_space As New Regex(format_string_space)

                    If (compare.IsMatch(temp_var_val) = True) Then

                        DPF_comm.Parameters.Add("@" & temp_var_key, SqlDbType.VarChar, 50)
                        DPF_comm.Parameters("@" & temp_var_key).Value = temp_var_val

                    ElseIf (compare_space.IsMatch(temp_var_val) = True And temp_var_key = "CleaningTech") Then

                        DPF_comm.Parameters.Add("@" & temp_var_key, SqlDbType.VarChar, 50)
                        DPF_comm.Parameters("@" & temp_var_key).Value = temp_var_val

                    Else

                        If (temp_var_key = "WTResults") Then

                            WTResultsValidationPrompt.Visible = True
                            WTResultsValidationPrompt.InnerHtml = "The Wire Test Results provided in the DPF Cleaning record PDF is not valid."

                        ElseIf (temp_var_key = "CleaningTech") Then

                            CleaningTechValidationPrompt.Visible = True
                            CLeaningTechValidationPrompt.InnerHtml = "The Cleaning Tech provided in the DPF Cleaning record PDF is not valid."

                        ElseIf (temp_var_key = "Condition") Then

                            ConditionValidationPrompt.Visible = True
                            ConditionValidationPrompt.InnerHtml = "The Condition provided in the DPF Cleaning record PDF is not valid."

                        End If

                        query_execution_flag = False

                    End If

                ElseIf (temp_var_key = "Notes" Or temp_var_key = "Company" Or temp_var_key = "Make" Or temp_var_key = "Model" Or temp_var_key = "FilterMake" Or temp_var_key = "Substrate") Then

                    DPF_comm.Parameters.Add("@" & temp_var_key, SqlDbType.VarChar, -1)
                    DPF_comm.Parameters("@" & temp_var_key).Value = temp_var_val

                End If

            Next

            'DPF_comm.Parameters.AddWithValue(@VINNumber, VINNumber)
            'DPF_comm.Parameters.AddWithValue(@Plate, Plate)

            If (query_execution_flag = True) Then

                DPF_comm.ExecuteNonQuery()

                SuccessfulImportPrompt.Visible = True
                SuccessfulImportPrompt.InnerHtml = "The import attempt was successful."

            End If

            DPF_conn.Close()

            'DPF_comm = New SqlCommand("INSERT INTO CF_DPF_Final (IDDPF, IDModifiedUser, EnterDate, ModifiedDate, IDProfileAccount, IDVehicles, InvoiceNumber, PONumber, Company, VINNumber, Make, Model, Plate, Miles, Hours, FilterMake, SerialNumber, PartNumber, Substrate, DocCleaned, Condition, DPFInitWeight, DPFFinalWeight, DPFWeightDiff, DOCInitWeight, DOCFinalWeight, DOCWeightDiff, DPFInitFR, DPFFinalFR, DPFFRDiff, WTResults, CleaningTech, MultipleCleanings, Notes) " &
            '    "VALUES ("

            '"INSERT INTO CF_Vehicles_Log_OpacityTests (IDVehicles, IDModifiedUser, EnterDate, ModifiedDate, AverageOpacity, TestResult, TestedBy, TestDate, RawTestResults, ScannerModel) " &
            '      "VALUES (@IDVehicles, @IDModifiedUser, GETDATE(), GETDATE(), @AverageOpacity, @TestResult, @TestedBy, DATEADD(dd, DATEDIFF(dd, 0, @TestDate), 0), @RawTestResults, @ScannerModel)", conn)
            'comm.Parameters.AddWithValue("@IDVehicles", IDVehicles)
            'comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)

            'theDoc.Read(theSrc)

            ''Dim theDocSoup As ObjectSoup
            'Dim thisForm As XForm
            ''Dim theField As Field
            'Dim theFieldString As String
            'Dim FieldNamesArray() As String
            'Dim CombinedFieldNames As String
            ''Dim theDocSoupCount As Integer
            ''Dim theIndirectObject As IndirectObject

            'theDocSoup = theDoc.ObjectSoup
            'CombinedFieldNames = ""
            'thisForm = theDoc.Form

            'FieldNamesArray = thisForm.GetFieldNames()
            ''theField = theDocSoup(0)
            ''theDocSoupCount = 0
            ''theFieldString = Str(theDocSoupCount)
            'For Each theFieldString In FieldNamesArray

            '    'If (theIndirectObject.Equals(theField, ComparisonType.Object) = True) Then

            '    CombinedFieldNames = CombinedFieldNames & ", " & theFieldString
            '    'theDocSoupCount = theDocSoupCount + 1

            '    'End If

            'Next
            ''theFieldString = Str(theDocSoupCount)
            'viewtextvariable_theField.Visible = True
            'viewtextvariable_theField.InnerHtml = CombinedFieldNames

            'Dim op As New TextOperation(theDoc)
            'Dim op_WO As New TextOperation(theDoc)
            'Dim op_Job As New TextOperation(theDoc)
            'Dim op_Company As New TextOperation(theDoc)
            'Dim op_VIN_UNIT As New TextOperation(theDoc)
            'Dim op_MAKE As New TextOperation(theDoc)
            'Dim op_MODEL As New TextOperation(theDoc)
            'op.PageContents.AddPages()
            'op_WO.PageContents.AddPages()
            'op_Job.PageContents.AddPages()
            'op_Company.PageContents.AddPages()
            'op_VIN_UNIT.PageContents.AddPages()
            'op_MAKE.PageContents.AddPages()
            'op_MODEL.PageContents.AddPages()

            'theDoc.Rect.String = "450 714 600 790"
            'Dim PDFPageText As String = op.GetText(theDoc.Rect, 1) ' Altered this line on 9/10/2019 to include arguments in GetText method.
            'viewtextvariable.Visible = True
            'viewtextvariable.InnerHtml = PDFPageText

            ' PDFPageText = Nothing
            ' theDoc.Rect.SetRect(450, 693, 122.4, 27)
            ' theDoc.Rect.SetRect(300, 300, 300, 300)

            '    theDoc.Rect.String = "450 693 600 720"
            '    PDFPageText = op_WO.GetText(theDoc.Rect, 1)
            '    viewtextvariable_WO.Visible = True
            '    viewtextvariable_WO.InnerHtml = PDFPageText

            '    theDoc.Rect.String = "450 666 600 693"
            '    PDFPageText = op_Job.GetText(theDoc.Rect, 1)
            '    viewtextvariable_Job.Visible = True
            '    viewtextvariable_Job.InnerHtml = PDFPageText

            '    theDoc.Rect.String = "297 575 558 612"
            '    PDFPageText = op_Company.GetText(theDoc.Rect, 1)
            '    viewtextvariable_Company.Visible = True
            '    viewtextvariable_Company.InnerHtml = PDFPageText

            '    theDoc.Rect.String = "297 552 558 575"
            '    PDFPageText = op_VIN_UNIT.GetText(theDoc.Rect, 1)
            '    viewtextvariable_VIN_UNIT.Visible = True
            '    viewtextvariable_VIN_UNIT.InnerHtml = PDFPageText

            '    theDoc.Rect.String = "297 535 558 552"
            '    PDFPageText = op_MAKE.GetText(theDoc.Rect, 1)
            '    viewtextvariable_MAKE.Visible = True
            '    viewtextvariable_MAKE.InnerHtml = PDFPageText

            '    theDoc.Rect.String = "297 518 558 535"
            '    PDFPageText = op_MODEL.GetText(theDoc.Rect, 1)
            '    viewtextvariable_MODEL.Visible = True
            '    viewtextvariable_MODEL.InnerHtml = PDFPageText

        End Using

        ' End of what was Added by Andrew on 9/3/2019.

        ' Initialize the DataSet object
        'myDataSet.Tables.Add()

        'col = myDataSet.Tables(0).Columns.Add("IDImport", GetType(Integer))
        'col.AutoIncrement = True

        'myDataSet.Tables(0).Columns.Add("IDProfileAccount", GetType(Integer))
        'myDataSet.Tables(0).Columns.Add("IDProfileTerminal", GetType(Integer))

        'col = myDataSet.Tables(0).Columns.Add("IDProfileFleet", GetType(Integer))
        'col.DefaultValue = 0

        'col = myDataSet.Tables(0).Columns.Add("IDVehicles", GetType(System.Guid))
        'col.DefaultValue = Guid.Empty

        'myDataSet.Tables(0).Columns.Add("CompanyName", GetType(String))
        'myDataSet.Tables(0).Columns.Add("TestCity", GetType(String))
        'myDataSet.Tables(0).Columns.Add("LicensePlate", GetType(String))
        'myDataSet.Tables(0).Columns.Add("Unit", GetType(String))
        'myDataSet.Tables(0).Columns.Add("TestDate", GetType(DateTime))
        'myDataSet.Tables(0).Columns.Add("TestedBy", GetType(String))
        'myDataSet.Tables(0).Columns.Add("AverageOpacity", GetType(Decimal))
        'myDataSet.Tables(0).Columns.Add("TestResult", GetType(String))
        'myDataSet.Tables(0).Columns.Add("Mileage", GetType(Integer))
        'myDataSet.Tables(0).Columns.Add("ScannerModel", GetType(String))

        '' Mileage Import
        'col = myDataSet.Tables(0).Columns.Add("Mileage", GetType(String))
        'col.DefaultValue = ""
        'col = myDataSet.Tables(0).Columns.Add("IDSignature", GetType(System.Guid))
        'col.DefaultValue = Guid.Empty

        'col = myDataSet.Tables(0).Columns.Add("TesterDetected", GetType(Boolean))
        'col.DefaultValue = False

        'myDataSet.Tables(0).Columns.Add("RawTestResults", GetType(String))
        'myDataSet.Tables(0).Columns.Add("Errors", GetType(String))

        'col = myDataSet.Tables(0).Columns.Add("OpacityTestsImportStatus", GetType(String))
        'col.DefaultValue = "pending"

        ' Determine type of import file and process appropriate tests

        'If Contents.IndexOf("WAGER: WIRELESS MODEL") > -1 Then
        '    ScannerName = "wager"
        '    ProcessWagerTests(Contents, myDataSet)
        'Else
        '    ScannerName = "redmountain"
        '    ProcessRedMountainTests(Contents, myDataSet)
        'End If

        'For Each dtRow As DataRow In myDataSet.Tables(0).Rows
        '    Try
        '        dtRow.Item("ScannerModel") = ScannerName
        '        dtRow.Item("OpacityTestsImportStatus") = "pending"

        ' Try to identify the Account, Terminal, and Vehicles involved

        'If AttachToDBRecord Then
        '            dtRow.Item("IDProfileAccount") = getIDProfileAccount(dtRow.Item("CompanyName"))
        '            dtRow.Item("IDProfileTerminal") = getIDProfileTerminal(dtRow.Item("IDProfileAccount"), dtRow.Item("TestCity"))
        '            dtRow.Item("IDVehicles") = Guid.Empty

        '            If dtRow.Item("IDProfileTerminal") > 0 Then
        '                dtRow.Item("IDVehicles") = getIDVehicles(dtRow.Item("IDProfileTerminal"), dtRow.Item("LicensePlate"), dtRow.Item("Unit")) ' if vehicle exists matching the VIN but doesn't match the Fleet, that's a potential problem
        '            Else
        '                BestGuessVehicleAndTerminal(dtRow)
        '            End If
        '        Else
        '            dtRow.Item("IDProfileAccount") = 0
        '            dtRow.Item("IDProfileTerminal") = 0
        '            dtRow.Item("IDVehicles") = Guid.Empty
        '        End If
        '    Catch e As Exception
        '        Throw e
        '    End Try
        'Next
        'hasErrors = EvaluateRecords(myDataSet.Tables(0).Rows, AttachToDBRecord)

        'Dim PDFFilePath As String

        'If AttachToDBRecord AndAlso Not hasErrors Then
        '    UpdateRecords(myDataSet.Tables(0))
        'End If

        'Dim myDataView As DataView = myDataSet.Tables(0).DefaultView

        ' 2016-08-12 EST -- Sorting by Unit Number instead of status
        ' myDataView.Sort = "OpacityTestsImportStatus ASC"
        'myDataView.Sort = "Unit ASC"

        'myDataTable = myDataView.Table()

        'If Not AttachToDBRecord Then
        '    PDFFilePath = GeneratePDF(myDataView, AttachToDBRecord)

        '    ViewState("PDFReportPath") = PDFFilePath

        '    btnPDFReport.Visible = True
        'End If


        'gv_Text.DataSource = myDataTable
        'gv_Text.DataBind()

        'If Not hasErrors Then
        '    myDataTable = New DataTable()
        'End If
    End Sub

    ' ProcessWagerTests
    Protected Sub ProcessWagerTests(ByVal contents As String, ByRef myDataSet As DataSet)
        Dim patt As Regex = New Regex("\-*END OF REPORT\-*(?:\r\n|\Z)", RegexOptions.IgnoreCase)
        Dim parts As String() = patt.Split(contents)
        Dim regexCompanyName As GroupCollection
        Dim regexLicensePlate As GroupCollection
        Dim regexUnit As GroupCollection
        Dim regexTestCity As GroupCollection
        Dim regexTestDate As GroupCollection
        Dim regexTestedBy As GroupCollection
        Dim regexAverageOpacity As GroupCollection
        Dim regexTestResult As GroupCollection
        '' Mileage Import
        Dim regexMileage As GroupCollection
        For Each part As String In parts
            If Regex.IsMatch(part, "\A(\s)*\Z", RegexOptions.Multiline) Then ' completely blank part; skip it
                Continue For
            End If
            If Regex.IsMatch(part, "\-*END OF TRANSMISSION \-*(?=\r\n|\n|\Z)", RegexOptions.IgnoreCase) Then
                Continue For
            End If
            Dim dtRow As DataRow = myDataSet.Tables(0).Rows.Add()
            dtRow.Item("RawTestResults") = part.TrimEnd(New Char() {vbCr, vbLf})
            regexCompanyName = Regex.Match(part, "Company:\s*(.*)(?=\r\n|\Z)", RegexOptions.IgnoreCase).Groups
            If regexCompanyName.Count > 1 Then
                dtRow.Item("CompanyName") = regexCompanyName(1).Value
            Else
                dtRow.Item("CompanyName") = ""
            End If
            regexLicensePlate = Regex.Match(part, "LIC PLATE:\s*(.*)(?=\r\n|\Z)", RegexOptions.IgnoreCase).Groups
            If regexLicensePlate.Count > 1 Then
                dtRow.Item("LicensePlate") = regexLicensePlate(1).Value
            Else
                dtRow.Item("LicensePlate") = ""
            End If
            regexUnit = Regex.Match(part, "VIN:\s*(.*)(?=\r\n|\Z)", RegexOptions.IgnoreCase).Groups
            If regexUnit.Count > 1 Then
                dtRow.Item("Unit") = regexUnit(1).Value
            Else
                dtRow.Item("Unit") = ""
            End If
            regexTestCity = Regex.Match(part, "^([\w\s]*)\s[A-Z]{2}\s\d{5}(?=\-\d{4})?(?=\r\n|\Z)", RegexOptions.IgnoreCase And RegexOptions.Multiline).Groups
            If regexTestCity.Count > 1 Then
                dtRow.Item("TestCity") = regexTestCity(1).Value
            Else
                dtRow.Item("TestCity") = ""
            End If
            regexTestDate = Regex.Match(part, "TEST DATE:\s*([0-9]{2})\/([0-9]{2})\/([0-9]{4})(?:\r\n|\Z)TEST TIME:\s*([0-9]{2}):([0-9]{2}):([0-9]{2})(?=\r\n|\Z)", RegexOptions.IgnoreCase).Groups
            If regexTestDate.Count > 1 Then
                dtRow.Item("TestDate") = New Date(regexTestDate(3).Value, regexTestDate(1).Value, regexTestDate(2).Value, regexTestDate(4).Value, regexTestDate(5).Value, regexTestDate(6).Value)
            Else
                dtRow.Item("TestDate") = DateTime.MinValue
            End If
            regexTestedBy = Regex.Match(part, "Inspector:\s*(.*)(?=\r\n|\Z)", RegexOptions.IgnoreCase).Groups
            If regexTestedBy.Count > 1 Then
                dtRow.Item("TestedBy") = regexTestedBy(1).Value
                dtRow.Item("TesterDetected") = CheckTester(dtRow)
            Else
                dtRow.Item("TestedBy") = ""
            End If
            regexAverageOpacity = Regex.Match(part, "AVERAGE\s*(\d+\.\d+)(?=\r\n|\Z)", RegexOptions.IgnoreCase).Groups
            If regexAverageOpacity.Count > 1 Then
                dtRow.Item("AverageOpacity") = regexAverageOpacity(1).Value
            Else
                dtRow.Item("AverageOpacity") = 0
            End If
            regexTestResult = Regex.Match(part, "VEHICLE\s*([a-zA-Z]*)\s*TEST\s*!!(?=\r\n|\Z)", RegexOptions.IgnoreCase).Groups
            If regexTestResult.Count > 1 Then
                Dim TestResult As String = regexTestResult(1).Value.ToUpper()
                If TestResult.IndexOf("FAIL") > -1 Then
                    dtRow.Item("TestResult") = "FAIL"
                Else
                    dtRow.Item("TestResult") = "PASS"
                End If
            Else
                dtRow.Item("TestResult") = ""
            End If
            '' Mileage Import
            regexMileage = Regex.Match(part, "Vehicle Mileage:\s*(.*)(?=\r\n|\Z)", RegexOptions.IgnoreCase).Groups
            If regexMileage.Count > 1 Then
                dtRow.Item("Mileage") = regexMileage(1).Value.ToUpper()
            Else
                dtRow.Item("Mileage") = ""
            End If
        Next
    End Sub

    ' ProcessRedMountainTests
    Protected Sub ProcessRedMountainTests(ByVal contents As String, ByRef myDataSet As DataSet)
        Dim currentCentury As String = DateTime.Now.Year.ToString().Substring(0, 2)
        'Dim PatternSplit As Regex = New Regex("(?:\r\n|\n)+(?=^\s*\*{3}\sTEST NUMBER \d*\s\*{3})", RegexOptions.Multiline)
        Dim PatternSplit As Regex = New Regex("(?<=\s*[\r\n])*(\s*\*{3} TEST NUMBER \d* \*{3})", RegexOptions.Multiline Or RegexOptions.IgnoreCase)
        'Dim PatternHeader As Regex = New Regex("\n+(?=\s*\*{3}\sTEST NUMBER \d*\s\*{3})", RegexOptions.IgnoreCase)
        Dim PatternHeader As Regex = New Regex("(\s*[\r\n])+(?=\s*\*{3} TEST NUMBER \d* \*{3})", RegexOptions.IgnoreCase Or RegexOptions.Multiline)
        Dim HeaderParts As String() = PatternHeader.Split(contents, 2)
        Dim parts As String() = PatternSplit.Split(HeaderParts(2))
        Dim regexCompanyName As GroupCollection
        Dim regexLicensePlate As GroupCollection
        Dim regexUnit As GroupCollection
        Dim regexTestCity As GroupCollection
        Dim regexTestDate As GroupCollection
        Dim regexTestedBy As GroupCollection
        Dim regexAverageOpacity As GroupCollection
        Dim regexTestResult As GroupCollection
        '' Mileage Import
        Dim regexMileage As GroupCollection
        'throw new Exception(parts(1) & "|" & parts(2))
        'For Each part As String In parts

        'if parts.length mod 2 <> 0 then 
        '	throw new Exception("Uneven test number and body " & parts.length mod 2 & " " & parts.length )
        'end if
        For i As Integer = 1 To parts.Length - 2 Step 2
            Dim part As String = parts(i) & parts(i + 1)
            If part = "" OrElse String.IsNullOrEmpty(part.Trim(New Char() {vbCr, vbLf}).Trim()) Then
                Continue For
            End If
            Dim dtRow As DataRow = myDataSet.Tables(0).Rows.Add()
            Dim trimChars = New Char() {vbCr, vbLf, " "}
            dtRow.Item("RawTestResults") = String.Format("{0}{1}{2}", HeaderParts(0).TrimStart(trimChars).TrimEnd(trimChars), vbCrLf, part.TrimStart(trimChars).TrimEnd(trimChars))
            regexCompanyName = Regex.Match(part, "Company Name:\s*(.*)(?=\r\n|\Z)", RegexOptions.IgnoreCase).Groups
            If regexCompanyName.Count > 1 Then
                dtRow.Item("CompanyName") = regexCompanyName(1).Value
            Else
                dtRow.Item("CompanyName") = ""
            End If
            regexLicensePlate = Regex.Match(part, "License Plate:\s*(.*)(?=\r\n|\Z)", RegexOptions.IgnoreCase).Groups
            If regexLicensePlate.Count > 1 Then
                dtRow.Item("LicensePlate") = regexLicensePlate(1).Value
            Else
                dtRow.Item("LicensePlate") = ""
            End If
            regexUnit = Regex.Match(part, "Veh\. VIN Or Unit#:\s*(.*)(?=\r\n|\Z)", RegexOptions.IgnoreCase).Groups
            If regexUnit.Count > 1 Then
                dtRow.Item("Unit") = regexUnit(1).Value
            Else
                dtRow.Item("Unit") = ""
            End If
            regexTestCity = Regex.Match(part, "Test City: \s*(.*)(?=\r\n|\Z)", RegexOptions.IgnoreCase).Groups
            If regexTestCity.Count > 1 Then
                dtRow.Item("TestCity") = regexTestCity(1).Value
            Else
                dtRow.Item("TestCity") = ""
            End If
            regexTestDate = Regex.Match(part, "Test Date: ([0-9]{2})-([0-9]{2})-([0-9]{2}).*Test Time: ([0-9]{1,2}):([0-9]{2}):([0-9]{2})(?=\r\n|\Z)", RegexOptions.IgnoreCase).Groups
            If regexTestDate.Count > 1 Then
                dtRow.Item("TestDate") = New Date(currentCentury & regexTestDate(3).Value, regexTestDate(1).Value, regexTestDate(2).Value, regexTestDate(4).Value, regexTestDate(5).Value, regexTestDate(6).Value)
            Else
                dtRow.Item("TestDate") = DateTime.MinValue
            End If
            regexTestedBy = Regex.Match(part, "Tested by:\s*(.*)(?=\r\n|\Z)", RegexOptions.IgnoreCase).Groups
            If regexTestedBy.Count > 1 Then
                dtRow.Item("TestedBy") = regexTestedBy(1).Value
                dtRow.Item("TesterDetected") = CheckTester(dtRow)
            Else
                dtRow.Item("TestedBy") = ""
            End If
            regexAverageOpacity = Regex.Match(part, "\d+\sTEST AVERAGE OPACITY:\.*(\d+\.\d+)\s%(?=\r\n|\Z)", RegexOptions.IgnoreCase).Groups
            If regexAverageOpacity.Count > 1 Then
                dtRow.Item("AverageOpacity") = regexAverageOpacity(1).Value
            Else
                dtRow.Item("AverageOpacity") = 0
            End If
            regexTestResult = Regex.Match(part, "TEST RESULTS:\s*\*{4}\s([a-zA-Z]*)\s\*{4}(?=\r\n|\Z)", RegexOptions.IgnoreCase).Groups
            If regexTestResult.Count > 1 Then
                dtRow.Item("TestResult") = regexTestResult(1).Value.ToUpper()
            Else
                dtRow.Item("TestResult") = ""
            End If
            '' Mileage Import
            regexMileage = Regex.Match(part, "Vehicle Mileage:\s*([0-9]+)(?=\r\n|\Z)", RegexOptions.IgnoreCase).Groups
            If regexMileage.Count > 1 Then
                dtRow.Item("Mileage") = CInt(regexMileage(1).Value.ToUpper())
            Else
                dtRow.Item("Mileage") = DBNull.Value
            End If
        Next
    End Sub

    ' EvaluateRecords
    Protected Function EvaluateRecords(ByRef dtRows As DataRowCollection, Optional ByVal AttachToDBRecord As Boolean = True) As Boolean
        Dim localErrors As Boolean = False

        For Each dtRow As DataRow In dtRows
            dtRow.RowError = ""
            dtRow.Item("Errors") = ""

            If Not AttachToDBRecord Then
                dtRow.Item("OpacityTestsImportStatus") = "okay"
            Else
                Try
                    dtRow.Item("OpacityTestsImportStatus") = "pending"
                    If dtRow.Item("IDProfileAccount") <= 0 Then
                        dtRow.RowError &= " No Account for this Vehicle"
                    End If
                    If dtRow.Item("IDProfileTerminal") <= 0 Then
                        dtRow.RowError &= " No Terminal for this Vehicle"
                    End If
                    If dtRow.Item("IDVehicles") = Guid.Empty Then
                        dtRow.RowError &= " No ID for this Vehicle"
                    End If
                    If dtRow.Item("IDSignature") = Guid.Empty Then
                        dtRow.RowError &= " No tester signature found for this Vehicle"
                    End If
                    If dtRow.HasErrors Then
                        localErrors = True
                        dtRow.Item("OpacityTestsImportStatus") = "error"
                        dtRow.Item("Errors") = dtRow.RowError
                    End If
                Catch
                End Try
            End If
        Next

        Return localErrors
    End Function

    ' CheckTester
    Protected Function CheckTester(ByRef dtRow As DataRow) As Boolean
        Dim Name As String = dtRow.Item("TestedBy")
        Dim FirstName As String = ""
        Dim LastName As String = ""
        If Name.Contains(" ") Then
            Dim NameParts As String() = Name.Split(" ")
            FirstName = NameParts(0)
            LastName = NameParts(1)
        Else
            FirstName = Name
        End If
        Dim conn As New SqlConnection(connectionString)
        Dim comm As SqlCommand
        If LastName.Length = 0 Then
            comm = New SqlCommand("SELECT * FROM CF_Signatures WHERE @FirstName IN (FirstName, LastName) " &
              " OR @FirstName = RTRIM(LTRIM(RTRIM(ISNULL(FirstName,'')) + ' ' + RTRIM(ISNULL(LastName,'')) )) ", conn)
            comm.Parameters.AddWithValue("@FirstName", FirstName)
        Else
            comm = New SqlCommand("SELECT * FROM CF_Signatures WHERE FirstName = @FirstName AND LastName = @LastName", conn)
            comm.Parameters.AddWithValue("@FirstName", FirstName)
            comm.Parameters.AddWithValue("@LastName", LastName)
        End If

        Dim objReader As SqlDataReader
        Try
            comm.Connection.Open()
            objReader = comm.ExecuteReader()
            If objReader.Read() Then ' existing signature; update
                Dim IDSignature As New Guid(objReader("IDSignature").ToString())
                dtRow.Item("IDSignature") = IDSignature
                Return True
            Else
                hasErrors = True
                dtRow.RowError &= " No tester signature found for this Vehicle"
                Return False
            End If
            objReader.Close()
        Finally
            conn.Close()
            comm.Connection.Close()
        End Try
    End Function

    ' UpdateRecords
    Public Sub UpdateRecords(ByRef dt As DataTable)
        Dim localErrors As Boolean = False
        Dim dvVehicles As DataView = New DataView(dt)
        dvVehicles.Sort = "Unit ASC" ' sort the PDFs by unit number
        Dim dtTerminals As DataTable = dvVehicles.ToTable(True, "IDProfileTerminal")

        Try
            For Each drTerminal As DataRow In dtTerminals.Rows
                localErrors = False
                dvVehicles.RowFilter = "IDProfileTerminal = " & drTerminal("IDProfileTerminal")
                For Each drvVehicle As DataRowView In dvVehicles
                    Dim drVehicle As DataRow = drvVehicle.Row
                    If Not UpsertOpacityTest(drVehicle) Then
                        localErrors = True
                        Continue For
                    End If
                    '' Mileage Import
                    If Not UpsertMileageLog(drVehicle) Then
                        localErrors = True
                        Continue For
                    End If
                Next
                If Not localErrors Then
                    GeneratePDF(dvVehicles)
                End If
            Next
        Catch ex As Exception
            hasErrors = True
            Messages.Text &= "Error: " & ex.Message.ToString()
            Throw New Exception("Error encountered while updating records", ex)
        End Try

        Dim conn As New SqlConnection(connectionString)
        Dim comm = New SqlCommand("UPDATE CF_Vehicles SET LastOpacityTestDate = Opacity_Tests.[MaxDate] FROM CF_Vehicles INNER JOIN (SELECT IDVehicles, MAX(TestDate) [MaxDate] FROM CF_Vehicles_Log_OpacityTests GROUP BY CF_Vehicles_Log_OpacityTests.IDVehicles) Opacity_Tests ON CF_Vehicles.IDVehicles = Opacity_Tests.IDVehicles", conn)
        Try
            conn.Open()
            comm.ExecuteNonQuery()
        Finally
            comm.Connection.Close()
            conn.Close()
        End Try

        If Not hasErrors Then
            Messages.Text &= String.Format("Created {0} new Opacity Tests.<br />Updated {1} Opacity Tests.<br />Inserted {2} Mileage Logs.<br>Updated {3} Mileage Logs.", InsertOpacityTestsCount, UpdateOpacityTestsCount, InsertMileageLogCount, UpdateMileageLogCount)
        Else
            Messages.Text &= "Records could Not be imported. Please fix all issues before completing.<br>"
            Messages.Text &= "Records with one of these missing values have been highlighted in red And were Not imported.<br><br>"
            Messages.Text &= "Records highlighted in yellow are pending.<br>"
            Messages.Text &= "Records highlighted in red have one Or more problems.<br>"
        End If
    End Sub

    ' getIDProfileAccount
    Public Function getIDProfileAccount(AccountName As String) As Integer
        Dim IDModifiedUser As Guid = Membership.GetUser().ProviderUserKey
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As New SqlCommand("SELECT * FROM CF_Profile_Account WHERE UPPER(RTRIM(ISNULL(AccountName,''))) LIKE '%' + UPPER(RTRIM(ISNULL(@AccountName,''))) + '%'", conn)
        Dim objReader As SqlDataReader
        Dim recordValue As Integer = 0
        comm.Connection.Open()
        comm.Parameters.Add("@AccountName", SqlDbType.VarChar, 50).Value = AccountName
        objReader = comm.ExecuteReader()
        If objReader.Read() Then
            recordValue = objReader("IDProfileAccount")
        End If
        objReader.Close()
        conn.Close()
        Return recordValue
    End Function

    ' getIDProfileTerminal
    Public Function getIDProfileTerminal(IDProfileAccount As Integer, TerminalName As String) As Integer
        Dim IDModifiedUser As Guid = Membership.GetUser().ProviderUserKey
        Dim conn As New SqlConnection(connectionString)
        Dim comm As New SqlCommand("SELECT * FROM CF_Profile_Terminal " &
          "WHERE UPPER(RTRIM(ISNULL(TerminalName,''))) LIKE '%' + UPPER(RTRIM(ISNULL(@TerminalName,''))) + '%' " &
          "AND RTRIM(ISNULL(@TerminalName,'')) <> '' " &
          "AND IDProfileAccount = @IDProfileAccount", conn)
        Dim objReader As SqlDataReader
        Dim recordValue As Integer = 0
        comm.Connection.Open()
        comm.Parameters.Add("@TerminalName", SqlDbType.VarChar, 50).Value = TerminalName
        comm.Parameters.Add("@IDProfileAccount", SqlDbType.Int).Value = IDProfileAccount
        objReader = comm.ExecuteReader()
        If objReader.Read() Then
            recordValue = objReader("IDProfileTerminal")
        End If
        objReader.Close()
        conn.Close()
        Return recordValue
    End Function

    ' getIDVehicles
    Public Function getIDVehicles(IDProfileTerminal As Integer, LicensePlateNo As String, Unit As String) As Guid
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As New SqlCommand("SELECT * FROM CF_Vehicles INNER JOIN CF_Profile_Fleet ON CF_Vehicles.IDProfileFleet = CF_Profile_Fleet.IDProfileFleet WHERE IDProfileTerminal = @IDProfileTerminal AND UPPER(RTRIM(LicensePlateNo)) = UPPER(RTRIM(@LicensePlateNo)) AND (UPPER(RTRIM(ChassisVIN)) = UPPER(RTRIM(@Unit)) OR UPPER(RTRIM(UnitNo)) = UPPER(RTRIM(@Unit)))", conn)
        Dim objReader As SqlDataReader
        Dim recordValue As Guid = Guid.Empty
        comm.Connection.Open()

        comm.Parameters.AddWithValue("@IDProfileTerminal", IDProfileTerminal)
        comm.Parameters.AddWithValue("@LicensePlateNo", LicensePlateNo)
        comm.Parameters.AddWithValue("@Unit", Unit)
        objReader = comm.ExecuteReader()
        If objReader.Read() Then
            recordValue = objReader("IDVehicles")
        End If
        objReader.Close()
        conn.Close()
        Return recordValue
    End Function

    ' BestGuessVehicleAndTerminal
    Public Function BestGuessVehicleAndTerminal(ByRef dtRow As DataRow) As Boolean
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As New SqlCommand("SELECT CF_Vehicles.IDVehicles, CF_Profile_Terminal.IDProfileTerminal FROM CF_Vehicles " &
          "INNER JOIN CF_Profile_Fleet ON CF_Vehicles.IDProfileFleet = CF_Profile_Fleet.IDProfileFleet " &
          "INNER JOIN CF_Profile_Terminal ON CF_Profile_Fleet.IDProfileTerminal = CF_Profile_Terminal.IDProfileTerminal " &
          "WHERE CF_Profile_Terminal.IDProfileAccount = @IDProfileAccount " &
          "AND @IDProfileTerminal IN (0, CF_Profile_Terminal.IDProfileTerminal)" &
          "AND UPPER(RTRIM(LicensePlateNo)) = UPPER(RTRIM(@LicensePlateNo)) " &
          "AND UPPER(RTRIM(@Unit)) IN (UPPER(RTRIM(ChassisVIN)), UPPER(RTRIM(UnitNo)) )", conn)
        Dim objReader As SqlDataReader
        Dim recordValue As Guid = Guid.Empty
        comm.Connection.Open()
        comm.Parameters.AddWithValue("@IDProfileAccount", dtRow("IDProfileAccount"))
        comm.Parameters.AddWithValue("@IDProfileTerminal", DB.RNI(dtRow("IDProfileTerminal")))
        comm.Parameters.AddWithValue("@LicensePlateNo", dtRow("LicensePlate"))
        comm.Parameters.AddWithValue("@Unit", dtRow("Unit"))
        objReader = comm.ExecuteReader()
        Dim firstIDVehicles As Guid = Guid.Empty
        Dim firstIDProfileTerminal As Integer = 0
        Dim recCount As Integer = 0
        Dim result = False
        If objReader.Read() Then
            firstIDVehicles = objReader("IDVehicles")
            firstIDProfileTerminal = objReader("IDProfileTerminal")
            recCount += 1
        End If
        While objReader.Read()
            recCount += 1
        End While
        If recCount = 1 Then
            dtRow("IDVehicles") = firstIDVehicles
            dtRow("IDProfileTerminal") = firstIDProfileTerminal
            result = True
        ElseIf recCount = 0 Then

            If dtRow("IDProfileAccount") > 0 Then
                dtRow.RowError &= "No Vehicles matching VIN/Unit and License Plate found in this Account"
            End If
        Else
            dtRow.RowError &= "One or more possible Vehicle matches in this Account"
        End If
        objReader.Close()
        conn.Close()

        Return result
    End Function

    ' UpsertOpacityTest
    Public Function UpsertOpacityTest(ByRef dtRow As DataRow) As Boolean
        Dim IDVehicles As New Guid(dtRow.Item("IDVehicles").ToString())
        Dim conn As New SqlConnection(connectionString)
        Dim comm As SqlCommand
        Dim IDModifiedUser As Guid = Membership.GetUser().ProviderUserKey

        Dim objReader As SqlDataReader

        comm = New SqlCommand("SELECT IDOpacityTestsLog FROM CF_Vehicles_Log_OpacityTests WHERE IDVehicles = @IDVehicles AND TestDate = DATEADD(dd, DATEDIFF(dd, 0, @TestDate), 0)", conn)
        comm.Parameters.AddWithValue("@IDVehicles", IDVehicles)
        comm.Parameters.AddWithValue("@TestDate", dtRow.Item("TestDate"))
        comm.Connection.Open()
        objReader = comm.ExecuteReader()

        If objReader.Read() Then ' existing opacity test; update
            Dim IDOpacityTestsLog As New Guid(objReader("IDOpacityTestsLog").ToString())
            objReader.Close()
            comm = New SqlCommand("UPDATE CF_Vehicles_Log_OpacityTests SET IDModifiedUser = @IDModifiedUser, ModifiedDate = GETDATE(), " &
              "AverageOpacity = @AverageOpacity, TestResult = @TestResult, " &
              "TestedBy = @TestedBy, TestDate = DATEADD(dd, DATEDIFF(dd, 0, @TestDate), 0)" &
              " WHERE IDOpacityTestsLog = @IDOpacityTestsLog", conn)
            comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
            comm.Parameters.AddWithValue("@IDOpacityTestsLog", IDOpacityTestsLog)
            comm.Parameters.AddWithValue("@AverageOpacity", dtRow.Item("AverageOpacity").ToString())
            comm.Parameters.AddWithValue("@TestResult", dtRow.Item("TestResult").ToString())
            comm.Parameters.AddWithValue("@TestedBy", dtRow.Item("TestedBy").ToString())
            comm.Parameters.AddWithValue("@TestDate", dtRow.Item("TestDate").ToString())
            Try
                comm.ExecuteNonQuery()
                dtRow("OpacityTestsImportStatus") = "update"
                UpdateOpacityTestsCount += 1
            Catch sqlExc As SqlException
                hasErrors = True
                dtRow.RowError &= sqlExc.ToString()
                dtRow.Item("Errors") = dtRow.RowError
                Return False
            Finally
                conn.Close()
                comm.Connection.Close()
            End Try
        Else ' no opacity test; insert
            objReader.Close()

            comm = New SqlCommand("INSERT INTO CF_Vehicles_Log_OpacityTests (IDVehicles, IDModifiedUser, EnterDate, ModifiedDate, AverageOpacity, TestResult, TestedBy, TestDate, RawTestResults, ScannerModel) " &
                  "VALUES (@IDVehicles, @IDModifiedUser, GETDATE(), GETDATE(), @AverageOpacity, @TestResult, @TestedBy, DATEADD(dd, DATEDIFF(dd, 0, @TestDate), 0), @RawTestResults, @ScannerModel)", conn)
            comm.Parameters.AddWithValue("@IDVehicles", IDVehicles)
            comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)

            For Each fieldname As String In New String() {"AverageOpacity", "TestResult", "TestedBy", "TestDate", "RawTestResults", "ScannerModel"}
                If dtRow.Table.Columns.Contains(fieldname) Then
                    comm.Parameters.AddWithValue("@" & fieldname, dtRow.Item(fieldname))
                End If
            Next

            Try
                ''Debugging
                'Dim query As String = SqlDbCommandDebug(comm)
                ''Debugging
                comm.ExecuteNonQuery()
                dtRow("OpacityTestsImportStatus") = "insert"
                InsertOpacityTestsCount += 1
            Catch sqlExc As SqlException
                hasErrors = True
                dtRow.RowError &= sqlExc.ToString()
                dtRow.Item("Errors") = dtRow.RowError
                Return False
            Finally
                conn.Close()
                comm.Connection.Close()
            End Try
        End If
        Return True
    End Function

    ' UpsertMileageLog
    '' Mileage Import
    Public Function UpsertMileageLog(ByRef dtRow As DataRow) As Boolean
        Dim Mileage As Integer? = If(Convert.IsDBNull(dtRow.Item("Mileage")), Nothing, dtRow.Item("Mileage"))
        If Mileage.HasValue = False OrElse Mileage <= 0 Then
            Return True
        End If
        Dim IDVehicles As New Guid(dtRow.Item("IDVehicles").ToString())
        Dim conn As New SqlConnection(connectionString)
        Dim comm As SqlCommand
        Dim IDModifiedUser As Guid = Membership.GetUser().ProviderUserKey

        Dim objReader As SqlDataReader

        comm = New SqlCommand("SELECT IDMileageLog FROM CF_Vehicles_Log_Mileage WHERE IDVehicles = @IDVehicles AND MileageDate = DATEADD(dd, DATEDIFF(dd, 0, @TestDate), 0)", conn)
        comm.Parameters.AddWithValue("@IDVehicles", IDVehicles)
        comm.Parameters.AddWithValue("@TestDate", dtRow.Item("TestDate").ToString())
        comm.Connection.Open()
        objReader = comm.ExecuteReader()

        If objReader.Read() Then ' existing opacity test; update
            Dim IDMileageLog As New Guid(objReader("IDMileageLog").ToString())
            objReader.Close()
            comm = New SqlCommand("UPDATE CF_Vehicles_Log_Mileage SET IDModifiedUser = @IDModifiedUser, ModifiedDate = GETDATE(), EnterDate = GETDATE(), " &
              "Mileage = @Mileage, MileageDate = DATEADD(dd, DATEDIFF(dd, 0, @TestDate), 0) WHERE IDMileageLog = @IDMileageLog", conn)
            comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
            comm.Parameters.AddWithValue("@IDMileageLog", IDMileageLog)
            comm.Parameters.AddWithValue("@Mileage", dtRow.Item("Mileage").ToString())
            comm.Parameters.AddWithValue("@TestDate", dtRow.Item("TestDate").ToString())
            Try
                comm.ExecuteNonQuery()
                UpdateMileageLogCount += 1
            Catch sqlExc As SqlException
                hasErrors = True
                dtRow.RowError &= sqlExc.ToString()
                dtRow.Item("Errors") = dtRow.RowError
                Return False
            Finally
                conn.Close()
                comm.Connection.Close()
            End Try
        Else ' no opacity test; insert
            objReader.Close()

            comm = New SqlCommand("INSERT INTO CF_Vehicles_Log_Mileage (IDVehicles, IDModifiedUser, EnterDate, ModifiedDate, Mileage, MileageDate) " &
              "VALUES (@IDVehicles, @IDModifiedUser, GETDATE(), GETDATE(), @Mileage, DATEADD(dd, DATEDIFF(dd, 0, @TestDate), 0))", conn)
            comm.Parameters.AddWithValue("@IDVehicles", IDVehicles)
            comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)

            For Each fieldname As String In New String() {"Mileage", "TestDate"}
                If dtRow.Table.Columns.Contains(fieldname) Then
                    comm.Parameters.AddWithValue("@" & fieldname, dtRow.Item(fieldname))
                End If
            Next

            Try
                comm.ExecuteNonQuery()
                InsertMileageLogCount += 1
            Catch sqlExc As SqlException
                hasErrors = True
                dtRow.RowError &= sqlExc.ToString()
                dtRow.Item("Errors") = dtRow.RowError
                Return False
            Finally
                conn.Close()
                comm.Connection.Close()
            End Try
        End If
        Return True
    End Function

    ' lb_selectUnit_Click
    Protected Sub lb_selectUnit_Click(ByVal sender As Object, ByVal e As GridCommandEventArgs) Handles rg_Terminals.ItemCommand
        Select Case e.CommandName
            Case "SelectUnit"
                Dim dr As DataRow = myDataTable.Select("IDImport = " & EditingRecord)(0)
                dr("IDVehicles") = New Guid(e.CommandArgument.ToString())

                ResetEditingRecord()

                hasErrors = EvaluateRecords(myDataTable.Rows)

                If Not hasErrors Then
                    UpdateRecords(myDataTable)
                End If
                Dim myDataView = myDataTable.AsDataView()
                myDataView.Sort = "OpacityTestsImportStatus ASC"
                gv_Text.DataSource = myDataView
                gv_Text.DataBind()

                If Not hasErrors Then
                    myDataTable = New DataTable()
                End If
        End Select
    End Sub

    ' ddl_Account_SelectedIndexChanged
    Protected Sub ddl_Account_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim IDProfileAccount As Integer = Convert.ToInt32(ddl_Account.SelectedValue.ToString())
        Dim dr As DataRow = myDataTable.Select("IDImport = " & EditingRecord)(0)
        dr("IDProfileAccount") = IDProfileAccount
        hidIDProfileAccount.Value = IDProfileAccount
        hidIDProfileTerminal.Value = 0
        hidIDProfileFleet.Value = 0
        fillTerminals(IDProfileAccount)
        fillFleets(0)
        rg_Terminals_OnLoad(Nothing, Nothing)
    End Sub

    ' fillTerminals
    Protected Sub fillTerminals(IDProfileAccount As Integer)
        If IDProfileAccount > 0 Then
            Dim dr As DataRow = myDataTable.Select("IDImport = " & EditingRecord)(0)
            Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)

            Dim adapter As New SqlDataAdapter("SELECT * FROM [CF_Profile_Terminal] WHERE ([IDProfileAccount] = @IDProfileAccount) ORDER BY [TerminalName]", connection)
            adapter.SelectCommand.Parameters.AddWithValue("@IDProfileAccount", IDProfileAccount)

            Dim dt As New DataTable()
            adapter.Fill(dt)

            ddl_Terminal.DataTextField = "TerminalName"
            ddl_Terminal.DataValueField = "IDProfileTerminal"
            ddl_Terminal.DataSource = dt
            ddl_Terminal.DataBind()
            ddl_Terminal.Items.Insert(0, New ListItem("- Select Terminal -", "0"))
        Else
            ddl_Terminal.Items.Clear()
        End If
    End Sub

    ' ddl_Terminal_SelectedIndexChanged
    Protected Sub ddl_Terminal_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim IDProfileTerminal As Integer = Convert.ToInt32(ddl_Terminal.SelectedValue.ToString())
        hidIDProfileTerminal.Value = IDProfileTerminal
        hidIDProfileFleet.Value = 0
        fillFleets(IDProfileTerminal)
        rg_Terminals_OnLoad(Nothing, Nothing)
    End Sub

    ' fillFleets
    Protected Sub fillFleets(IDProfileTerminal As Integer)
        If IDProfileTerminal > 0 Then
            Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)

            Dim adapter As New SqlDataAdapter("SELECT * FROM [CF_Profile_Fleet] WHERE ([IDProfileTerminal] = @IDProfileTerminal)", connection)
            adapter.SelectCommand.Parameters.AddWithValue("@IDProfileTerminal", IDProfileTerminal)

            Dim dt As New DataTable()
            adapter.Fill(dt)

            ddl_Fleet.DataTextField = "FleetName"
            ddl_Fleet.DataValueField = "IDProfileFleet"
            ddl_Fleet.DataSource = dt
            ddl_Fleet.DataBind()
            ddl_Fleet.Items.Insert(0, New ListItem("- Select Fleet -", "0"))
        Else
            ddl_Fleet.Items.Clear()
        End If
    End Sub

    ' ddl_Fleet_SelectedIndexChanged
    Protected Sub ddl_Fleet_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim IDProfileAccount As Integer = Convert.ToInt32(hidIDProfileAccount.Value)
        Dim IDProfileTerminal As Integer = Convert.ToInt32(hidIDProfileTerminal.Value)
        Dim IDProfileFleet As Integer = Convert.ToInt32(ddl_Fleet.SelectedValue.ToString())
        Dim dr As DataRow = myDataTable.Select("IDImport = " & EditingRecord)(0)
        dr("IDProfileAccount") = IDProfileAccount
        dr("IDProfileTerminal") = IDProfileTerminal
        dr("IDProfileFleet") = IDProfileFleet
        hidIDProfileFleet.Value = IDProfileFleet
        rg_Terminals_OnLoad(Nothing, Nothing)
    End Sub

    ' rg_Terminals_OnLoad
    Protected Sub rg_Terminals_OnLoad(ByVal o As Object, ByVal e As EventArgs) Handles rg_Terminals.Load
        Dim IDProfileFleet As Integer
        Integer.TryParse(hidIDProfileFleet.Value, IDProfileFleet)
        rg_Terminals.Visible = IDProfileFleet > 0
    End Sub

    ' rg_Terminals_ItemCreated
    Protected Sub rg_Terminals_ItemCreated(ByVal sender As Object, ByVal e As Telerik.Web.UI.GridItemEventArgs) Handles rg_Terminals.ItemCreated
        If TypeOf e.Item Is GridCommandItem Then
            e.Item.FindControl("InitInsertButton").Parent.Visible = False
        End If
    End Sub

    ' ddl_Account_DataBound
    Protected Sub ddl_Account_DataBound(ByVal sender As Object, ByVal e As EventArgs)
        Dim IDProfileAccount As Integer = CInt(hidIDProfileAccount.Value)
        If IDProfileAccount > 0 Then
            ddl_Account.SelectedValue = hidIDProfileAccount.Value
            fillTerminals(hidIDProfileAccount.Value)
        End If
    End Sub

    ' ddl_Terminal_DataBound
    Protected Sub ddl_Terminal_DataBound(ByVal sender As Object, ByVal e As EventArgs)
        Dim IDProfileTerminal As Integer = CInt(hidIDProfileTerminal.Value)
        If IDProfileTerminal > 0 Then
            ddl_Terminal.SelectedValue = hidIDProfileTerminal.Value
            fillFleets(hidIDProfileTerminal.Value)
        End If
    End Sub

    ' ddl_Fleet_DataBound
    Protected Sub ddl_Fleet_DataBound(ByVal sender As Object, ByVal e As EventArgs)
        Dim IDProfileFleet As Integer = CInt(hidIDProfileFleet.Value)
        If IDProfileFleet > 0 Then
            ddl_Fleet.SelectedValue = hidIDProfileFleet.Value
        End If
    End Sub

    ' gv_Text_OnRowCommand
    Protected Sub gv_Text_OnRowCommand(sender As Object, e As GridViewCommandEventArgs)
        Dim IDImport As Integer = CInt(e.CommandArgument)
        Dim dr As DataRow = myDataTable.Select("IDImport = " & IDImport)(0)
        Dim IDProfileAccount As Integer = dr("IDProfileAccount")
        Dim IDProfileTerminal As Integer = dr("IDProfileTerminal")
        Dim IDProfileFleet As Integer = dr("IDProfileFleet")
        hidIDProfileAccount.Value = IDProfileAccount
        hidIDProfileTerminal.Value = IDProfileTerminal
        hidIDProfileFleet.Value = IDProfileFleet
        EditingRecord = IDImport
        tbCompanyName.Text = dr("CompanyName")
        tbTestCity.Text = dr("TestCity")
        tbLicensePlate.Text = dr("LicensePlate")
        tbUnitNo.Text = dr("Unit")
        tbTestDate.Text = dr("TestDate")
        tbTestedBy.Text = dr("TestedBy")
        tbAverageOpacity.Text = dr("AverageOpacity")
        tbTestResult.Text = dr("TestResult")
        tbMileage.Text = dr("Mileage")
        Select Case e.CommandName
            Case "SelectAccount"
                ddl_Account.Visible = True
                ddl_Terminal.Visible = True
                pnlFixRecords.Visible = True
                pnlSelectUnit.Visible = True
                pnlSelectSignature.Visible = False
                dvSectionImport.Visible = False
            Case "SelectTerminal"
                ddl_Account.Visible = True
                If ddl_Account.Items.Count > 1 Then
                    ddl_Account.SelectedValue = hidIDProfileAccount.Value
                    fillTerminals(hidIDProfileAccount.Value)
                End If
                ddl_Terminal.Visible = True
                pnlFixRecords.Visible = True
                pnlSelectUnit.Visible = True
                pnlSelectSignature.Visible = False
                dvSectionImport.Visible = False
                fillTerminals(dr("IDProfileAccount"))
            Case "SelectUnit"
                ddl_Account.Visible = True
                If ddl_Account.Items.Count > 1 Then
                    ddl_Account.SelectedValue = hidIDProfileAccount.Value
                    fillTerminals(hidIDProfileAccount.Value)
                End If
                ddl_Terminal.Visible = True
                pnlFixRecords.Visible = True
                pnlSelectUnit.Visible = True
                pnlSelectSignature.Visible = False
                dvSectionImport.Visible = False
                rg_Terminals_OnLoad(Nothing, Nothing)
            Case "SelectSignature"
                Dim IDSignature As New Guid(dr("IDSignature").ToString())
                pnlFixRecords.Visible = True
                pnlSelectUnit.Visible = False
                pnlSelectSignature.Visible = True
                dvSectionImport.Visible = False
                Dim myDataTable As DataTable = GetSignatures()
                gv_Signatures.DataSource = myDataTable
                gv_Signatures.DataBind()
        End Select
    End Sub

    ' ReturnList
    Public Sub ReturnList(sender As Object, e As EventArgs) Handles btnReturnList.Click
        'Response.redirect("default.aspx")
        ResetEditingRecord()
    End Sub

    ' gv_Signatures_OnRowCommand
    Protected Sub gv_Signatures_OnRowCommand(sender As Object, e As GridViewCommandEventArgs)
        Dim IDSignature As New Guid(e.CommandArgument.ToString())
        Select Case e.CommandName
            Case "SelectSignature"
                Dim dr As DataRow = myDataTable.Select("IDImport = " & EditingRecord)(0)
                dr.Item("IDSignature") = IDSignature
                dr.Item("TesterDetected") = True

                ResetEditingRecord()

                hasErrors = EvaluateRecords(myDataTable.Rows)

                If Not hasErrors Then
                    UpdateRecords(myDataTable)
                End If
                Dim myDataView = myDataTable.AsDataView()
                myDataView.Sort = "OpacityTestsImportStatus ASC"
                gv_Text.DataSource = myDataView
                gv_Text.DataBind()

                If Not hasErrors Then
                    myDataTable = New DataTable()
                End If
        End Select
    End Sub

    ' ResetEditingRecord
    Protected Sub ResetEditingRecord()
        EditingRecord = -1
        hidIDProfileAccount.Value = 0
        hidIDProfileTerminal.Value = 0
        hidIDProfileFleet.Value = 0
        pnlFixRecords.Visible = False
        dvSectionImport.Visible = True
        fillTerminals(0)
        fillFleets(0)
        ddl_Account.SelectedIndex = 0

        tbCompanyName.Text = ""
        tbTestCity.Text = ""
        tbLicensePlate.Text = ""
        tbUnitNo.Text = ""
        tbTestDate.Text = ""
        tbTestedBy.Text = ""
        tbAverageOpacity.Text = ""
        tbTestResult.Text = ""
        tbMileage.Text = ""
    End Sub

    ' GetSignatures
    Protected Function GetSignatures() As DataTable
        Dim conn As New SqlConnection(connectionString)
        conn.Open()
        Dim adapter As New SqlDataAdapter("SELECT * FROM [CF_Signatures]", conn)
        Try
            Dim dt As New DataTable()
            adapter.Fill(dt)
            Return dt
        Catch sqlExc As SqlException
            hasErrors = True
            Messages.Text = sqlExc.Message.ToString()
            Return New DataTable()
        Finally
            conn.Close()
        End Try
    End Function

    ' GeneratePDF
    Protected Function GeneratePDF(ByVal dvRow As DataView, Optional ByVal AttachToDBRecord As Boolean = True)
        Dim RFilePath As String

        If dvRow.Count = 0 Then
            Throw New ArgumentException("No test results for given view")
        End If

        Dim TestDate As String = DateTime.Parse(dvRow(0)("TestDate")).ToString("MM/dd/yyyy")
        Dim IDProfileAccount As Integer = dvRow(0)("IDProfileAccount")
        Dim IDProfileTerminal As Integer = dvRow(0)("IDProfileTerminal")

        Dim PdfDoc As New Doc()
        'setup font
        PdfDoc.Font = PdfDoc.EmbedFont("Tahoma")

        'logo
        Dim img As New Bitmap(Path.Combine(Server.MapPath("~/images"), "CF_Logo.jpg"))
        Dim imgWidth As Double = img.Width / 6
        Dim imgHeight As Double = img.Height / 6

        For Each drvRow As DataRowView In dvRow
            Dim dtRow As DataRow = drvRow.Row
            PdfDoc.Page = PdfDoc.AddPage()

            Dim RedMountainSig As Regex = New Regex("Tester\'s Signature(\s|\S)*", RegexOptions.IgnoreCase)
            Dim WagerSig As Regex = New Regex("TESTER\s_*(?:\r\n|\n|\r)", RegexOptions.IgnoreCase)
            Dim RedMountainPassFail As Regex = New Regex("", RegexOptions.IgnoreCase)
            Dim WagerPassFail As Regex = New Regex("", RegexOptions.IgnoreCase)
            Dim IDSignature As New Guid(dtRow.Item("IDSignature").ToString())
            Dim ScannerName As String = "unknown"
            Dim RawTestResults As String = dtRow("RawTestResults").ToString().Trim().TrimEnd(vbCr, vbLf, " ")
            'Dim CircleTop As Double  --WARNINGS commented out by due to not being used Sam 2/20
            Dim CircleRight As Double
            Dim CircleBottom As Double
            Dim CircleLeft As Double
            Dim CircleHeight As Double
            Dim CircleWidth As Double
            Dim SignatureTop As Double
            Dim SignatureLeft As Double
            Dim SignatureText As String = ""
            Dim DocLeft As Double = toPoints(1)
            Dim DocRight As Double = toPoints(4.5)
            Dim SignatureWidth As Double = toPoints(1)
            Dim SignatureHeight As Double = toPoints(0.5)
            Dim SignatureLineStart As New XPoint()
            Dim SignatureLineEnd As New XPoint()
            Dim LineOffsetFromEnd As Double
            If Not dtRow("ScannerModel") Is DBNull.Value Then
                ScannerName = dtRow("ScannerModel")
            End If
            'logo size 870x199, resized to 1/6 size
            PdfDoc.Rect.Top = toPoints(10.75)
            PdfDoc.Rect.Right = DocLeft + toPoints(0.5) + imgWidth
            PdfDoc.Rect.Bottom = toPoints(10.5) - imgHeight
            PdfDoc.Rect.Left = DocLeft + toPoints(0.5)
            PdfDoc.AddImage(img)

            'address
            PdfDoc.Rect.Top = toPoints(10.82) - imgHeight
            PdfDoc.Rect.Right = DocLeft + toPoints(0.5) + imgWidth
            PdfDoc.Rect.Bottom = toPoints(9.82) - imgHeight
            PdfDoc.Rect.Left = DocLeft + toPoints(0.5)
            PdfDoc.HPos = 0.5
            PdfDoc.VPos = 0.5
            PdfDoc.FontSize = 12
            PdfDoc.Color.String = "0 0 0"
            PdfDoc.AddText("1822 21ST STREET" & Environment.NewLine & "SACRAMENTO, CA 95811")

            SignatureLineStart.X = DocLeft
            SignatureLineEnd.X = DocRight

            'settle differences
            If ScannerName = "wager" Then
                RawTestResults = WagerSig.Replace(RawTestResults, "").Trim().TrimEnd(vbCr, vbLf, " ")
                ' CircleTop = toPoints(3.35)
                CircleRight = toPoints(2.125)
                ' CircleBottom = toPoints(3.05)
                CircleLeft = toPoints(1.5)
                PdfDoc.FontSize = 10

                SignatureTop = toPoints(1.9) + SignatureHeight
                SignatureLeft = DocLeft
                SignatureText = "TESTER"

                Dim resultsAt = Math.Max(Math.Max(RawTestResults.ToLower().LastIndexOf("pass"), RawTestResults.ToLower().LastIndexOf("fail")), RawTestResults.ToLower().LastIndexOf("invalid"))
                ' ADS 2016-10-14 There was no pass or fail found in this row....
                If resultsAt < 0 Then
                    LineOffsetFromEnd = -1
                Else
                    LineOffsetFromEnd = RawTestResults.Substring(resultsAt).Split(vbCr).Length
                End If
            Else ' red mountain
                RawTestResults = RedMountainSig.Replace(RawTestResults, "").Trim().TrimEnd(vbCr, vbLf, " ")
                ' CircleTop = toPoints(1.3)
                CircleRight = toPoints(3.2125)
                ' CircleBottom = toPoints(1.0)
                CircleLeft = toPoints(2.6125)
                PdfDoc.FontSize = 10

                SignatureTop = toPoints(0.1) + SignatureHeight
                SignatureLeft = DocLeft
                SignatureText = "Tester's Signature"
                Dim resultsAt = Math.Max(Math.Max(RawTestResults.ToLower().LastIndexOf("pass"), RawTestResults.ToLower().LastIndexOf("fail")), RawTestResults.ToLower().LastIndexOf("invalid"))
                ' ADS 2016-10-14 There was no pass or fail found in this row....
                If resultsAt < 0 Then
                    LineOffsetFromEnd = -1
                Else
                    LineOffsetFromEnd = RawTestResults.Substring(resultsAt).Split(vbCr).Length
                End If
            End If
            CircleHeight = toPoints(0.3)
            CircleWidth = CircleRight - CircleLeft



            'test results
            PdfDoc.Rect.Top = toPoints(9.82) - imgHeight
            PdfDoc.Rect.Right = DocRight
            PdfDoc.Rect.Bottom = toPoints(1.5)
            PdfDoc.Rect.Left = DocLeft
            PdfDoc.HPos = 0
            PdfDoc.VPos = 0

            Dim numberOfLines = RawTestResults.Split(vbCr).Length()
            Dim estimatedHeightOfText = (PdfDoc.TextStyle.Size + PdfDoc.TextStyle.LineSpacing) * numberOfLines
            Dim textSizeSave = PdfDoc.TextStyle.Size
            Dim lineSpacingSave = PdfDoc.TextStyle.LineSpacing
            'Throw New Exception(String.Format("I'm taking up {0} Of {1}", estimatedHeightOfText, PdfDoc.Rect.Height))
            If estimatedHeightOfText > PdfDoc.Rect.Height Then
                Dim scaleFactor = PdfDoc.Rect.Height / estimatedHeightOfText
                PdfDoc.TextStyle.Size = PdfDoc.TextStyle.Size * scaleFactor
                PdfDoc.TextStyle.LineSpacing = PdfDoc.TextStyle.LineSpacing * scaleFactor
                CircleLeft = (CircleLeft - DocLeft) * scaleFactor + DocLeft
                CircleWidth = CircleWidth * scaleFactor
            End If
            ' Now that we've set up the size, just let it overflow because slight rounding errors 
            ' can cause the text to clip.
            PdfDoc.Rect.Bottom = toPoints(0)

            ' If you don't add the vbcr at the end then YPos will be at the last row.
            PdfDoc.AddText(RawTestResults.TrimEnd(vbCr, vbLf, " ") & vbCr)

            Dim curPos As New XPoint(PdfDoc.Pos.ToString)

            If LineOffsetFromEnd >= 0 Then
                CircleBottom = curPos.Y + (PdfDoc.TextStyle.Size + PdfDoc.TextStyle.LineSpacing) * (LineOffsetFromEnd - 1)
                CircleBottom -= CircleHeight / 4
                'test result circle
                PdfDoc.Rect.Bottom = CircleBottom
                PdfDoc.Rect.Left = CircleLeft
                PdfDoc.Rect.Top = PdfDoc.Rect.Bottom + CircleHeight
                PdfDoc.Rect.Right = PdfDoc.Rect.Left + CircleWidth
                PdfDoc.Color.String = "255 0 0"
                PdfDoc.Width = toPoints(0.03)
                PdfDoc.AddOval(False)
            End If

            PdfDoc.TextStyle.Size = textSizeSave
            PdfDoc.TextStyle.LineSpacing = lineSpacingSave

            'signature text
            SignatureTop = curPos.Y - (PdfDoc.TextStyle.Size + PdfDoc.TextStyle.LineSpacing) * 2 ' 2.5 is a magic number. AFAIk, it should be 2.
            'SignatureTop = curPos.Y - (0 + 0)*1 ' 2.5 is a magic number. AFAIk, it should be 2.
            SignatureLineStart.Y = SignatureTop - SignatureHeight
            SignatureLineEnd.Y = SignatureTop - SignatureHeight

            PdfDoc.Rect.Top = SignatureTop
            PdfDoc.Rect.Right = DocRight
            PdfDoc.Rect.Bottom = SignatureTop - Math.Max(0, toPoints(1.5))
            PdfDoc.Rect.Left = DocLeft
            PdfDoc.Color.String = "0 0 0"
            PdfDoc.AddText(SignatureText)

            'signature
            Dim signature As New Bitmap(Server.MapPath(GetSignatureFilePath(IDSignature)))
            PdfDoc.Rect.Top = SignatureTop - toPoints(0.125)
            PdfDoc.Rect.Right = DocLeft + toPoints(0.5) + SignatureWidth
            PdfDoc.Rect.Bottom = SignatureTop - toPoints(0.125) - SignatureHeight
            PdfDoc.Rect.Left = DocLeft + toPoints(0.5)
            PdfDoc.AddImageBitmap(signature, True)
            PdfDoc.Color.String = "0 0 0"
            PdfDoc.Width = toPoints(0.01)
            PdfDoc.AddLine(SignatureLineStart.X, SignatureLineStart.Y, SignatureLineEnd.X, SignatureLineEnd.Y)
        Next

        Dim PDFFileName As String = Guid.NewGuid().ToString() & ".pdf"
        Dim PDFFilePath As String

        If Not AttachToDBRecord Then
            PDFFilePath = Path.Combine(Server.MapPath(TempFileRepositoryFolder), PDFFileName)

            Try
                If Not Directory.Exists(Server.MapPath(TempFileRepositoryFolder)) Then
                    Directory.CreateDirectory(Server.MapPath(TempFileRepositoryFolder))
                End If

                PdfDoc.Save(PDFFilePath)
            Catch ex As Exception
                Throw
            End Try

            RFilePath = Path.Combine(TempFileRepositoryFolder, PDFFileName)
        Else
            PDFFilePath = Path.Combine(Server.MapPath(FileRepositoryFolder), PDFFileName)

            Try
                PdfDoc.Save(PDFFilePath)
                SavePDFPath(IDProfileAccount, IDProfileTerminal, TestDate, dvRow.Count, PDFFilePath)
            Catch ex As Exception
                Throw
            End Try

            RFilePath = Path.Combine(FileRepositoryFolder, PDFFileName)
        End If

        Return RFilePath
    End Function

    ' SavePDFPath
    Protected Sub SavePDFPath(ByVal IDProfileAccount As Integer, ByVal IDProfileTerminal As Integer, ByVal TestDate As String, ByVal NumberOfVehicles As Integer, ByVal PdfFilePath As String)
        Dim PdfFileInfo As FileInfo = New FileInfo(PdfFilePath)
        Dim IDModifiedUser As Guid = Membership.GetUser().ProviderUserKey
        Dim IDFile As String = Guid.NewGuid.ToString()
        Dim IDDocumentType As Integer = 655 ' SELECT IDOptionList FROM CF_Option_List WHERE OptionName = 'DocumentType' AND RecordValue = 'OpacityTests'
        Dim Title As String = String.Format("PSIP Test Results on {0} for {1} Vehicles", TestDate, NumberOfVehicles)
        Using conn As New SqlConnection(connectionString)
            conn.Open()
            Using comm As New SqlCommand("SELECT IDOptionList FROM CF_Option_List WHERE OptionName = 'DocumentType' AND RecordValue = 'OpacityTests'", conn)
                IDDocumentType = comm.ExecuteScalar()
            End Using
            Using comm As New SqlCommand("INSERT INTO [CF_Files] (IDFile, EnterDate, IDModifiedUser, ModifiedDate, Title, FileName, FileSize, FilePath, IDDocumentType, IDProfileAccount, IDProfileTerminal) VALUES(@IDFile, GETDATE(), @IDModifiedUser, GETDATE(), @Title, @FileName, @FileSize, @FilePath, @IDDocumentType, @IDProfileAccount, @IDProfileTerminal)", conn)
                With comm.Parameters
                    .AddWithValue("@IDFile", IDFile)
                    .AddWithValue("@IDModifiedUser", IDModifiedUser)
                    .AddWithValue("@Title", Title)
                    .AddWithValue("@FileName", PdfFileInfo.Name)
                    .AddWithValue("@FileSize", PdfFileInfo.Length)
                    .AddWithValue("@FilePath", FileRepositoryFolder)
                    .AddWithValue("@IDDocumentType", IDDocumentType)
                    .AddWithValue("@IDProfileAccount", IDProfileAccount)
                    .AddWithValue("@IDProfileTerminal", IDProfileTerminal)
                End With

                Try
                    comm.ExecuteNonQuery()
                Catch ex As Exception
                    Throw New Exception(String.Format("Unable to save {0} to File Repository", PdfFileInfo.Name), ex)
                Finally
                    If conn.State <> ConnectionState.Closed Then
                        conn.Close()
                    End If
                End Try
            End Using
        End Using
    End Sub

    ' GetSignatureFilePath
    Protected Function GetSignatureFilePath(ByVal IDSignature As Guid) As String
        Dim conn As New SqlConnection(connectionString)
        Dim comm As New SqlCommand("SELECT FilePath FROM CF_Signatures WHERE IDSignature = @IDSignature", conn)
        Dim objReader As SqlDataReader
        Dim recordValue As String = ""
        comm.Connection.Open()

        comm.Parameters.AddWithValue("@IDSignature", IDSignature)
        objReader = comm.ExecuteReader()
        If objReader.Read() Then
            recordValue = objReader("FilePath")
        End If
        objReader.Close()
        conn.Close()
        Return recordValue
    End Function

    ' toPoints
    Protected Function toPoints(ByVal inches As Double) As Double
        Return (inches * 72)
    End Function

    ' toInches
    Protected Function toInches(ByVal points As Double) As Double
        Return (points / 72)
    End Function

    ' SqlDbCommandDebug
    Public Function SqlDbCommandDebug(ByVal oCommand As SqlCommand) As String
        Dim query As String = ""

        query = oCommand.CommandText

        For Each param As SqlParameter In oCommand.Parameters
            If IsNumeric(param.Value) Then
                query = query.Replace(param.ParameterName, param.Value.ToString())
            Else
                query = query.Replace(param.ParameterName, "'" & param.Value.ToString().Replace("'", "''") & "'")
            End If
        Next

        Return query
    End Function
End Class