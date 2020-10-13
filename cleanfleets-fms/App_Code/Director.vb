'---------------------------------------------------------
' Copyright © 2008-2010 RADactive srl - All Rights Reserved.
' <www.RADactive.com>
'  
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF 
' ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
' TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
' PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT 
' SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR 
' ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN 
' ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
' OR OTHER DEALINGS IN THE SOFTWARE.
'---------------------------------------------------------

Imports System.Web.SessionState
Imports System.Data.SqlClient

Public Class Director

    ' Create a new open connection to the database
    Public Shared Function GetNewOpenDbConnection() As SqlConnection
        Dim connection As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
        connection.Open()
        Return connection
    End Function

#Region "I-Load Internal codes"

    Public Const Ex_E_101_ILoad1_InternalCode As String = "Ex_E_101_ILoad1"

    Public Const Ex_E_102_ILoad1_InternalCode As String = "Ex_E_102_ILoad1"

    Public Const Ex_E_103_ILoad1_InternalCode As String = "Ex_E_103_ILoad1"

    Public Const Ex_E_201_ILoad1_InternalCode As String = "Ex_E_201_ILoad1"

    Public Const Ex_E_202_ILoad1_InternalCode As String = "Ex_E_202_ILoad1"

    Public Const Ex_E_203_ILoad1_InternalCode As String = "Ex_E_203_ILoad1"

    Public Const Ex_E_204_ILoad1_InternalCode As String = "Ex_E_204_ILoad1"

#End Region

#Region "I-Load Reposity Folders"

    Public Shared ReadOnly Property ImageRepositoryFolder() As String
        Get
            Return System.Configuration.ConfigurationManager.AppSettings("ImageRepositoryFolder")
        End Get
    End Property

    Public Shared ReadOnly Property Ex_E_102_ILoad1_RepositoryFolder() As String
        Get
            Return System.Configuration.ConfigurationManager.AppSettings("Ex_E_102_ILoad1_RepositoryFolder")
        End Get
    End Property

    Public Shared ReadOnly Property Ex_E_103_ILoad1_RepositoryFolder() As String
        Get
            Return System.Configuration.ConfigurationManager.AppSettings("Ex_E_103_ILoad1_RepositoryFolder")
        End Get
    End Property

#End Region

End Class
