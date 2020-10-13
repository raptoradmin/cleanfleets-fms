Public Class _default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If HttpContext.Current.User.Identity.IsAuthenticated Then
            FormsAuthentication.RedirectFromLoginPage(Membership.GetUser().UserName, CType(login1.FindControl("RememberMe"), CheckBox).Checked) 'Remember Me checkbox)	
        End If
    End Sub

    Protected Sub LoginRole(ByVal sender As Object, ByVal e As System.EventArgs) Handles Login1.LoggedIn
        FormsAuthentication.RedirectFromLoginPage(Login1.UserName, CType(login1.FindControl("RememberMe"), CheckBox).Checked) 'Remember Me checkbox)
        ' MG 12/5/2011 - the logic below has been moved to the new DefaultPage redirect.aspx[.vb].  
        'If Roles.IsUserInRole(Login1.UserName, "Administrator") = True Then
        '    Response.Redirect("cf_console/")
        'ElseIf Roles.IsUserInRole(Login1.UserName, "Employee") = True Then
        '    Response.Redirect("cf_console/")
        'ElseIf Roles.IsUserInRole(Login1.UserName, "Client") = True Then
        '    Response.Redirect("cf_client/")
        'End If
    End Sub


    Protected Sub ForgotPWButton_click(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Redirect("forgotpassword.aspx")
    End Sub

End Class