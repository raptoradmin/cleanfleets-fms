Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Public Class enginesadd1
    Inherits BaseWebForm

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim IDVehicles As New Guid(Request.QueryString("IDVehicles"))

        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As New SqlCommand("SELECT [ChassisVIN] FROM [CF_Vehicles] WHERE IDVehicles = @IDVehicles", conn)
        Dim objDR As Data.SqlClient.SqlDataReader

        comm.Parameters.Add("@IDVehicles", SqlDbType.UniqueIdentifier).Value = IDVehicles

        comm.Connection.Open()

        objDR = comm.ExecuteReader(System.Data.CommandBehavior.CloseConnection)

        While objDR.Read()
            lbl_VehicleVIN.Text = objDR("ChassisVIN")
        End While

        comm.Connection.Close()

    End Sub



    Protected Sub btnInsert_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInsert.Click

        Dim IDProfileFleet As String = Request.QueryString("IDProfilefleet")
        Dim IDProfileTerminal As String = Request.QueryString("IDProfileTerminal")
        Dim IDProfileAccount As String = Request.QueryString("IDProfileAccount")
        Dim IDVehicles As New Guid(Request.QueryString("IDVehicles"))

        Dim conn As SqlConnection
        Dim cmd As SqlCommand
        Dim strconnection, strsqlinsert As String

        Dim currentUser As MembershipUser = Membership.GetUser()
        Dim currentUserId As Guid = CType(currentUser.ProviderUserKey, Guid)
        Dim IDEngines As Guid = Guid.NewGuid()

        If Page.IsValid() Then

            strconnection = (ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
            strsqlinsert = "Insert into CF_Engines ( "
            strsqlinsert += "IDEngines, IDModifiedUser, ModifiedDate, IDVehicles, IDProfileAccount, IDEngineManufacturer, Displacement, EstRetrofitCost, EngineModel, IDEngineStatus, IDEngineFuelType, IDModelYear, SerialNum, FamilyName, Horsepower, Description, Notes, NotesCF"
            strsqlinsert += ")"
            strsqlinsert += " values ("
            strsqlinsert += "@IDEngines, @IDModifiedUser, @ModifiedDate, @IDVehicles, @IDProfileAccount, @IDEngineManufacturer, @Displacement, @EstRetrofitCost, @EngineModel, @IDEngineStatus, @IDEngineFuelType, @IDModelYear, @SerialNum, @FamilyName, @Horsepower, @Description, @Notes, @NotesCF"
            strsqlinsert += ")"

            conn = New SqlConnection(strconnection)
            cmd = New SqlCommand(strsqlinsert, conn)

            cmd.Parameters.Add("@IDEngines", SqlDbType.UniqueIdentifier).Value = IDEngines
            cmd.Parameters.Add("@IDModifiedUser", SqlDbType.UniqueIdentifier).Value = currentUserId
            cmd.Parameters.Add("@ModifiedDate", SqlDbType.DateTime).Value = DateTime.Now
            cmd.Parameters.Add("@IDVehicles", SqlDbType.UniqueIdentifier).Value = IDVehicles
            cmd.Parameters.Add("@IDProfileAccount", SqlDbType.Int).Value = IDProfileAccount
            cmd.Parameters.Add("@IDEngineManufacturer", SqlDbType.Int).Value = ddl_IDEngineManufacturer.SelectedValue
            cmd.Parameters.Add("@IDEngineStatus", SqlDbType.Int).Value = ddl_IDEngineStatus.SelectedValue
            cmd.Parameters.Add("@IDEngineFuelType", SqlDbType.Int).Value = ddl_IDEngineFuelType.SelectedValue
            cmd.Parameters.Add("@IDModelYear", SqlDbType.Int).Value = ddl_ModelYear.SelectedValue
            cmd.Parameters.Add("@SerialNum", SqlDbType.VarChar, 50).Value = tbx_SerialNum.Text
            cmd.Parameters.Add("@FamilyName", SqlDbType.VarChar, 50).Value = tbx_FamilyName.Text
            cmd.Parameters.Add("@EngineModel", SqlDbType.VarChar, 50).Value = tbx_EngineModel.Text
            cmd.Parameters.Add("@Horsepower", SqlDbType.VarChar, 50).Value = tbx_Horsepower.Text
            cmd.Parameters.Add("@Displacement", SqlDbType.VarChar, 50).Value = tbx_Displacement.Text
            cmd.Parameters.Add("@EstRetrofitCost", SqlDbType.VarChar, 50).Value = tbx_EstRetrofitCost.Text
            cmd.Parameters.Add("@Description", SqlDbType.VarChar, 8000).Value = tbx_Description.Text
            cmd.Parameters.Add("@Notes", SqlDbType.VarChar, 8000).Value = tbx_Notes.Text
            cmd.Parameters.Add("@NotesCF", SqlDbType.VarChar, 8000).Value = tbx_NotesCF.Text

            cmd.Connection.Open()
            cmd.ExecuteNonQuery()
            cmd.Connection.Close()

            Dim IDVehicle As String = IDVehicles.ToString

            Response.Redirect("vehiclesdetails.aspx?IDProfilefleet=" & IDProfileFleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDVehicles=" & IDVehicle)
        End If
    End Sub


    Protected Sub UniqueEngineSerialNumValidator(sender As Object, args As ServerValidateEventArgs)
        Dim conn As SqlConnection
        Dim cmd As SqlCommand
        Dim strconnection, strsqlvalidate As String

        Dim currentUser As MembershipUser = Membership.GetUser()
        Dim currentUserId As Guid = CType(currentUser.ProviderUserKey, Guid)
        Dim count As Integer = 0

        strconnection = (ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
        conn = New SqlConnection(strconnection)

        strsqlvalidate = "SELECT COUNT(*) FROM CF_Engines WHERE UPPER(RTRIM(SerialNum)) = UPPER(RTRIM(@SerialNum)) AND UPPER(RTRIM(SerialNum)) > '' "
        cmd = New SqlCommand(strsqlvalidate, conn)
        cmd.Parameters.Add("@SerialNum", SqlDbType.VarChar, 50).Value = args.Value
        cmd.Connection.Open()
        count = cmd.ExecuteScalar()
        cmd.Connection.Close()
        Response.Write(count)
        'Response.End()
        args.IsValid = (count = 0)
    End Sub

End Class




