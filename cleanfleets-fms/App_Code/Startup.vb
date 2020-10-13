'Imports Hangfire
'Imports hangfire.Dashboard
'Imports Hangfire.SqlServer
'Imports Microsoft.Owin
'Imports Owin

'<Assembly: OwinStartup(GetType(Startup))>

Public Class Startup
	Private Shared connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)

    '    Public Shared Sub Configuration(app As IAppBuilder)
    '        GlobalConfiguration.Configuration.UseSqlServerStorage(connectionString)
    '        Dim dashboardOptions As New DashboardOptions() With {
    '              .AppPath = VirtualPathUtility.ToAbsolute("~")
    '              }

    '        app.UseHangfireDashboard("/hangfire", dashboardOptions)

    '        app.UseHangfireServer()
    '    End Sub
End Class