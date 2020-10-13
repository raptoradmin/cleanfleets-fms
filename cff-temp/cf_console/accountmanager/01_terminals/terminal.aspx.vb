Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Public Class terminal1
    Inherits BaseWebForm


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Add_Terminal.Click

        Dim AccountName As Label = CType(FormView1.FindControl("lbl_AccountName"), Label)
        Dim AccountID As Label = CType(FormView1.FindControl("lbl_IDProfileAccount"), Label)
        If AccountName IsNot Nothing Then
            Dim AcctName As String = AccountName.Text
            Dim AcctID As String = AccountID.Text
            Response.Redirect("terminaladd.aspx?AccountName=" & AcctName & "&IDProfileAccount=" & AcctID)
        End If
    End Sub

End Class