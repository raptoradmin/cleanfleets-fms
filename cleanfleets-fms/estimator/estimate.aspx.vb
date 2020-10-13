Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.CodeDom
Imports System.Web
Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Security
Imports System.Security.Principal.WindowsIdentity


Public Class estimate
    Inherits BaseWebForm

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        Dim IDAccount As String = Request.QueryString("IDAccount")


        Dim cn As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ToString)
        cn.Open()
        Dim SqlCmd As SqlCommand
        SqlCmd = New SqlCommand("SELECT [AccountName] FROM [CF_QE_Account] WHERE IDAccount = " & IDAccount & "", cn)

        lbl_AccountName.Text = CType(SqlCmd.ExecuteScalar, String)


        cn.Close()

    End Sub

End Class