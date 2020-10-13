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
Public Class estimator
    Inherits BaseWebForm

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        Dim IDAccount As String = Request.QueryString("IDAccount")
        hfd_IDAccount.Value = Request.QueryString("IDAccount")

        Dim cn As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ToString)
        cn.Open()
        Dim SqlCmd As SqlCommand
        SqlCmd = New SqlCommand("SELECT [AccountName] FROM [CF_QE_Account] WHERE IDAccount = " & IDAccount & "", cn)

        lbl_AccountName.Text = CType(SqlCmd.ExecuteScalar, String)


        cn.Close()

    End Sub



    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click

        Dim conn As SqlConnection
        Dim cmd As SqlCommand
        Dim strconnection, strsqlinsert As String
        Dim IDAccount As String = Request.QueryString("IDAccount")


        strconnection = (ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
        strsqlinsert = "Insert into CF_QE_Estimate ( "
        strsqlinsert += "IDQEAccount, IDGrossVehicleWeight, IDChassisModelYear, QuantityVehicles, EstReplacementCost, EstRetrofitCost"
        strsqlinsert += ")"
        strsqlinsert += " values ("
        strsqlinsert += "@IDQEAccount, @IDGrossVehicleWeight, @IDChassisModelYear, @QuantityVehicles, @EstReplacementCost, @EstRetrofitCost"
        strsqlinsert += ")"
        strsqlinsert += "; SELECT SCOPE_IDENTITY() ; "

        conn = New SqlConnection(strconnection)
        cmd = New SqlCommand(strsqlinsert, conn)

        cmd.Parameters.Add("@IDQEAccount", SqlDbType.Int).Value = hfd_IDAccount.Value
        cmd.Parameters.Add("@IDGrossVehicleWeight", SqlDbType.Int).Value = ddl_GVW.SelectedValue
        cmd.Parameters.Add("@IDChassisModelYear", SqlDbType.Int).Value = ddl_Year.SelectedValue
        cmd.Parameters.Add("@QuantityVehicles", SqlDbType.Int).Value = tbx_TotalVehicles.Text
        cmd.Parameters.Add("@EstReplacementCost", SqlDbType.Money).Value = tbx_ReplacementCost.Text
        cmd.Parameters.Add("@EstRetrofitCost", SqlDbType.Money).Value = tbx_RetrofitCost.Text


        cmd.Connection.Open()
        cmd.ExecuteScalar()
        cmd.Connection.Close()

        Response.Redirect("estimator.aspx?IDAccount=" & IDAccount)
    End Sub

End Class
