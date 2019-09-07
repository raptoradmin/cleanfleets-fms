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
Public Class employee_add
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub CreateUserWizard1_CreatedUser(ByVal sender As Object, ByVal e As System.EventArgs) Handles CreateUserWizard1.CreatedUser


        Dim UserRole As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("ddl_IDEmployeeRole"), DropDownList).Text
        Dim IDTitle As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("ddl_IDEmployeeTitle"), DropDownList).Text
        Dim LastName As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("tb_LastName"), TextBox).Text
        Dim FirstName As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("tb_FirstName"), TextBox).Text
        Dim MI As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("tb_MI"), TextBox).Text
        Dim UserName As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("UserName"), TextBox).Text
        Dim PasswordQuestion As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("Question"), TextBox).Text
        Dim Email As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("Email"), TextBox).Text
        Dim Address1 As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("tb_Address1"), TextBox).Text
        Dim Address2 As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("tb_Address2"), TextBox).Text
        Dim City As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("tb_City"), TextBox).Text
        Dim State As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("tb_State"), TextBox).Text
        Dim Zip As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("tb_Zip"), TextBox).Text
        Dim Telephone1 As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("tb_Telephone1"), Telerik.Web.UI.RadMaskedTextBox).Text
        Dim Ext1 As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("tb_Ext1"), TextBox).Text
        Dim Telephone2 As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("tb_Telephone2"), Telerik.Web.UI.RadMaskedTextBox).Text
        Dim Ext2 As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("tb_Ext2"), TextBox).Text
        Dim Telephone3 As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("tb_Telephone3"), Telerik.Web.UI.RadMaskedTextBox).Text
        Dim Ext3 As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("tb_Ext3"), TextBox).Text
        Dim CellPhone As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("tb_CellPhone"), Telerik.Web.UI.RadMaskedTextBox).Text
        Dim Fax1 As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("tb_Fax1"), Telerik.Web.UI.RadMaskedTextBox).Text
        Dim Notes As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("tb_Notes"), TextBox).Text
        Dim NotesCF As String = DirectCast(CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("tb_NotesCF"), TextBox).Text


        Dim newUser As MembershipUser = Membership.GetUser(CreateUserWizard1.UserName)
        If newUser Is Nothing Then

            Throw New ApplicationException("Can't find the user.")

        End If
        Dim CF_SQL_Connection As String = ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString
        Dim insertSql As String = "INSERT INTO CF_Profile_Contact(UserRole, UserId, IDModifiedUser, EnterDate, ModifiedDate, IDTitle, LastName, FirstName, MI, Address1, Address2, City, State, Zip, Telephone1, Ext1, Telephone2, Ext2, Telephone3, Ext3, CellPhone, Fax1, Notes, NotesCF) VALUES(@UserRole, @UserId, @IDModifiedUser, @EnterDate, @ModifiedDate, @IDTitle, @LastName, @FirstName, @MI, @Address1, @Address2, @City, @State, @Zip, @Telephone1, @Ext1, @Telephone2, @Ext2, @Telephone3, @Ext3, @CellPhone, @Fax1, @Notes, @NotesCF)" & "Select Scope_Identity()"

        Dim newUserId As Guid = CType(newUser.ProviderUserKey, Guid)
        Dim currentUser As MembershipUser = Membership.GetUser(User.Identity.Name)
        Dim currentUserId As Guid = CType(currentUser.ProviderUserKey, Guid)
        Dim IDProfileContact As String

        Using myConnection As New SqlConnection(CF_SQL_Connection)
            myConnection.Open()
            Dim myCommand As New SqlCommand(insertSql, myConnection)
            myCommand.Parameters.AddWithValue("UserRole", UserRole)
            myCommand.Parameters.AddWithValue("@UserId", newUserId)
            myCommand.Parameters.AddWithValue("@IDModifiedUser", currentUserId)
            myCommand.Parameters.AddWithValue("EnterDate", DateTime.Now)
            myCommand.Parameters.AddWithValue("ModifiedDate", DateTime.Now)
            myCommand.Parameters.AddWithValue("IDTitle", IDTitle)
            myCommand.Parameters.AddWithValue("LastName", LastName)
            myCommand.Parameters.AddWithValue("FirstName", FirstName)
            myCommand.Parameters.AddWithValue("MI", MI)
            myCommand.Parameters.AddWithValue("Address1", Address1)
            myCommand.Parameters.AddWithValue("Address2", Address2)
            myCommand.Parameters.AddWithValue("City", City)
            myCommand.Parameters.AddWithValue("State", State)
            myCommand.Parameters.AddWithValue("Zip", Zip)
            myCommand.Parameters.AddWithValue("Telephone1", Telephone1)
            myCommand.Parameters.AddWithValue("Ext1", Ext1)
            myCommand.Parameters.AddWithValue("Telephone2", Telephone2)
            myCommand.Parameters.AddWithValue("Ext2", Ext2)
            myCommand.Parameters.AddWithValue("Telephone3", Telephone3)
            myCommand.Parameters.AddWithValue("Ext3", Ext3)
            myCommand.Parameters.AddWithValue("CellPhone", CellPhone)
            myCommand.Parameters.AddWithValue("Fax1", Fax1)
            myCommand.Parameters.AddWithValue("Notes", Notes)
            myCommand.Parameters.AddWithValue("NotesCF", NotesCF)

            IDProfileContact = myCommand.ExecuteScalar()
            myConnection.Close()
        End Using
        Roles.AddUserToRole(CreateUserWizard1.UserName.ToString(), UserRole)
        Response.Redirect("employee_details.aspx?IDProfileContact=" & IDProfileContact)
    End Sub


End Class
