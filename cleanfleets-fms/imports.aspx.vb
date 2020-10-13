Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.CodeDom
Imports System.Web
Imports System.IO

Public Class _imports
    Inherits BaseWebForm

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btn_ImportVehicles_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_ImportVehicles.Click


        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As New SqlCommand("SELECT * FROM CFV_Import_Vehicles", conn)
        comm.Connection.Open()

        Dim myDataAdapter As New SqlDataAdapter(comm)
        Dim myDataSet As New DataSet
        Dim dtData As New DataTable
        Dim dtRow As DataRow
        myDataAdapter.Fill(myDataSet)
        conn.Close()

        For Each dtRow In myDataSet.Tables(0).Rows

            Dim IDProfileFleet = dtRow.Item("IDProfileFleet")
            Dim IDEquipmentType = dtRow.Item("IDEquipmentType")
            Dim IDEquipmentCategory = dtRow.Item("IDEquipmentCategory")
            Dim IDVehicleStatus = dtRow.Item("IDVehicleStatus")
            Dim IDCARBGroup = dtRow.Item("IDCARBGroup")
            Dim LicensePlateNo = dtRow.Item("LicensePlateNo")
            Dim ChassisVIN = dtRow.Item("ChassisVIN")
            Dim IDChassisMake = dtRow.Item("IDChassisMake")
            Dim IDChassisModelYear = dtRow.Item("IDChassisModelYear")
            Dim UnitNo = dtRow.Item("UnitNo")
            Dim AnnualMiles = dtRow.Item("AnnualMiles")
            Dim AnnualHours = dtRow.Item("AnnualHours")
            Dim ActualMiles = dtRow.Item("ActualMiles")
            Dim ActualHours = dtRow.Item("ActualHours")
            Dim GrossVehicleWeight = dtRow.Item("GrossVehicleWeight")
            Dim PlannedComplianceDate = dtRow.Item("PlannedComplianceDate")
            Dim ActualComplianceDate = dtRow.Item("ActualComplianceDate")
            Dim BackupStatusDate = dtRow.Item("BackupStatusDate")
            Dim RetireStatusDate = dtRow.Item("RetireStatusDate")
            Dim EstReplacementCost = dtRow.Item("EstReplacementCost")
            Dim PlannedRetirementDate = dtRow.Item("PlannedRetirementDate")
            Dim ActualRetirementDate = dtRow.Item("ActualRetirementDate")



            Dim conn2 As SqlConnection
            Dim cmd As SqlCommand
            Dim strconnection, strsqlinsert As String

            strconnection = (ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
            strsqlinsert = "Insert into CF_Vehicles ( "
            strsqlinsert += "IDProfileFleet, IDEquipmentType, IDEquipmentCategory, IDVehicleStatus, IDCARBGroup, LicensePlateNo, ChassisVIN, IDChassisMake, IDChassisModelYear, UnitNo, AnnualMiles, AnnualHours, ActualMiles, ActualHours, GrossVehicleWeight, PlannedComplianceDate, ActualComplianceDate, BackupStatusDate, RetireStatusDate, EstReplacementCost, PlannedRetirementDate, ActualRetirementDate"
            strsqlinsert += ")"
            strsqlinsert += " values ("
            strsqlinsert += "@IDProfileFleet, @IDEquipmentType, @IDEquipmentCategory, @IDVehicleStatus, @IDCARBGroup, @LicensePlateNo, @ChassisVIN, @IDChassisMake, @IDChassisModelYear, @UnitNo, @AnnualMiles, @AnnualHours, @ActualMiles, @ActualHours, @GrossVehicleWeight, @PlannedComplianceDate, @ActualComplianceDate, @BackupStatusDate, @RetireStatusDate, @EstReplacementCost, @PlannedRetirementDate, @ActualRetirementDate"
            strsqlinsert += ")"
            strsqlinsert += "; SELECT SCOPE_IDENTITY() ; "

            conn2 = New SqlConnection(strconnection)
            cmd = New SqlCommand(strsqlinsert, conn2)

            cmd.Parameters.Add("@IDProfileFleet", SqlDbType.Int).Value = IDProfileFleet
            cmd.Parameters.Add("@IDEquipmentType", SqlDbType.Int).Value = IDEquipmentType
            cmd.Parameters.Add("@IDEquipmentCategory", SqlDbType.Int).Value = IDEquipmentCategory
            cmd.Parameters.Add("@IDVehicleStatus", SqlDbType.Int).Value = IDVehicleStatus
            cmd.Parameters.Add("@IDCARBGroup", SqlDbType.Int).Value = IDCARBGroup
            cmd.Parameters.Add("@LicensePlateNo", SqlDbType.NVarChar, 50).Value = LicensePlateNo
            cmd.Parameters.Add("@ChassisVIN", SqlDbType.NVarChar, 50).Value = ChassisVIN
            cmd.Parameters.Add("@IDChassisMake", SqlDbType.Int).Value = IDChassisMake
            cmd.Parameters.Add("@IDChassisModelYear", SqlDbType.Int).Value = IDChassisModelYear
            cmd.Parameters.Add("@UnitNo", SqlDbType.NVarChar, 50).Value = UnitNo
            cmd.Parameters.Add("@AnnualMiles", SqlDbType.NVarChar, 50).Value = AnnualMiles
            cmd.Parameters.Add("@AnnualHours", SqlDbType.NVarChar, 50).Value = AnnualHours
            cmd.Parameters.Add("@ActualMiles", SqlDbType.NVarChar, 50).Value = ActualMiles
            cmd.Parameters.Add("@ActualHours", SqlDbType.NVarChar, 50).Value = ActualHours
            cmd.Parameters.Add("@GrossVehicleWeight", SqlDbType.NVarChar, 50).Value = GrossVehicleWeight
            cmd.Parameters.Add("@EstReplacementCost", SqlDbType.Money).Value = EstReplacementCost

            If PlannedComplianceDate Is Nothing Then
                cmd.Parameters.Add("@PlannedComplianceDate", SqlDbType.DateTime).Value = DBNull.Value
            Else
                cmd.Parameters.Add("@PlannedComplianceDate", SqlDbType.DateTime).Value = PlannedComplianceDate
            End If

            If ActualComplianceDate Is Nothing Then
                cmd.Parameters.Add("@ActualComplianceDate", SqlDbType.DateTime).Value = DBNull.Value
            Else
                cmd.Parameters.Add("@ActualComplianceDate", SqlDbType.DateTime).Value = ActualComplianceDate
            End If

            If BackupStatusDate Is Nothing Then
                cmd.Parameters.Add("@BackupStatusDate", SqlDbType.DateTime).Value = DBNull.Value
            Else
                cmd.Parameters.Add("@BackupStatusDate", SqlDbType.DateTime).Value = BackupStatusDate
            End If

            If RetireStatusDate Is Nothing Then
                cmd.Parameters.Add("@RetireStatusDate", SqlDbType.DateTime).Value = DBNull.Value
            Else
                cmd.Parameters.Add("@RetireStatusDate", SqlDbType.DateTime).Value = RetireStatusDate
            End If

            If PlannedRetirementDate Is Nothing Then
                cmd.Parameters.Add("@PlannedRetirementDate", SqlDbType.DateTime).Value = DBNull.Value
            Else
                cmd.Parameters.Add("@PlannedRetirementDate", SqlDbType.DateTime).Value = PlannedRetirementDate
            End If

            If ActualRetirementDate Is Nothing Then
                cmd.Parameters.Add("@ActualRetirementDate", SqlDbType.DateTime).Value = DBNull.Value
            Else
                cmd.Parameters.Add("@ActualRetirementDate", SqlDbType.DateTime).Value = ActualRetirementDate
            End If

            cmd.Connection.Open()
            IDProfileFleet = cmd.ExecuteScalar
            cmd.Connection.Close()

        Next


    End Sub



    Protected Sub btn_Import_Engines_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Import_Engines.Click


        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As New SqlCommand("SELECT * FROM CFV_Import_Engines", conn)
        comm.Connection.Open()

        Dim myDataAdapter As New SqlDataAdapter(comm)
        Dim myDataSet As New DataSet
        Dim dtData As New DataTable
        Dim dtRow As DataRow
        myDataAdapter.Fill(myDataSet)
        conn.Close()

        For Each dtRow In myDataSet.Tables(0).Rows

            Dim IDProfileAccount = dtRow.Item("IDProfileAccount")
            Dim IDVehicles = dtRow.Item("IDVehicles")
            Dim IDEngineManufacturer = dtRow.Item("IDEngineManufacturer")
            Dim EngineModel = dtRow.Item("EngineModel")
            Dim IDEngineStatus = dtRow.Item("IDEngineStatus")
            Dim IDEngineFuelType = dtRow.Item("IDEngineFuelType")
            Dim IDModelYear = dtRow.Item("IDModelYear")
            Dim SerialNum = dtRow.Item("SerialNum")
            Dim FamilyName = dtRow.Item("FamilyName")
            Dim SeriesModelNo = dtRow.Item("SeriesModelNo")
            Dim Horsepower = dtRow.Item("Horsepower")
            Dim Displacement = dtRow.Item("Displacement")
            Dim EstRetrofitCost = dtRow.Item("EstRetrofitCost")

            Dim conn2 As SqlConnection
            Dim cmd As SqlCommand
            Dim strconnection, strsqlinsert As String

            strconnection = (ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
            strsqlinsert = "Insert into CF_Engines ( "
            strsqlinsert += "IDProfileAccount, IDVehicles, IDEngineManufacturer, EngineModel, IDEngineStatus, IDEngineFuelType, IDModelYear, SerialNum, FamilyName, SeriesModelNo, Horsepower, Displacement, EstRetrofitCost"
            strsqlinsert += ")"
            strsqlinsert += " values ("
            strsqlinsert += "@IDProfileAccount, @IDVehicles, @IDEngineManufacturer, @EngineModel, @IDEngineStatus, @IDEngineFuelType, @IDModelYear, @SerialNum, @FamilyName, @SeriesModelNo, @Horsepower, @Displacement, @EstRetrofitCost"
            strsqlinsert += ")"
            strsqlinsert += "; SELECT SCOPE_IDENTITY() ; "

            conn2 = New SqlConnection(strconnection)
            cmd = New SqlCommand(strsqlinsert, conn2)

            cmd.Parameters.Add("@IDProfileAccount", SqlDbType.Int).Value = IDProfileAccount
            cmd.Parameters.Add("@IDVehicles", SqlDbType.Int).Value = IDVehicles
            cmd.Parameters.Add("@IDEngineManufacturer", SqlDbType.Int).Value = IDEngineManufacturer
            cmd.Parameters.Add("@EngineModel", SqlDbType.NVarChar, 50).Value = EngineModel
            cmd.Parameters.Add("@IDEngineStatus", SqlDbType.Int).Value = IDEngineStatus
            cmd.Parameters.Add("@IDEngineFuelType", SqlDbType.Int).Value = IDEngineFuelType
            cmd.Parameters.Add("@IDModelYear", SqlDbType.NVarChar, 50).Value = IDModelYear
            cmd.Parameters.Add("@SerialNum", SqlDbType.NVarChar, 50).Value = SerialNum
            cmd.Parameters.Add("@FamilyName", SqlDbType.NVarChar, 50).Value = FamilyName
            cmd.Parameters.Add("@SeriesModelNo", SqlDbType.NVarChar, 50).Value = SeriesModelNo
            cmd.Parameters.Add("@Horsepower", SqlDbType.NVarChar, 50).Value = Horsepower
            cmd.Parameters.Add("@Displacement", SqlDbType.NVarChar, 50).Value = Displacement
            cmd.Parameters.Add("@EstRetrofitCost", SqlDbType.NVarChar, 50).Value = EstRetrofitCost


            cmd.Connection.Open()
            IDProfileAccount = cmd.ExecuteScalar
            cmd.Connection.Close()

        Next

    End Sub



    Protected Sub btn_Import_DECs_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Import_DECs.Click

        Dim connectionString As String = DirectCast(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString, String)
        Dim conn As New SqlConnection(connectionString)
        Dim comm As New SqlCommand("SELECT * FROM CFV_Import_DECs", conn)
        comm.Connection.Open()

        Dim myDataAdapter As New SqlDataAdapter(comm)
        Dim myDataSet As New DataSet
        Dim dtData As New DataTable
        Dim dtRow As DataRow
        myDataAdapter.Fill(myDataSet)
        conn.Close()

        For Each dtRow In myDataSet.Tables(0).Rows

            Dim IDProfileAccount = dtRow.Item("IDProfileAccount")
            Dim IDEngines = dtRow.Item("IDEngines")
            Dim SerialNo = dtRow.Item("SerialNo")
            Dim DECSName = dtRow.Item("DECSName")
            Dim IDDECSManufacturer = dtRow.Item("IDDECSManufacturer")
            Dim IDDECSLevel = dtRow.Item("IDDECSLevel")
            Dim DECSModelNo = dtRow.Item("DECSModelNo")
            Dim DECSInstallationDate = dtRow.Item("DECSInstallationDate")

            Dim conn2 As SqlConnection
            Dim cmd As SqlCommand
            Dim strconnection, strsqlinsert As String

            strconnection = (ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
            strsqlinsert = "Insert into CF_DECS ( "
            strsqlinsert += "IDProfileAccount, IDEngines, SerialNo, DECSName, IDDECSManufacturer, IDDECSLevel, DECSModelNo, DECSInstallationDate"
            strsqlinsert += ")"
            strsqlinsert += " values ("
            strsqlinsert += "@IDProfileAccount, @IDEngines, @SerialNo, @DECSName, @IDDECSManufacturer, @IDDECSLevel, @DECSModelNo, @DECSInstallationDate"
            strsqlinsert += ")"
            strsqlinsert += "; SELECT SCOPE_IDENTITY() ; "

            conn2 = New SqlConnection(strconnection)
            cmd = New SqlCommand(strsqlinsert, conn2)

            cmd.Parameters.Add("@IDProfileAccount", SqlDbType.Int).Value = IDProfileAccount
            cmd.Parameters.Add("@IDEngines", SqlDbType.Int).Value = IDEngines
            cmd.Parameters.Add("@SerialNo", SqlDbType.VarChar, 50).Value = SerialNo
            cmd.Parameters.Add("@DECSName", SqlDbType.VarChar, 50).Value = DECSName
            cmd.Parameters.Add("@IDDECSManufacturer", SqlDbType.Int).Value = IDDECSManufacturer
            cmd.Parameters.Add("@IDDECSLevel", SqlDbType.Int).Value = IDDECSLevel
            cmd.Parameters.Add("@DECSModelNo", SqlDbType.VarChar, 50).Value = DECSModelNo

            If DECSInstallationDate Is Nothing Then
                cmd.Parameters.Add("@DECSInstallationDate", SqlDbType.DateTime).Value = DBNull.Value
            Else
                cmd.Parameters.Add("@DECSInstallationDate", SqlDbType.DateTime).Value = DECSInstallationDate
            End If

            cmd.Connection.Open()
            IDProfileAccount = cmd.ExecuteScalar
            cmd.Connection.Close()

        Next

    End Sub


End Class