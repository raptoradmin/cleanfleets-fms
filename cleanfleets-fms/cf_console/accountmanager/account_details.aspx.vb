Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.CodeDom
Imports System.Web
Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Web.Configuration
Imports System.Security
Imports System.Security.Principal.WindowsIdentity
Imports System.IO
Imports System.Collections.Generic
Imports CFUtilities

Public Class account_details1
    Inherits BaseWebForm

    Protected IDProfileAccount As String

   

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack Then
            If (FormView1.CurrentMode = FormViewMode.Edit) Then
                createDefaultModuleEdit()
                createCustomModuleEdit("CustomModulesEdit")
            ElseIf (FormView1.CurrentMode = FormViewMode.ReadOnly) Then
                createDefaultModuleView()
                'createCustomModuleView()
                createCustomModuleEdit("CustomModulesView")
            End If
        End If

        IDProfileAccount = Request.QueryString("IDProfileAccount")
    End Sub

    Protected Function FormatPhone(Optional ByVal phone As String = "") As String
        Return CommonFunctions.FormatPhone(phone)
    End Function

    Protected Sub FormView1_DataBound(sender As Object, e As EventArgs) Handles FormView1.DataBound
        If (FormView1.CurrentMode = FormViewMode.Edit) Then
            createDefaultModuleEdit()
            createCustomModuleEdit("CustomModulesEdit")
        ElseIf (FormView1.CurrentMode = FormViewMode.ReadOnly) Then
            createDefaultModuleView()
            createCustomModuleEdit("CustomModulesView")
            'createCustomModuleView()
        End If
    End Sub

    Protected Sub FormView1_ItemUpdated(ByVal sender As Object, ByVal e As FormViewUpdatedEventArgs) Handles FormView1.ItemUpdated
        updateDefaultModulePreferences()
    End Sub

    Protected Sub sdsfvAccountDetails_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsfvAccountDetails.Deleted
        Response.Redirect("account_list.aspx")
    End Sub

    Protected Sub sdsfvAccountDetails_Updating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles sdsfvAccountDetails.Updating
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
        Dim query As String = SqlDbCommandDebug(e.Command)
        Dim s As String = ""
    End Sub

    Protected Sub sdsfvAccountDetailsNotes_Updating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles sdsfvAccountDetailsNotes.Updating
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

    Protected Sub sdsfvAccountDetailsInternalNotes_Updating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles sdsfvAccountDetailsInternalNotes.Updating
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
    Protected Sub sds_rpv_Contact_Updating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles sds_rpv_Contact.Updating
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

    Protected Sub src_DefaultModules_Updating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles src_DefaultModules.Updating

    End Sub

    Protected Sub btn_AddContact_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_AddContact.Click

        Dim IDAccount As Label = CType(FormView1.FindControl("lbl_IDProfileAccount"), Label)
        Dim AccountNameLabel As Label = CType(FormView1.FindControl("AccountNameLabel"), Label)
        If IDAccount IsNot Nothing Then
            Dim AcctID As String = IDAccount.Text
            Dim AcctNm As String = AccountNameLabel.Text
            Response.Redirect("account_user_add.aspx?&IDProfileAccount=" & AcctID & "&AccountName=" & AcctNm)
        End If
    End Sub

    ' if the selected option is no longer in the list, it'll throw problems.  This will set the value to the first item in the select list (should be "Select")
    Protected Sub PreventErrorOnbinding(sender As Object, e As EventArgs)
        Dim theDropDownList As DropDownList = CType(sender, DropDownList)

        RemoveHandler theDropDownList.DataBinding, AddressOf Me.PreventErrorOnbinding
        theDropDownList.AppendDataBoundItems = False
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

    Protected Sub sds_PublicDocuments_InsertingUpdating(ByVal sender As Object, ByVal e As SqlDataSourceCommandEventArgs) Handles sds_PublicDocuments.Inserting,
      sds_PublicDocuments.Updating
        ' change the parameters here
        Dim UserID As String
        Dim MemUser As MembershipUser
        MemUser = Membership.GetUser()
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

    Protected Sub sds_PublicDocuments_Deleting(ByVal sender As Object, ByVal e As SqlDataSourceCommandEventArgs) Handles sds_PublicDocuments.Deleting
        ' delete the file referenced by this record
        Dim UserID As String
        Dim MemUser As MembershipUser
        MemUser = Membership.GetUser()
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

    'Protected Sub btnUpdate_click(ByVal sender As Object, ByVal e As EventArgs)
    Private lastFileUploadInfo As New Dictionary(Of String, String)
    Protected Sub rgd_publicDocuments_ItemCommand(ByVal sender As Object, ByVal e As GridCommandEventArgs) Handles rgd_PublicDocuments.ItemCommand
        ' Item command fires before Updating and Inserting
        ' This function must save the file to disk, and get file information parameters to the updating/inserting command
        ' one important question is how do I know the recordId?
        ' another question is, how do I keep variables for the state, that don't persist on subsequent calls

        If e.CommandName = "PerformInsert" OrElse e.CommandName = "Update" Then
            Dim uploadRequiredF As Boolean
            lastFileUploadInfo.Clear()
            'Throw New Exception("Got here")
            ' save the file, store the file information
            ' I need the GUID of the row, or to create a new GUID if the row is an insert
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

            Dim uploadedFile As FileUpload = CType(e.Item.FindControl("fu_PublicDocument"), FileUpload)
            Dim messageLabel As Label = CType(e.Item.FindControl("PublicDocumentMessageLbl"), Label)

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
                Exit Sub
            End If

            Dim extension As String = Path.GetExtension(uploadedFile.PostedFile.FileName).ToLower()
            Dim destinationFilePath As String = WebConfigurationManager.AppSettings("FileRepositoryFolder")
            Dim destinationFileName As String
            'Dim recordId As Guid  --WARNINGS commented out by due to not being used Sam 2/20

            If extension <> ".pdf" Then
                messageLabel.Text = "Invalid file type [" & extension & "]."
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
                'Throw exc
                lastFileUploadInfo.Clear()
                e.Canceled = True
                Exit Sub
            End Try


        End If
    End Sub

    Protected Sub rgd_publicDocuments_ItemCreated(ByVal sender As Object, ByVal e As GridItemEventArgs) Handles rgd_PublicDocuments.ItemCreated

        If (TypeOf e.Item Is GridDataItem) Then

            Dim item As GridDataItem = CType(e.Item, GridDataItem)
            Dim deleteBtn As LinkButton = CType(item.FindControl("AutoGeneratedDeleteButton"), LinkButton)
            deleteBtn.Attributes.Add("onclick", "return confirm('Are you sure you want to delete this Document?')")
        End If
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
            'Dim recordId As Guid  --WARNINGS commented out by due to not being used Sam 2/20

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

    'sets the connection string from your web config file. "DBConnection" is the name of your Connection String
    Private Function GetConnectionString() As String
        Return System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString
    End Function

    Private Sub createDefaultModuleEdit()
        Dim defaultModulesEdit = FormView1.FindControl("DefaultModulesEdit")
        Dim IDProfileAccount = Request.QueryString("IDProfileAccount")
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim table = New Table()

        'create table header row
        Dim headerRow = New TableRow()
        Dim nameHeader = New TableCell()
        Dim displayedHeader = New TableCell()
        nameHeader.Text = "Module"
        nameHeader.CssClass = "tdtable"
        displayedHeader.Text = "Displayed"
        displayedHeader.CssClass = "tdtable"

        headerRow.Controls.Add(nameHeader)
        headerRow.Controls.Add(displayedHeader)
        table.Controls.Add(headerRow)

        Dim SQLString = "SELECT [IsDisplayed], [DisplayValue], [RecordValue], [IDDefaultModule] " &
                            "FROM [CF_AccountDefaultModules] INNER JOIN [CF_Option_List] " &
                            "ON IDDefaultModule = IDOptionList " &
                            "WHERE IDProfileAccount = @IDProfileAccount " &
                            "ORDER BY [DisplayValue]"
        Using myConnection As New SqlConnection(connectionString)
            myConnection.Open()
            Dim command As New SqlCommand(SQLString, myConnection)
            command.Parameters.Add("@IDProfileAccount", IDProfileAccount)
            Dim MyReader As SqlDataReader = command.ExecuteReader
            While MyReader.Read()
                Dim newRow = New TableRow()
                Dim moduleName = New TableCell()
                Dim moduleLabel = New Label()
                Dim isDisplayedCell = New TableCell()
                Dim isDisplayedCheckbox As New CheckBox()
                Dim checkboxID = "checkbox" & MyReader("IDDefaultModule")

                moduleLabel.Text = MyReader("DisplayValue")
                moduleLabel.AssociatedControlID = checkboxID
                moduleName.CssClass = "defaultModuleTableCell"
                moduleName.Controls.Add(moduleLabel)
                isDisplayedCheckbox.Checked = If(MyReader("IsDisplayed").ToUpper().Trim() = "Y", True, False)
                isDisplayedCheckbox.ID = checkboxID
                isDisplayedCell.CssClass = "defaultModuleTableCell"
                isDisplayedCell.Controls.Add(isDisplayedCheckbox)
                newRow.CssClass = ("moduleRow")

                newRow.Controls.Add(moduleName)
                newRow.Controls.Add(isDisplayedCell)

                table.Controls.Add(newRow)
            End While

            myConnection.Close()
        End Using
        defaultModulesEdit.Controls.Add(table)

    End Sub

    Private Sub createDefaultModuleView()
        Dim defaultModulesView = FormView1.FindControl("DefaultModulesView")
        Dim IDProfileAccount = Request.QueryString("IDProfileAccount")
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim table = New Table()

        'create table header row
        Dim headerRow = New TableRow()
        Dim nameHeader = New TableCell()
        Dim displayedHeader = New TableCell()
        nameHeader.Text = "Module"
        nameHeader.CssClass = "tdtable"
        displayedHeader.Text = "Displayed"
        displayedHeader.CssClass = "tdtable"
        headerRow.Controls.Add(nameHeader)
        headerRow.Controls.Add(displayedHeader)
        table.Controls.Add(headerRow)

        Dim SQLString = "SELECT [IsDisplayed], [DisplayValue], [RecordValue], [IDDefaultModule] " &
                            "FROM [CF_AccountDefaultModules] INNER JOIN [CF_Option_List] " &
                            "ON IDDefaultModule = IDOptionList " &
                            "WHERE IDProfileAccount = @IDProfileAccount " &
                            "ORDER BY [DisplayValue]"
        Using myConnection As New SqlConnection(connectionString)
            myConnection.Open()
            Dim command As New SqlCommand(SQLString, myConnection)
            command.Parameters.Add("@IDProfileAccount", IDProfileAccount)
            Dim MyReader As SqlDataReader = command.ExecuteReader
            While MyReader.Read()
                Dim newRow = New TableRow()
                Dim moduleName = New TableCell()
                Dim isDisplayed = New TableCell()

                moduleName.Text = MyReader("DisplayValue")
                moduleName.CssClass = "moduleTableCell"
                isDisplayed.Text = If(MyReader("IsDisplayed").ToUpper().Trim() = "Y", "Yes", "No")
                isDisplayed.CssClass = "moduleTableCell"
                newRow.CssClass = ("moduleRow")

                newRow.Controls.Add(moduleName)
                newRow.Controls.Add(isDisplayed)

                table.Controls.Add(newRow)
            End While

            myConnection.Close()
        End Using
        defaultModulesView.Controls.Add(table)
    End Sub

    Private Sub createCustomModuleView()
        Dim customModulesView = FormView1.FindControl("CustomModulesView")
        Dim table = New Table()
        Dim profileID = Request.QueryString("IDProfileAccount")

        'create table header row
        Dim headerRow = New TableRow()
        Dim fileHeader = New TableCell()
        Dim contentsHeader = New TableCell()
        fileHeader.Text = "Module Name"
        fileHeader.CssClass = "tdtable"
        contentsHeader.Text = "Contents"
        contentsHeader.CssClass = "tdtable"
        headerRow.Controls.Add(fileHeader)
        headerRow.Controls.Add(contentsHeader)
        table.Controls.Add(headerRow)

        Dim customModules As New Dictionary(Of String, String)
        Dim SQLString = "SELECT [ModuleName], [IDCustomModule] " &
                        "FROM [CF_CustomModule] " &
                        "WHERE IDProfileAccount = @IDProfileAccount " &
                        "ORDER BY [ModuleName]"

        Dim IDProfileAccount = Request.QueryString("IDProfileAccount")
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)

        Using myConnection As New SqlConnection(connectionString)
            myConnection.Open()
            Dim command As New SqlCommand(SQLString, myConnection)
            command.Parameters.Add("@IDProfileAccount", IDProfileAccount)
            Dim MyReader As SqlDataReader = command.ExecuteReader
            While MyReader.Read()
                Dim IDCustomModule = MyReader("IDCustomModule")
                Dim moduleName = MyReader("ModuleName")
                customModules.Add(IDCustomModule, moduleName)
            End While
            myConnection.Close()
        End Using

        For Each modulePair As KeyValuePair(Of String, String) In customModules
            Dim moduleName = modulePair.Value
            Dim moduleID = modulePair.Key

            ' get each file associated with the custom module id
            SQLString = "SELECT Title " &
                        "FROM CF_CustomModuleContents INNER JOIN CF_Files " &
                        "ON CF_CustomModuleContents.IDFile = CF_Files.IDFile " &
                        "WHERE IDCustomModule = @ModuleID"
            Using myConnection As New SqlConnection(connectionString)
                myConnection.Open()
                Dim command As New SqlCommand(SQLString, myConnection)
                command.Parameters.Add("@ModuleID", moduleID)
                Dim MyReader As SqlDataReader = command.ExecuteReader

                Dim newRow = New TableRow()
                Dim nameCell = New TableCell()
                Dim contentsCell = New TableCell()
                Dim contentsTable = New Table()

                nameCell.Text = moduleName
                nameCell.CssClass = "moduleTableCell"
                contentsCell.CssClass = "moduleTableCell"
                newRow.CssClass = "moduleRow"

                newRow.Controls.Add(nameCell)
                Dim ul = New HtmlGenericControl("ul")
                ul.Attributes.Add("class", "contentsList")

                While MyReader.Read()
                    Dim li = New HtmlGenericControl("li")
                    li.InnerText = MyReader("Title")
                    ul.Controls.Add(li)
                End While
                contentsCell.Controls.Add(ul)
                newRow.Controls.Add(contentsCell)

                table.Controls.Add(newRow)
                myConnection.Close()
            End Using
        Next
        customModulesView.Controls.Add(table)
    End Sub


    Private Sub createCustomModuleEdit(ByVal controlToAddTo As String)
        Dim customModulesControl = FormView1.FindControl(controlToAddTo)
        Dim table = New Table()
        Dim profileID = Request.QueryString("IDProfileAccount")

        'create table header row
        Dim headerRow = New TableRow()
        Dim fileHeader = New TableCell()
        Dim contentsHeader = New TableCell()
        Dim controlHeader = New TableCell()
        fileHeader.Text = "Module Name"
        fileHeader.CssClass = "tdtable"
        contentsHeader.Text = "Contents"
        contentsHeader.CssClass = "tdtable"
        controlHeader.Text = "Controls"
        controlHeader.CssClass = "tdtable"
        headerRow.Controls.Add(fileHeader)
        headerRow.Controls.Add(contentsHeader)
        headerRow.Controls.Add(controlHeader)
        table.Controls.Add(headerRow)

        Dim customModules As New Dictionary(Of String, String)
        Dim SQLString = "SELECT [ModuleName], [IDCustomModule] " &
                            "FROM [CF_CustomModule] " &
                            "WHERE IDProfileAccount = @IDProfileAccount " &
                            "ORDER BY [ModuleName]"

        Dim IDProfileAccount = Request.QueryString("IDProfileAccount")
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)

        Using myConnection As New SqlConnection(connectionString)
            myConnection.Open()
            Dim command As New SqlCommand(SQLString, myConnection)
            command.Parameters.Add("@IDProfileAccount", IDProfileAccount)
            Dim MyReader As SqlDataReader = command.ExecuteReader
            While MyReader.Read()
                Dim IDCustomModule = MyReader("IDCustomModule")
                Dim moduleName = MyReader("ModuleName")
                customModules.Add(IDCustomModule, moduleName)
            End While
            myConnection.Close()
        End Using

        For Each modulePair As KeyValuePair(Of String, String) In customModules
            Dim moduleName = modulePair.Value
            Dim moduleID = modulePair.Key


            SQLString = "SELECT Title " &
                        "FROM CF_CustomModuleContents " &
                        "INNER JOIN CFV_Files_Account_Public  " &
                        "  ON CF_CustomModuleContents.IDFile = CFV_Files_Account_Public.IDFile " &
                        "WHERE IDCustomModule = @ModuleID " &
                        "UNION " &
                        "SELECT T.TerminalName + ' - ' + F.Title AS Title " &
                        "FROM CF_CustomModuleContents " &
                        "INNER JOIN CF_Files F " &
                        "  ON CF_CustomModuleContents.IDFile = F.IDFile " &
                        "INNER JOIN CF_Profile_Terminal T " &
                        "  ON F.IDProfileTerminal = T.IDProfileTerminal " &
                        "WHERE F.IDProfileAccount = @IDProfileAccount " &
                        "AND CF_CustomModuleContents.IDCustomModule = @moduleID " &
                        "AND F.IDProfileTerminal IS NOT NULL "
            Using myConnection As New SqlConnection(connectionString)
                myConnection.Open()
                Dim command As New SqlCommand(SQLString, myConnection)
                command.Parameters.Add("@ModuleID", moduleID)
                command.Parameters.Add("@IDProfileAccount", IDProfileAccount)
                Dim MyReader As SqlDataReader = command.ExecuteReader

                Dim newRow = New TableRow()
                Dim nameCell = New TableCell()
                Dim contentsCell = New TableCell()

                nameCell.CssClass = "moduleTableCell"
                nameCell.Text = moduleName
                newRow.Controls.Add(nameCell)
                newRow.CssClass = ("moduleRow")
                contentsCell.CssClass = "topAlign"

                Dim ol = New HtmlGenericControl("ol")
                ol.Attributes.Add("class", "contentsList")

                While MyReader.Read()
                    Dim li = New HtmlGenericControl("li")
                    li.InnerText = MyReader("Title")
                    ol.Controls.Add(li)
                End While

                contentsCell.Controls.Add(ol)
                newRow.Controls.Add(contentsCell)

                Dim buttonCell = New TableCell()
                buttonCell.CssClass = "moduleTableCell"

                Dim deleteButton = New Button()
                deleteButton.Text = "Delete Module"
                deleteButton.Attributes.Add("runat", "server")
                deleteButton.CommandArgument = moduleID
                deleteButton.OnClientClick = "return confirm('Are you certain you want to delete this Custom Module?')"
                AddHandler deleteButton.Click, AddressOf Me.deleteCustomModule

                Dim editButton = New Button()
                editButton.Text = "Edit Module"
                editButton.Attributes.Add("runat", "server")
                editButton.CommandArgument = moduleID
                AddHandler editButton.Click, AddressOf Me.editCustomModule

                buttonCell.Controls.Add(deleteButton)
                buttonCell.Controls.Add(New LiteralControl("<br />"))
                buttonCell.Controls.Add(editButton)
                newRow.Controls.Add(buttonCell)

                table.Controls.Add(newRow)
                myConnection.Close()
            End Using
        Next
        customModulesControl.Controls.Add(table)
    End Sub

    Protected Sub deleteCustomModule(ByVal sender As Object, ByVal e As EventArgs)
        Dim moduleID As String = sender.CommandArgument

        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)

        Dim SQLStr = "DELETE FROM CF_CustomModule WHERE IDCustomModule = @ModuleID; " &
                        "DELETE FROM CF_CustomModuleContents WHERE IDCustomModule = @ModuleID"
        Using myConnection As New SqlConnection(connectionString)
            myConnection.Open()
            Dim command As New SqlCommand(SQLStr, myConnection)
            command.Parameters.Add("@ModuleID", moduleID)
            command.ExecuteNonQuery()
            myConnection.Close()
        End Using

        ' Change the FormView back to ReadOnly mode, the custom module
        ' won't disappear until the mode changes, even though it is gone from the db
        ' rebind?
        FormView1.ChangeMode(FormViewMode.ReadOnly)
    End Sub

    Protected Sub editCustomModule(ByVal sender As Object, ByVal e As EventArgs)
        Dim moduleID As String = sender.CommandArgument

        Response.Redirect("account_custom_module.aspx?IDProfileAccount=" & IDProfileAccount & "&IDModule=" & moduleID, True)
    End Sub

    Private Sub updateDefaultModulePreference(ByVal moduleID As String, ByVal preference As Boolean)
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim preferenceString = If(preference, "Y", "N")


        Dim SQLStr = "UPDATE CF_AccountDefaultModules " &
                        "SET IsDisplayed = @IsDisplayed " &
                        "WHERE IDProfileAccount = @ProfileID AND IDDefaultModule = @ModuleID"
        Using myConnection As New SqlConnection(connectionString)
            myConnection.Open()
            Dim command As New SqlCommand(SQLStr, myConnection)
            command.Parameters.AddWithValue("@ProfileID", IDProfileAccount)
            command.Parameters.AddWithValue("@ModuleID", moduleID)
            command.Parameters.AddWithValue("@IsDisplayed", preferenceString)
            command.ExecuteNonQuery()
            myConnection.Close()
        End Using
    End Sub

    Protected Sub createModuleBtn_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Response.Redirect("account_custom_module.aspx?IDProfileAccount=" & IDProfileAccount, True)
    End Sub

    Protected Sub updateDefaultModulePreferences()
        Dim defaultModuleIDList As List(Of String)
        defaultModuleIDList = getDefaultModuleIDs()
        Dim preference As Boolean
        Dim checkboxID As String
        Dim checkbox As CheckBox

        For Each moduleID As String In defaultModuleIDList
            ' the asp:checkbox controls are initialized with an id 
            ' of "checkBox[moduleID]"
            checkboxID = "checkbox" & moduleID
            checkbox = FormView1.FindControl(checkboxID)
            preference = checkbox.Checked
            updateDefaultModulePreference(moduleID, preference)
        Next
    End Sub

    Private Function getDefaultModuleIDs() As List(Of String)
        Dim SQLStr = "SELECT IDDefaultModule " &
                        "FROM CF_AccountDefaultModules " &
                        "WHERE IDProfileAccount = @ProfileID"
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim moduleIDs = New List(Of String)
        Using myConnection As New SqlConnection(connectionString)
            myConnection.Open()
            Dim command As New SqlCommand(SQLStr, myConnection)
            command.Parameters.AddWithValue("@ProfileID", IDProfileAccount)
            Dim reader As SqlDataReader = command.ExecuteReader()
            While reader.Read()
                moduleIDs.Add(reader("IDDefaultModule"))
            End While
            myConnection.Close()
        End Using

        Return moduleIDs
    End Function


    Public Function SqlDbCommandDebug(ByVal oCommand As SqlCommand) As String
        Dim query As String = ""

        query = oCommand.CommandText

        For Each param As SqlParameter In oCommand.Parameters
            If IsNumeric(param.Value) Then
                query = query.Replace(param.ParameterName, param.Value.ToString())
            Else
                If param.Value Is Nothing Then
                    query = query.Replace(param.ParameterName, "''")
                Else
                    query = query.Replace(param.ParameterName, "'" & param.Value.ToString().Replace("'", "''") & "'")
                End If
            End If
        Next

        Return query
    End Function

End Class

