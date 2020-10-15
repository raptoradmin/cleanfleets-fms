Imports System.Web.Security
Imports System.Web.Security.Roles
Imports System.Web.Security.Membership
Imports System.Data
Imports System.Data.SqlClient
Imports Telerik.Web.UI
Imports System.Globalization
Imports System.Text
Public Class vehiclesadd1
    Inherits BaseWebForm

    ' MG 11/22/2011 - Check that the VIN is unique before creating record
    Sub UniqueVINValidator(sender As Object, args As ServerValidateEventArgs)
        Dim conn As SqlConnection
        Dim cmd As SqlCommand
        Dim strconnection, strsqlvalidate As String

        Dim currentUser As MembershipUser = Membership.GetUser()
        Dim currentUserId As Guid = CType(currentUser.ProviderUserKey, Guid)
        Dim count As Integer = 0

        strconnection = (ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
        conn = New SqlConnection(strconnection)

        strsqlvalidate = "SELECT COUNT(*) FROM CF_Vehicles WHERE UPPER(RTRIM(ChassisVIN)) = UPPER(RTRIM(@ChassisVIN)) AND UPPER(RTRIM(ChassisVIN)) > '' "
        cmd = New SqlCommand(strsqlvalidate, conn)
        cmd.Parameters.Add("@ChassisVIN", SqlDbType.VarChar, 50).Value = args.Value
        cmd.Connection.Open()
        count = cmd.ExecuteScalar()
        cmd.Connection.Close()

        args.IsValid = (count = 0)
    End Sub


    ' MG 11/22/2011 - Check that the License Plate Number is unique before creating record
    Sub UniqueLicensePlateNoValidator(sender As Object, args As ServerValidateEventArgs)
        Dim conn As SqlConnection
        Dim cmd As SqlCommand
        Dim strconnection, strsqlvalidate As String
        Dim LicensePlateState As String
        Dim currentUser As MembershipUser = Membership.GetUser()
        Dim currentUserId As Guid = CType(currentUser.ProviderUserKey, Guid)
        Dim count As Integer = 0

        '10/02/2012 IR: Changed code to access retrieve LicensePlateState from the DropDownList on the form
        'the original code was throwing a System.NullReferenceException
        'LicensePlateState = CType(Me.FindControl("ddl_LicensePlateState"), DropDownList).SelectedItem.value
        LicensePlateState = ddl_LicensePlateState.SelectedValue

        strconnection = (ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
        conn = New SqlConnection(strconnection)

        strsqlvalidate = "SELECT COUNT(*) FROM CF_Vehicles WHERE UPPER(RTRIM(LicensePlateNo)) = UPPER(RTRIM(@LicensePlateNo)) " &
          " AND UPPER(RTRIM(LicensePlateState)) = UPPER(RTRIM(@LicensePlateState)) " &
          " AND UPPER(RTRIM(LicensePlateNo)) > '' "
        cmd = New SqlCommand(strsqlvalidate, conn)
        cmd.Parameters.Add("@LicensePlateNo", SqlDbType.VarChar, 50).Value = args.Value
        cmd.Parameters.Add("@LicensePlateState", SqlDbType.VarChar, 2).Value = LicensePlateState
        cmd.Connection.Open()
        count = cmd.ExecuteScalar()
        cmd.Connection.Close()

        args.IsValid = (count = 0)
    End Sub

    Protected Sub btnInsert_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInsert.Click

        Dim IDProfileFleet As String = Request.QueryString("IDProfilefleet")
        Dim IDProfileTerminal As String = Request.QueryString("IDProfileTerminal")
        Dim IDProfileAccount As String = Request.QueryString("IDProfileAccount")

        Dim conn As SqlConnection
        Dim cmd As SqlCommand
        Dim strconnection, strsqlinsert As String

        If Page.IsValid() Then
            Dim currentUser As MembershipUser = Membership.GetUser()
            Dim currentUserId As Guid = CType(currentUser.ProviderUserKey, Guid)
            Dim IDVehicles As Guid = Guid.NewGuid()


            strconnection = (ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ConnectionString)
            strsqlinsert = "Insert into CF_Vehicles ( "
            strsqlinsert += "IDVehicles, ActualRetirementDate, PlannedRetirementDate, EstReplacementCost, IDModifiedUser, ModifiedDate, IDProfileFleet, IDEquipmentType, IDEquipmentCategory, IDVehicleStatus, IDCARBGroup, LicensePlateState, LicensePlateNo, ChassisVIN, IDChassisMake, ChassisModel, IDChassisModelYear, UnitNo, Description, AnnualMiles, AnnualHours, ActualMiles, ActualHours, BasedOutsideCA, GPSEquipped, AllWheelDrive, WeightClassBin, GrossVehicleWeight, PlannedComplianceDate, ActualComplianceDate, BackupStatusDate, RetireStatusDate, Notes, NotesCF, LastOpacityTestDate, IDWeightDefinition"
            strsqlinsert += ")"
            strsqlinsert += " values ("
            strsqlinsert += "@IDVehicles, @ActualRetirementDate, @PlannedRetirementDate, @EstReplacementCost, @IDModifiedUser, @ModifiedDate, @IDProfileFleet, @IDEquipmentType, @IDEquipmentCategory, @IDVehicleStatus, @IDCARBGroup, @LicensePlateState, @LicensePlateNo, @ChassisVIN, @IDChassisMake, @ChassisModel, @IDChassisModelYear, @UnitNo, @Description, @AnnualMiles, @AnnualHours, @ActualMiles, @ActualHours, @BasedOutsideCA, @GPSEquipped, @AllWheelDrive, @WeightClassBin, @GrossVehicleWeight, @PlannedComplianceDate, @ActualComplianceDate, @BackupStatusDate, @RetireStatusDate, @Notes, @NotesCF, @LastOpacityTestDate, @IDWeightDefinition"
            strsqlinsert += ")"
            strsqlinsert += "; SELECT SCOPE_IDENTITY() ; "
            conn = New SqlConnection(strconnection)
            cmd = New SqlCommand(strsqlinsert, conn)

            cmd.Parameters.Add("@IDVehicles", SqlDbType.UniqueIdentifier).Value = IDVehicles
            cmd.Parameters.Add("@IDProfileFleet", SqlDbType.Int).Value = hf_IDProfileFleet.Value
            cmd.Parameters.Add("@UnitNo", SqlDbType.VarChar, 50).Value = tbx_UnitNo.Text
            cmd.Parameters.Add("@LicensePlateState", SqlDbType.Char, 2).Value = ddl_LicensePlateState.Selectedvalue
            cmd.Parameters.Add("@LicensePlateNo", SqlDbType.VarChar, 50).Value = tbx_LicensePlateNo.Text
            cmd.Parameters.Add("@ChassisVIN", SqlDbType.VarChar, 50).Value = tbx_ChassisVIN.Text
            cmd.Parameters.Add("@IDCARBGroup", SqlDbType.Int).Value = ddl_IDCARBGroup.SelectedValue
            cmd.Parameters.Add("@IDChassisModelYear", SqlDbType.Int).Value = ddl_ChassisModelYear.SelectedValue
            cmd.Parameters.Add("@ChassisModel", SqlDbType.VarChar, 50).Value = tbx_ChassisModel.Text
            cmd.Parameters.Add("@IDModifiedUser", SqlDbType.UniqueIdentifier).Value = currentUserId
            cmd.Parameters.Add("@ModifiedDate", SqlDbType.DateTime).Value = DateTime.Now
            cmd.Parameters.Add("@IDEquipmentType", SqlDbType.Int).Value = ddl_IDEquipmentType.SelectedValue
            cmd.Parameters.Add("@IDEquipmentCategory", SqlDbType.Int).Value = ddl_IDEquipmentCategory.SelectedValue
            cmd.Parameters.Add("@IDVehicleStatus", SqlDbType.Int).Value = ddl_IDVehicleStatus.SelectedValue
            cmd.Parameters.Add("@IDChassisMake", SqlDbType.VarChar, 50).Value = ddl_ChassisMake.SelectedValue
            cmd.Parameters.Add("@Description", SqlDbType.VarChar, 8000).Value = tbx_Description.Text
            cmd.Parameters.Add("@AnnualMiles", SqlDbType.VarChar, 50).Value = tbx_AnnualMiles.Text
            cmd.Parameters.Add("@AnnualHours", SqlDbType.VarChar, 50).Value = tbx_AnnualHours.Text
            cmd.Parameters.Add("@ActualMiles", SqlDbType.VarChar, 50).Value = tbx_ActualMiles.Text
            cmd.Parameters.Add("@ActualHours", SqlDbType.VarChar, 50).Value = tbx_ActualHours.Text
            cmd.Parameters.Add("@BasedOutsideCA", SqlDbType.VarChar, 50).Value = ddl_BasedOutsideCA.SelectedValue
            cmd.Parameters.Add("@GPSEquipped", SqlDbType.VarChar, 50).Value = ddl_GPSEquipped.SelectedValue
            cmd.Parameters.Add("@AllWheelDrive", SqlDbType.VarChar, 50).Value = ddl_AllWheelDrive.SelectedValue
            cmd.Parameters.Add("@WeightClassBin", SqlDbType.VarChar, 50).Value = ddl_WeightClassBin.SelectedValue
            cmd.Parameters.Add("@EstReplacementCost", SqlDbType.Money).Value = tbx_EstReplacementCost.Text
            cmd.Parameters.Add("@GrossVehicleWeight", SqlDbType.VarChar, 50).Value = tbx_GrossVehicleWeight.Text
            cmd.Parameters.Add("@Notes", SqlDbType.VarChar, 8000).Value = tbx_Notes.Text
            cmd.Parameters.Add("@NotesCF", SqlDbType.VarChar, 8000).Value = tbx_NotesCF.Text

            If rdp_PlannedComplianceDate.SelectedDate Is Nothing Then
                cmd.Parameters.Add("@PlannedComplianceDate", SqlDbType.DateTime).Value = DBNull.Value
            Else
                cmd.Parameters.Add("@PlannedComplianceDate", SqlDbType.DateTime).Value = rdp_PlannedComplianceDate.SelectedDate
            End If
            If rdp_ActualComplianceDate.SelectedDate Is Nothing Then
                cmd.Parameters.Add("@ActualComplianceDate", SqlDbType.DateTime).Value = DBNull.Value
            Else
                cmd.Parameters.Add("@ActualComplianceDate", SqlDbType.DateTime).Value = rdp_ActualComplianceDate.SelectedDate
            End If
            If rdp_BackupStatusDate.SelectedDate Is Nothing Then
                cmd.Parameters.Add("@BackupStatusDate", SqlDbType.DateTime).Value = DBNull.Value
            Else
                cmd.Parameters.Add("@BackupStatusDate", SqlDbType.DateTime).Value = rdp_BackupStatusDate.SelectedDate
            End If
            If rdp_RetireStatusDate.SelectedDate Is Nothing Then
                cmd.Parameters.Add("@RetireStatusDate", SqlDbType.DateTime).Value = DBNull.Value
            Else
                cmd.Parameters.Add("@RetireStatusDate", SqlDbType.DateTime).Value = rdp_RetireStatusDate.SelectedDate
            End If
            If rdp_PlannedRetirementDate.SelectedDate Is Nothing Then
                cmd.Parameters.Add("@PlannedRetirementDate", SqlDbType.DateTime).Value = DBNull.Value
            Else
                cmd.Parameters.Add("@PlannedRetirementDate", SqlDbType.DateTime).Value = rdp_PlannedRetirementDate.SelectedDate
            End If
            If rdp_ActualRetirementDate.SelectedDate Is Nothing Then
                cmd.Parameters.Add("@ActualRetirementDate", SqlDbType.DateTime).Value = DBNull.Value
            Else
                cmd.Parameters.Add("@ActualRetirementDate", SqlDbType.DateTime).Value = rdp_ActualRetirementDate.SelectedDate
            End If

            If rdp_LastOpacityTestDate.SelectedDate Is Nothing Then
                cmd.Parameters.Add("@LastOpacityTestDate", SqlDbType.DateTime).Value = DBNull.Value
            Else
                cmd.Parameters.Add("@LastOpacityTestDate", SqlDbType.DateTime).Value = rdp_LastOpacityTestDate.SelectedDate
            End If

            If hf_fleetsRuleCode.Value = hf_onRoadRuleCode.Value Then
                Dim weight As Integer
                If Integer.TryParse(tbx_GrossVehicleWeight.Text, NumberStyles.AllowThousands, CultureInfo.CurrentCulture, weight) AndAlso weight > 14000 Then
                    If weight <= 26000 Then
                        cmd.Parameters.Add("@IDWeightDefinition", SqlDbType.Int).Value = hf_lightRuleCode.Value
                    Else
                        cmd.Parameters.Add("@IDWeightDefinition", SqlDbType.Int).Value = hf_heavyRuleCode.Value
                    End If
                Else
                    cmd.Parameters.Add("@IDWeightDefinition", SqlDbType.Int).Value = DBNull.Value
                End If
            Else
                cmd.Parameters.Add("@IDWeightDefinition", SqlDbType.Int).Value = DBNull.Value
            End If

            cmd.Connection.Open()
            cmd.ExecuteNonQuery()
            cmd.Connection.Close()

            Dim IDVehicle As String = IDVehicles.ToString

            Response.Redirect("vehiclesdetails.aspx?IDProfileFleet=" & IDProfileFleet & "&IDProfileTerminal=" & IDProfileTerminal & "&IDProfileAccount=" & IDProfileAccount & "&IDVehicles=" & IDVehicle)
        End If
    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        tbx_EstReplacementCost.Text = ("0")
        Dim IDProfilefleet As String = Request.QueryString("IDProfilefleet")
        hf_IDProfileFleet.Value = Request.QueryString("IDProfileFleet")

        Dim cn As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("CF_SQL_Connection").ToString)
        cn.Open()
        Dim SqlCmd As SqlCommand
        SqlCmd = New SqlCommand("SELECT [FleetName] FROM [CF_Profile_Fleet] WHERE IDProfilefleet = " & IDProfilefleet & "", cn)

        lbl_FleetName.Text = CType(SqlCmd.ExecuteScalar, String)


        'The following values are needed for setting the correct WeightDefinition code, if applicable.
        SqlCmd = New SqlCommand("SELECT [IDRuleCode] FROM [CF_Profile_Fleet] WHERE IDProfilefleet = " & IDProfilefleet & "", cn)
        hf_fleetsRuleCode.Value = CType(SqlCmd.ExecuteScalar, Integer)

        SqlCmd = New SqlCommand("SELECT [IDOptionList] FROM [CF_Option_List] WHERE OptionName = 'WeightDefinition' AND RecordValue = 'LighterVehicle'", cn)
        hf_lightRuleCode.Value = CType(SqlCmd.ExecuteScalar, Integer)

        SqlCmd = New SqlCommand("SELECT [IDOptionList] FROM [CF_Option_List] WHERE OptionName = 'WeightDefinition' AND RecordValue = 'HeavierVehicle'", cn)
        hf_heavyRuleCode.Value = CType(SqlCmd.ExecuteScalar, Integer)

        SqlCmd = New SqlCommand("SELECT [IDOptionList] FROM [CF_Option_List] WHERE OptionName = 'RuleCode' AND RecordValue = 'On Road'", cn)
        hf_onRoadRuleCode.Value = CType(SqlCmd.ExecuteScalar, Integer)

        cn.Close()

    End Sub

    Protected Sub PreventErrorOnbinding(sender As Object, e As EventArgs)
        ' if the selected option is no longer in the list, it'll throw problems.  This will set the value to the first item in the select list (should be "Select")
        Dim theDropDownList As DropDownList = CType(sender, DropDownList)
        RemoveHandler theDropDownList.DataBinding, AddressOf Me.PreventErrorOnbinding
        theDropDownList.AppendDataBoundItems = True
        Try
            theDropDownList.DataBind()
        Catch exc As ArgumentOutOfRangeException

            theDropDownList.SelectedValue = theDropDownList.Items(0).Value
        End Try
    End Sub

End Class