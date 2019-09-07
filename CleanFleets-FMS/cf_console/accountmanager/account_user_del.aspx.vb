Imports System.Data.SqlClient
Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Public Class account_user_del
    Inherits BaseWebForm

    Protected Sub sds_Contact_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sds_Contact.Deleted

        Response.Redirect("account_user_list_all.aspx")

    End Sub

    Protected Sub DeleteButton_Click(ByVal sender As Object, ByVal e As System.EventArgs)


        Dim User As Label = CType(FormView1.FindControl("lbl_UserName"), Label)
        Dim UserName As String = User.Text
        Dim IDProfileContact As String = CType(FormView1.FindControl("lbl_IDProfileContact"), Label).Text

        Dim sql As String
        Dim strConnString As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
        sql = "DELETE FROM CF_Profile_Contact WHERE (IDProfileContact = @IDProfileContact)"
        Dim connection As New SqlConnection(strConnString)
        Dim command As New SqlCommand(sql, connection)

        command.Parameters.Add("@IDProfileContact", SqlDbType.Int).Value = IDProfileContact

        command.Connection.Open()
        command.ExecuteNonQuery()
        command.Connection.Close()




        If User IsNot Nothing Then
            Dim AcctID As String = UserName
            Membership.DeleteUser(UserName)
        End If

    End Sub

End Class

