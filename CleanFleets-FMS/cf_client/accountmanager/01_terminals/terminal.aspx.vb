Public Class terminal
    Inherits BaseWebForm

    '09/13/2012 IR: Added page load method to set UserId for the sql datasource
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        sds_Profile_Terminal.SelectParameters("UserId").DefaultValue = Membership.GetUser().ProviderUserKey.ToString()

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