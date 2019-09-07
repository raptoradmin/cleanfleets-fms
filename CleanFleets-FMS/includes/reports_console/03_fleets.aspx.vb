Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI

Public Class _03_fleets
    Inherits BaseWebForm

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

            Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
            Dim conn As New SqlConnection(connectionString)
            Dim comm As New SqlCommand("SELECT * FROM CF_Profile_Account ORDER BY AccountName", conn)
            comm.Connection.Open()


            Dim ddlValues As SqlDataReader
            ddlValues = comm.ExecuteReader()

            ddl_Accounts.DataSource = ddlValues
            ddl_Accounts.DataValueField = "IDProfileAccount"
            ddl_Accounts.DataTextField = "AccountName"
            ddl_Accounts.DataBind()

            comm.Connection.Close()
            comm.Connection.Dispose()

        End If
    End Sub

    Protected Sub ddl_Accounts_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddl_Accounts.SelectedIndexChanged

        Dim IDProfileAccount = ddl_Accounts.SelectedValue

        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As New SqlCommand("SELECT * FROM CF_Profile_Terminal WHERE IDProfileAccount = @IDProfileAccount ORDER BY TerminalName", conn)
        comm.Connection.Open()

        comm.Parameters.Add("@IDProfileAccount", SqlDbType.Int).Value = IDProfileAccount

        Dim ddlValues As SqlDataReader
        ddlValues = comm.ExecuteReader()

        ddl_Terminals.DataSource = ddlValues
        ddl_Terminals.DataValueField = "IDProfileTerminal"
        ddl_Terminals.DataTextField = "TerminalName"
        ddl_Terminals.DataBind()

        comm.Connection.Close()
        comm.Connection.Dispose()




    End Sub
End Class