Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports Telerik.Web.UI

Public Class managesignatures
    Inherits BaseWebForm

    Dim hasErrors As Boolean = False
    Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
    Const SAVEPATH As String = "~/signatures/"

    Private Sub managesignatures_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender

        Dim myDataTable As DataTable = GetSignatures()
        rg_Signatures.DataSource = myDataTable
        rg_Signatures.DataBind()
    End Sub

    Protected Function GetSignatures() As DataTable
        Dim conn As New SqlConnection(connectionString)
        conn.Open()
        Dim adapter As New SqlDataAdapter("SELECT IDSignature, FirstName, LastName, FilePath FROM [CF_Signatures] ORDER BY FirstName, LastName", conn)
        Try
            Dim dt As New DataTable()
            adapter.Fill(dt)
            Return dt
        Catch sqlExc As SqlException
            hasErrors = True
            Messages.Text = sqlExc.Message.ToString()
            Return New DataTable()
        Finally
            conn.Close()
        End Try
    End Function

    Protected Sub btnImport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnImport.Click
        Dim FilePath As String = ""
        Dim FirstName As String = txb_FirstName.Text
        Dim LastName As String = txb_LastName.Text
        If FirstName.Length = 0 AndAlso LastName.Length = 0 Then
            hasErrors = True
            Messages.Text = "Please supply a first or last name."
            Return
        End If
        FirstName = StrConv(FirstName, VbStrConv.ProperCase)
        LastName = StrConv(LastName, VbStrConv.ProperCase)
        If Page.IsValid Then
            If Not Directory.Exists(Server.MapPath(SAVEPATH)) Then
                Directory.CreateDirectory(Server.MapPath(SAVEPATH))
            End If
            Dim FileName As String = FirstName & LastName & Path.GetExtension(fu_ImportFile.FileName)
            FilePath = Path.Combine(Server.MapPath(SAVEPATH), FileName)
            fu_ImportFile.SaveAs(FilePath)

            InsertSignature(Path.Combine(SAVEPATH, FileName), FirstName, LastName)


            If Not hasErrors Then
                Messages.Text = "Signature uploaded successfully.<br>"
                txb_FirstName.Text = ""
                txb_LastName.Text = ""
            End If
        End If
    End Sub

    Public Sub InsertSignature(ByVal FilePath As String, ByVal FirstName As String, ByVal LastName As String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As SqlCommand
        Dim IDModifiedUser As Guid = Membership.GetUser().ProviderUserKey

        ' Removed since proposal didn't specify updating records, only inserting
        Dim objReader As SqlDataReader

        comm = New SqlCommand("SELECT IDSignature FROM CF_Signatures WHERE FirstName = @FirstName AND LastName = @LastName", conn)
        comm.Parameters.AddWithValue("@FirstName", FirstName)
        comm.Parameters.AddWithValue("@LastName", LastName)
        comm.Connection.Open()
        objReader = comm.ExecuteReader()

        If objReader.Read() Then ' existing signature; update
            Dim IDSignature As New Guid(objReader("IDSignature").ToString())
            objReader.Close()
            comm = New SqlCommand("UPDATE CF_Signatures SET IDModifiedUser = @IDModifiedUser, ModifiedDate = GETDATE(), FilePath = @FilePath, FirstName = @FirstName, LastName = @LastName WHERE IDSignature = @IDSignature", conn)
            comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
            comm.Parameters.AddWithValue("@IDSignature", IDSignature)
            comm.Parameters.AddWithValue("@FilePath", FilePath)
            comm.Parameters.AddWithValue("@FirstName", FirstName)
            comm.Parameters.AddWithValue("@LastName", LastName)
            Try
                comm.ExecuteNonQuery()
            Catch sqlExc As SqlException
                hasErrors = True
                Messages.Text = sqlExc.Message.ToString()
                Return
            Finally
                conn.Close()
                comm.Connection.Close()
            End Try
        Else ' no signature; insert
            objReader.Close()
            comm = New SqlCommand("INSERT INTO CF_Signatures (IDSignature, IDModifiedUser, EnterDate, ModifiedDate, FilePath, FirstName, LastName) " &
                  "VALUES (NEWID(), @IDModifiedUser, GETDATE(), GETDATE(), @FilePath, @FirstName, @LastName)", conn)
            comm.Parameters.AddWithValue("@IDModifiedUser", IDModifiedUser)
            comm.Parameters.AddWithValue("@FilePath", FilePath)
            comm.Parameters.AddWithValue("@FirstName", FirstName)
            comm.Parameters.AddWithValue("@LastName", LastName)

            Try
                comm.ExecuteNonQuery()
            Catch sqlExc As SqlException
                hasErrors = True
                Messages.Text = sqlExc.Message.ToString()
                Return
            Finally
                conn.Close()
                comm.Connection.Close()
            End Try
        End If
        hasErrors = False
    End Sub

    Protected Sub rg_Signatures_ItemCommand(ByVal sender As Object, ByVal e As GridCommandEventArgs) Handles rg_Signatures.ItemCommand
        Dim IDSignature As New Guid(e.CommandArgument.ToString())
        Select Case e.CommandName
            Case "DeleteSignature"
                Dim conn As New SqlConnection(connectionString)
                Dim comm As New SqlCommand("SELECT * FROM CF_Signatures WHERE IDSignature = @IDSignature", conn)
                comm.Parameters.AddWithValue("@IDSignature", IDSignature)
                Dim objReader As SqlDataReader
                Try
                    comm.Connection.Open()
                    objReader = comm.ExecuteReader()
                    If objReader.Read() Then ' existing signature; update
                        Dim FilePath As String = Path.Combine(Server.MapPath(SAVEPATH), objReader("FilePath").ToString())
                        If File.Exists(FilePath) Then
                            File.Delete(FilePath)
                        End If
                    Else
                        hasErrors = True
                        Messages.Text = "No signature available to delete for this record"
                        Return
                    End If
                    objReader.Close()
                    comm = New SqlCommand("DELETE FROM CF_Signatures WHERE IDSignature = @IDSignature", conn)
                    comm.Parameters.AddWithValue("@IDSignature", IDSignature)
                    comm.ExecuteNonQuery()
                Catch sqlExc As SqlException
                    hasErrors = True
                    Messages.Text = sqlExc.Message.ToString()
                    Return
                Finally
                    conn.Close()
                    comm.Connection.Close()
                End Try
        End Select
        hasErrors = False
    End Sub
End Class
