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

Imports System.Data
Imports System.Data.SqlClient
Imports Radactive.WebControls.ILoad
Imports Radactive.WebControls.ILoad.Configuration

' This ICustomStorageManager implementation allows to save image files
' into a MS SqlServer database.
' To configure I-Load to use your Custom Storage Manager edit the Web.Config file:
' radactive.iload / settings / customStorageManager / type.
Public Class CustomStorageManager
    Implements Radactive.WebControls.ILoad.Core.ICustomStorageManager

    Private Function GetNewOpenDbConnection() As SqlConnection
        ' Insert here your own database connection initializer...
        Return Director.GetNewOpenDbConnection()
    End Function

#Region "ICustomStorageManager Members"

    Public Function IndexXmlExists(ByVal configurationInternalCode As String, ByVal imageId As String, ByVal customStorageManagerExtraData As Object) As Boolean Implements Core.ICustomStorageManager.IndexXmlExists
        If (TypeOf customStorageManagerExtraData Is SqlTransaction) Then
            Dim transaction As SqlTransaction = DirectCast(customStorageManagerExtraData, SqlTransaction)
            Return Me.IndexXmlExists(transaction.Connection, transaction, configurationInternalCode, imageId)
        Else
            If (TypeOf customStorageManagerExtraData Is SqlConnection) Then
                Dim connection As SqlConnection = DirectCast(customStorageManagerExtraData, SqlConnection)
                Return Me.IndexXmlExists(connection, Nothing, configurationInternalCode, imageId)
            Else
                Using connection As SqlConnection = Me.GetNewOpenDbConnection()
                    Return Me.IndexXmlExists(connection, Nothing, configurationInternalCode, imageId)
                End Using
            End If
        End If
    End Function

    Public Function ImageExists(ByVal configurationInternalCode As String, ByVal imageId As String, ByVal resizeInternalCode As String, ByVal fileExtension As String, ByVal customStorageManagerExtraData As Object) As Boolean Implements Core.ICustomStorageManager.ImageExists
        If (TypeOf customStorageManagerExtraData Is SqlTransaction) Then
            Dim transaction As SqlTransaction = DirectCast(customStorageManagerExtraData, SqlTransaction)
            Return Me.ImageExists(transaction.Connection, transaction, configurationInternalCode, imageId, resizeInternalCode, fileExtension)
        Else
            If (TypeOf customStorageManagerExtraData Is SqlConnection) Then
                Dim connection As SqlConnection = DirectCast(customStorageManagerExtraData, SqlConnection)
                Return Me.ImageExists(connection, Nothing, configurationInternalCode, imageId, resizeInternalCode, fileExtension)
            Else
                Using connection As SqlConnection = Me.GetNewOpenDbConnection()
                    Return Me.ImageExists(connection, Nothing, configurationInternalCode, imageId, resizeInternalCode, fileExtension)
                End Using
            End If
        End If
    End Function

    Public Function LoadIndexXml(ByVal configurationInternalCode As String, ByVal imageId As String, ByVal customStorageManagerExtraData As Object) As String Implements Core.ICustomStorageManager.LoadIndexXml
        If (TypeOf customStorageManagerExtraData Is SqlTransaction) Then
            Dim transaction As SqlTransaction = DirectCast(customStorageManagerExtraData, SqlTransaction)
            Return Me.LoadIndexXml(transaction.Connection, transaction, configurationInternalCode, imageId)
        Else
            If (TypeOf customStorageManagerExtraData Is SqlConnection) Then
                Dim connection As SqlConnection = DirectCast(customStorageManagerExtraData, SqlConnection)
                Return Me.LoadIndexXml(connection, Nothing, configurationInternalCode, imageId)
            Else
                Using connection As SqlConnection = Me.GetNewOpenDbConnection()
                    Return Me.LoadIndexXml(connection, Nothing, configurationInternalCode, imageId)
                End Using
            End If
        End If
    End Function

    Public Function LoadImage(ByVal configurationInternalCode As String, ByVal imageId As String, ByVal resizeInternalCode As String, ByVal fileExtension As String, ByVal customStorageManagerExtraData As Object) As Byte() Implements Core.ICustomStorageManager.LoadImage
        If (TypeOf customStorageManagerExtraData Is SqlTransaction) Then
            Dim transaction As SqlTransaction = DirectCast(customStorageManagerExtraData, SqlTransaction)
            Return Me.LoadImage(transaction.Connection, transaction, configurationInternalCode, imageId, resizeInternalCode, fileExtension)
        Else
            If (TypeOf customStorageManagerExtraData Is SqlConnection) Then
                Dim connection As SqlConnection = DirectCast(customStorageManagerExtraData, SqlConnection)
                Return Me.LoadImage(connection, Nothing, configurationInternalCode, imageId, resizeInternalCode, fileExtension)
            Else
                Using connection As SqlConnection = Me.GetNewOpenDbConnection()
                    Return Me.LoadImage(connection, Nothing, configurationInternalCode, imageId, resizeInternalCode, fileExtension)
                End Using
            End If
        End If
    End Function

    Public Sub SaveIndexXml(ByVal configurationInternalCode As String, ByVal imageId As String, ByVal indexXml As String, ByVal customStorageManagerExtraData As Object) Implements Core.ICustomStorageManager.SaveIndexXml
        If (TypeOf customStorageManagerExtraData Is SqlTransaction) Then
            Dim transaction As SqlTransaction = DirectCast(customStorageManagerExtraData, SqlTransaction)
            Me.SaveIndexXml(transaction.Connection, transaction, configurationInternalCode, imageId, indexXml)
        Else
            If (TypeOf customStorageManagerExtraData Is SqlConnection) Then
                Dim connection As SqlConnection = DirectCast(customStorageManagerExtraData, SqlConnection)
                Me.SaveIndexXml(connection, Nothing, configurationInternalCode, imageId, indexXml)
            Else
                Using connection As SqlConnection = Me.GetNewOpenDbConnection()
                    Me.SaveIndexXml(connection, Nothing, configurationInternalCode, imageId, indexXml)
                End Using
            End If
        End If
    End Sub

    Public Sub SaveImage(ByVal configurationInternalCode As String, ByVal imageId As String, ByVal resizeInternalCode As String, ByVal fileExtension As String, ByVal image() As Byte, ByVal imageSize As System.Drawing.Size, ByVal customStorageManagerExtraData As Object) Implements Core.ICustomStorageManager.SaveImage
        If (TypeOf customStorageManagerExtraData Is SqlTransaction) Then
            Dim transaction As SqlTransaction = DirectCast(customStorageManagerExtraData, SqlTransaction)
            Me.SaveImage(transaction.Connection, transaction, configurationInternalCode, imageId, resizeInternalCode, fileExtension, image, imageSize)
        Else
            If (TypeOf customStorageManagerExtraData Is SqlConnection) Then
                Dim connection As SqlConnection = DirectCast(customStorageManagerExtraData, SqlConnection)
                Me.SaveImage(connection, Nothing, configurationInternalCode, imageId, resizeInternalCode, fileExtension, image, imageSize)
            Else
                Using connection As SqlConnection = Me.GetNewOpenDbConnection()
                    Me.SaveImage(connection, Nothing, configurationInternalCode, imageId, resizeInternalCode, fileExtension, image, imageSize)
                End Using
            End If
        End If
    End Sub

    Public Sub DeleteIndexXml(ByVal configurationInternalCode As String, ByVal imageId As String, ByVal customStorageManagerExtraData As Object) Implements Core.ICustomStorageManager.DeleteIndexXml
        If (TypeOf customStorageManagerExtraData Is SqlTransaction) Then
            Dim transaction As SqlTransaction = DirectCast(customStorageManagerExtraData, SqlTransaction)
            Me.DeleteIndexXml(transaction.Connection, transaction, configurationInternalCode, imageId)
        Else
            If (TypeOf customStorageManagerExtraData Is SqlConnection) Then
                Dim connection As SqlConnection = DirectCast(customStorageManagerExtraData, SqlConnection)
                Me.DeleteIndexXml(connection, Nothing, configurationInternalCode, imageId)
            Else
                Using connection As SqlConnection = Me.GetNewOpenDbConnection()
                    Me.DeleteIndexXml(connection, Nothing, configurationInternalCode, imageId)
                End Using
            End If
        End If
    End Sub

    Public Sub DeleteImage(ByVal configurationInternalCode As String, ByVal imageId As String, ByVal resizeInternalCode As String, ByVal fileExtension As String, ByVal customStorageManagerExtraData As Object) Implements Core.ICustomStorageManager.DeleteImage
        If (TypeOf customStorageManagerExtraData Is SqlTransaction) Then
            Dim transaction As SqlTransaction = DirectCast(customStorageManagerExtraData, SqlTransaction)
            Me.DeleteImage(transaction.Connection, transaction, configurationInternalCode, imageId, resizeInternalCode, fileExtension)
        Else
            If (TypeOf customStorageManagerExtraData Is SqlConnection) Then
                Dim connection As SqlConnection = DirectCast(customStorageManagerExtraData, SqlConnection)
                Me.DeleteImage(connection, Nothing, configurationInternalCode, imageId, resizeInternalCode, fileExtension)
            Else
                Using connection As SqlConnection = Me.GetNewOpenDbConnection()
                    Me.DeleteImage(connection, Nothing, configurationInternalCode, imageId, resizeInternalCode, fileExtension)
                End Using
            End If
        End If
    End Sub

