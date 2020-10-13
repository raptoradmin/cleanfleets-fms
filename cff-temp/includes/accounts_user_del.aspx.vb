Imports System.Data.SqlClient
Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Public Class accounts_user_del
    Inherits BaseWebForm

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Protected Sub sds_Contact_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sds_Contact.Deleted
        Dim IDProfileAccount As String = CType(FormView1.FindControl("hf_IDProfileAccount"), HiddenField).Value
        Response.Redirect("account_user_list.aspx?&IDProfileAccount=" & IDProfileAccount)

    End Sub

    Protected Sub DeleteButton_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim User As Label = CType(FormView1.FindControl("lbl_UserName"), Label)
        If User IsNot Nothing Then
            Dim AcctID As String = User.Text
            Membership.DeleteUser(User.Text)
        End If

    End Sub
End Class