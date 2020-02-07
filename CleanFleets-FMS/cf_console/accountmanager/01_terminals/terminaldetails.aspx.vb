Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.IO
Imports System.Collections.Generic
Imports System.Web.Configuration
Imports CFUtilities

Public Class terminaldetails1
    Inherits BaseWebForm

    Private lastFileUploadInfo As New Dictionary(Of String, String)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim IDAccount = Request.QueryString("IDProfileAccount")
        btn_TerminalList.PostBackUrl = "terminal.aspx?IDProfileAccount=" & IDAccount
    End Sub

    Protected Function FormatPhone(Optional ByVal phone As String = "") As String
        Return CommonFunctions.FormatPhone(phone)
    End Function

    Protected Sub SqlDataSource1_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sds_cfv_Profile_Terminal.Deleted
        Response.Redirect("terminal.aspx")
    End Sub

    Protected Sub SqlDataSource1_Updating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles sds_cfv_Profile_Terminal.Updating
        Dim UserID As String
        Dim MemUser As MembershipUser
        MemUser = Membership.GetUser()
        UserID = MemUser.ProviderUserKey.ToString()

        If MemUser Is Nothing Then
            e.Cancel = True
        Else
            e.Command.Parameters("@IDModifiedUser").Value = UserID.ToString()
            e.Command.Parameters("@ModifiedDate").Value = DateTime.Now
        End If
    End Sub

    ' if the selected option is no longer in the list, it'll throw problems.  This will set the value to the first item in the select list (should be "Select")
    Protected Sub PreventErrorOnbinding(sender As Object, e As EventArgs)
        Dim theDropDownList As DropDownList = CType(sender, DropDownList)

        RemoveHandler theDropDownList.DataBinding, AddressOf Me.PreventErrorOnbinding
        theDropDownList.AppendDataBoundItems = True
        Try
            theDropDownList.DataBind()
        Catch exc As ArgumentOutOfRangeException
            theDropDownList.SelectedValue = theDropDownList.Items(0).Value
        End Try

        theDropDownList.AppendDataBoundItems = True
        theDropDownList.Items.Clear()
        theDropDownList.Items.Insert(0, New ListItem("--Select--", ""))
        theDropDownList.SelectedValue = theDropDownList.Items(0).Value
    End Sub

    ' change the parameters here
    Protected Sub sds_TerminalDocuments_InsertingUpdating(ByVal sender As Object, ByVal e As SqlDataSourceCommandEventArgs) Handles sds_TerminalDocuments.Inserting,
      sds_TerminalDocuments.Updating

        Dim UserID As String
        Dim MemUser As MembershipUser = Membership.GetUser()
        UserID = MemUser.ProviderUserKey.ToString()

        If MemUser Is Nothing OrElse lastFileUploadInfo.Count = 0 Then
            e.Cancel = True
        Else
            e.Command.Parameters("@IDFile").Value = lastFileUploadInfo("IDFile")
            e.Command.Parameters("@IDModifiedUser").Value = UserID.ToString()
            'e.Command.Parameters("@ModifiedDate").Value = DateTime.Now
            If lastFileUploadInfo.ContainsKey("SkipFileUpload") AndAlso lastFileUploadInfo("SkipFileUpload") = "N" Then
                e.Command.Parameters("@FileName").Value = lastFileUploadInfo("FileName")
                e.Command.Parameters("@FileSize").Value = lastFileUploadInfo("FileSize")
                e.Command.Parameters("@FilePath").Value = lastFileUploadInfo("FilePath")
            Else
                ' By setting this value to null, we have it configured to use the existing value (Field = ISNULL(@Field, Field))
                e.Command.Parameters("@FileName").Value = DBNull.Value
                e.Command.Parameters("@FileSize").Value = DBNull.Value
                e.Command.Parameters("@FilePath").Value = DBNull.Value
            End If
            lastFileUploadInfo.Clear()
        End If
    End Sub


    ' delete the file referenced by this record
    Protected Sub sds_TerminalDocuments_Deleting(ByVal sender As Object, ByVal e As SqlDataSourceCommandEventArgs) Handles sds_TerminalDocuments.Deleting
        Dim UserID As String
        Dim MemUser As MembershipUser = Membership.GetUser()
        UserID = MemUser.ProviderUserKey.ToString()
        Dim conn As New SqlConnection(GetConnectionString())

        conn.Open()
        Dim cmd As New SqlCommand("SELECT FileName, FilePath FROM CF_Files WHERE IDFile = @IDFile", conn)
        cmd.Parameters.AddWithValue("@IDFile", e.Command.Parameters("@IDFile").Value)
        cmd.CommandType = CommandType.Text
        Try
            Dim reader As SqlDataReader = cmd.ExecuteReader()
            If reader.Read() Then
                If Not IsDBNull(reader("FileName")) AndAlso Not IsDBNull(reader("FilePath")) Then
                    File.Delete(Server.MapPath(Path.Combine(reader("FilePath").trim(), reader("FileName").trim())))
                End If
            End If
        Catch ex As System.Data.SqlClient.SqlException
            Dim msg As String = "Delete Error: "
            msg += ex.Message
            e.Cancel = True
            Throw New Exception(msg)
        Finally
            conn.Close()
        End Try
    End Sub

    ' Item command fires before Updating and Inserting
    ' This function must save the file to disk, and get file information parameters to the updating/inserting command
    Protected Sub rgd_TerminalDocuments_ItemCommand(ByVal sender As Object, ByVal e As GridCommandEventArgs) Handles rgd_TerminalDocuments.ItemCommand
        If e.CommandName = "PerformInsert" OrElse e.CommandName = "Update" Then
            Dim uploadRequiredF As Boolean
            lastFileUploadInfo.Clear()

            If e.CommandName = "PerformInsert" Then
                lastFileUploadInfo("IDFile") = Guid.NewGuid().ToString()
                uploadRequiredF = True
            Else
                lastFileUploadInfo("IDFile") = DirectCast(e.Item, GridEditFormItem).GetDataKeyValue("IDFile").ToString()
                uploadRequiredF = False
            End If
            If New Guid(lastFileUploadInfo("IDFile")) = Guid.Empty Then
                Throw New ArgumentException("RecordID is an empty GUID. This record hasn't been saved yet.")
            End If

            Dim uploadedFile As FileUpload = CType(e.Item.FindControl("fu_TerminalDocument"), FileUpload)
            Dim messageLabel As Label = CType(e.Item.FindControl("TerminalDocumentMessageLbl"), Label)

            If uploadedFile Is Nothing Then Throw New NullReferenceException()
            messageLabel.Text = ""

            If uploadedFile.PostedFile Is Nothing OrElse String.IsNullOrEmpty(uploadedFile.PostedFile.FileName) OrElse
              uploadedFile.PostedFile.InputStream Is Nothing Then
                If uploadRequiredF Then
                    messageLabel.Text &= "You must upload a file."
                Else
                    lastFileUploadInfo("SkipFileUpload") = "Y"
                    ' do nothing
                End If
                lastFileUploadInfo.Clear()
                Exit Sub
            End If

            Dim extension As String = Path.GetExtension(uploadedFile.PostedFile.FileName).ToLower()
            Dim destinationFilePath As String = WebConfigurationManager.AppSettings("FileRepositoryFolder")
            Dim destinationFileName As String
            'Dim recordId As Guid --WARNINGS commented out by Sam 2/20

            If extension <> ".pdf" Then
                messageLabel.Text = "Invalid file type [" & extension & "]."
                lastFileUploadInfo.Clear()
                Exit Sub
            End If

            ' insert and get UID, then SaveAs using the format {0}{1}: 0=GUID,1=extension. 
            ' we arn't saving the original file name to avoid problems when uploading a new file with a different name
            destinationFileName = String.Format("{0}{1}", lastFileUploadInfo("IDFile"), extension)

            Try
                uploadedFile.PostedFile.SaveAs(Server.MapPath(Path.Combine(destinationFilePath, destinationFileName)))
                lastFileUploadInfo("FileName") = destinationFileName
                lastFileUploadInfo("FileSize") = uploadedFile.PostedFile.ContentLength
                lastFileUploadInfo("FilePath") = destinationFilePath
                lastFileUploadInfo("SkipFileUpload") = "N"
            Catch exc As Exception
                messageLabel.Text &= "Could not save file. " & exc.Message
                lastFileUploadInfo.Clear()
                e.Canceled = True
                Throw New Exception(exc.ToString())
                Exit Sub
            End Try
        End If
    End Sub

    Protected Sub rgd_TerminalDocuments_ItemCreated(ByVal sender As Object, ByVal e As GridItemEventArgs) Handles rgd_TerminalDocuments.ItemCreated
        If (TypeOf e.Item Is GridDataItem) Then
            Dim item As GridDataItem = CType(e.Item, GridDataItem)
            Dim deleteBtn As LinkButton = CType(item.FindControl("AutoGeneratedDeleteButton"), LinkButton)

            deleteBtn.Attributes.Add("onclick", "return confirm('Are you sure you want to delete this Document?')")
        End If
    End Sub

    Private Function GetConnectionString() As String
        Return System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString
    End Function
End Class