#End Region

#Region "Logic"

    Private Function IndexXmlExists(ByVal connection As SqlConnection, ByVal transaction As SqlTransaction, ByVal configurationInternalCode As String, ByVal imageId As String) As Boolean
        Using command As SqlCommand = connection.CreateCommand()
            If (Not (transaction Is Nothing)) Then
                command.Transaction = transaction
            End If
            command.CommandType = CommandType.Text
            command.CommandText = "SELECT [ImageId] FROM [Radactive_ILoad_Indexes] WHERE ([ConfigurationInternalCode]=@ConfigurationInternalCode) AND ([ImageId]=@ImageId)"
            command.Parameters.AddWithValue("@ConfigurationInternalCode", configurationInternalCode)
            command.Parameters.AddWithValue("@ImageId", imageId)
            Using reader As SqlDataReader = command.ExecuteReader()
                Return reader.Read()
            End Using
        End Using
    End Function

    Private Function ImageExists(ByVal connection As SqlConnection, ByVal transaction As SqlTransaction, ByVal configurationInternalCode As String, ByVal imageId As String, ByVal resizeInternalCode As String, ByVal fileExtension As String) As Boolean
        Using command As SqlCommand = connection.CreateCommand()
            If (Not (transaction Is Nothing)) Then
                command.Transaction = transaction
            End If
            command.CommandType = CommandType.Text
            command.CommandText = "SELECT [ImageId] FROM [Radactive_ILoad_Images] WHERE ([ConfigurationInternalCode]=@ConfigurationInternalCode) AND ([ImageId]=@ImageId) AND ([ResizeInternalCode]=@ResizeInternalCode)"
            command.Parameters.AddWithValue("@ConfigurationInternalCode", configurationInternalCode)
            command.Parameters.AddWithValue("@ImageId", imageId)
            command.Parameters.AddWithValue("@ResizeInternalCode", resizeInternalCode)
            Using reader As SqlDataReader = command.ExecuteReader()
                Return reader.Read()
            End Using
        End Using
    End Function

    Private Function LoadIndexXml(ByVal connection As SqlConnection, ByVal transaction As SqlTransaction, ByVal configurationInternalCode As String, ByVal imageId As String) As String
        Using command As SqlCommand = connection.CreateCommand()
            If (Not (transaction Is Nothing)) Then
                command.Transaction = transaction
            End If
            command.CommandType = CommandType.Text
            command.CommandText = "SELECT [IndexXml] FROM [Radactive_ILoad_Indexes] WHERE ([ConfigurationInternalCode]=@ConfigurationInternalCode) AND ([ImageId]=@ImageId)"
            command.Parameters.AddWithValue("@ConfigurationInternalCode", configurationInternalCode)
            command.Parameters.AddWithValue("@ImageId", imageId)
            Using reader As SqlDataReader = command.ExecuteReader()
                If (reader.Read()) Then
                    Return DirectCast(reader("IndexXml"), String)
                Else
                    Return Nothing
                End If
            End Using
        End Using
    End Function

    Private Function LoadImage(ByVal connection As SqlConnection, ByVal transaction As SqlTransaction, ByVal configurationInternalCode As String, ByVal imageId As String, ByVal resizeInternalCode As String, ByVal fileExtension As String) As Byte()
        Using command As SqlCommand = connection.CreateCommand()
            If (Not (transaction Is Nothing)) Then
                command.Transaction = transaction
            End If
            command.CommandType = CommandType.Text
            command.CommandText = "SELECT [ImageBytes] FROM [Radactive_ILoad_Images] WHERE ([ConfigurationInternalCode]=@ConfigurationInternalCode) AND ([ImageId]=@ImageId) AND ([ResizeInternalCode]=@ResizeInternalCode)"
            command.Parameters.AddWithValue("@ConfigurationInternalCode", configurationInternalCode)
            command.Parameters.AddWithValue("@ImageId", imageId)
            command.Parameters.AddWithValue("@ResizeInternalCode", resizeInternalCode)
            Using reader As SqlDataReader = command.ExecuteReader()
                If (reader.Read()) Then
                    Return DirectCast(reader("ImageBytes"), Byte())
                Else
                    Return Nothing
                End If
            End Using
        End Using
    End Function

    Private Sub SaveIndexXml(ByVal connection As SqlConnection, ByVal transaction As SqlTransaction, ByVal configurationInternalCode As String, ByVal imageId As String, ByVal indexXml As String)
        If (Not (transaction Is Nothing)) Then
            If (Me.IndexXmlExists(connection, transaction, configurationInternalCode, imageId)) Then
                Me.DeleteIndexXml(connection, transaction, configurationInternalCode, imageId)
            End If
            Using command As SqlCommand = connection.CreateCommand()
                command.Transaction = transaction
                command.CommandType = CommandType.Text
                command.CommandText = "INSERT INTO [Radactive_ILoad_Indexes] ([ConfigurationInternalCode], [ImageId], [IndexXml]) VALUES (@ConfigurationInternalCode, @ImageId, @IndexXml)"
                command.Parameters.AddWithValue("@ConfigurationInternalCode", configurationInternalCode)
                command.Parameters.AddWithValue("@ImageId", imageId)
                command.Parameters.AddWithValue("@IndexXml", indexXml)
                command.ExecuteNonQuery()
            End Using
        Else
            Dim tempTransaction As SqlTransaction = connection.BeginTransaction()
            Try
                Me.SaveIndexXml(connection, tempTransaction, configurationInternalCode, imageId, indexXml)
                tempTransaction.Commit()
            Catch ex As Exception
                tempTransaction.Rollback()
                Throw ex
            Finally
                tempTransaction.Dispose()
            End Try
        End If
    End Sub

    Private Sub SaveImage(ByVal connection As SqlConnection, ByVal transaction As SqlTransaction, ByVal configurationInternalCode As String, ByVal imageId As String, ByVal resizeInternalCode As String, ByVal fileExtension As String, ByVal image() As Byte, ByVal imageSize As System.Drawing.Size)
        If (Not (transaction Is Nothing)) Then
            If (Me.ImageExists(connection, transaction, configurationInternalCode, imageId, resizeInternalCode, fileExtension)) Then
                Me.DeleteImage(connection, transaction, configurationInternalCode, imageId, resizeInternalCode, fileExtension)
            End If
            Using command As SqlCommand = connection.CreateCommand()
                command.Transaction = transaction
                command.CommandType = CommandType.Text
                command.CommandText = "INSERT INTO [Radactive_ILoad_Images] ([ConfigurationInternalCode], [ImageId], [ResizeInternalCode], [ImageBytes]) VALUES (@ConfigurationInternalCode, @ImageId, @ResizeInternalCode, @ImageBytes)"
                command.Parameters.AddWithValue("@ConfigurationInternalCode", configurationInternalCode)
                command.Parameters.AddWithValue("@ImageId", imageId)
                command.Parameters.AddWithValue("@ResizeInternalCode", resizeInternalCode)
                command.Parameters.AddWithValue("@ImageBytes", image)
                command.ExecuteNonQuery()
            End Using
        Else
            Dim tempTransaction As SqlTransaction = connection.BeginTransaction()
            Try
                Me.SaveImage(connection, tempTransaction, configurationInternalCode, imageId, resizeInternalCode, fileExtension, image, imageSize)
                tempTransaction.Commit()
            Catch ex As Exception
                tempTransaction.Rollback()
                Throw ex
            Finally
                tempTransaction.Dispose()
            End Try
        End If
    End Sub

    Private Sub DeleteIndexXml(ByVal connection As SqlConnection, ByVal transaction As SqlTransaction, ByVal configurationInternalCode As String, ByVal imageId As String)
        Using command As SqlCommand = connection.CreateCommand()
            If (Not (transaction Is Nothing)) Then
                command.Transaction = transaction
            End If
            command.CommandType = CommandType.Text
            command.CommandText = "DELETE FROM [Radactive_ILoad_Indexes] WHERE ([ConfigurationInternalCode]=@ConfigurationInternalCode) AND ([ImageId]=@ImageId)"
            command.Parameters.AddWithValue("@ConfigurationInternalCode", configurationInternalCode)
            command.Parameters.AddWithValue("@ImageId", imageId)
            command.ExecuteNonQuery()
        End Using
    End Sub

    Private Sub DeleteImage(ByVal connection As SqlConnection, ByVal transaction As SqlTransaction, ByVal configurationInternalCode As String, ByVal imageId As String, ByVal resizeInternalCode As String, ByVal fileExtension As String)
        Using command As SqlCommand = connection.CreateCommand()
            If (Not (transaction Is Nothing)) Then
                command.Transaction = transaction
            End If
            command.CommandType = CommandType.Text
            command.CommandText = "DELETE FROM [Radactive_ILoad_Images] WHERE ([ConfigurationInternalCode]=@ConfigurationInternalCode) AND ([ImageId]=@ImageId) AND ([ResizeInternalCode]=@ResizeInternalCode)"
            command.Parameters.AddWithValue("@ConfigurationInternalCode", configurationInternalCode)
            command.Parameters.AddWithValue("@ImageId", imageId)
            command.Parameters.AddWithValue("@ResizeInternalCode", resizeInternalCode)
            command.ExecuteNonQuery()
        End Using
    End Sub

#End Region

End Class
