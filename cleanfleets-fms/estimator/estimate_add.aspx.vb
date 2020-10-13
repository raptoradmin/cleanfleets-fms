Imports System.Data
Imports System.Data.SqlClient
Public Class estimate_add
    Inherits BaseWebForm

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click

        Dim conn As SqlConnection
        Dim cmd As SqlCommand
        Dim strconnection, strsqlinsert As String
        Dim IDAccount As String


        strconnection = (ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
        strsqlinsert = "Insert into CF_QE_Account ( "
        strsqlinsert += "AccountName"
        strsqlinsert += ")"
        strsqlinsert += " values ("
        strsqlinsert += "@AccountName"
        strsqlinsert += ")"
        strsqlinsert += "; SELECT SCOPE_IDENTITY() ; "

        conn = New SqlConnection(strconnection)
        cmd = New SqlCommand(strsqlinsert, conn)


        cmd.Parameters.Add("@AccountName", SqlDbType.NVarChar, 150).Value = tbx_AccountName.Text


        cmd.Connection.Open()
        IDAccount = cmd.ExecuteScalar
        cmd.Connection.Close()

        Response.Redirect("estimator.aspx?IDAccount=" & IDAccount)
    End Sub
End Class