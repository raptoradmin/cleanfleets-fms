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
Public Class account_user_list
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim queryString As String = "SELECT IDProfileAccount, AccountName FROM CF_Profile_Account WHERE IDProfileAccount =  " + Request.QueryString("IDProfileAccount")

        Using myConnection As New SqlConnection(connectionString)
            Dim myCommand As New SqlCommand(queryString, myConnection)
            myConnection.Open()
            Dim MyReader As SqlDataReader = myCommand.ExecuteReader
            MyReader.Read()
            lbl_Account_Name.Text = MyReader("AccountName")
            hdf_IDProfileAccount.Value = MyReader("IDProfileAccount")
            myConnection.Close()
        End Using
    End Sub



    Protected Sub btn_Add_User_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Add_User.Click
        Dim IDProfileAccount As String = hdf_IDProfileAccount.Value
        Response.Redirect("account_user_add.aspx?IDProfileAccount=" & IDProfileAccount)
    End Sub


End Class
