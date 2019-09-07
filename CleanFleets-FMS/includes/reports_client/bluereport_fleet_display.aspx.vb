Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Public Class bluereport_fleet_display1
    Inherits BaseWebForm

    Protected vehicleView As DataView

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Me.IsPostBack() Then

        Else

        End If

        'btn_Print.Attributes("onClick") = "javascript:window.print();return false"
        btn_Print.Attributes("onClick") = "javascript:document.execCommand('print', false, null);return false"
        '09/13/2012 IR: Added retrieval of the current userID for the sql datasources
        Dim UserID As Guid
        Dim MemUser As MembershipUser
        MemUser = Membership.GetUser()
        UserID = MemUser.ProviderUserKey
        sds_ReportEnginesDECS.SelectParameters("UserId").DefaultValue = UserID.ToString()

        vehicleView = CType(sds_ReportEnginesDECS.Select(DataSourceSelectArguments.Empty), DataView)
    End Sub

End Class