--Araco exec [dbo].[ReportOpacityTesting] 1124,1537
CREATE PROCEDURE [dbo].[ReportOpacityTesting]

	@IDProfileTerminal	int = 0,
	@IDProfileFleet		int = 0

AS

BEGIN

	SELECT
		/*CF_Profile_Terminal.TerminalName + '/' + CF_Profile_Fleet.FleetName [Location],*/
		CF_Vehicles.LicensePlateNo [License Plate],
		RTRIM(LTRIM(CF_Vehicles.UnitNo)) [Unit No.],
		/*ISNULL([VehicleYear].DisplayValue, '') [Model Year],
		ISNULL([VehicleMake].DisplayValue, '') [Make],*/
		/*[dbo].[GetIDOptionListDisplayName](CF_Vehicles.IDChassisModelYear) AS  [Model Year],*/
		[dbo].[GetIDOptionListDisplayName](CF_Vehicles.IDChassisMake) AS  [Make],
		/*ISNULL(CF_Vehicles.ActualMiles, '') [Mileage],*/
		/*ISNULL([EngineManufacturer].DisplayValue, '') [Engine Manufacturer],*/
		[dbo].[GetIDOptionListDisplayName](CF_Engines.IDEngineManufacturer) AS  [Engine Manufacturer],
		ISNULL([dbo].[GetIDOptionListDisplayName](CF_Engines.IDModelYear),'') AS  [Engine MY],
		/*ISNULL([EngineYear].DisplayValue, '') [Engine MY],*/
		ISNULL(CF_Engines.Horsepower, '') [Horsepower],
		ISNULL([DECSLevel].DisplayValue, '') [DECS Level]
	FROM
		CF_Profile_Terminal INNER JOIN CF_Profile_Fleet ON
				CF_Profile_Terminal.IDProfileTerminal = CF_Profile_Fleet.IDProfileTerminal
			INNER JOIN CF_Vehicles ON
				CF_Profile_Fleet.IDProfileFleet = CF_Vehicles.IDProfileFleet
			LEFT JOIN CF_Engines ON
				CF_Vehicles.IDVehicles = CF_Engines.IDVehicles AND
				CF_Profile_Terminal.IDProfileAccount = CF_Engines.IDProfileAccount
				
			LEFT JOIN CF_Option_List [VehicleStatus] ON
				CF_Vehicles.IDVehicleStatus = [VehicleStatus].IDOptionList AND
				[VehicleStatus].OptionName = 'VehicleStatus'
			LEFT JOIN CF_Option_List [EngineStatus] ON
				CF_Engines.IDEngineStatus = [EngineStatus].IDOptionList AND
				[EngineStatus].OptionName = 'EngineStatus'
			LEFT JOIN CF_DECS ON
				CF_Engines.IDEngines = CF_DECS.IDEngines
			LEFT JOIN CF_Option_List [DECSLevel] ON
				CF_DECS.IDDECSLevel = [DECSLevel].IDOptionList AND
				[DECSLevel].OptionName = 'DECSLevel'
	WHERE
		[CF_Engines].IDEngineFuelType = 375 AND --PT 20180123 only diesel engines per Jared 
		[VehicleStatus].RecordValue IN ('In Use', 'Low Use') AND -- MG 2017-01-18 - Added 'Low Use'
		[EngineStatus].RecordValue IN ('In Use', 'Low Use') AND -- MG 2017-01-18 - Added 'Low Use'
		-- 2016-05-23 MG - Only return Vehicles belongin to one of the following groups
		UPPER([dbo].[GetIDOptionListDisplayName](CF_Vehicles.IDCARBGroup)) IN ('14,000 GVWR OR LESS', 'CHE', 'GROUP 1', 'GROUP 2', 'GROUP 3', 'GROUP 4', 'ON ROAD', 'TRANSIT FLEET VEHICLE', 'URBAN BUS')
		AND CF_Profile_Terminal.IDProfileTerminal = @IDProfileTerminal AND
		CF_Vehicles.IDProfileFleet =
			CASE
				WHEN @IDProfileFleet = 0 THEN CF_Vehicles.IDProfileFleet
				ELSE @IDProfileFleet
			END
	ORDER BY
		/*[Location] ASC,*/
		RIGHT(REPLICATE('0', 50) + CF_Vehicles.UnitNo, 50)
		
END


