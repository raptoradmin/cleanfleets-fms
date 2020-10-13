Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports System.Globalization
Imports System.Text
Imports Telerik.Web.UI
Public Class vehiclestransfer
    Inherits BaseWebForm

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click


        Dim IDProfileTerminal As String = Request.QueryString("IDProfileTerminal")
        Dim IDProfileAccount As String = Request.QueryString("IDProfileAccount")
        Dim IDVehicles As New Guid(Request.QueryString("IDVehicles"))
        Dim IDProfileFleet = ddl_Fleet.SelectedValue


        Dim sql As String
        Dim strConnString As [String] = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
        sql = "UPDATE CF_Vehicles SET IDProfileFleet = @IDProfileFleet WHERE IDVehicles = @IDVehicles"
        Dim cn As New SqlConnection(strConnString)
        Dim cmd As New SqlCommand(sql, cn)

        cmd.Parameters.Add("@IDVehicles", SqlDbType.UniqueIdentifier).Value = IDVehicles
        cmd.Parameters.Add("@IDProfileFleet", SqlDbType.Int).Value = IDProfileFleet

        cmd.Connection.Open()
        cmd.ExecuteNonQuery()
        cmd.Connection.Close()

        Dim IDVehicle As String = IDVehicles.ToString

        updateWeightDefinitionBasedOnNewRuleCode(IDVehicle, IDProfileFleet.ToString)

        Response.Redirect("vehiclesdetails.aspx?IDProfileFleet=" & IDProfileFleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDVehicles=" & IDVehicle)

    End Sub


    '	Since the rule code is a property of the fleet, the vehicle's weight definition
    '	may need to be updated
    '	(weight definitions are only valid if the rule code is "On Road")
    Private Sub updateWeightDefinitionBasedOnNewRuleCode(ByVal IDVehicles As String, ByVal IDProfileFleet As String)
        Dim onRoadRuleCode = getOnRoadRuleCode()
        Dim newFleetsRuleCode = getFleetsRuleCode(IDProfileFleet)

        If newFleetsRuleCode = onRoadRuleCode Then
            setWeightDefinition(IDVehicles)
        Else
            removeWeightDefinition(IDVehicles)
        End If
    End Sub


    Private Function getOnRoadRuleCode() As Integer
        Dim onRoadRuleCode As Integer
        Dim strConnString As String = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
        Dim sqlStr = "SELECT IDOptionList FROM CF_Option_List WHERE RecordValue = @RecordValue AND OptionName = @OptionName"
        Dim conn As New SqlConnection(strConnString)
        Dim comm As New SqlCommand(sqlStr, conn)
        comm.Connection.Open()

        comm.Parameters.Add("@RecordValue", "On Road")
        comm.Parameters.Add("@OptionName", "RuleCode")

        onRoadRuleCode = comm.ExecuteScalar()

        comm.Connection.Close()

        Return onRoadRuleCode
    End Function


    Private Function getFleetsRuleCode(ByVal IDProfileFleet As String) As Integer
        Dim fleetRuleCode As Integer
        Dim strConnString As String = System.Configuration.ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString()
        Dim sqlStr = "SELECT IDRuleCode FROM CF_Profile_Fleet WHERE IDProfileFleet = @IDProfileFleet"
        Dim conn As New SqlConnection(strConnString)
        Dim comm As New SqlCommand(sqlStr, conn)
        comm.Connection.Open()

        comm.Parameters.Add("@IDProfileFleet", IDProfileFleet)

        fleetRuleCode = comm.ExecuteScalar()

        comm.Connection.Close()

        Return fleetRuleCode
    End Function

    Private Sub setWeightDefinition(ByVal IDVehicles As String)
        Dim weightDefinition As Integer
        Dim weightString = getVehicleWeight(IDVehicles)
        Dim weight As Integer
        If Integer.TryParse(weightString, NumberStyles.AllowThousands, CultureInfo.CurrentCulture, weight) Then
            If weight > 14000 AndAlso weight <= 26000 Then
                weightDefinition = getWeightDefinitionCode("LighterVehicle")
            ElseIf weight > 26000 Then
                weightDefinition = getWeightDefinitionCode("HeavierVehicle")
            Else
                weightDefinition = 0
            End If
        Else
            weightDefinition = 0
        End If

        updateWeightDefinition(IDVehicles, weightDefinition)
    End Sub

    Private Sub removeWeightDefinition(ByVal IDVehicles As String)
        updateWeightDefinition(IDVehicles, 0)
    End Sub


    Private Sub updateWeightDefinition(ByVal IDVehicles As String, ByVal idWeightDefinition As Integer)
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As SqlCommand
        'Dim vehicleWeight As String  --WARNINGS commented out by Sam 2/20 because it wasn't being used
        Dim sqlStr = "UPDATE CF_Vehicles " &
                        "SET IDWeightDefinition = @WeightDefinition " &
                        "WHERE IDVehicles = @IDVehicles"
        comm = New SqlCommand(sqlStr, conn)
        comm.Connection.Open()
        comm.Parameters.Add("@IDVehicles", IDVehicles)
        comm.Parameters.Add("@WeightDefinition", idWeightDefinition)
        comm.ExecuteNonQuery()
        comm.Connection.Close()
    End Sub

    Private Function getVehicleWeight(ByVal IDVehicles As String) As String
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As SqlCommand
        Dim vehicleWeight As String
        Dim sqlStr = "SELECT GrossVehicleWeight " &
                        "FROM CF_Vehicles " &
                        "WHERE IDVehicles = @IDVehicles"
        comm = New SqlCommand(sqlStr, conn)
        comm.Connection.Open()
        comm.Parameters.Add("@IDVehicles", IDVehicles)

        vehicleWeight = comm.ExecuteScalar()

        comm.Connection.Close()

        Return vehicleWeight
    End Function

    Private Function getWeightDefinitionCode(ByVal recordValue As String) As Integer
        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As SqlCommand
        Dim idWeightDefinition As Integer
        Dim sqlStr = "SELECT IDOptionList " &
                        "FROM CF_Option_List " &
                        "WHERE RecordValue = @RecordValue AND OptionName = @OptionName"
        comm = New SqlCommand(sqlStr, conn)
        comm.Connection.Open()
        comm.Parameters.Add("@RecordValue", recordValue)
        comm.Parameters.Add("@OptionName", "WeightDefinition")

        idWeightDefinition = comm.ExecuteScalar()

        comm.Connection.Close()

        Return idWeightDefinition
    End Function

End Class