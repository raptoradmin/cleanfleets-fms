Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Public Class engine_DECsadd1
    Inherits BaseWebForm

    Protected Sub btnInsert_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInsert.Click

        Dim IDEngines As String = Request.QueryString("IDEngines")

        Dim conn As SqlConnection
        Dim cmd As SqlCommand
        Dim strconnection, strsqlinsert As String

        Dim currentUser As MembershipUser = Membership.GetUser()
        Dim currentUserId As Guid = CType(currentUser.ProviderUserKey, Guid)
        Dim IDDECs As String




        strconnection = (ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
        strsqlinsert = "Insert into CF_DECs ( "
        strsqlinsert += "IDModifiedUser, ModifiedDate, IDEngines, DECSName, IDDECSManufacturer, IDDECSLevel, DECSModelNo, DECSInstallationDate, Notes, NotesCF"
        strsqlinsert += ")"
        strsqlinsert += " values ("
        strsqlinsert += "@IDModifiedUser, @ModifiedDate, @IDEngines, @DECSName, @IDDECSManufacturer, @IDDECSLevel, @DECSModelNo, @DECSInstallationDate, @Notes, @NotesCF"
        strsqlinsert += ")"
        strsqlinsert += "; SELECT SCOPE_IDENTITY() ; "
        conn = New SqlConnection(strconnection)
        cmd = New SqlCommand(strsqlinsert, conn)
        cmd.Parameters.Add("@IDModifiedUser", SqlDbType.UniqueIdentifier).Value = currentUserId
        cmd.Parameters.Add("@ModifiedDate", SqlDbType.DateTime).Value = DateTime.Now
        cmd.Parameters.Add("@IDEngines", SqlDbType.Int).Value = IDEngines
        cmd.Parameters.Add("@DECSName", SqlDbType.VarChar, 50).Value = tbx_DECSName.Text
        cmd.Parameters.Add("@IDDECSManufacturer", SqlDbType.Int).Value = ddl_IDDECSManufacturer.Text
        cmd.Parameters.Add("@IDDECSLevel", SqlDbType.Int).Value = ddl_IDDECSLevel.Text
        cmd.Parameters.Add("@DECSModelNo", SqlDbType.VarChar, 50).Value = tbx_DECSModelNo.Text
        cmd.Parameters.Add("@DECSInstallationDate", SqlDbType.DateTime).Value = rdp_DECSInstallationDate.SelectedDate
        cmd.Parameters.Add("@Notes", SqlDbType.VarChar, 8000).Value = tbx_Notes.Text
        cmd.Parameters.Add("@NotesCF", SqlDbType.VarChar, 8000).Value = tbx_NotesCF.Text
        cmd.Connection.Open()
        IDDECs = cmd.ExecuteScalar
        cmd.Connection.Close()
        Response.Redirect("engines_detached.aspx")
    End Sub




    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim IDEngines As String = Request.QueryString("IDEngines")

        Dim cn As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ToString)
        cn.Open()
        Dim SqlCmd As SqlCommand
        SqlCmd = New SqlCommand("SELECT [SerialNum] FROM [CF_Engines] WHERE IDEngines = IDEngines", cn)


        lbl_EngineSerialNo.Text = CType(SqlCmd.ExecuteScalar, String)
        cn.Close()



    End Sub

End Class