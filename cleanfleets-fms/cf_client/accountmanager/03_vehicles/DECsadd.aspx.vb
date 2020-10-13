Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Public Class DECsadd
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim IDEngines As New Guid(Request.QueryString("IDEngines"))
        hf_ID_Engine.Value = Request.QueryString("IDEngines")

        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As New SqlCommand("SELECT [SerialNum] FROM [CF_Engines] WHERE IDEngines = @IDEngines", conn)
        Dim objDR As Data.SqlClient.SqlDataReader

        comm.Parameters.Add("@IDEngines", SqlDbType.UniqueIdentifier).Value = IDEngines

        comm.Connection.Open()

        objDR = comm.ExecuteReader(System.Data.CommandBehavior.CloseConnection)

        While objDR.Read()
            lbl_EngineSerialNo.Text = objDR("SerialNum")
        End While

        comm.Connection.Close()

    End Sub


    Protected Sub btnInsert_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInsert.Click

        Dim IDProfileFleet As String = Request.QueryString("IDProfilefleet")
        Dim IDProfileTerminal As String = Request.QueryString("IDProfileTerminal")
        Dim IDProfileAccount As String = Request.QueryString("IDProfileAccount")
        Dim IDVehicles As String = Request.QueryString("IDVehicles")
        Dim IDEngines As New Guid(Request.QueryString("IDEngines"))

        Dim conn As SqlConnection
        Dim cmd As SqlCommand
        Dim strconnection, strsqlinsert As String

        Dim currentUser As MembershipUser = Membership.GetUser()
        Dim currentUserId As Guid = CType(currentUser.ProviderUserKey, Guid)
        Dim IDDECs As Guid = Guid.NewGuid()

        strconnection = (ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
        strsqlinsert = "Insert into CF_DECs ( "
        strsqlinsert += "IDDECs, IDModifiedUser, ModifiedDate, IDEngines, IDProfileAccount, DECSName, SerialNo, IDDECSManufacturer, IDDECSLevel, DECSModelNo, DECSInstallationDate, Notes, NotesCF"
        strsqlinsert += ")"
        strsqlinsert += " values ("
        strsqlinsert += "@IDDECs, @IDModifiedUser, @ModifiedDate, @IDEngines, @IDProfileAccount, @DECSName, @SerialNo, @IDDECSManufacturer, @IDDECSLevel, @DECSModelNo, @DECSInstallationDate, @Notes, @NotesCF"
        strsqlinsert += ")"

        conn = New SqlConnection(strconnection)
        cmd = New SqlCommand(strsqlinsert, conn)

        cmd.Parameters.Add("@IDDECs", SqlDbType.UniqueIdentifier).Value = IDDECs
        cmd.Parameters.Add("@IDModifiedUser", SqlDbType.UniqueIdentifier).Value = currentUserId
        cmd.Parameters.Add("@ModifiedDate", SqlDbType.DateTime).Value = DateTime.Now
        cmd.Parameters.Add("@IDEngines", SqlDbType.UniqueIdentifier).Value = IDEngines
        cmd.Parameters.Add("@DECSName", SqlDbType.VarChar, 50).Value = tbx_DECSName.Text
        cmd.Parameters.Add("@SerialNo", SqlDbType.VarChar, 50).Value = tbx_SerialNo.Text
        cmd.Parameters.Add("@IDProfileAccount", SqlDbType.Int).Value = IDProfileAccount
        cmd.Parameters.Add("@IDDECSManufacturer", SqlDbType.Int).Value = ddl_IDDECSManufacturer.Text
        cmd.Parameters.Add("@IDDECSLevel", SqlDbType.Int).Value = ddl_IDDECSLevel.Text
        cmd.Parameters.Add("@DECSModelNo", SqlDbType.VarChar, 50).Value = tbx_DECSModelNo.Text
        cmd.Parameters.Add("@DECSInstallationDate", SqlDbType.DateTime).Value = rdp_DECSInstallationDate.SelectedDate
        cmd.Parameters.Add("@Notes", SqlDbType.VarChar, 8000).Value = tbx_Notes.Text
        cmd.Parameters.Add("@NotesCF", SqlDbType.VarChar, 8000).Value = tbx_NotesCF.Text

        cmd.Connection.Open()
        cmd.ExecuteNonQuery()
        cmd.Connection.Close()

        Response.Redirect("vehiclesdetails.aspx?IDProfilefleet=" & IDProfileFleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDVehicles=" & IDVehicles)

    End Sub
End Class