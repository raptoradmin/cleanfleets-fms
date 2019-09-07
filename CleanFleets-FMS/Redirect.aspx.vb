Public Class Redirect
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim currentUser As MembershipUser = Membership.GetUser()
        If Roles.IsUserInRole(currentUser.UserName, "Administrator") = True Then
            Response.Redirect("cf_console/")
        ElseIf Roles.IsUserInRole(currentUser.UserName, "Employee") = True Then
            Response.Redirect("cf_console/")
        ElseIf Roles.IsUserInRole(currentUser.UserName, "Client") = True Then
            Response.Redirect("cf_client/")
        End If
    End Sub

End Class