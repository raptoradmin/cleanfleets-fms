
CREATE PROCEDURE [dbo].[ReportRequiresOpacityTesting]

	@IDProfileAccount	int

AS

BEGIN

	SELECT
		CF_Profile_Terminal.TerminalName [Terminal Name],
		CF_Profile_Fleet.FleetName [Fleet Name],
		CF_Vehicles.UnitNo [Unit Number],
		CF_Vehicles.ChassisVIN [VIN],
		CF_Vehicles.LicensePlateNo [License Plate Number],
		CF_Vehicles.LicensePlateState [License Plate State],
		[VehicleStatus].RecordValue [Vehicle Status],
		CONVERT(varchar(20), CF_Vehicles.LastOpacityTestDate, 101 ) [Last Opacity Test Date],
		[CARBGroup].RecordValue [CARB Group]
	FROM
		CF_Profile_Terminal INNER JOIN CF_Profile_Fleet ON
				CF_Profile_Terminal.IDProfileTerminal = CF_Profile_Fleet.IDProfileTerminal
			INNER JOIN CF_Vehicles ON
				CF_Profile_Fleet.IDProfileFleet = CF_Vehicles.IDProfileFleet
			LEFT JOIN CF_Option_List [VehicleStatus] ON
				CF_Vehicles.IDVehicleStatus = [VehicleStatus].IDOptionList AND
				[VehicleStatus].OptionName = 'VehicleStatus'
			LEFT JOIN CF_Option_List [CARBGroup] ON
				CF_Vehicles.IDCARBGroup = [CARBGroup].IDOptionList AND
				[CARBGroup].OptionName = 'CARBGroup'
	WHERE
		LOWER([VehicleStatus].RecordValue) IN('in use','low use') AND
		CF_Profile_Terminal.IDProfileAccount = @IDProfileAccount
	ORDER BY
		CF_Profile_Terminal.TerminalName,
		CF_Profile_Fleet.FleetName,
		CF_Vehicles.UnitNo
		
END



