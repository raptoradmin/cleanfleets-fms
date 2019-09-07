Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Public Class DECs_attach1
    Inherits BaseWebForm


    Protected Sub btn_Attach_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Attach.Click

        Dim IDProfilefleet As String = Request.QueryString("IDProfilefleet")
        Dim IDProfileTerminal As String = Request.QueryString("IDProfileTerminal")
        Dim IDProfileAccount As String = Request.QueryString("IDProfileAccount")
        Dim IDVehicles As New Guid(Request.QueryString("IDVehicles"))
        Dim IDEngines As New Guid(Request.QueryString("IDEngines"))
        Dim IDDEC As String = ddl_IDDECs.SelectedValue
        Dim IDDECs As New Guid(IDDEC)

        Dim sql As String
        Dim strConnString As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
        sql = "UPDATE CF_DECS SET IDEngines = @IDEngines WHERE IDDECS = @IDDECS"
        Dim connection As New SqlConnection(strConnString)
        Dim command As New SqlCommand(sql, connection)

        command.Parameters.Add("@IDEngines", SqlDbType.UniqueIdentifier).Value = IDEngines
        command.Parameters.Add("@IDDECS", SqlDbType.UniqueIdentifier).Value = IDDECs

        command.Connection.Open()
        command.ExecuteNonQuery()
        command.Connection.Close()

        Dim IDVehicle As String = IDVehicles.ToString

        Response.Redirect("../03_vehicles/vehiclesdetails.aspx?IDProfileFleet=" & IDProfilefleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDVehicles=" & IDVehicle)

    End Sub

End Class



