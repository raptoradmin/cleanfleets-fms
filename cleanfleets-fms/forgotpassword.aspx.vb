Public Class forgotpassword
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Public Sub ReturnToLogin(sender As Object, e As EventArgs)
        Response.Redirect("default.aspx")
    End Sub
End Class