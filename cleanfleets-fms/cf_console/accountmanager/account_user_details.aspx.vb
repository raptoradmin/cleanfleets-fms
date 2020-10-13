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
Public Class account_user_details
    Inherits BaseWebForm

    Protected Sub SqlDataSource1_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsfvEmployeeDetails.Deleted

        Response.Redirect("account_user_list.aspx")

    End Sub

    Protected Sub Formview1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles FormView1.PreRender

        If FormView1.CurrentMode = FormViewMode.Edit Then

            Dim rowView As DataRowView = CType(FormView1.DataItem, DataRowView)

            If Not IsNothing(rowView) AndAlso Not IsNothing(CType(FormView1.FindControl("DropDownListTitle"), DropDownList).Items.FindByValue(rowView("IDTitle").ToString())) Then
                CType(FormView1.FindControl("DropDownListTitle"), DropDownList).SelectedValue = rowView("IDTitle").ToString()

            End If

        End If

    End Sub



    Protected Sub Formview1_ItemUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewUpdateEventArgs) Handles FormView1.ItemUpdating

        e.NewValues("IDTitle") = CType(FormView1.FindControl("DropDownListTitle"), DropDownList).SelectedValue

    End Sub




    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim IDProfileContact As String = Request.QueryString("IDProfileContact")
        Dim userID As String
        Dim cn As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ToString)
        cn.Open()
        Dim SqlCmd As SqlCommand
        '09/13/2012 IR: Get the userID of the selected user to be used by the sqldatasource
        SqlCmd = New SqlCommand("SELECT [UserID] FROM [CF_Profile_Contact] WHERE IDProfileContact = @IDProfileContact", cn)
        SqlCmd.Parameters.Add("@IDProfileContact", SqlDbType.VarChar, 50).Value = IDProfileContact

        userID = CType(SqlCmd.ExecuteScalar, Guid).ToString()
        cn.Close()
        sds_Profile_Terminal.UpdateParameters("UserId").DefaultValue = userID
    End Sub


    Protected Sub SqlDataSource1_Updating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles sdsfvEmployeeDetails.Updating
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

    Protected Sub UpdateButton_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        '        Dim UserID As String = Session("UserID").ToString()
        '

        '
        '
        '
        '        Dim Pass As TextBox = CType(FormView1.FindControl("tbx_Password"), TextBox)
        '        Dim Password As String = Pass.Text
        '        Dim PassQuest As TextBox = CType(FormView1.FindControl("tbx_PasswordQuestion"), TextBox)
        '        Dim PasswordQuestion As String = PassQuest.Text
        '
        '        Dim sql1 As String
        '        Dim strConnString1 As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
        '        sql1 = "UPDATE aspnet_Membership SET Password = @Password, PasswordQuestion = @PasswordQuestion, PasswordFormat = 0 WHERE UserID = @UserID"
        '        Dim cn1 As New SqlConnection(strConnString1)
        '        Dim cmd1 As New SqlCommand(sql1, cn1)
        '
        '        cmd1.Parameters.Add("@UserID", SqlDbType.VarChar, 50).Value = UserID
        '        cmd1.Parameters.Add("@Password", SqlDbType.VarChar, 50).Value = Password
        '        cmd1.Parameters.Add("@PasswordQuestion", SqlDbType.VarChar, 50).Value = PasswordQuestion
        '
        '        cmd1.Connection.Open()
        '        'cmd1.ExecuteNonQuery()
        '        cmd1.Connection.Close()



        'UPDATE [aspnet_Users] SET UserName = @UserName, LoweredUserName = LOWER(@UserName) WHERE UserId = @UserID;
        'UPDATE [aspnet_Membership] SET Email = @Email, LoweredEmail = LOWER(@Email), PasswordQuestion = @PasswordQuestion WHERE UserId = @UserID; 
        'Dim UserID as string = CType(FormView1.FindControl("UserIDHiddenField"), HiddenField)
        ' MG 5/24/2012 - the previous author completely butchered saving information about users. this fixes that.
        Dim newpassword As String = CType(FormView1.FindControl("tbx_Password"), TextBox).Text
        Dim oldpassword As String = CType(FormView1.FindControl("tbx_OldPassword"), HiddenField).Value
        Dim PasswordQuestion As String = CType(FormView1.FindControl("tbx_PasswordQuestion"), TextBox).Text
        Dim PasswordAnswer As String = CType(FormView1.FindControl("tbx_PasswordAnswer"), TextBox).Text
        Dim email As String = CType(FormView1.FindControl("EmailTextBox"), TextBox).Text


        Dim UserName As String = CType(FormView1.FindControl("hf_OldUserName"), HiddenField).Value
        Dim user As MembershipUser = Membership.GetUser(UserName)
        user.Email = email

        Message.Text = ""
        Try
            Membership.UpdateUser(user)
        Catch exc As System.Configuration.Provider.ProviderException
            Message.Text &= exc.Message
        End Try

        Try
            user.ChangePasswordQuestionAndAnswer(oldpassword, PasswordQuestion, PasswordAnswer)
        Catch exc As System.Configuration.Provider.ProviderException
            Message.Text &= exc.Message
        End Try

        If oldpassword <> newpassword Then
            Try
                If user.ChangePassword(oldpassword, newpassword) Then
                    Message.Text &= "Password Changed."
                End If
            Catch exc As System.Configuration.Provider.ProviderException
                Message.Text &= exc.Message
            End Try
        End If

        Dim UserID As Object = user.ProviderUserKey
        Dim sql As String
        Dim strConnString As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
        sql = "UPDATE aspnet_Users SET UserName = @UserName, LoweredUserName = LOWER(@UserName) WHERE UserID = @UserID"
        Dim cn As New SqlConnection(strConnString)
        Dim cmd As New SqlCommand(sql, cn)

        cmd.Parameters.Add("@UserID", SqlDbType.Variant).Value = UserID
        cmd.Parameters.Add("@UserName", SqlDbType.VarChar, 50).Value = UserName
        'cmd.Connection.Open()
        'cmd.ExecuteNonQuery() ' MG 5/24/2012 - can't update username. the update either doesn't persist or is never made.
        'cmd.Connection.Close()
        Dim updateSQL = "UPDATE CF_UserTerminals SET PermissionLevel = @PermissionLevel WHERE UserId = @UserId AND IDProfileTerminal = @IDProfileTerminal"
        Using myConnection As New SqlConnection(strConnString)
            myConnection.Open()
            Dim RadGrid1 As RadGrid = CType(FindControlIterative(Page, "RadGrid1"), RadGrid)
            For Each row As GridDataItem In RadGrid1.Items
                Dim permissionCell As TableCell = row("PermissionLevel")
                Dim permissionDL As DropDownList = permissionCell.FindControl("Permissions")
                Dim permissionLevel As String = permissionDL.SelectedValue
                If permissionLevel = "" Then
                    permissionLevel = "G"
                End If
                Dim terminalHidden As HiddenField = permissionCell.FindControl("IDProfileTerminalHiddenField")
                Dim IDProfileTerminal As String = terminalHidden.Value
                Dim myCommand = New SqlCommand(updateSQL, myConnection)
                myCommand.Parameters.AddWithValue("@UserId", UserID)
                myCommand.Parameters.AddWithValue("@PermissionLevel", permissionLevel)
                myCommand.Parameters.AddWithValue("@IDProfileTerminal", IDProfileTerminal)
                myCommand.ExecuteScalar()
            Next
            myConnection.Close()
        End Using
    End Sub

    Public Shared Function FindControlIterative(ByVal myRoot As Control, ByVal myIDOfControlToFind As String) As Control
        Dim myRootControl As Control = New Control
        myRootControl = myRoot
        Dim setOfChildControls As LinkedList(Of Control) = New LinkedList(Of Control)
        Do While (myRootControl IsNot Nothing)
            If myRootControl.ID = myIDOfControlToFind Then
                Return myRootControl
            End If
            For Each childControl As Control In myRootControl.Controls
                If childControl.ID = myIDOfControlToFind Then
                    Return childControl
                End If
                If childControl.HasControls() Then
                    setOfChildControls.AddLast(childControl)
                End If
            Next
            myRootControl = setOfChildControls.First.Value
            setOfChildControls.Remove(myRootControl)
        Loop
        Return Nothing
    End Function
End Class

