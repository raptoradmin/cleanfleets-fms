Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.CodeDom
Imports System.Web
Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Security
Imports System.Security.Principal.WindowsIdentity
Imports System.Collections.Generic
Public Class account_custom_module
    Inherits BaseWebForm
    Private filesTable As DataTable
    Private message As String
    Private IDProfileAccount As String
    Private IDCustomModule As String
    Private connectionString As String
    Private SQLStr As String

    Protected Sub Page_PreLoad(ByVal Sender As System.Object, ByVal e As System.EventArgs)
        connectionString = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        SQLStr = "SELECT IDProfileAccount, IDProfileContact, ContactName, Account FROM CFV_Profile_Contact WHERE UserName = @UserName"
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        IDProfileAccount = Request.QueryString("IDProfileAccount")
        IDCustomModule = Request.QueryString("IDModule")

        ' prepopulate the filestable if there is something in idcustommodule querystring
        If Not String.IsNullOrEmpty(IDCustomModule) AndAlso Not IsPostBack Then
            getExistingModules()
        End If

        setMessageLabel()

        If Not IsPostBack Then
            populateFilesDropDown()
        End If


    End Sub

    Protected Sub rdg_fileTable_NeedDataSource(ByVal source As Object, ByVal e As Telerik.Web.UI.GridNeedDataSourceEventArgs) Handles rdg_fileTable.NeedDataSource
        getDataTable()

        rdg_fileTable.DataSource = filesTable
        Me.ViewState.Add("dataTableViewState", filesTable)
    End Sub

    Protected Sub rdg_fileTable_DeleteCommand(ByVal source As Object, ByVal e As Telerik.Web.UI.GridCommandEventArgs) Handles rdg_fileTable.DeleteCommand
        getDataTable()
        'Dim row = filesTable.NewRow()
        filesTable.Rows(e.Item.ItemIndex).Delete()
        'row("File Name") = e.Item.ItemIndex
        'row("FileID") = "sdfgdfg"
        'filesTable.Rows.Add(row)
        Me.ViewState.Add("dataTableViewState", filesTable)
    End Sub

    Protected Sub addFileButton_Click(ByVal sender As Object, ByVal e As EventArgs)
        Page.Validate()
        If (Page.IsValid) Then

            getDataTable()
            Dim fileName = ddlFiles.SelectedItem.Text
            Dim fileID = ddlFiles.SelectedItem.Value

            ' prevents being able to add the default "Select" option in the drop down
            If Not String.IsNullOrEmpty(fileID) Then
                Dim row = filesTable.NewRow()
                row("File Name") = fileName
                row("FileID") = fileID
                filesTable.Rows.Add(row)
            End If
        End If

        rdg_fileTable.Rebind()
        Me.ViewState.Add("dataTableViewState", filesTable)
    End Sub

    Protected Sub saveButton_Click(ByVal sender As Object, ByVal e As EventArgs)
        Page.Validate()
        getDataTable()
        If formIsValid() AndAlso (Page.IsValid) Then


            If Not String.IsNullOrEmpty(IDCustomModule) Then
                updateModule()
            Else
                saveModule()
            End If
            Response.Redirect("account_details.aspx?IDProfileAccount=" & IDProfileAccount, True)

            ' redirect back to account details instead of showing a success message
            'showSuccessMessage()
        End If

        setMessageLabel()
    End Sub

    Protected Sub cancelButton_Click(ByVal sender As Object, ByVal e As EventArgs)
        Response.Redirect("account_details.aspx?IDProfileAccount=" & IDProfileAccount, True)
    End Sub

    Private Sub getExistingModules()
        getDataTable()
        Dim moduleName = New String("")
        connectionString = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        IDProfileAccount = Request.QueryString("IDProfileAccount")

        ' Displays Title of public documents as-is;
        ' Prepends terminal name to terminal documents
        SQLStr = "SELECT CF_CustomModuleContents.IDFile, Title, 1 AS InitialOrder " &
                    "FROM CF_CustomModuleContents " &
                    "INNER JOIN CFV_Files_Account_Public  " &
                    "  ON CF_CustomModuleContents.IDFile = CFV_Files_Account_Public.IDFile " &
                    "WHERE IDCustomModule = @ModuleID " &
                    "UNION " &
                    "SELECT F.IDFile, T.TerminalName + ' - ' + F.Title AS Title, 21 AS InitialOrder " &
                    "FROM CF_CustomModuleContents " &
                    "INNER JOIN CF_Files F " &
                    "  ON CF_CustomModuleContents.IDFile = F.IDFile " &
                    "INNER JOIN CF_Profile_Terminal T " &
                    "  ON F.IDProfileTerminal = T.IDProfileTerminal " &
                    "WHERE F.IDProfileAccount = @IDProfileAccount " &
                    "AND CF_CustomModuleContents.IDCustomModule = @moduleID " &
                    "AND F.IDProfileTerminal IS NOT NULL " &
                    "ORDER BY InitialOrder, Title "

        Using myConnection As New SqlConnection(connectionString)
            Dim myCommand As New SqlCommand(SQLStr, myConnection)
            myConnection.Open()
            myCommand.Parameters.AddWithValue("@moduleID", IDCustomModule)
            myCommand.Parameters.AddWithValue("@IDProfileAccount", IDProfileAccount)
            Dim MyReader As SqlDataReader = myCommand.ExecuteReader

            While MyReader.Read()
                Dim fileName = MyReader("Title")
                Dim fileID = MyReader("IDFile")
                Dim newRow = filesTable.NewRow()
                newRow("File Name") = fileName
                newRow("FileID") = fileID
                filesTable.Rows.Add(newRow)
            End While

            myConnection.Close()
        End Using

        ' get the module name separately in the case that if there 
        ' are no files, the sql will not return anything due to the inner joins
        tb_moduleName.Text = getModuleName()

        Me.ViewState.Add("dataTableViewState", filesTable)
        rdg_fileTable.DataSource = filesTable
    End Sub

    Private Function getModuleName() As String
        SQLStr = "SELECT ModuleName " &
                    "FROM CF_CustomModule " &
                    "WHERE IDCustomModule = @moduleID"
        Dim moduleName As String
        Using myConnection As New SqlConnection(connectionString)
            Dim myCommand As New SqlCommand(SQLStr, myConnection)
            myConnection.Open()
            myCommand.Parameters.AddWithValue("@moduleID", IDCustomModule)
            Dim MyReader As SqlDataReader = myCommand.ExecuteReader

            If MyReader.Read() Then
                moduleName = MyReader("ModuleName")
            End If

            myConnection.Close()
        End Using

        Return moduleName
    End Function

    Private Sub saveModule()
        getDataTable()
        connectionString = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        IDProfileAccount = Request.QueryString("IDProfileAccount")
        Dim moduleName = tb_moduleName.Text
        Dim moduleID As String
        SQLStr = "INSERT INTO CF_CustomModule(IDProfileAccount, ModuleName) " &
                    "VALUES (@ProfileID, @ModuleName) " &
                    ";SELECT @@IDENTITY"
        Using myConnection As New SqlConnection(connectionString)
            Dim myCommand As New SqlCommand(SQLStr, myConnection)
            myConnection.Open()
            myCommand.Parameters.AddWithValue("@ProfileID", IDProfileAccount)
            myCommand.Parameters.AddWithValue("@ModuleName", moduleName)
            moduleID = myCommand.ExecuteScalar()
            myConnection.Close()
        End Using

        saveModuleContents(moduleID)

    End Sub

    Private Sub saveModuleContents(ByVal moduleID As String)
        SQLStr = "INSERT INTO CF_CustomModuleContents(IDCustomModule, IDFile) " &
                    "VALUES (@ModuleID, @FileID)"

        Using myConnection As New SqlConnection(connectionString)
            myConnection.Open()

            For Each row As DataRow In filesTable.Rows
                Dim myCommand As New SqlCommand(SQLStr, myConnection)
                myCommand.Parameters.AddWithValue("@ModuleID", moduleID)
                myCommand.Parameters.AddWithValue("@FileID", row("fileID"))
                myCommand.ExecuteNonQuery()
            Next
            myConnection.Close()
        End Using
    End Sub

    Private Sub updateModule()
        ' updates the module name, thendeletes all entries in CF_CusomModuleContents for
        ' the IDCustomModule, then calls saveModuleContents to insert all files that beling

        getDataTable()
        updateModuleName()

        IDCustomModule = Request.QueryString("IDModule")
        connectionString = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        SQLStr = "DELETE FROM CF_CustomModuleContents " &
                    "WHERE IDCustomModule = @moduleID"
        Using myConnection As New SqlConnection(connectionString)
            Dim myCommand As New SqlCommand(SQLStr, myConnection)
            myConnection.Open()
            myCommand.Parameters.AddWithValue("@moduleID", IDCustomModule)
            myCommand.ExecuteNonQuery()
            myConnection.Close()
        End Using

        saveModuleContents(IDCustomModule)
    End Sub

    Private Sub updateModuleName()
        IDCustomModule = Request.QueryString("IDModule")

        connectionString = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim moduleName = tb_moduleName.Text
        Dim moduleID As String
        SQLStr = "UPDATE CF_CustomModule SET ModuleName = @moduleName WHERE IDCustomModule = @moduleID"
        Using myConnection As New SqlConnection(connectionString)
            Dim myCommand As New SqlCommand(SQLStr, myConnection)
            myConnection.Open()
            myCommand.Parameters.AddWithValue("@moduleID", IDCustomModule)
            myCommand.Parameters.AddWithValue("@moduleName", tb_moduleName.Text)
            myCommand.ExecuteNonQuery()
            myConnection.Close()
        End Using

    End Sub

    Private Sub setMessageLabel()
        If (Me.ViewState("messageLabel") IsNot Nothing) Then
            messageLabel.Text = CType(Me.ViewState("messageLabel"), String)
        End If
    End Sub

    Private Sub getDataTable()
        If (Me.ViewState("dataTableViewState") IsNot Nothing) Then
            filesTable = CType(Me.ViewState("dataTableViewState"), DataTable)
        Else
            ' DataTable isn't in view state, so we need to load it from scratch.
            createFilesTable()
        End If
    End Sub

    Private Sub createFilesTable()
        filesTable = New DataTable()
        filesTable.Columns.Add("File Name")
        filesTable.Columns.Add("FileID")
    End Sub

    Private Function formIsValid() As Boolean
        If String.IsNullOrEmpty(tb_moduleName.Text) Then
            message = "Module must have a name."
            Me.ViewState.Add("messageLabel", message)
            Return False
        End If

        If filesTable.Rows.Count = 0 Then
            message = "Module must contain at least one file."
            Me.ViewState.Add("messageLabel", message)
            Return False
        End If

        Return True
    End Function

    Public Sub showSuccessMessage()
        Dim messageText = "Module successfully created."
        messageLabel.Text = messageText
        Me.ViewState.Add("messageLabel", messageText)
    End Sub



    ' Since asp doesn't support a grouped dropdownlist, a custom class is required (App_Code/GroupedDropDownList.vb).
    ' Either the code doesn't support the optgroup attribute getting set automagically by the sqldatasource, or I don't know how to do it,
    ' So the dropdownlist is populated here
    Private Sub populateFilesDropDown()
        SQLStr = "SELECT IDFile, Title, 'Public Documents' AS optgroup, 1 AS InitialOrder " &
                    "FROM CFV_Files_Account_Public " &
                    "WHERE IDProfileAccount = @IDProfileAccount " &
                    "UNION " &
                    "SELECT F.IDFile, F.Title AS Title,  T.TerminalName + ' - Terminal Documents' AS optgroup, 2 AS InitialOrder " &
                    "FROM CF_Files F " &
                    "INNER JOIN CF_Profile_Terminal T " &
                    "  ON F.IDProfileTerminal = T.IDProfileTerminal " &
                    "WHERE F.IDProfileAccount = @IDProfileAccount " &
                    "AND F.IDProfileTerminal IS NOT NULL " &
                    "ORDER BY InitialOrder, Title"
        connectionString = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Using myConnection As New SqlConnection(connectionString)
            Dim myCommand As New SqlCommand(SQLStr, myConnection)
            myConnection.Open()
            myCommand.Parameters.AddWithValue("@IDProfileAccount", IDProfileAccount)
            Dim reader = myCommand.ExecuteReader()

            While reader.Read()
                Dim listItem = New ListItem(reader("Title"))
                listItem.Attributes.Add("optgroup", reader("optgroup"))
                listItem.Value = reader("IDFile").ToString()

                ddlFiles.Items.Add(listItem)
            End While
            myConnection.Close()
        End Using
    End Sub

End Class