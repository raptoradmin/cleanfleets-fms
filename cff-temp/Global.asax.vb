Imports System.Web.SessionState

Public Class Global_asax
    Inherits System.Web.HttpApplication

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        'Hangfire.JobStorage.Current = New Hangfire.SqlServer.SqlServerStorage("CF_SQL_Connection")
        'PSIPScheduler.AddBackgroundJob(Of PSIPAutomatedNotification)()
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the session is started
    End Sub

    Sub Application_BeginRequest(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires at the beginning of each request

    End Sub

    Sub Application_AuthenticateRequest(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires upon attempting to authenticate the use
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when an error occurs
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the session ends
    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the application ends
    End Sub

    Sub Application_PreSendRequestHeaders(ByVal sender As Object, ByVal e As EventArgs)

        Dim s As String = Response.RedirectLocation

        ' replace /login.aspx with your path
        If (s IsNot Nothing AndAlso s.Contains("default.aspx?ReturnUrl=")) Then

            Response.RedirectLocation = "/default.aspx"
        End If
    End Sub
End Class