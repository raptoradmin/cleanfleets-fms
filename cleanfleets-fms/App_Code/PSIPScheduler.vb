'Imports Hangfire

'Public Class PSIPScheduler

'	''' <summary>
'	''' Adds a background job to be executed. 
'	''' </summary>
'	''' <typeparam name="T"></typeparam>
'	''' <remarks></remarks>
'	Public Shared Sub AddBackgroundJob(Of T)()
'		Dim CronSchedule As String = DirectCast(ConfigurationManager.AppSettings("CronSchedule"), String)
'		RecurringJob.AddOrUpdate(Of T)("PSIP Monthly Notifications", Sub(job) CType(job, IHangfireJob).DoJob(), CronSchedule, TimeZoneInfo.Local)
'	End Sub
'End Class