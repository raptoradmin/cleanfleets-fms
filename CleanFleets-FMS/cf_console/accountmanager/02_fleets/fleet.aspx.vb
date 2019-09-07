Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Public Class fleet1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Add_Fleet.Click

        Dim TerminalName As Label = CType(FormView1.FindControl("lbl_TerminalName"), Label)
        Dim TerminalID As Label = CType(FormView1.FindControl("lbl_IDProfileTerminal"), Label)
        Dim AccountID As Label = CType(FormView1.FindControl("lbl_IDProfileAccount"), Label)
        If TerminalName IsNot Nothing Then
            Dim TermName As String = TerminalName.Text
            Dim TermID As String = TerminalID.Text
            Dim AcctID As String = AccountID.Text
            Response.Redirect("fleetadd.aspx?TermName=" & TermName & "&IDProfileTerminal=" & TermID & "&IDProfileAccount=" & AcctID)
        End If
    End Sub
End Class