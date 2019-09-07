Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports Telerik.Web.UI
Public Class bluereport_fleet_CARB1
    Inherits BaseWebForm

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then

        End If
    End Sub


    Protected Sub ddl_Account_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim IDProfileAccount As Integer = Convert.ToInt32(ddl_Account.SelectedValue.ToString())
        'fillTerminals(IDProfileAccount)
        'fillFleets(0)
    End Sub



    Protected Sub btn_Report_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Report.Click
        If Page.IsValid() Then
            Dim windowManager As New RadWindowManager()
            Dim RadWindow As New RadWindow()
            RadWindow.NavigateUrl = "~/includes/reports_console/bluereport_fleet_display.aspx?Query=Fleet&IDProfileAccount=" & ddl_Account.SelectedValue & "&IDCARBGroup=" & ddl_CARBGroup.SelectedValue
            RadWindow.ID = "RadWindow1"
            RadWindow.VisibleOnPageLoad = True
            RadWindow.Height = 400
            RadWindow.Width = 850
            RadWindow.Modal = True
            windowManager.Windows.Add(RadWindow)
            Me.Form.Controls.Add(RadWindow)
        End If
    End Sub


    Protected Sub ddl_Fleet_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) 'Handles RadComboBox3.SelectedIndexChanged

        'Session("IDProfileFLeet") = RadComboBox3.SelectedValue

    End Sub


    Sub cf_ddl_Validate(sender As Object, args As ServerValidateEventArgs)
        Dim value As Integer
        args.IsValid = True
        If args.IsValid Then args.IsValid = (Integer.TryParse(args.Value, value) AndAlso value > 0)
    End Sub



End Class