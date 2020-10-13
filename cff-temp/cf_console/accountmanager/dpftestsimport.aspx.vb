Imports System.Web.Security
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
Imports WebSupergoo.ABCpdf7
Public Class WebForm1
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

            filespec1 = Path.Combine(Server.MapPath(TEMP_FOLDER), Membership.GetUser().UserName.ToLower() & "_OpacityTestsImport" & Path.GetExtension(fu_ImportFile.FileName))
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