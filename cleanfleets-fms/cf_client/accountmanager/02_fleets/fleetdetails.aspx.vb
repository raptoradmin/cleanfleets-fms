Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports CFUtilities

Public Class fleetdetails
    Inherits BaseWebForm

    '09/13/2012 IR: Added terminalpermission for to be used to hide update buttons based on permission level
    Protected terminalPermission As String
    Protected Sub sds_cfv_Profile_Fleet_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sds_cfv_Profile_Fleet.Deleted
        Response.Redirect("fleet.aspx")
    End Sub

    Protected Sub sds_cfv_Profile_Fleet_Updating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles sds_cfv_Profile_Fleet.Updating
        Dim UserID As String
        Dim MemUser As MembershipUser
        MemUser = Membership.GetUser()
        UserID = MemUser.ProviderUserKey.ToString()

        If MemUser Is Nothing Then
            e.Cancel = True
        Else
            e.Command.Parameters("@IDModifiedUser").Value = UserID.ToString()
            e.Command.Parameters("@ModifiedDate").Value = DateTime.Now
        End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim IDTerminal = Request.QueryString("IDProfileTerminal")
        Dim IDAccount = Request.QueryString("IDProfileAccount")
        Dim IDFleet = Request.QueryString("IDProfileFleet")
        btn_FleetList.PostBackUrl = "fleet.aspx?IDProfileTerminal=" & IDTerminal & "&IDProfileAccount=" & IDAccount & "&IDProfileFleet=" & IDFleet

        Dim UserID As Guid
        Dim MemUser As MembershipUser
        MemUser = Membership.GetUser()
        UserID = MemUser.ProviderUserKey

        Dim cn As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ToString)
        cn.Open()
        Dim SqlCmd As SqlCommand
        SqlCmd = New SqlCommand("SELECT dbo.GetTerminalPermission(@IDProfileTerminal, @UserId)", cn)
        SqlCmd.Parameters.Add("@IDProfileTerminal", SqlDbType.Int).Value = Request.QueryString("IDProfileTerminal")
        SqlCmd.Parameters.Add("@UserId", SqlDbType.UniqueIdentifier).Value = UserID
        terminalPermission = SqlCmd.ExecuteScalar
        cn.Close()
    End Sub
    Protected Function FormatPhone(Optional ByVal phone As String = "") As String
        Return CommonFunctions.FormatPhone(phone)
    End Function
End Class