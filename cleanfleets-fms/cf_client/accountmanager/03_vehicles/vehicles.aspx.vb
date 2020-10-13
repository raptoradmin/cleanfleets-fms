Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Public Class vehicles
    Inherits BaseWebForm
    '09/13/2012 IR: Added terminalpermission for to be used to hide update buttons based on permission level
    Protected terminalPermission As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
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
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim IDProfilefleet As String = Request.QueryString("IDProfilefleet")
        Dim IDProfileTerminal As String = Request.QueryString("IDProfileTerminal")
        Dim IDProfileAccount As String = Request.QueryString("IDProfileAccount")
        If IDProfilefleet IsNot Nothing Then
            Response.Redirect("vehiclesadd.aspx?IDProfileFleet=" & IDProfilefleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount)
        End If
    End Sub

End Class