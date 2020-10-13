'Imports Microsoft.VisualBasic
'Imports System.Threading
'Imports System.Web
'Imports System.Text
'Imports System
'Imports System.Security.Principal
'Imports System.Web.Security

'Namespace Inspironix.Modules

'    Public Class BasicAuthHttpModule
'        Implements IHttpModule

'        Private Const Realm As String = "CleanFleetsCsvExporter"

'        Public Sub Init(ByVal context As HttpApplication)
'            context.OnAuthenticateRequest() += AddressOf OnApplicationAuthenticateRequest
'            context.OnEndRequest += AddressOf OnApplicationEndRequest
'        End Sub

'        Private Shared Sub SetPrincipal(ByVal principal As IPrincipal)
'            Thread.CurrentPrincipal = principal
'            If HttpContext.Current IsNot Nothing Then
'                HttpContext.Current.User = principal
'            End If
'        End Sub

'        Private Shared Function CheckPassword(ByVal username As String, ByVal password As String) As Boolean
'            Return Membership.ValidateUser(username, password)
'        End Function

'        Private Shared Function AuthenticateUser(ByVal credentials As String()) As Boolean
'            Dim validated As Boolean = False
'            Try
'                Dim name As String = credentials(0)
'                Dim password As String = credentials(1)
'                validated = CheckPassword(name, password)
'                If validated Then
'                    Dim identity = New GenericIdentity(name)
'                    SetPrincipal(New GenericPrincipal(identity, Nothing))
'                End If
'            Catch __unusedFormatException1__ As FormatException
'                validated = False
'            End Try

'            Return validated
'        End Function

'        Private Shared Sub OnApplicationAuthenticateRequest(ByVal sender As Object, ByVal e As EventArgs)
'            Dim request = HttpContext.Current.Request
'            Dim authHeader = request.Headers("Authorization")
'            If authHeader IsNot Nothing Then
'                Dim authHeaderVal = parseAuthHeader(authHeader)
'                If authHeaderVal IsNot Nothing Then
'                    AuthenticateUser(authHeaderVal)
'                End If
'            End If
'        End Sub

'        Private Shared Sub OnApplicationEndRequest(ByVal sender As Object, ByVal e As EventArgs)
'            Dim response = HttpContext.Current.Response
'            If response.StatusCode = 401 Then
'                response.Headers.Add("WWW-Authenticate", String.Format("Basic realm=""{0}""", Realm))
'            End If
'        End Sub

'        Public Sub Dispose()
'        End Sub

'        Private Shared Function parseAuthHeader(ByVal authHeader As String) As String()
'            If authHeader Is Nothing OrElse authHeader.Length = 0 OrElse Not authHeader.StartsWith("Basic") Then Return Nothing
'            Dim base64Credentials As String = authHeader.Substring(6)
'            Dim credentials As String() = Encoding.ASCII.GetString(Convert.FromBase64String(base64Credentials)).Split(New Char() {":"c})
'            If credentials.Length <> 2 OrElse String.IsNullOrEmpty(credentials(0)) OrElse String.IsNullOrEmpty(credentials(0)) Then Return Nothing
'            Return credentials
'        End Function

'        Private Sub IHttpModule_Init(context As HttpApplication) Implements IHttpModule.Init

'        End Sub

'        Private Sub IHttpModule_Dispose() Implements IHttpModule.Dispose

'        End Sub
'    End Class
'End Namespace
