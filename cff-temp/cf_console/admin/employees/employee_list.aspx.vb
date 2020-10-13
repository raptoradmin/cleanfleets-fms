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

Public Class employee_list
    Inherits BaseWebForm

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btn_Add_Employee_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Add_Employee.Click

        Response.Redirect("employee_add.aspx")

    End Sub

End Class