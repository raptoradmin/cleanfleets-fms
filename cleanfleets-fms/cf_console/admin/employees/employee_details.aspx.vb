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
Public Class employee_details
    Inherits BaseWebForm

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public MemUser As MembershipUser
    Public UserID As String

    Private Sub cf_console_admin_profiles_employee_employeedetails_PreLoad(sender As Object, e As EventArgs) Handles Me.PreLoad
        MemUser = Membership.GetUser()
        UserID = MemUser.ProviderUserKey.ToString()
    End Sub

    Private Sub sdsfvEmployeeDetails_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles sdsfvEmployeeDetails.Selecting
        If MemUser Is Nothing Then
            MemUser = Membership.GetUser()
            UserID = MemUser.ProviderUserKey.ToString()
        End If

        If MemUser Is Nothing Then
            e.Cancel = True
        Else
            e.Command.Parameters("@IDModifiedUser").Value = UserID.ToString()
        End If
    End Sub

    Protected Sub SqlDataSource1_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsfvEmployeeDetails.Deleted
        Response.Redirect("employee_list.aspx")
    End Sub

    Protected Sub SqlDataSource1_Updating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles sdsfvEmployeeDetails.Updating
        If MemUser Is Nothing Then
            MemUser = Membership.GetUser()
            UserID = MemUser.ProviderUserKey.ToString()
        End If

        If MemUser Is Nothing Then
            e.Cancel = True
        Else
            e.Command.Parameters("@IDModifiedUser").Value = UserID.ToString()
            e.Command.Parameters("@ModifiedDate").Value = DateTime.Now
        End If
    End Sub

End Class