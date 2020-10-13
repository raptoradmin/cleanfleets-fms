Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Security.Cryptography
Imports System.Data
Imports System.Data.SqlClient
Imports System.Data.OleDb
Imports Telerik.Web.UI
Imports System.IO
Imports System.Collections.Generic
Imports System.Threading
Imports Ionic.Zip
Imports Inspironix
'Imports Inspironix.DB
Imports System.Globalization
Imports System.Text
Public Class vehicleimport
    Inherits System.Web.UI.Page

    Dim InsertAccountCount As Integer
    Dim InsertTerminalCount As Integer
    Dim InsertFleetCount As Integer
    Dim InsertVehicleCount As Integer
    Dim UpdateVehicleCount As Integer
    Dim ChangedFleetVehicleCount As Integer
    Dim InsertEngineCount As Integer
    Dim UpdateEngineCount As Integer
    Dim InsertDECSCount As Integer
    Dim UpdateDECSCount As Integer
    Dim MissingCodes As New Dictionary(Of String, Integer)()
    Dim hasZip As Boolean
    Dim UploadedFilesCount As Integer = 0
    Dim UploadedImagesCount As Integer = 0


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'Dim IDVehicles As New Guid(Request.QueryString("IDVehicles"))
        '
        '        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        '        Dim conn As New SqlConnection(connectionString)
        '        Dim comm As New SqlCommand("SELECT [ChassisVIN] FROM [CF_Vehicles] WHERE IDVehicles = @IDVehicles", conn)
        '        Dim objDR As Data.SqlClient.SqlDataReader
        '
        '        comm.Parameters.AddWithValue("@IDVehicles", SqlDbType.UniqueIdentifier).Value = IDVehicles
        '
        '        comm.Connection.Open()
        '
        '        objDR = comm.ExecuteReader(System.Data.CommandBehavior.CloseConnection)
        '
        '        While objDR.Read()
        '            lbl_VehicleVIN.Text = objDR("ChassisVIN")
        '        End While
        '
        '        comm.Connection.Close()

        If fu_ImportFile2.HasFile Then
            hasZip = True
        Else
            hasZip = False
        End If
    End Sub

    Protected Sub gv_Excel_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            'determine the value of the UnitsInStock field
            Dim VehicleImportStatus As String = DataBinder.Eval(e.Row.DataItem, "VehicleImportStatus")
            Select Case VehicleImportStatus
                Case "update"
                    e.Row.BackColor = Drawing.Color.Yellow
                Case "error"
                    e.Row.BackColor = Drawing.Color.IndianRed
                Case "warning"
                    e.Row.BackColor = Drawing.Color.Pink
                Case Else
                    e.Row.Visible = False
            End Select


        End If
    End Sub


    Protected Enum ImportRoutine
        ImportDataAndFiles
        ImportFilesOnly
    End Enum

    Protected Sub btnImport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnImport.Click
        Dim SAVEPATH As String = "~/cf_console/accountmanager/temp/"
        Dim filespec1 As String = ""
        Dim filespec2 As String = ""
        If Page.IsValid Then
            If Not Directory.Exists(Server.MapPath(SAVEPATH)) Then
                Directory.CreateDirectory(Server.MapPath(SAVEPATH))
            End If
            filespec1 = Path.Combine(Server.MapPath(SAVEPATH), Membership.GetUser().UserName.ToLower() & "_vehicleImport" & Path.GetExtension(fu_ImportFile.FileName))
            fu_ImportFile.SaveAs(filespec1)

            '07/16/2012 IR: Added code to upload a user selected .zip file to the server
            filespec2 = Path.Combine(Server.MapPath(SAVEPATH), Membership.GetUser().UserName.ToLower() & "_vehicleImport" & Path.GetExtension(fu_ImportFile2.FileName))
            fu_ImportFile2.SaveAs(filespec2)

            '07/17/2012 IR: Added filespec2 to allow .zip file to be unpacked onto the server
            importVehicles(filespec1, filespec2, ImportRoutine.ImportDataAndFiles)

            Messages.Text = String.Format("Created {0} new Accounts.<br>Created {1} new Terminals.<br>Created {2} new Fleets." &
              "<br>Created {3} new Vehicles.<br>Updated {4} existing Vehicles including moving {5} Vehicles to a different Fleet.<br>" &
              "<br>Created {6} new Engines.<br>Updated {7} existing Engines.<br>Created {8} new DECS.<br>Updated {9} existing DECS.<br>" &
              "<br>Uploaded {10} Images and {11} Files<br>", InsertAccountCount, InsertTerminalCount, InsertFleetCount, InsertVehicleCount, UpdateVehicleCount, ChangedFleetVehicleCount, InsertEngineCount, UpdateEngineCount, InsertDECSCount, UpdateDECSCount, UploadedImagesCount, UploadedFilesCount)
            Messages.Text &= "<br>The following Data Conversions are missing: <br>"
            For Each kvp As KeyValuePair(Of String, Integer) In MissingCodes
                Messages.Text &= kvp.Key & " &times;" & kvp.Value & "<br>"
            Next
            Messages.Text &= "Records with one of these missing values have been highlighted in red and were not imported.<br><br>"
            Messages.Text &= "Records highlighted in yellow were updated.<br>"
            Messages.Text &= "Records highlighted in red have one or more problems.<br>"
            Messages.Text &= "Records highlighted in pink have one or more warnings.<br>"
        End If


    End Sub

    Protected Sub btnImportFiles_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnImportFiles.Click
        Dim SAVEPATH As String = "~/cf_console/accountmanager/temp/"
        Dim filespec1 As String = ""
        Dim filespec2 As String = ""
        If Page.IsValid Then
            If Not Directory.Exists(Server.MapPath(SAVEPATH)) Then
                Directory.CreateDirectory(Server.MapPath(SAVEPATH))
            End If
            filespec1 = Path.Combine(Server.MapPath(SAVEPATH), Membership.GetUser().UserName.ToLower() & "_vehicleImport" & Path.GetExtension(fu_ImportFile.FileName))
            fu_ImportFile.SaveAs(filespec1)

            '07/16/2012 IR: Added code to upload a user selected .zip file to the server
            filespec2 = Path.Combine(Server.MapPath(SAVEPATH), Membership.GetUser().UserName.ToLower() & "_vehicleImport" & Path.GetExtension(fu_ImportFile2.FileName))
            fu_ImportFile2.SaveAs(filespec2)

            '07/17/2012 IR: Added filespec2 to allow .zip file to be unpacked onto the server
            importVehicles(filespec1, filespec2, ImportRoutine.ImportFilesOnly)

            Messages.Text = String.Format("Created {0} new Accounts.<br>Created {1} new Terminals.<br>Created {2} new Fleets." &
              "<br>Created {3} new Vehicles.<br>Updated {4} existing Vehicles including moving {5} Vehicles to a different Fleet.<br>" &
              "<br>Created {6} new Engines.<br>Updated {7} existing Engines.<br>Created {8} new DECS.<br>Updated {9} existing DECS.<br>" &
              "<br>Uploaded {10} Images and {11} Files<br>", InsertAccountCount, InsertTerminalCount, InsertFleetCount, InsertVehicleCount, UpdateVehicleCount, ChangedFleetVehicleCount, InsertEngineCount, UpdateEngineCount, InsertDECSCount, UpdateDECSCount, UploadedImagesCount, UploadedFilesCount)
            Messages.Text &= "<br>The following Data Conversions are missing: <br>"
            For Each kvp As KeyValuePair(Of String, Integer) In MissingCodes
                Messages.Text &= kvp.Key & " &times;" & kvp.Value & "<br>"
            Next
            Messages.Text &= "Records with one of these missing values have been highlighted in red and were not imported.<br><br>"
            Messages.Text &= "Records highlighted in yellow were updated.<br>"
            Messages.Text &= "Records highlighted in red have one or more problems.<br>"
            Messages.Text &= "Records highlighted in pink have one or more warnings.<br>"
        End If


    End Sub

    Protected Function getFirstWorksheetName(conn As OleDbConnection) As String
        Dim dbSchema As DataTable = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, Nothing)
        Dim strsheetName As String = "Sheet1$"
        If (dbSchema IsNot Nothing AndAlso dbSchema.Rows.Count > 0) Then
            strsheetName = Convert.ToString(dbSchema.Rows(0)("TABLE_NAME"))
        End If
        Return strsheetName
    End Function

    '07/17/2012 IR: Added ZIPFileSpec parameter to allow picture files to be unpacked onto the server
    Protected Sub importVehicles(ByVal XLSFileSpec As String, ByVal ZIPFileSpec As String, Routine As ImportRoutine)
        ' server requires 2007 Office System Driver Data Connectivity http://www.microsoft.com/download/en/details.aspx?displaylang=en&id=23734
        'Dim ExcelSQLStr As String  --WARNINGS commented out by due to not being used Sam 2/20
        Dim ExcelConnStr As String
        Dim ExcelConn As OleDbConnection
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)

        ' HDR = header, IMEX = treat all columns as text (instead of General)
        If Path.GetExtension(XLSFileSpec) = ".xlsx" Then
            ExcelConnStr = "Provider=Microsoft.ACE.OLEDB.12.0; Data Source='" & XLSFileSpec & "'; Extended Properties=""Excel 12.0 Xml; HDR=YES; IMEX=1"""
            Throw New ArgumentException(".XLSX files cause crashes.  Please try an .XLS file instead")
        ElseIf Path.GetExtension(XLSFileSpec) = ".xls" Then
            ExcelConnStr = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source='" & XLSFileSpec & "'; Extended Properties=""Excel 8.0; HDR=Yes; IMEX=1; """
        Else
            Throw New ArgumentException("Unrecognized file type.")
        End If

        If hasZip Then
            If Path.GetExtension(ZIPFileSpec) <> ".zip" Then
                Throw New ArgumentException("Unrecognized file type. Expecting .zip file type.")
            End If
        End If

        ExcelConn = New OleDbConnection(ExcelConnStr)
        ExcelConn.Open()

        Try
            Dim objcommand As New OleDbCommand(String.Format("SELECT * FROM [{0}] WHERE RTRIM(Account) > ''  ", getFirstWorksheetName(ExcelConn)), ExcelConn)

            ' uncommenting these lines will show the data in a table on the import page
            Dim myDataAdapter As New OleDbDataAdapter(objcommand)
            Dim myDataSet As New DataSet
            If 1 = 0 Then
                myDataSet.Tables.Add("Sheet1")
                Dim myDataTable As DataTable = myDataSet.Tables(0)
                myDataSet.Tables(0).Columns.Add("Account", GetType(String))
                myDataSet.Tables(0).Columns.Add("Terminal", GetType(String))
                myDataSet.Tables(0).Columns.Add("Fleet", GetType(String))
                myDataSet.Tables(0).Columns.Add("UnitNo", GetType(String))
                myDataSet.Tables(0).Columns.Add("LicensePlateNo", GetType(String))
                myDataSet.Tables(0).Columns.Add("ChassisVIN", GetType(String))
                myDataSet.Tables(0).Columns.Add("EquipmentType", GetType(String))
                myDataSet.Tables(0).Columns.Add("EquipmentCategory", GetType(String))
                myDataSet.Tables(0).Columns.Add("VehicleStatus", GetType(String))
                myDataSet.Tables(0).Columns.Add("CARBGroup", GetType(String))
                myDataSet.Tables(0).Columns.Add("ChassisMake", GetType(String))
                myDataSet.Tables(0).Columns.Add("ChassisModelYear", GetType(String))
                myDataSet.Tables(0).Columns.Add("Model", GetType(String))
                myDataSet.Tables(0).Columns.Add("AnnualMiles", GetType(String))
                myDataSet.Tables(0).Columns.Add("AnnualHours", GetType(String))
                myDataSet.Tables(0).Columns.Add("ActualMiles", GetType(String))
                myDataSet.Tables(0).Columns.Add("ActualHours", GetType(String))
                myDataSet.Tables(0).Columns.Add("GrossVehicleWeight", GetType(String))
                myDataSet.Tables(0).Columns.Add("PlannedComplianceDate", GetType(String))
                myDataSet.Tables(0).Columns.Add("ActualComplianceDate", GetType(String))
                myDataSet.Tables(0).Columns.Add("BackupStatusDate", GetType(String))
                myDataSet.Tables(0).Columns.Add("RetireStatusDate", GetType(String))
                myDataSet.Tables(0).Columns.Add("EstReplacementCost", GetType(String))
                myDataSet.Tables(0).Columns.Add("PlannedRetirementDate", GetType(String))
                myDataSet.Tables(0).Columns.Add("ActualRetirementDate", GetType(String))
                myDataSet.Tables(0).Columns.Add("EngineManufacturer", GetType(String))
                myDataSet.Tables(0).Columns.Add("EngineModel", GetType(String))
                myDataSet.Tables(0).Columns.Add("EngineStatus", GetType(String))
                myDataSet.Tables(0).Columns.Add("EngineFuelType", GetType(String))
                myDataSet.Tables(0).Columns.Add("ModelYear", GetType(String))
                myDataSet.Tables(0).Columns.Add("SerialNum", GetType(String))
                myDataSet.Tables(0).Columns.Add("FamilyName", GetType(String))
                myDataSet.Tables(0).Columns.Add("SeriesModelNo", GetType(String))
                myDataSet.Tables(0).Columns.Add("Horsepower", GetType(String))
                myDataSet.Tables(0).Columns.Add("Displacement", GetType(String))
                myDataSet.Tables(0).Columns.Add("EstRetrofitCost", GetType(String))
                myDataSet.Tables(0).Columns.Add("DECSName", GetType(String))
                myDataSet.Tables(0).Columns.Add("SerialNo", GetType(String))
                myDataSet.Tables(0).Columns.Add("DECSManufacturer", GetType(String))
                myDataSet.Tables(0).Columns.Add("DECSLevel", GetType(String))
                myDataSet.Tables(0).Columns.Add("DECSModelNo", GetType(String))
                myDataSet.Tables(0).Columns.Add("DECSInstallationDate", GetType(String))
                myDataAdapter.Fill(myDataSet, "Sheet1")
            Else
                myDataAdapter.Fill(myDataSet)
            End If

            ' --WARNINGS commented out by due to not being used Sam 2/20
            'Dim IDProfileAccount As Integer
            'Dim IDProfileTerminal As Integer
            'Dim IDProfileFleet As Integer
            'Dim IDVehicles As Guid
            Dim col As DataColumn


            myDataSet.Tables(0).Columns.Add("IDProfileAccount", GetType(Integer))
            myDataSet.Tables(0).Columns.Add("IDProfileTerminal", GetType(Integer))
            myDataSet.Tables(0).Columns.Add("IDProfileFleet", GetType(Integer))
            myDataSet.Tables(0).Columns.Add("IDVehicles", GetType(System.Guid))
            myDataSet.Tables(0).Columns.Add("IDEngines", GetType(System.Guid))
            myDataSet.Tables(0).Columns.Add("IDDECS", GetType(System.Guid))
            myDataSet.Tables(0).Columns.Add("Errors", GetType(String))
            myDataSet.Tables(0).Columns.Add("Warnings", GetType(String))
            myDataSet.Tables(0).Columns.Add("SerialNumStr", GetType(String))
            myDataSet.Tables(0).Columns.Add("UnitNoStr", GetType(String))
            myDataSet.Tables(0).Columns.Add("Previous Fleet", GetType(String))
            col = myDataSet.Tables(0).Columns.Add("ImportEngine", GetType(Boolean))
            col.DefaultValue = False
            col = myDataSet.Tables(0).Columns.Add("ImportDECS", GetType(Boolean))
            col.DefaultValue = False

            col = myDataSet.Tables(0).Columns.Add("VehicleImportStatus", GetType(String))
            col.DefaultValue = "pending"
            'col.AllowDbNull = false

            'col.AllowDbNull = false
            'col.unique = true

            '07/16/2012 IR: Removed "EquipmentCategory"
            'dim fieldsToConvert as string()
            Dim fieldsToConvert = New String() {}
            If Routine = ImportRoutine.ImportDataAndFiles Then
                fieldsToConvert = New String() {"EquipmentType", "VehicleStatus", "CARBGroup", "ChassisMake", "EngineManufacturer", "EngineStatus",
                  "EngineFuelType", "ChassisModelYear", "ModelYear", "DECSManufacturer", "DECSLevel", "SpecialProvision", "WeightDefinition"}
                For Each fieldname As String In fieldsToConvert
                    col = myDataSet.Tables(0).Columns.Add("ID" & fieldname, GetType(Integer))
                    myDataSet.Tables(0).Columns("ID" & fieldname).SetOrdinal(myDataSet.Tables(0).Columns.IndexOf(fieldname) + 1) ' place it right after its namesake
                Next
            End If

            'for each fieldname as string in fieldsToConvert
            '				col = myDataSet.tables(0).Columns.AddWithValue("ID" & fieldname, GetType(Integer))
            '				myDataSet.tables(0).Columns("ID" & fieldname).setOrdinal(myDataSet.tables(0).Columns.indexOf(fieldname)+1) ' place it right after its namesake
            '			next
            If Routine = ImportRoutine.ImportDataAndFiles Then
                myDataSet.Tables(0).Columns("SerialNumStr").SetOrdinal(myDataSet.Tables(0).Columns.IndexOf("SerialNum") + 1) ' place it right after SerialNum
                myDataSet.Tables(0).Columns("UnitNoStr").SetOrdinal(myDataSet.Tables(0).Columns.IndexOf("UnitNo") + 1) ' place it right after SerialNum
            End If

            For Each dtRow As DataRow In myDataSet.Tables(0).Rows
                Try
                    dtRow.Item("VehicleImportStatus") = "pending"
                    dtRow.Item("IDProfileAccount") = getIDProfileAccount(dtRow.Item("Account"))
                    dtRow.Item("IDProfileTerminal") = getIDProfileTerminal(dtRow.Item("IDProfileAccount"), dtRow.Item("Terminal"))
                    dtRow.Item("IDProfileFleet") = getIDProfileFleet(dtRow.Item("IDProfileTerminal"), dtRow.Item("Fleet"))
                    dtRow.Item("IDVehicles") = getIDVehicles(dtRow.Item("IDProfileFleet"), dtRow.Item("ChassisVIN")) ' if vehicle exists matching the VIN but doesn't match the Fleet, that's a potential problem
                    '09/07/2012 IR: Added calls to getIDEngine and getIDDECS in case we are importing images only if importing images and data these values will get overwritten
                    dtRow.Item("IDEngines") = getIDEngine(dtRow)
                    dtRow.Item("IDDECS") = getIDDECS(dtRow)
                    For Each fieldname As String In fieldsToConvert

                        If fieldname.ToLower() Like "*year" Then
                            dtRow.Item("ID" & fieldname) = lookupCodeValue(dtRow.Item(fieldname), "Year")
                        Else
                            If dtRow.Table.Columns.Contains(fieldname) AndAlso dtRow.Table.Columns.Contains("ID" & fieldname) Then
                                dtRow.Item("ID" & fieldname) = lookupCodeValue(dtRow.Item(fieldname), fieldname)
                                If Not IsDBNull(dtRow.Item(fieldname)) AndAlso (IsDBNull(dtRow.Item("ID" & fieldname)) OrElse dtRow.Item("ID" & fieldname) = 0) _
                                  AndAlso Trim(dtRow.Item(fieldname)) > "" Then
                                    dtRow.RowError &= "Missing conversion for " & fieldname & "=" & dtRow.Item(fieldname)
                                End If
                            End If
                        End If
                    Next

                    If dtRow.Item("IDProfileFleet") <= 0 Then
                        dtRow.RowError &= "No fleet for this Vehicle"
                    End If
                    ' convert serial number to string
                    Try
                        dtRow("ImportEngine") = True
                        dtRow("ImportDECS") = True

                        If IsDBNull(dtRow("SerialNum")) Then
                            dtRow("SerialNumStr") = ""
                            dtRow("ImportEngine") = False
                            dtRow("ImportDECS") = False
                            'throw new ArgumentException("Engine Serial Number is empty.  Please check that an Engine Serial Number has been entered and that the cell is ""Text""")
                        ElseIf Integer.TryParse(dtRow("SerialNum"), Nothing) Then
                            dtRow("SerialNumStr") = CStr(dtRow("SerialNum"))
                        Else
                            dtRow("SerialNumStr") = dtRow("SerialNum").replace("'", "")
                        End If
                        If dtRow("SerialNumStr") Like "[1-9].*[0-9]e+[0-9]*" Then ' scientific notation 

                            Throw New ArgumentException("There was a problem converting the Engine Serial Number to text")
                        End If

                        'MG 2016-02-17 - enforce an Engine Model Year
                        If Integer.TryParse(dtRow("ModelYear"), Nothing) = False Then
                            dtRow("ImportEngine") = False
                            dtRow("ImportDECS") = False
                            Throw New ArgumentException("There was a problem converting the Engine Model Year.")
                        End If

                    Catch exc As Exception

                        dtRow.RowError &= exc.Message
                    End Try

                    If Routine = ImportRoutine.ImportDataAndFiles Then
                        Try
                            If IsDBNull(dtRow("UnitNo")) Then
                                Throw New ArgumentException("UnitNo is empty.  Please check that a Unit Number has been entered and that cell is ""Text""")
                            ElseIf Integer.TryParse(dtRow("UnitNO"), Nothing) Then
                                dtRow("UnitNoStr") = CStr(dtRow("UnitNO"))
                            Else
                                dtRow("UnitNoStr") = dtRow("UnitNo").replace("'", "")
                            End If
                            If dtRow("UnitNoStr") Like "[1-9].*[0-9]e+[0-9]*" Then ' scientific notation

                                Throw New ArgumentException("There was a problem converting the Unit Number to text")
                            End If
                        Catch exc As Exception
                            dtRow.RowError &= exc.Message
                        End Try
                    End If

                Catch exc As Exception

                    dtRow.RowError &= exc.Message
                End Try

                'dtRow.item("VehicleImportStatus") = "update"
            Next
            ' remove serial number (possibly a column of type Double) and replace it with the string version
            myDataSet.Tables(0).Columns("SerialNum").ColumnName = "OldSerialNum"
            myDataSet.Tables(0).Columns("SerialNumStr").ColumnName = "SerialNum"
            For Each dtRow As DataRow In myDataSet.Tables(0).Rows
                If Not dtRow.HasErrors Then
                    dtRow.Item("IDEngines") = getIDEngine(dtRow)
                End If
            Next
            If Routine = ImportRoutine.ImportDataAndFiles Then
                myDataSet.Tables(0).Columns("UnitNo").ColumnName = "OldUnitNo"
                myDataSet.Tables(0).Columns("UnitNoStr").ColumnName = "UnitNo"
            End If

            '20180612 PT - SALLY/JARED REQUEST REMOVING THE WEIGHTDEFINITION COLUMN
            'For Each dtRow As DataRow In myDataSet.Tables(0).Rows
            '    If Not validateWeightDefinition(dtRow) Then
            '        dtRow.RowError &= "Invalid WeightDefinition"
            '    End If
            'Next

            For Each dtRow As DataRow In myDataSet.Tables(0).Rows
                If Routine = ImportRoutine.ImportDataAndFiles Then
                    If Not dtRow.HasErrors Then updateOrInsertVehicle(dtRow)
                    If Not dtRow.HasErrors AndAlso dtRow("ImportEngine") Then updateOrInsertEngine(dtRow)
                    If Not dtRow.HasErrors AndAlso dtRow("ImportDECS") Then updateOrInsertDECS(dtRow)
                End If
                If Routine = ImportRoutine.ImportDataAndFiles OrElse Routine = ImportRoutine.ImportFilesOnly Then
                    If Not dtRow.HasErrors AndAlso hasZip Then updateOrInsertFiles(dtRow, ZIPFileSpec)
                End If

            Next

            For Each dtRow As DataRow In myDataSet.Tables(0).Rows
                If dtRow.HasErrors Then
                    dtRow.Item("VehicleImportStatus") = "error"
                    dtRow.Item("Errors") = dtRow.RowError
                    Continue For
                End If
            Next
            gv_Excel.DataSource = myDataSet.Tables(0).DefaultView
            gv_Excel.DataBind()

        Finally
            ExcelConn.Close()
            If conn.State <> ConnectionState.Closed AndAlso conn.State <> ConnectionState.Broken Then
                conn.Close()
            End If
        End Try
    End Sub


    Public Function getIDProfileAccount(AccountName As String) As Integer
        Dim IDModifiedUser As Guid = Membership.GetUser().ProviderUserKey
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As New SqlCommand("SELECT * FROM CF_Profile_Account WHERE UPPER(RTRIM(ISNULL(AccountName,''))) = UPPER(RTRIM(ISNULL(@AccountName,''))) ", conn)
        Dim objReader As SqlDataReader
        Dim recordValue As Integer = 0
        comm.Connection.Open()
        comm.Parameters.Add("@AccountName", SqlDbType.VarChar, 50).Value = AccountName
        objReader = comm.ExecuteReader()
        If objReader.Read() Then
            recordValue = objReader("IDProfileAccount")
        Else
            objReader.Close()
            comm = New SqlCommand("INSERT INTO CF_Profile_Account (IDModifiedUser, EnterDate, ModifiedDate, AccountName) VALUES (@IDModifiedUser, GETDATE(), GETDATE(), @AccountName); SELECT scope_identity()", conn)
            comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
            comm.Parameters.AddWithValue("@AccountName", AccountName)
            recordValue = comm.ExecuteScalar()
            InsertAccountCount += 1

            ' insert the default module preferences for the account here:
            insertDefaultModulePreferences(conn, recordValue)
        End If
        objReader.Close()
        conn.Close()
        Return recordValue
    End Function

    Private Sub insertDefaultModulePreferences(ByVal conn As SqlConnection, ByVal profileID As String)
        Dim moduleIDs = New Dictionary(Of String, String)

        Dim comm As New SqlCommand("SELECT IDOptionList, RecordValue FROM CF_Option_List WHERE OptionName = @optionName ", conn)
        comm.Parameters.AddWithValue("@optionName", "DefaultModule")
        Dim objReader As SqlDataReader
        objReader = comm.ExecuteReader()
        While objReader.Read()
            moduleIDs.Add(objReader("IDOptionList"), objReader("RecordValue"))
        End While

        objReader.Close()

        For Each kvp As KeyValuePair(Of String, String) In moduleIDs
            Dim moduleID = kvp.Key
            Dim moduleName = kvp.Value
            Dim preference As String
            Select Case moduleName
                Case "ComplianceCertification"
                    preference = "Y"
                Case "FleetSummary"
                    preference = "Y"
                Case "OpacityTests"
                    preference = "Y"
                Case "EngineModelYearReplacementSchedule"
                    preference = "N"
                Case "STBPhaseInOption"
                    preference = "N"
                Case "LowMileageConstruction"
                    preference = "N"
                Case "NOxExempt"
                    preference = "N"
                Case Else
                    Throw New Exception("Unsupported module.")
            End Select

            comm = New SqlCommand("INSERT INTO CF_AccountDefaultModules (IDProfileAccount, IDDefaultModule, IsDisplayed) VALUES (@ProfileId, @ModuleID, @IsDisplayed) ", conn)
            comm.Parameters.AddWithValue("@ProfileID", profileID)
            comm.Parameters.AddWithValue("@ModuleID", moduleID)
            comm.Parameters.AddWithValue("@IsDisplayed", preference)
            comm.ExecuteNonQuery()

        Next
    End Sub

    Public Function getIDProfileTerminal(IDProfileAccount As Integer, TerminalName As String) As Integer
        Dim IDModifiedUser As Guid = Membership.GetUser().ProviderUserKey
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As New SqlCommand("SELECT * FROM CF_Profile_Terminal " &
          "WHERE UPPER(RTRIM(ISNULL(TerminalName,''))) = UPPER(RTRIM(ISNULL(@TerminalName,''))) " &
          "AND IDProfileAccount = @IDProfileAccount", conn)
        Dim objReader As SqlDataReader
        Dim recordValue As Integer = 0
        comm.Connection.Open()
        comm.Parameters.Add("@TerminalName", SqlDbType.VarChar, 50).Value = TerminalName
        comm.Parameters.Add("@IDProfileAccount", SqlDbType.Int).Value = IDProfileAccount
        objReader = comm.ExecuteReader()
        If objReader.Read() Then
            recordValue = objReader("IDProfileTerminal")
        Else
            objReader.Close()
            comm = New SqlCommand("INSERT INTO CF_Profile_Terminal (IDModifiedUser, EnterDate, ModifiedDate, IDProfileAccount, TerminalName) VALUES (@IDModifiedUser, GETDATE(), GETDATE(), @IDProfileAccount, @TerminalName); SELECT scope_identity()", conn)
            comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
            comm.Parameters.AddWithValue("@IDProfileAccount", IDProfileAccount)
            comm.Parameters.AddWithValue("@TerminalName", TerminalName)
            recordValue = comm.ExecuteScalar()
            InsertTerminalCount += 1
        End If
        objReader.Close()
        conn.Close()
        Return recordValue
    End Function

    Public Function getIDProfileFleet(IDProfileTerminal As Integer, FleetName As String) As Integer
        Dim IDModifiedUser As Guid = Membership.GetUser().ProviderUserKey
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As New SqlCommand("SELECT * FROM CF_Profile_Fleet " &
          "WHERE UPPER(RTRIM(ISNULL(FleetName,''))) = UPPER(RTRIM(ISNULL(@FleetName,''))) " &
          "AND IDProfileTerminal = @IDProfileTerminal", conn)
        Dim objReader As SqlDataReader
        Dim recordValue As Integer = 0
        comm.Connection.Open()
        comm.Parameters.Add("@FleetName", SqlDbType.VarChar, 50).Value = FleetName
        comm.Parameters.AddWithValue("@IDProfileTerminal", SqlDbType.Int).Value = IDProfileTerminal
        objReader = comm.ExecuteReader()
        If objReader.Read() Then
            recordValue = objReader("IDProfileFleet")
        Else
            objReader.Close()
            comm = New SqlCommand("INSERT INTO CF_Profile_Fleet (IDModifiedUser, EnterDate, ModifiedDate, IDProfileTerminal, FleetName) VALUES (@IDModifiedUser, GETDATE(), GETDATE(), @IDProfileTerminal, @FleetName); SELECT scope_identity()", conn)
            comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
            comm.Parameters.AddWithValue("@IDProfileTerminal", IDProfileTerminal)
            comm.Parameters.AddWithValue("@FleetName", FleetName)
            recordValue = comm.ExecuteScalar()
            InsertFleetCount += 1
        End If
        objReader.Close()
        conn.Close()
        Return recordValue
    End Function


    Public Function getIDVehicles(IDProfileFleet As Integer, ChassisVIN As String) As Guid
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As New SqlCommand("SELECT * FROM CF_Vehicles WHERE UPPER(RTRIM(ChassisVIN)) = UPPER(RTRIM(@ChassisVIN))", conn)
        Dim objReader As SqlDataReader
        Dim recordValue As Guid = Guid.Empty
        comm.Connection.Open()
        comm.Parameters.Add("@ChassisVIN", SqlDbType.VarChar, 50).Value = ChassisVIN
        objReader = comm.ExecuteReader()
        If objReader.Read() Then
            If objReader("IDProfileFleet") <> IDProfileFleet Then
                ' how are we returning messages?
            End If
            recordValue = objReader("IDVehicles")
        End If
        objReader.Close()
        conn.Close()
        Return recordValue
    End Function

    Public Function lookupCodeValue(ByVal inputStr As Object, ByVal codeSet As String) As Integer
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As New SqlCommand("SELECT IDOptionList FROM CF_Option_List WHERE UPPER(RTRIM(ISNULL(DisplayValue,''))) = UPPER(RTRIM(ISNULL(@DisplayValue,''))) " &
          "AND UPPER(RTRIM(ISNULL(OptionName,''))) = UPPER(RTRIM(ISNULL(@OptionName,''))) ", conn)
        Dim objReader As SqlDataReader
        Dim recordValue As Integer = 0
        comm.Connection.Open()
        comm.Parameters.Add("@DisplayValue", SqlDbType.VarChar, 100).Value = inputStr
        comm.Parameters.Add("@OptionName", SqlDbType.VarChar, 50).Value = codeSet
        objReader = comm.ExecuteReader()
        If objReader.Read() Then
            If Not IsDBNull(objReader("IDOptionList")) Then
                recordValue = objReader("IDOptionList")
            End If
        End If
        '08/06/2012 IR: Added trim to inputStr.toString in order to correct display of missing conversion counts
        If recordValue = 0 AndAlso Trim(inputStr.ToString) > "" Then
            Dim key As String = codeSet & ": " & inputStr
            If MissingCodes.ContainsKey(key) Then
                MissingCodes(key) += 1
            Else
                MissingCodes.Add(key, 1)
            End If
        End If
        objReader.Close()
        conn.Close()
        Return recordValue
    End Function


    Public Sub updateOrInsertVehicle(ByRef dtRow As DataRow)
        Dim IDVehicles As New Guid(dtRow.Item("IDVehicles").ToString())
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim conn2 As New SqlConnection(connectionString)
        Dim comm As SqlCommand
        Dim comm2 As SqlCommand
        Dim rowErrorF = False
        Dim IDModifiedUser As Guid = Membership.GetUser().ProviderUserKey
        Dim objReader As SqlDataReader

        If IDVehicles = Guid.Empty Then ' no vehicle with VIN found; insert
            IDVehicles = Guid.NewGuid()
            comm = New SqlCommand("SELECT * FROM Information_SCHEMA.columns WHERE Table_name='CF_Vehicles' AND column_name='LicensePlateState'", conn)
            comm.Connection.Open()
            objReader = comm.ExecuteReader()

            If objReader.Read() Then
                objReader.Close()
                comm.Connection.Close()
                comm = New SqlCommand("INSERT INTO CF_Vehicles (IDVehicles, IDModifiedUser, EnterDate, ModifiedDate, LicensePlateNo, LicensePlateState, ChassisVIN) " &
                  "VALUES (@IDVehicles, @IDModifiedUser, GETDATE(), GETDATE(), @LicensePlateNo, @LicensePlateState, @ChassisVIN)", conn)
                comm.Connection.Open()
                comm.Parameters.AddWithValue("@IDVehicles", IDVehicles)
                comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
                '10/08/2012 IR: Added a test to check in the specified LicensePlateState is valid
                comm2 = New SqlCommand("SELECT RecordValue FROM CF_Option_List WHERE @State IN (RTRIM(ISNULL(DisplayValue, '')), RTRIM(ISNULL(RecordValue, '')))", conn2)
                comm2.Connection.Open()
                Dim LPState As String = If(String.IsNullOrEmpty(dtRow.Item("LicensePlateState")), "", dtRow.Item("LicensePlateState"))
                comm2.Parameters.AddWithValue("@State", LPState)
                dtRow.Item("LicensePlateState") = comm2.ExecuteScalar()
                If (String.IsNullOrWhiteSpace(dtRow.Item("LicensePlateState"))) Then 'LicensePlateState is not valid
                    rowErrorF = True 'set flag so no updating or inserting for this row will occur
                    dtRow.RowError &= "Unknown LicensePlateState: ' " & LPState & " '"
                End If
                comm2.Connection.Close()
                conn2.Close()

                For Each fieldname As String In New String() {"LicensePlateNo", "LicensePlateState", "ChassisVIN"}
                    If dtRow.Table.Columns.Contains(fieldname) Then
                        comm.Parameters.AddWithValue("@" & fieldname, dtRow.Item(fieldname))
                    Else
                        'Response.write("Fieldname " & fieldname & " is not in the source excel table")
                    End If
                Next
            Else
                objReader.Close()
                comm = New SqlCommand("INSERT INTO CF_Vehicles (IDVehicles, IDModifiedUser, EnterDate, ModifiedDate, LicensePlateNo, ChassisVIN) " &
                  "VALUES (@IDVehicles, @IDModifiedUser, GETDATE(), GETDATE(), @LicensePlateNo, @ChassisVIN)", conn)
                comm.Parameters.AddWithValue("@IDVehicles", IDVehicles)
                comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
                For Each fieldname As String In New String() {"LicensePlateNo", "ChassisVIN"}
                    If dtRow.Table.Columns.Contains(fieldname) Then
                        comm.Parameters.AddWithValue("@" & fieldname, dtRow.Item(fieldname))
                    Else
                        'Response.write("Fieldname " & fieldname & " is not in the source excel table")
                    End If
                Next
            End If
            Try
                If Not rowErrorF Then
                    comm.ExecuteNonQuery()
                    dtRow("IDVehicles") = IDVehicles
                    dtRow("VehicleImportStatus") = "insert"
                    InsertVehicleCount += 1
                End If
            Catch sqlExc As SqlException
                If sqlExc.ToString Like "*LicensePlate*" AndAlso Not sqlExc.ToString Like "*@LicensePlateState*" Then
                    comm = New SqlCommand("SELECT [dbo].[GetVehicleATFPath](IDVehicles) AS ATFPath " &
                      "FROM CF_Vehicles WHERE UPPER(RTRIM(LicensePlateNo)) = UPPER(RTRIM(@LicensePlateNo))", conn)
                    comm.Parameters.AddWithValue("@LicensePlateNo", dtRow("LicensePlateNo"))
                    objReader = comm.ExecuteReader()
                    If objReader.Read() Then
                        dtRow.RowError &= "This license plate already exists for another Vehicle (" & objReader("ATFPath") & ")."
                    Else
                        dtRow.RowError &= "This license plate already exists for another Vehicle (unknown Vehicle)."
                    End If
                    objReader.Close()
                Else
                    dtRow.RowError &= sqlExc.ToString()
                End If
                Return
            Finally
                comm.Connection.Close()
                conn.Close()
            End Try

            '07/19/2012 IR: Removed old code that built sql query for inserting new vehicles

        Else
            ' check if vehicle exists in another fleet
            comm = New SqlCommand("SELECT [dbo].[GetVehicleATFPath](IDVehicles) AS ATFPath " &
              "FROM CF_Vehicles WHERE IDVehicles = @IDVehicles AND IDProfileFleet <> @IDProfileFleet", conn)
            comm.Connection.Open()
            comm.Parameters.AddWithValue("@IDVehicles", dtRow("IDVehicles"))
            comm.Parameters.AddWithValue("@IDProfileFleet", dtRow("IDProfileFleet"))
            objReader = comm.ExecuteReader()
            If objReader.Read() Then
                ChangedFleetVehicleCount += 1
                dtRow("Previous Fleet") &= "Changed Fleet from " & objReader("ATFPath")
            End If
            comm.Connection.Close()
            comm = New SqlCommand("SELECT * FROM Information_SCHEMA.columns WHERE Table_name='CF_Vehicles' AND column_name='LicensePlateState'", conn)
            comm.Connection.Open()
            objReader = comm.ExecuteReader()
            If objReader.Read() Then
                objReader.Close()
                comm.Connection.Close()
                comm = New SqlCommand("UPDATE CF_Vehicles SET IDModifiedUser = @IDModifiedUser, ModifiedDate = GETDATE(), " &
                  "LicensePlateNo = @LicensePlateNo, LicensePlateState = @LicensePlateState WHERE IDVehicles = @IDVehicles", conn)
                comm.Connection.Open()
                comm.Parameters.AddWithValue("@IDVehicles", IDVehicles)
                comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)

                comm2 = New SqlCommand("SELECT RecordValue FROM CF_Option_List WHERE @State IN (RTRIM(ISNULL(DisplayValue, '')), RTRIM(ISNULL(RecordValue, '')))", conn2)
                comm2.Connection.Open()
                Dim LPState As String = If(String.IsNullOrWhiteSpace(dtRow.Item("LicensePlateState")), "", dtRow.Item("LicensePlateState"))
                comm2.Parameters.AddWithValue("@State", LPState)
                dtRow.Item("LicensePlateState") = comm2.ExecuteScalar()
                If (String.IsNullOrWhiteSpace(dtRow.Item("LicensePlateState"))) Then
                    rowErrorF = True
                    dtRow.RowError &= "Unknown LicensePlateState: ' " & LPState & " '"
                End If
                comm2.Connection.Close()
                conn2.Close()

                For Each fieldname As String In New String() {"LicensePlateNo", "LicensePlateState"}
                    If dtRow.Table.Columns.Contains(fieldname) Then
                        comm.Parameters.AddWithValue("@" & fieldname, dtRow.Item(fieldname))
                    Else
                        'Response.write("Fieldname " & fieldname & " is not in the source excel table")
                    End If
                Next
            Else
                objReader.Close()
                comm = New SqlCommand("UPDATE CF_Vehicles SET IDModifiedUser = @IDModifiedUser, ModifiedDate = GETDATE(), " &
                  "LicensePlateNo = @LicensePlateNo WHERE IDVehicles = @IDVehicles", conn)
                'comm.Connection.Open
                comm.Parameters.AddWithValue("@IDVehicles", IDVehicles)
                comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
                If dtRow.Table.Columns.Contains("LicensePlateNo") Then
                    comm.Parameters.AddWithValue("@LicensePlateNo", dtRow.Item("LicensePlateNo"))
                Else
                    'Response.write("Fieldname " & fieldname & " is not in the source excel table")
                End If
            End If
            Try
                If Not rowErrorF Then
                    comm.ExecuteNonQuery()
                    dtRow("VehicleImportStatus") = "update"
                    UpdateVehicleCount += 1
                End If
            Catch sqlExc As SqlException
                If sqlExc.ToString Like "*LicensePlate*" AndAlso Not sqlExc.ToString Like "*@LicensePlateState*" Then
                    comm = New SqlCommand("SELECT [dbo].[GetVehicleATFPath](IDVehicles) AS ATFPath " &
                      "FROM CF_Vehicles WHERE UPPER(RTRIM(LicensePlateNo)) = UPPER(RTRIM(@LicensePlateNo))", conn)
                    comm.Parameters.AddWithValue("@LicensePlateNo", dtRow("LicensePlateNo"))
                    objReader = comm.ExecuteReader()
                    If objReader.Read() Then
                        dtRow.RowError &= "This license plate already exists for another Vehicle (" & objReader("ATFPath") & ")."
                    Else
                        dtRow.RowError &= "This license plate already exists for another Vehicle (unknown Vehicle)."
                    End If
                    objReader.Close()

                Else
                    dtRow.RowError &= sqlExc.ToString()
                End If
                Return
            Finally
                conn.Close()
                comm.Connection.Close()
            End Try

            '07/19/2012 IR: Removed old code that built sql query for updating existing vehicles

        End If

        If Not rowErrorF Then
            comm = New SqlCommand("UPDATE CF_Vehicles SET IDModifiedUser = @IDModifiedUser, ModifiedDate = GETDATE(), ChassisModel = @ChassisModel, Description = @Description," &
              "IDRuleCode = @IDRuleCode WHERE IDVehicles = @IDVehicles", conn)

            comm.Connection.Open()
            comm.Parameters.AddWithValue("@IDVehicles", IDVehicles)
            comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
            comm.Parameters.AddWithValue("@IDRuleCode", If(dtRow.Table.Columns.Contains("RuleCode"), dtRow.Item("RuleCode"), 0))
            comm.Parameters.AddWithValue("@Description", If(dtRow.Table.Columns.Contains("Description"), dtRow.Item("Description"), ""))
            comm.Parameters.AddWithValue("@ChassisModel", dtRow.Item("Model"))
            Try
                comm.ExecuteNonQuery()
            Finally
                comm.Connection.Close()
                conn.Close()
            End Try

            For Each fieldname As String In New String() {"IDProfileFleet", "IDEquipmentType", "IDVehicleStatus", "IDCARBGroup", "IDChassisModelYear", "IDChassisMake",
              "UnitNo", "AnnualMiles", "AnnualHours", "ActualMiles", "ActualHours", "GrossVehicleWeight", "PlannedComplianceDate", "ActualComplianceDate", "BackupStatusDate",
              "RetireStatusDate", "EstReplacementCost", "PlannedRetirementDate", "ActualRetirementDate", "LastOpacityTestDate", "Notes", "IDWeightDefinition"}
                comm = New SqlCommand("UPDATE CF_Vehicles SET " & fieldname & " = @value WHERE IDVehicles = @IDVehicles", conn)
                comm.Connection.Open()
                comm.Parameters.AddWithValue("@IDVehicles", IDVehicles)
                If dtRow.Table.Columns.Contains(fieldname) Then
                    If fieldname.ToLower Like "*date" Or fieldname.ToLower Like "*cost" Then
                        If IsDBNull(dtRow.Item(fieldname)) Then
                            comm.Parameters.AddWithValue("@value", dtRow.Item(fieldname))
                        ElseIf TypeOf (dtRow.Item(fieldname)) Is DateTime Then
                            comm.Parameters.AddWithValue("@value", dtRow.Item(fieldname))
                        ElseIf IsNumeric(dtRow.Item(fieldname)) Then
                            comm.Parameters.AddWithValue("@value", dtRow.Item(fieldname))
                        ElseIf dtRow.Item(fieldname).trim() = "" Then
                            comm.Parameters.AddWithValue("@value", DBNull.Value)
                        Else
                            comm.Parameters.AddWithValue("@value", dtRow.Item(fieldname))
                        End If
                    Else
                        comm.Parameters.AddWithValue("@value", dtRow.Item(fieldname))
                    End If
                Else
                    'Response.write("Fieldname " & fieldname & " is not in the source excel table")
                    comm.Parameters.AddWithValue("@value", DBNull.Value)
                End If
                Try
                    comm.ExecuteNonQuery()
                Catch ex As Exception
                    Response.Write(ex.ToString())
                Finally
                    comm.Connection.Close()
                    conn.Close()
                End Try
            Next
            For Each fieldname As String In New String() {"IDSpecialProvision", "ActualInServiceDate", "EstimatedInServiceDate"}
                comm = New SqlCommand("SELECT * FROM Information_SCHEMA.columns WHERE Table_name='CF_Vehicles' AND column_name=@CName", conn)
                comm.Connection.Open()
                comm.Parameters.AddWithValue("@Cname", fieldname)
                objReader = comm.ExecuteReader()

                If objReader.Read() Then
                    objReader.Close()
                    comm.Connection.Close()
                    comm = New SqlCommand("UPDATE CF_Vehicles SET " & fieldname & " = @value WHERE IDVehicles = @IDVehicles", conn)
                    comm.Connection.Open()
                    comm.Parameters.AddWithValue("@IDVehicles", IDVehicles)
                    comm.Parameters.AddWithValue("@FieldName", fieldname)
                    If dtRow.Table.Columns.Contains(fieldname) Then
                        If fieldname.ToLower Like "*date" Then
                            If IsDBNull(dtRow.Item(fieldname)) Then
                                comm.Parameters.AddWithValue("@value", dtRow.Item(fieldname))
                            ElseIf TypeOf (dtRow.Item(fieldname)) Is DateTime Then
                                comm.Parameters.AddWithValue("@value", dtRow.Item(fieldname))
                            ElseIf dtRow.Item(fieldname).trim() = "" Then
                                comm.Parameters.AddWithValue("@value", DBNull.Value)
                            Else
                                comm.Parameters.AddWithValue("@value", dtRow.Item(fieldname))
                            End If
                        Else
                            comm.Parameters.AddWithValue("@value", dtRow.Item(fieldname))
                        End If
                    Else
                        'Response.write("Fieldname " & fieldname & " is not in the source excel table")
                        comm.Parameters.AddWithValue("@value", DBNull.Value)
                    End If
                    Try
                        comm.ExecuteNonQuery()
                    Finally
                        comm.Connection.Close()
                        conn.Close()
                    End Try
                Else
                    comm.Connection.Close()
                End If
            Next
        End If
    End Sub

    'PH 07/08/2014
    ' Check to see if the WeightDefinition value is valid.
    ' If it's valid, returns true
    ' if it's non-existant and should exist, insert the value and return true
    ' if it's invalid, return false
    ' 
    '	A weight definition can only exist if the rule code is "On Road"
    '	Valid weight definitions are based on weight:
    '		Weight > 14000 && weight <= 26000: weight definition = "Lighter Vehicle"
    '		Weight > 26000: weight definition = "Heavier Vehicle"
    Private Function validateWeightDefinition(ByVal row As DataRow) As Boolean
        Dim columns = row.Table.Columns

        'get rule code from fleet
        Dim idFleet As Integer = row("IDProfileFleet")
        Dim ruleCode As String = getFleetsRuleCode(idFleet)
        Dim weightDefinition As String = If(IsDBNull(row("WeightDefinition")) OrElse String.IsNullOrWhiteSpace(row("WeightDefinition")), "", row("WeightDefinition"))
        Dim weightString As String = If(String.IsNullOrWhiteSpace(row("GrossVehicleWeight")), "", row("GrossVehicleWeight"))
        Dim weight As Integer

        If ruleCode <> "On Road" AndAlso Not String.IsNullOrEmpty(weightDefinition) Then
            Return False
            ' WeightDefinitions are only valid if the rule code is "On Road"
        End If

        If Integer.TryParse(weightString, NumberStyles.AllowThousands, CultureInfo.CurrentCulture, weight) AndAlso ruleCode = "On Road" Then
            If weight > 14000 AndAlso weight <= 26000 Then
                ' WeightDefinition should be Lighter Vehicle
                If String.IsNullOrEmpty(weightDefinition) Then
                    ' weight definition is empty when it should be set, so set it
                    Dim idWeightDefinition As Integer = getWeightDefinitionID("LighterVehicle")
                    row("IDWeightDefinition") = idWeightDefinition
                    row("WeightDefinition") = "Lighter Vehicle"
                    Return True
                ElseIf weightDefinition <> "Lighter Vehicle" Then
                    'weight definition is incorrect, return false
                    Return False
                Else
                    'weight definition is correct, return true
                    Return True
                End If
            ElseIf weight > 26000 Then

                If String.IsNullOrEmpty(weightDefinition) Then
                    ' weight definition is empty when it should be set, so set it
                    Dim idWeightDefinition As Integer = getWeightDefinitionID("HeavierVehicle")
                    row("IDWeightDefinition") = idWeightDefinition
                    row("WeightDefinition") = "Heavier Vehicle"
                    Return True
                ElseIf weightDefinition <> "Heavier Vehicle" Then
                    'weight definition is incorrect, return false
                    Return False
                Else
                    'weight definition is correct, return true
                    Return True
                End If
            End If
        End If

        If String.IsNullOrEmpty(weightDefinition) Then
            Return True
        Else
            Return False
        End If
    End Function

    Private Function getFleetsRuleCode(ByVal idFleet As Integer) As String
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As SqlCommand
        Dim ruleCode As String
        Dim sqlStr = "SELECT RecordValue " &
                        "FROM CF_Profile_Fleet " &
                        "INNER JOIN CF_Option_List " &
                        "ON IDRuleCode = IDOptionList " &
                        "WHERE IDProfileFleet = @IDProfileFleet"
        comm = New SqlCommand(sqlStr, conn)
        comm.Connection.Open()
        comm.Parameters.AddWithValue("@IDProfileFleet", idFleet)

        ruleCode = comm.ExecuteScalar()

        comm.Connection.Close()

        Return ruleCode
    End Function

    Private Function getWeightDefinitionID(ByVal recordValue As String) As Integer
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As SqlCommand
        Dim idWeightDefinition As Integer
        Dim sqlStr = "SELECT IDOptionList " &
                        "FROM CF_Option_List " &
                        "WHERE RecordValue = @RecordValue AND OptionName = @OptionName"
        comm = New SqlCommand(sqlStr, conn)
        comm.Connection.Open()
        comm.Parameters.AddWithValue("@RecordValue", recordValue)
        comm.Parameters.AddWithValue("@OptionName", "WeightDefinition")

        idWeightDefinition = comm.ExecuteScalar()

        comm.Connection.Close()

        Return idWeightDefinition
    End Function

    Public Function getIDEngine(ByRef dtRow As DataRow) As Guid
        Dim IDVehicles As New Guid(dtRow.Item("IDVehicles").ToString())
        'Dim IDEngines as new Guid(dtRow.item("IDEngines").toString())
        Dim IDEngines As Guid = Guid.Empty
        'Dim IDDECS as Guid
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As SqlCommand
        Dim IDModifiedUser As Guid = Membership.GetUser().ProviderUserKey
        Dim objReader As SqlDataReader
        'if IDEngines = Guid.Empty then ' no Engine serial number = no engine = no DECS
        '			return Guid.Empty.toString()
        '		end if

        ' we'll always update the DECS for the engine.  but what if there's two? order by matching serial no
        If (Not String.IsNullOrWhiteSpace(dtRow("SerialNum"))) Then 'if no serialnum on workbook dont query DB
            comm = New SqlCommand("SELECT IDEngines, IDVehicles FROM CF_Engines " &
              "WHERE UPPER(LTRIM(RTRIM(ISNULL(SerialNum,'')))) = UPPER(LTRIM(RTRIM(ISNULL(@SerialNum,''))))", conn)
            comm.Connection.Open()
            comm.Parameters.AddWithValue("@SerialNum", dtRow("SerialNum"))
            objReader = comm.ExecuteReader()

            If objReader.Read() Then
                dtRow.Item("IDEngines") = objReader("IDEngines")
            Else
                dtRow.Item("IDEngines") = Guid.Empty
            End If
            objReader.Close()
            comm.Connection.Close()
        Else
            dtRow.Item("IDEngines") = Guid.Empty
        End If

        Return dtRow.Item("IDEngines")
    End Function

    Public Sub updateOrInsertEngine(ByRef dtRow As DataRow)
        Dim IDVehicles As New Guid(dtRow.Item("IDVehicles").ToString())
        Dim IDEngines As Guid = Guid.Empty
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As SqlCommand
        Dim IDModifiedUser As Guid = Membership.GetUser().ProviderUserKey
        Dim objReader As SqlDataReader

        If IsDBNull(dtRow.Item("SerialNum")) OrElse dtRow.Item("SerialNum") = "" Then ' no serial number = no engine
            dtRow.RowError &= "No Engine Serial Number"
            Return
        End If
        comm = New SqlCommand("SELECT IDEngines, IDVehicles FROM CF_Engines " &
          "WHERE UPPER(LTRIM(RTRIM(ISNULL(SerialNum,'')))) = UPPER(LTRIM(RTRIM(ISNULL(@SerialNum,''))))", conn)
        comm.Connection.Open()
        comm.Parameters.AddWithValue("@SerialNum", dtRow("SerialNum"))
        objReader = comm.ExecuteReader()
        If objReader.Read() Then
            IDEngines = objReader("IDEngines")
            ' MG 1/3/2012 - check that if it exists, it's assigned to this vehicle, we don't want to leave a vehicle out there with no engine because of a typo
            ' MG 1/4/2012 - if the IDVehicles is null for the engine, it's detached
            If Not IsDBNull(objReader("IDVehicles")) AndAlso IDVehicles <> objReader("IDVehicles") Then
                dtRow.RowError &= "An Engine using this Serial Number (column SerialNum) already exists for another Vehicle."

                objReader.Close()
                comm.Connection.Close()

                ' PH 6/9/2014 - add the detached engine with an IDVehicles of NULL, due to a bug that causes some engines
                '				to have an IDVehicles that points to a non-existant vehicle.  This will allow clients to 
                '				run the importer with engines and faulty IDs
                If IDVehicles = Guid.Empty Then
                    IDVehicles = objReader("IDVehicles")
                Else
                    Return
                End If
            End If
        End If
        objReader.Close()
        comm.Connection.Close()

        If IDEngines = Guid.Empty Then ' no engine with Serial Number found; insert
            IDEngines = Guid.NewGuid()
            comm = New SqlCommand("INSERT INTO CF_Engines (IDEngines, IDModifiedUser, EnterDate, ModifiedDate, IDProfileAccount, IDVehicles, IDEngineManufacturer, EngineModel, IDEngineStatus, IDEngineFuelType, IDModelYear, SerialNum, FamilyName, SeriesModelNo, Horsepower, Displacement, EstRetrofitCost)  " &
              "VALUES (@IDEngines, @IDModifiedUser, GETDATE(), GETDATE(), @IDProfileAccount, @IDVehicles, @IDEngineManufacturer, @EngineModel, @IDEngineStatus, @IDEngineFuelType, @IDModelYear, @SerialNum, @FamilyName, @SeriesModelNo, @Horsepower, @Displacement, @EstRetrofitCost)", conn)

            comm.Parameters.AddWithValue("@IDEngines", IDEngines)
            comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)

            For Each fieldname As String In New String() {"IDProfileAccount", "IDVehicles", "IDEngineManufacturer", "EngineModel", "IDEngineStatus", "IDEngineFuelType", "IDModelYear", "SerialNum", "FamilyName", "SeriesModelNo", "Horsepower", "Displacement", "EstRetrofitCost"}
                If dtRow.Table.Columns.Contains(fieldname) Then
                    If fieldname.ToLower Like "*date" Or fieldname.ToLower Like "*cost" Then
                        If IsDBNull(dtRow.Item(fieldname)) Then
                            comm.Parameters.AddWithValue("@" & fieldname, dtRow.Item(fieldname))
                        ElseIf TypeOf (dtRow.Item(fieldname)) Is DateTime Then
                            comm.Parameters.AddWithValue("@value", dtRow.Item(fieldname))
                        ElseIf IsNumeric(dtRow.Item(fieldname)) Then
                            comm.Parameters.AddWithValue("@value", dtRow.Item(fieldname))
                        ElseIf dtRow.Item(fieldname).trim() = "" Then
                            comm.Parameters.AddWithValue("@" & fieldname, DBNull.Value)
                        Else
                            comm.Parameters.AddWithValue("@" & fieldname, dtRow.Item(fieldname))
                        End If
                    Else
                        comm.Parameters.AddWithValue("@" & fieldname, dtRow.Item(fieldname))
                    End If
                Else
                    'Response.write("Fieldname " & fieldname & " is not in the source excel table")
                End If
            Next
            comm.Connection.Open()

            Try
                comm.ExecuteNonQuery()
                InsertEngineCount += 1
            Catch sqlExc As SqlException
                dtRow.RowError &= sqlExc.ToString()
            Finally
                comm.Connection.Close()
            End Try
        Else
            comm = New SqlCommand("UPDATE CF_Engines SET IDModifiedUser = @IDModifiedUser, ModifiedDate = GETDATE(), IDVehicles = @IDVehicles, IDProfileAccount = @IDProfileAccount, IDEngineManufacturer = @IDEngineManufacturer, EngineModel = @EngineModel, IDEngineStatus = @IDEngineStatus, IDEngineFuelType = @IDEngineFuelType, IDModelYear = @IDModelYear, SerialNum = @SerialNum, FamilyName = @FamilyName, SeriesModelNo = @SeriesModelNo, Horsepower = @Horsepower, Displacement = @Displacement, EstRetrofitCost = @EstRetrofitCost WHERE IDEngines = @IDEngines", conn)

            comm.Parameters.AddWithValue("@IDEngines", IDEngines)
            comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)

            Dim curFieldNames = New String() {"IDProfileAccount", "IDVehicles", "IDEngineManufacturer", "EngineModel", "IDEngineStatus", "IDEngineFuelType", "IDModelYear", "SerialNum", "FamilyName", "SeriesModelNo", "Horsepower", "Displacement"}
            For Each fieldname As String In curFieldNames
                If dtRow.Table.Columns.Contains(fieldname) Then
                    If fieldname.ToLower Like "*date" Or fieldname.ToLower Like "*cost" Then
                        If IsDBNull(dtRow.Item(fieldname)) Then
                            comm.Parameters.AddWithValue("@" & fieldname, dtRow.Item(fieldname))
                        ElseIf TypeOf (dtRow.Item(fieldname)) Is DateTime Then
                            comm.Parameters.AddWithValue("@value", dtRow.Item(fieldname))
                        ElseIf IsNumeric(dtRow.Item(fieldname)) Then
                            comm.Parameters.AddWithValue("@value", dtRow.Item(fieldname))
                        ElseIf dtRow.Item(fieldname).trim() = "" Then
                            comm.Parameters.AddWithValue("@" & fieldname, DBNull.Value)
                        Else
                            comm.Parameters.AddWithValue("@" & fieldname, dtRow.Item(fieldname))
                        End If
                    Else
                        comm.Parameters.AddWithValue("@" & fieldname, dtRow.Item(fieldname))
                    End If
                Else
                    'Response.write("Fieldname " & fieldname & " is not in the source excel table")
                End If
            Next
            comm.Parameters.AddWithValue("@EstRetrofitCost", dtRow.Item("EstRetrofitCost"))
            comm.Connection.Open()

            Try
                comm.ExecuteNonQuery()
                UpdateEngineCount += 1
            Catch sqlExc As SqlException
                dtRow.RowError &= sqlExc.ToString()
            Finally
                comm.Connection.Close()
            End Try
        End If
        dtRow.Item("IDEngines") = IDEngines
        If conn.State = ConnectionState.Open Then conn.Close()

    End Sub

    Public Function getIDDECS(ByRef dtRow As DataRow) As Guid
        Dim IDVehicles As New Guid(dtRow.Item("IDVehicles").ToString())
        Dim IDEngines As New Guid(dtRow.Item("IDEngines").ToString())
        'Dim IDDECS As Guid  --WARNINGS commented out by due to not being used Sam 2/20
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As SqlCommand
        Dim IDModifiedUser As Guid = Membership.GetUser().ProviderUserKey
        Dim objReader As SqlDataReader
        If IDEngines = Guid.Empty Then ' no Engine serial number = no engine = no DECS
            Return Guid.Empty
        End If

        ' we'll always update the DECS for the engine.  but what if there's two? order by matching serial no
        comm = New SqlCommand("SELECT TOP 1 * FROM CF_DECS WHERE IDEngines = @IDEngines " &
          "ORDER BY CASE WHEN UPPER(RTRIM(ISNULL(SerialNo,''))) = UPPER(RTRIM(ISNULL(@SerialNo,''))) THEN 1 ELSE 10 END, " &
          "CASE WHEN UPPER(RTRIM(ISNULL(DECSName,''))) = UPPER(RTRIM(ISNULL(@DECSName,''))) THEN 1 ELSE 10 END", conn)

        comm.Parameters.AddWithValue("@IDEngines", IDEngines)
        comm.Parameters.AddWithValue("@SerialNo", dtRow.Item("SerialNo"))
        comm.Parameters.AddWithValue("@DECSName", dtRow.Item("DECSName"))
        comm.Connection.Open()
        objReader = comm.ExecuteReader()
        If objReader.Read() Then
            dtRow.Item("IDDECS") = objReader("IDDECS")
        Else
            dtRow.Item("IDDECS") = Guid.Empty
        End If
        objReader.Close()
        comm.Connection.Close()

        Return dtRow.Item("IDDECS")
    End Function

    Public Sub updateOrInsertDECS(ByRef dtRow As DataRow)
        Dim IDVehicles As New Guid(dtRow.Item("IDVehicles").ToString())
        Dim IDEngines As New Guid(dtRow.Item("IDEngines").ToString())
        Dim IDDECS As Guid
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As SqlCommand
        Dim IDModifiedUser As Guid = Membership.GetUser().ProviderUserKey
        Dim objReader As SqlDataReader


        If IDEngines = Guid.Empty Then ' no Engine serial number = no engine = no DECS
            Return
        End If

        Dim hasValues As Boolean = False
        For Each fieldname As String In New String() {"SerialNo", "DECSName", "IDDECSManufacturer", "IDDECSLevel", "DECSModelNo", "DECSInstallationDate"}
            If dtRow.Table.Columns.Contains(fieldname) Then
                If fieldname.ToLower() Like "id*" Then

                    If Not IsDBNull(dtRow.Item(fieldname)) AndAlso dtRow.Item(fieldname) > 0 Then
                        hasValues = True
                        Exit For
                    End If
                Else
                    If Not IsDBNull(dtRow.Item(fieldname)) AndAlso dtRow.Item(fieldname).trim() > "" Then
                        hasValues = True
                        Exit For
                    End If
                End If
            End If
        Next
        If Not hasValues Then
            If dtRow.Table.Columns.Contains("DECSFiles") Then 'check for DECS File or Image
                If Not IsDBNull(dtRow.Item("DECSFiles")) AndAlso dtRow.Item("DECSFiles").trim() > "" Then
                    comm = New SqlCommand("SELECT * FROM CF_DECS WHERE IDEngines = @IDEngines ", conn)
                    comm.Connection.Open()
                    comm.Parameters.AddWithValue("@IDEngines", IDEngines)
                    objReader = comm.ExecuteReader()
                    If objReader.Read() Then 'DECS already exists associate file/image with it
                        IDDECS = objReader("IDDECS")
                    Else
                        'DECS File or Image exists on workbook but no DECS exists and no DECS information on import workbook 
                        'create blank DECS to associate the image with.
                        objReader.Close()
                        IDDECS = Guid.NewGuid()
                        comm = New SqlCommand("INSERT INTO CF_DECS (IDDECS, IDModifiedUser, EnterDate, ModifiedDate, IDEngines)" &
                          "VALUES (@IDDECS, @IDModifiedUser, GETDATE(), GETDATE(), @IDEngines)", conn)
                        comm.Parameters.AddWithValue("@IDDECS", IDDECS)
                        comm.Parameters.AddWithValue("@IDEngines", IDEngines)
                        comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
                        objReader = comm.ExecuteReader()
                        InsertDECSCount += 1
                    End If
                    dtRow.Item("IDDECS") = IDDECS
                    objReader.Close()
                    comm.Connection.Close()
                End If
            End If
            Return
        End If

        ' we'll always update the DECS for the engine.  but what if there's two? order by matching serial no
        comm = New SqlCommand("SELECT TOP 1 * FROM CF_DECS WHERE IDEngines = @IDEngines " &
          "ORDER BY CASE WHEN UPPER(RTRIM(ISNULL(SerialNo,''))) = UPPER(RTRIM(ISNULL(@SerialNo,''))) THEN 1 ELSE 10 END, " &
          "CASE WHEN UPPER(RTRIM(ISNULL(DECSName,''))) = UPPER(RTRIM(ISNULL(@DECSName,''))) THEN 1 ELSE 10 END", conn)

        comm.Parameters.AddWithValue("@IDEngines", IDEngines)
        comm.Parameters.AddWithValue("@SerialNo", dtRow.Item("SerialNo"))
        comm.Parameters.AddWithValue("@DECSName", dtRow.Item("DECSName"))
        comm.Connection.Open()
        objReader = comm.ExecuteReader()
        If objReader.Read() Then
            IDDECS = objReader("IDDECS")
        End If
        objReader.Close()
        comm.Connection.Close()

        If IDDECS = Guid.Empty Then
            ' insert
            IDDECS = Guid.NewGuid()
            comm = New SqlCommand("INSERT INTO CF_DECS (IDDECS, IDModifiedUser, EnterDate, ModifiedDate, IDProfileAccount, IDEngines, SerialNo, DECSName, IDDECSManufacturer, IDDECSLevel, DECSModelNo, DECSInstallationDate) " &
              "VALUES (@IDDECS, @IDModifiedUser, GETDATE(), GETDATE(), @IDProfileAccount, @IDEngines, @SerialNo, @DECSName, @IDDECSManufacturer, @IDDECSLevel, @DECSModelNo, @DECSInstallationDate)", conn)
            comm.Parameters.AddWithValue("@IDDECS", IDDECS)
            comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
            'comm.parameters.AddWithValue("@IDDECSLevel", if(dtRow.table.columns.contains("IDDECSLevel"), dtRow.item("IDDECSLevel"),0))
            For Each fieldname As String In New String() {"IDProfileAccount", "IDEngines", "SerialNo", "DECSName", "IDDECSManufacturer", "IDDECSLevel", "DECSModelNo", "DECSInstallationDate"}
                If dtRow.Table.Columns.Contains(fieldname) Then
                    If fieldname.ToLower Like "*date" Or fieldname.ToLower Like "*cost" Then
                        If IsDBNull(dtRow.Item(fieldname)) Then
                            comm.Parameters.AddWithValue("@" & fieldname, dtRow.Item(fieldname))
                        ElseIf TypeOf (dtRow.Item(fieldname)) Is DateTime Then
                            comm.Parameters.AddWithValue("@" & fieldname, dtRow.Item(fieldname))
                        ElseIf IsNumeric(dtRow.Item(fieldname)) Then
                            comm.Parameters.AddWithValue("@value", dtRow.Item(fieldname))
                        ElseIf dtRow.Item(fieldname).trim() = "" Then
                            comm.Parameters.AddWithValue("@" & fieldname, DBNull.Value)
                        Else
                            comm.Parameters.AddWithValue("@" & fieldname, dtRow.Item(fieldname))
                        End If
                    Else
                        comm.Parameters.AddWithValue("@" & fieldname, dtRow.Item(fieldname))
                    End If
                Else
                    'Response.write("Fieldname " & fieldname & " is not in the source excel table")
                End If
            Next
            comm.Connection.Open()
            comm.ExecuteNonQuery()
            comm.Connection.Close()
            InsertDECSCount += 1
        Else
            ' update
            comm = New SqlCommand("UPDATE CF_DECS SET IDModifiedUser = @IDModifiedUser , ModifiedDate = GETDATE(), IDProfileAccount = @IDProfileAccount, IDEngines = @IDEngines, SerialNo = @SerialNo, DECSName = @DECSName, IDDECSManufacturer = @IDDECSManufacturer, IDDECSLevel = @IDDECSLevel, DECSModelNo = @DECSModelNo, DECSInstallationDate = @DECSInstallationDate WHERE IDDECS = @IDDECS", conn)
            comm.Parameters.AddWithValue("@IDDECS", IDDECS)
            comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
            'comm.parameters.AddWithValue("@IDDECSLevel", if(dtRow.table.columns.contains("IDDECSLevel"), dtRow.item("IDDECSLevel"),0))
            For Each fieldname As String In New String() {"IDProfileAccount", "IDEngines", "SerialNo", "DECSName", "IDDECSManufacturer", "IDDECSLevel", "DECSModelNo", "DECSInstallationDate"}
                If dtRow.Table.Columns.Contains(fieldname) Then
                    If fieldname.ToLower Like "*date" Or fieldname.ToLower Like "*cost" Then
                        If IsDBNull(dtRow.Item(fieldname)) Then
                            comm.Parameters.AddWithValue("@" & fieldname, dtRow.Item(fieldname))
                        ElseIf TypeOf (dtRow.Item(fieldname)) Is DateTime Then
                            comm.Parameters.AddWithValue("@" & fieldname, dtRow.Item(fieldname))
                        ElseIf TypeOf (dtRow.Item(fieldname)) Is DateTime Then
                            comm.Parameters.AddWithValue("@value", dtRow.Item(fieldname))
                        ElseIf IsNumeric(dtRow.Item(fieldname)) Then
                            comm.Parameters.AddWithValue("@value", dtRow.Item(fieldname))
                        ElseIf dtRow.Item(fieldname).trim() = "" Then
                            comm.Parameters.AddWithValue("@" & fieldname, DBNull.Value)
                        Else
                            comm.Parameters.AddWithValue("@" & fieldname, dtRow.Item(fieldname))
                        End If
                    Else
                        comm.Parameters.AddWithValue("@" & fieldname, dtRow.Item(fieldname))
                    End If
                Else
                    'Response.write("Fieldname " & fieldname & " is not in the source excel table")
                End If
            Next
            comm.Connection.Open()
            comm.ExecuteNonQuery()
            comm.Connection.Close()
            UpdateDECSCount += 1

        End If
        dtRow.Item("IDDECS") = IDDECS
        If conn.State = ConnectionState.Open Then conn.Close()

    End Sub

    Public Sub updateOrInsertFiles(ByRef dtRow As DataRow, ByVal ZIPFileSpec As String)
        Dim IDVehicles As New Guid(dtRow.Item("IDVehicles").ToString())
        Dim IDEngines As New Guid(dtRow.Item("IDEngines").ToString())
        Dim IDDECS As Guid
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim conn2 As New SqlConnection(connectionString)
        Dim comm As SqlCommand
        Dim comm2 As SqlCommand
        Dim IDModifiedUser As Guid = Membership.GetUser().ProviderUserKey
        Dim objReader As SqlDataReader
        Dim fieldVal As String
        Dim fieldValArr() As String
        Dim picTarget As String = Server.MapPath("../../includes/imagemanager/imagefiles")
        Dim fileTarget As String = Server.MapPath("../../includes/filemanager/files")
        Dim picPath As String = ConfigurationManager.AppSettings("ImageRepositoryFolder")
        Dim filePath As String = ConfigurationManager.AppSettings("FileRepositoryFolder")
        Dim fileExt As String
        Dim upFileExt As String
        Dim recordValue As String
        Dim firstRecord As Boolean = True
        Dim itemFound As Boolean
        Dim insertF As Boolean

        Try
            IDDECS = New Guid(dtRow.Item("IDDECS").ToString())
        Catch ex As Exception
            IDDECS = Guid.Empty
        End Try

        If Not Directory.Exists(picTarget) Then
            Directory.CreateDirectory(picTarget)
        End If
        If Not Directory.Exists(fileTarget) Then
            Directory.CreateDirectory(fileTarget)
        End If
        If cbReplaceAllFiles.Checked Then
            '09/07/2012 IR: Get images associated with current vehicle checked in by the current user and delete them
            comm = New SqlCommand("SELECT FilePath, IDImages, FileName FROM CF_Images WHERE IDVehicles = @IDVehicles AND IDModifiedUser = @IDModifiedUser", conn)
            comm.Connection.Open()
            comm.Parameters.AddWithValue("@IDVehicles", IDVehicles)
            comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
            objReader = comm.ExecuteReader()
            While objReader.Read()
                File.Delete(Server.MapPath(Path.Combine(objReader("FilePath"), objReader("FileName"))))
                comm2 = New SqlCommand("DELETE FROM CF_Images WHERE IDImages = @IDImages", conn2)
                comm2.Parameters.AddWithValue("@IDImages", objReader("IDImages"))
                comm2.Connection.Open()
                comm2.ExecuteScalar()
                comm2.Connection.Close()
            End While
            objReader.Close()
            comm.Connection.Close()
            '09/07/2012 IR: Get files associated with current vehicle checked in by the current user and delete them
            comm = New SqlCommand("SELECT FilePath, IDFile, FileName FROM CF_Files WHERE IDVehicles = @IDVehicles AND IDModifiedUser = @IDModifiedUser", conn)
            comm.Connection.Open()
            comm.Parameters.AddWithValue("@IDVehicles", IDVehicles)
            comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
            objReader = comm.ExecuteReader()
            While objReader.Read()
                File.Delete(Server.MapPath(Path.Combine(objReader("FilePath"), objReader("FileName"))))
                comm2 = New SqlCommand("DELETE FROM CF_Files WHERE IDFile = @IDFile", conn2)
                comm2.Parameters.AddWithValue("@IDFile", objReader("IDFile"))
                comm2.Connection.Open()
                comm2.ExecuteScalar()
                comm2.Connection.Close()
            End While
            objReader.Close()
            comm.Connection.Close()

            '09/07/2012 IR: Get images associated with current engine checked in by the current user and delete them
            comm = New SqlCommand("SELECT FilePath, IDImages, FileName FROM CF_Images WHERE IDEngines = @IDEngines AND IDModifiedUser = @IDModifiedUser", conn)
            comm.Connection.Open()
            comm.Parameters.AddWithValue("@IDEngines", IDEngines)
            comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
            objReader = comm.ExecuteReader()
            While objReader.Read()
                File.Delete(Server.MapPath(Path.Combine(objReader("FilePath"), objReader("FileName"))))
                comm2 = New SqlCommand("DELETE FROM CF_Images WHERE IDImages = @IDImages", conn2)
                comm2.Parameters.AddWithValue("@IDImages", objReader("IDImages"))
                comm2.Connection.Open()
                comm2.ExecuteScalar()
                comm2.Connection.Close()
            End While
            objReader.Close()
            comm.Connection.Close()
            '09/07/2012 IR: Get files associated with current engine checked in by the current user and delete them
            comm = New SqlCommand("SELECT FilePath, IDFile, FileName FROM CF_Files WHERE IDEngines = @IDEngines AND IDModifiedUser = @IDModifiedUser", conn)
            comm.Connection.Open()
            comm.Parameters.AddWithValue("@IDEngines", IDEngines)
            comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
            objReader = comm.ExecuteReader()
            While objReader.Read()
                File.Delete(Server.MapPath(Path.Combine(objReader("FilePath"), objReader("FileName"))))
                comm2 = New SqlCommand("DELETE FROM CF_Files WHERE IDFile = @IDFile", conn2)
                comm2.Parameters.AddWithValue("@IDFile", objReader("IDFile"))
                comm2.Connection.Open()
                comm2.ExecuteScalar()
                comm2.Connection.Close()
            End While
            objReader.Close()
            comm.Connection.Close()

            '09/07/2012 IR: Get images associated with current DECS checked in by the current user and delete them
            comm = New SqlCommand("SELECT FilePath, IDImages, FileName FROM CF_Images WHERE IDDECS = @IDDECS AND IDModifiedUser = @IDModifiedUser", conn)
            comm.Connection.Open()
            comm.Parameters.AddWithValue("@IDDECS", IDDECS)
            comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
            objReader = comm.ExecuteReader()
            While objReader.Read()
                File.Delete(Server.MapPath(Path.Combine(objReader("FilePath"), objReader("FileName"))))
                comm2 = New SqlCommand("DELETE FROM CF_Images WHERE IDImages = @IDImages", conn2)
                comm2.Parameters.AddWithValue("@IDImages", objReader("IDImages"))
                comm2.Connection.Open()
                comm2.ExecuteScalar()
                comm2.Connection.Close()
            End While
            objReader.Close()
            comm.Connection.Close()
            '09/07/2012 IR: Get files associated with current DECS checked in by the current user and delete them
            comm = New SqlCommand("SELECT FilePath, IDFile, FileName FROM CF_Files WHERE IDDECS = @IDDECS AND IDModifiedUser = @IDModifiedUser", conn)
            comm.Connection.Open()
            comm.Parameters.AddWithValue("@IDDECS", IDDECS)
            comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
            objReader = comm.ExecuteReader()
            While objReader.Read()
                File.Delete(Server.MapPath(Path.Combine(objReader("FilePath"), objReader("FileName"))))
                comm2 = New SqlCommand("DELETE FROM CF_Files WHERE IDFile = @IDFile", conn2)
                comm2.Parameters.AddWithValue("@IDFile", objReader("IDFile"))
                comm2.Connection.Open()
                comm2.ExecuteScalar()
                comm2.Connection.Close()
            End While
            objReader.Close()
            comm.Connection.Close()

            'comm = new SQLCommand("SELECT FilePath, IDImages, FileName FROM CF_Images WHERE IDDECS = @IDDECS AND IDModifiedUser = @IDModifiedUser " & _
            '			  "UNION SELECT FilePath, IDFile, FileName FROM CF_Files WHERE IDDECS = @IDDECS AND IDModifiedUser = @IDModifiedUser ", conn)
            '			comm.Connection.Open()
            '			comm.parameters.AddWithValue("@IDDECS", IDDECS)
            '			comm.parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
            '			objReader = comm.ExecuteReader()
            '			while objReader.read()
            '				File.delete(Server.MapPath(Path.combine(objReader("FilePath"), objReader("FileName"))))
            '				comm2 = new SQLCommand("DELETE FROM CF_Images WHERE IDImages = @IDImages", conn)
            '				comm2.parameters.AddWithValue("@IDImages", objReader("IDImages"))
            '				comm2.Connection.Open()
            '				comm2.ExecuteScalar()
            '			end while
            '			objReader.close()
            '			comm.Connection.Close()
            '			comm2.Connection.Close()
        End If


        For Each fieldname As String In New String() {"VehicleFiles", "EngineFiles", "DECSFiles"} 'check 3 possible columns for each file
            firstRecord = True ' by default, assume that it's the first (default) record

            'Response.write("Field Name = " & fieldname & "<br/>" & vbcrlf)
            'Response.write("Field Contents = " & dtRow.item(fieldname) & "<br/>" & vbcrlf)
            If Not IsDBNull(dtRow.Item(fieldname)) AndAlso dtRow.Item(fieldname).trim() > "" Then 'there are files associated with this record
                fieldVal = dtRow.Item(fieldname) 'get the associated files from the current field
                fieldValArr = fieldVal.Split(New Char() {"|"c})
                For Each curFile As String In fieldValArr 'process each file found in the current field
                    fileExt = Path.GetExtension(curFile)
                    upFileExt = fileExt.ToUpper()
                    If upFileExt = ".JPG" Or upFileExt = ".BMP" Or upFileExt = ".PNG" Or upFileExt = ".GIF" Then 'current file is an image file
                        Using zip As ZipFile = ZipFile.Read(ZIPFileSpec)
                            Dim entry As ZipEntry
                            For Each entry In zip 'check each entry in the zip file to see if it is the current file
                                If String.Equals(entry.FileName, curFile) Then
                                    Dim IDImages As Guid = Guid.NewGuid()
                                    entry.Extract(picTarget)
                                    Dim newFileName = picTarget & "\" & IDImages.ToString() & fileExt
                                    File.Move(picTarget & "\" & entry.FileName, newFileName) 'rename file with GUID after extraction

                                    If String.Equals(fieldname, "VehicleFiles") Then
                                        comm = New SqlCommand("SELECT FilePath, IDImages, FileName, DefaultImage FROM CF_Images WHERE IDVehicles = @IDVehicles", conn)
                                        comm.Connection.Open()
                                        comm.Parameters.AddWithValue("@IDVehicles", IDVehicles)
                                    ElseIf String.Equals(fieldname, "EngineFiles") Then
                                        comm = New SqlCommand("SELECT FilePath, IDImages, FileName, DefaultImage FROM CF_Images WHERE IDEngines = @IDEngines AND IDDECS IS NULL", conn)
                                        comm.Connection.Open()
                                        comm.Parameters.AddWithValue("@IDEngines", IDEngines)
                                    Else
                                        comm = New SqlCommand("SELECT FilePath, IDImages, FileName, DefaultImage FROM CF_Images WHERE IDDECS = @IDDECS", conn)
                                        comm.Connection.Open()
                                        comm.Parameters.AddWithValue("@IDDECS", IDDECS)
                                    End If

                                    objReader = comm.ExecuteReader() 'get all image files already associated with the current vehicle
                                    itemFound = False 'flag to indicate the current file is already associated with the current vehicle
                                    ' MG 10/11/12 - scan all attached images to see if we need to set new image as default
                                    Do While objReader.Read() ' andAlso not itemFound
                                        recordValue = objReader("FilePath")
                                        If objReader("DefaultImage") Then
                                            firstRecord = False
                                        End If
                                        'hash the current file and new file to see if they are the same
                                        If File.Exists(picTarget & "\" & objReader("FileName")) AndAlso File.Exists(newFileName) Then
                                            Dim hash1 As String = Inspironix.Cryptography.Hash(picTarget & "\" & objReader("FileName"))
                                            Dim hash2 As String = Inspironix.Cryptography.Hash(newFileName)
                                            If String.Equals(hash1, hash2) Then 'new file is already associated with the current vehicle
                                                itemFound = True
                                                File.Delete(newFileName)
                                            End If
                                        End If
                                    Loop
                                    objReader.Close()
                                    If Not itemFound Then 'new file is not associated with the current vehicle
                                        comm = New SqlCommand("INSERT INTO CF_Images (IDImages, IDModifiedUser, DefaultImage, EnterDate, ModifiedDate, IDVehicles, IDEngines, " &
                                            "IDDECS, Title, FilePath, FileName, UserID) VALUES(@IDImages, @IDModifiedUser, @DefaultImage, GETDATE(), GETDATE(), @IDVehicles, @IDEngines, " &
                                            "@IDDECS, @Title, @FilePath, @FileName, @UserID)", conn)
                                        comm.Parameters.AddWithValue("@IDImages", IDImages)
                                        comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
                                        comm.Parameters.AddWithValue("@Title", DBNull.Value)
                                        comm.Parameters.AddWithValue("@FilePath", picPath)
                                        comm.Parameters.AddWithValue("@FileName", IDImages.ToString() & Path.GetExtension(entry.FileName))
                                        comm.Parameters.AddWithValue("@UserID", IDModifiedUser)

                                        If firstRecord Then
                                            comm.Parameters.AddWithValue("@DefaultImage", 1)
                                            firstRecord = False 'subsequent records will not be set to default
                                        Else
                                            comm.Parameters.AddWithValue("@DefaultImage", 0)
                                        End If
                                        insertF = True
                                        If fieldname = "VehicleFiles" Then

                                            If Not IDVehicles = Guid.Empty Then
                                                comm.Parameters.AddWithValue("@IDVehicles", IDVehicles)
                                                comm.Parameters.AddWithValue("@IDEngines", DBNull.Value)
                                                comm.Parameters.AddWithValue("@IDDECS", DBNull.Value)
                                            Else
                                                insertF = False
                                                dtRow.Item("Warnings") &= "Vehicle Image: " & entry.FileName &
                                                      " Could not be imported, the Vehicle was not found" & vbCrLf
                                                dtRow("VehicleImportStatus") = "warning"
                                            End If
                                        ElseIf fieldname = "EngineFiles" Then
                                            'Response.write("IDEngines: " & IDEngines.toString() & "<br/>")
                                            If Not IDEngines = Guid.Empty Then
                                                comm.Parameters.AddWithValue("@IDEngines", IDEngines)
                                                comm.Parameters.AddWithValue("@IDVehicles", DBNull.Value)
                                                comm.Parameters.AddWithValue("@IDDECS", DBNull.Value)
                                            Else
                                                insertF = False
                                                dtRow.Item("Warnings") &= "Engine Image: " & entry.FileName &
                                                      " Could not be imported, the Engine was not found" & vbCrLf
                                                dtRow("VehicleImportStatus") = "warning"
                                            End If
                                        Else
                                            If Not IDEngines = Guid.Empty AndAlso Not IDDECS = Guid.Empty Then
                                                comm.Parameters.AddWithValue("@IDDECS", IDDECS)
                                                comm.Parameters.AddWithValue("@IDVehicles", DBNull.Value)
                                                comm.Parameters.AddWithValue("@IDEngines", IDEngines)
                                            Else
                                                insertF = False
                                                dtRow.Item("Warnings") &= "DECS Image: " & entry.FileName &
                                                      " Could not be imported, the DECS was not found" & vbCrLf
                                                dtRow("VehicleImportStatus") = "warning"
                                            End If
                                        End If
                                        'if not IDVehicles = Guid.empty then
                                        '	comm.parameters.AddWithValue("@IDVehicles", IDVehicles)
                                        'else
                                        '	comm.parameters.AddWithValue("@IDVehicles", DBNull.value)
                                        'end if
                                        '
                                        'if not IDEngines = Guid.empty then
                                        '	comm.parameters.AddWithValue("@IDEngines", IDEngines)
                                        'else
                                        '	comm.parameters.AddWithValue("@IDEngines", DBNull.value)
                                        'end if
                                        '
                                        'if not IDDECS = Guid.empty then
                                        '	comm.parameters.AddWithValue("@IDDECS", IDDECS)
                                        'else
                                        '	comm.parameters.AddWithValue("@IDDECS", DBNull.value)
                                        'end if	
                                        If insertF Then
                                            comm.ExecuteNonQuery()
                                            UploadedImagesCount += 1
                                        End If
                                    End If
                                    comm.Connection.Close()
                                End If
                            Next
                        End Using
                    Else
                        'handle non image files such as .pdf
                        Using zip As ZipFile = ZipFile.Read(ZIPFileSpec)
                            Dim entry As ZipEntry
                            For Each entry In zip
                                If String.Equals(entry.FileName, curFile) Then
                                    Dim IDFile As Guid = Guid.NewGuid()
                                    entry.Extract(fileTarget)
                                    Dim newFileName = fileTarget & "\" & IDFile.ToString() & fileExt
                                    File.Move(fileTarget & "\" & entry.FileName, newFileName)
                                    'Response.write("Field Name: " & fieldname & "<br/>" & vbcrlf)
                                    If String.Equals(fieldname, "VehicleFiles") Then
                                        comm = New SqlCommand("SELECT FilePath, IDFile, FileName FROM CF_Files WHERE IDVehicles = @IDVehicles", conn)
                                        comm.Connection.Open()
                                        comm.Parameters.AddWithValue("@IDVehicles", IDVehicles)
                                    ElseIf String.Equals(fieldname, "EngineFiles") Then
                                        comm = New SqlCommand("SELECT FilePath, IDFile, FileName FROM CF_Files WHERE IDEngines = @IDEngines", conn)
                                        comm.Connection.Open()
                                        comm.Parameters.AddWithValue("@IDEngines", IDEngines)
                                    Else
                                        comm = New SqlCommand("SELECT FilePath, IDFile, FileName FROM CF_Files WHERE IDDECS = @IDDECS", conn)
                                        comm.Connection.Open()
                                        comm.Parameters.AddWithValue("@IDDECS", IDDECS)
                                    End If

                                    objReader = comm.ExecuteReader()
                                    itemFound = False
                                    Do While objReader.Read() AndAlso Not itemFound
                                        'Response.write("File Name: " & objReader("FileName") & "<br/>" & vbcrlf)
                                        recordValue = objReader("FilePath")
                                        If File.Exists(fileTarget & "\" & objReader("FileName")) Then
                                            Dim hash1 As String = Inspironix.Cryptography.Hash(fileTarget & "\" & objReader("FileName"))
                                            Dim hash2 As String = Inspironix.Cryptography.Hash(newFileName)
                                            If String.Equals(hash1, hash2) Then
                                                itemFound = True
                                                File.Delete(newFileName)
                                            End If
                                        End If
                                    Loop
                                    objReader.Close()
                                    If Not itemFound Then
                                        comm = New SqlCommand("INSERT INTO CF_Files (IDFile, IDModifiedUser, EnterDate, ModifiedDate, IDVehicles, IDEngines, " &
                                            "IDDECS, Title, FilePath, FileName, FileSize, IDProfileAccount, IDProfileTerminal, IDProfileFleet, Notes)" &
                                            "VALUES(@IDFile, @IDModifiedUser, GETDATE(), GETDATE(), @IDVehicles, @IDEngines, @IDDECS, @Title, @FilePath, @FileName, " &
                                            "@FileSize, @IDProfileAccount, @IDProfileTerminal, @IDProfileFleet, @Notes)", conn)
                                        comm.Parameters.AddWithValue("@IDFile", IDFile)
                                        comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
                                        comm.Parameters.AddWithValue("@Title", DBNull.Value)
                                        comm.Parameters.AddWithValue("@FilePath", filePath)
                                        comm.Parameters.AddWithValue("@FileName", IDFile.ToString() & Path.GetExtension(entry.FileName))
                                        comm.Parameters.AddWithValue("@FileSize", entry.UncompressedSize())
                                        comm.Parameters.AddWithValue("@Notes", DBNull.Value)

                                        insertF = True
                                        If fieldname = "VehicleFiles" Then

                                            If Not IDVehicles = Guid.Empty Then
                                                comm.Parameters.AddWithValue("@IDVehicles", IDVehicles)
                                                comm.Parameters.AddWithValue("@IDEngines", DBNull.Value)
                                                comm.Parameters.AddWithValue("@IDDECS", DBNull.Value)
                                            Else
                                                insertF = False
                                                dtRow.Item("Warnings") &= "Vehicle File: " & entry.FileName &
                                                      " Could not be imported, the Vehicle was not found"
                                                dtRow("VehicleImportStatus") = "warning"
                                            End If
                                        ElseIf fieldname = "EngineFiles" Then

                                            If Not IDEngines = Guid.Empty Then
                                                comm.Parameters.AddWithValue("@IDEngines", IDEngines)
                                                comm.Parameters.AddWithValue("@IDVehicles", DBNull.Value)
                                                comm.Parameters.AddWithValue("@IDDECS", DBNull.Value)
                                            Else
                                                insertF = False
                                                dtRow.Item("Warnings") &= "Engine File: " & entry.FileName &
                                                      " Could not be imported, the Engine was not found"
                                                dtRow("VehicleImportStatus") = "warning"
                                            End If
                                        Else
                                            If Not IDEngines = Guid.Empty AndAlso Not IDDECS = Guid.Empty Then
                                                comm.Parameters.AddWithValue("@IDDECS", IDDECS)
                                                comm.Parameters.AddWithValue("@IDVehicles", DBNull.Value)
                                                comm.Parameters.AddWithValue("@IDEngines", IDEngines)
                                            Else
                                                insertF = False
                                                dtRow.Item("Warnings") &= "DECS File: " & entry.FileName &
                                                      " Could not be imported, the Engine was not found"
                                                dtRow("VehicleImportStatus") = "warning"
                                            End If
                                        End If
                                        '	if not IDVehicles = Guid.empty then
                                        '		comm.parameters.AddWithValue("@IDVehicles", IDVehicles)
                                        '	else
                                        '		comm.parameters.AddWithValue("@IDVehicles", DBNull.value)
                                        '	end if
                                        '	
                                        '	if not IDEngines = Guid.empty then
                                        '		comm.parameters.AddWithValue("@IDEngines", IDEngines)
                                        '	else
                                        '		comm.parameters.AddWithValue("@IDEngines", DBNull.value)
                                        '	end if
                                        '	
                                        '	if not IDDECS = Guid.empty then
                                        '		comm.parameters.AddWithValue("@IDDECS", IDDECS)
                                        '	else
                                        '		comm.parameters.AddWithValue("@IDDECS", DBNull.value)
                                        '	end if	
                                        If insertF Then
                                            If dtRow.Item("IDProfileAccount") <= 0 Then
                                                comm.Parameters.AddWithValue("@IDProfileAccount", DBNull.Value)
                                            Else
                                                comm.Parameters.AddWithValue("@IDProfileAccount", dtRow.Item("IDProfileAccount"))
                                            End If

                                            If dtRow.Item("IDProfileTerminal") <= 0 Then
                                                comm.Parameters.AddWithValue("@IDProfileTerminal", DBNull.Value)
                                            Else
                                                comm.Parameters.AddWithValue("@IDProfileTerminal", dtRow.Item("IDProfileTerminal"))
                                            End If

                                            If dtRow.Item("IDProfileFleet") <= 0 Then
                                                comm.Parameters.AddWithValue("@IDProfileFleet", DBNull.Value)
                                            Else
                                                comm.Parameters.AddWithValue("@IDProfileFleet", dtRow.Item("IDProfileFleet"))
                                            End If

                                            comm.ExecuteNonQuery()
                                            UploadedFilesCount += 1
                                        End If
                                    End If
                                    comm.Connection.Close()
                                End If
                            Next
                        End Using
                    End If
                Next
            End If
        Next
        conn.Close()
    End Sub

    Public Function Hash(ByVal FileSpec As String) As String
        Dim sha1Managed As New SHA1Managed()
        Dim hashStream As Stream = New FileStream(FileSpec, FileMode.Open, FileAccess.Read)
        Dim str1 As String = BitConverter.ToString(New SHA1Managed().ComputeHash(hashStream)).Replace("-", "")
        Dim fs As FileStream = DirectCast(hashStream, FileStream)
        Dim str2 As String = str1
        fs.Close()
        Return str2
    End Function

End Class
'Public Static String Hash(ref Stream streamToHash)
'    {
'      Return BitConverter.ToString(New SHA1Managed().ComputeHash(streamToHash)).Replace("-", "");
'    }

'    Public Static String Hash(String FileSpec)
'    {
'      SHA1Managed shA1Managed = New SHA1Managed();
'      Stream streamToHash = (Stream) New FileStream(FileSpec, FileMode.Open, FileAccess.Read);
'      String str1 = Inspironix.Cryptography.Hash(ref streamToHash);
'      FileStream fileStream = (fileStream) streamToHash;
'      String str2 = str1;
'      fileStream.Close();
'      Return str2;
'    }
'  }