
CREATE PROCEDURE [dbo].[ReportOpacityTestingResults]

	@IDProfileAccount int = 0,
	@IDProfileTerminal	int = 0,
	@IDProfileFleet		int = 0,
	@FromDate date = NULL,
	@ThroughDate date = NULL

AS

BEGIN

	SELECT
		CF_Profile_Terminal.TerminalName + '/' + CF_Profile_Fleet.FleetName [Location],
		RTRIM(LTRIM(CF_Vehicles.UnitNo)) [Unit No.],
		CF_Vehicles.ChassisVIN [VIN],
		CF_Vehicles.LicensePlateNo [License Plate],
		[dbo].[GetIDOptionListDisplayName](CF_Vehicles.IDChassisMake) AS  [Vehicle Make],
		[dbo].[GetIDOptionListDisplayName](CF_Engines.IDEngineManufacturer) AS  [Engine Manufacturer],
		[dbo].[GetIDOptionListDisplayName](CF_Engines.IDModelYear) AS [Engine Model Year],
		/*ISNULL(CF_Vehicles.ActualMiles, '') [Mileage],*/
		--[dbo].[GetIDOptionListDisplayName](CF_Engines.IDEngineManufacturer) AS [Engine Manufacturer],
		--[dbo].[GetIDOptionListDisplayName](CF_Engines.IDModelYear) AS [Engine MY],
		--ISNULL(CF_Engines.Horsepower, '') [Horsepower],
		[dbo].[GetIDOptionListDisplayName](CF_DECS.IDDECSLevel) AS [DECS Level],
		UPPER(LEFT(PSIP2.TestResult, 1)) + LOWER(SUBSTRING(PSIP2.TestResult, 2, LEN(PSIP2.TestResult)-1)) AS [Pass/Fail],
		PSIP2.AverageOpacity as [Test Avg (%)],
		PSIP2.TestDate AS [Date Tested],
		PSIP2.TestedBy AS [Tester],
		Mileage.Mileage
	FROM CF_Profile_Terminal 
		INNER JOIN CF_Profile_Fleet ON CF_Profile_Terminal.IDProfileTerminal = CF_Profile_Fleet.IDProfileTerminal
		INNER JOIN CF_Vehicles ON CF_Profile_Fleet.IDProfileFleet = CF_Vehicles.IDProfileFleet
		LEFT JOIN CF_Engines ON	CF_Vehicles.IDVehicles = CF_Engines.IDVehicles AND
			CF_Profile_Terminal.IDProfileAccount = CF_Engines.IDProfileAccount
			AND [dbo].[GetIDOptionListDisplayName](CF_Engines.IDEngineStatus) = 'In Use' 
		LEFT JOIN CF_DECS ON CF_Engines.IDEngines = CF_DECS.IDEngines
		LEFT JOIN CF_Option_List [VehicleStatus] ON	CF_Vehicles.IDVehicleStatus = [VehicleStatus].IDOptionList AND
			[VehicleStatus].OptionName = 'VehicleStatus'
		LEFT JOIN CF_Option_List [EngineFuelType] ON	CF_Engines.IDEngineFuelType = [EngineFuelType].IDOptionList AND
		  [EngineFuelType].OptionName = 'EngineFuelType'
		LEFT JOIN CF_Option_List [CARBGroup] ON	CF_Vehicles.IDCARBGroup = [CARBGroup].IDOptionList AND
			[CARBGroup].OptionName = 'CARBGroup'
		/*LEFT JOIN CF_Option_List [EngineStatus] ON CF_Engines.IDEngineStatus = [EngineStatus].IDOptionList AND
			[EngineStatus].OptionName = 'EngineStatus'*/
		OUTER APPLY (SELECT TOP 1 * 
			FROM CF_Vehicles_Log_OpacityTests PSIP
			WHERE (@FromDate IS NULL OR TestDate > @FromDate)
			AND (@ThroughDate IS NULL OR TestDate <= @ThroughDate )
			AND (CF_Vehicles.ActualRetirementDate IS NULL OR TestDate <= CF_Vehicles.ActualRetirementDate)
			AND (IDVehicles = CF_Vehicles.IDVehicles)
			ORDER BY TestDate
		  ) AS PSIP2  -- creative TOP 1 per Vehicle
		LEFT JOIN CF_Vehicles_Log_Mileage Mileage ON Mileage.IDVehicles = CF_Vehicles.IDVehicles
		  AND Mileage.MileageDate = PSIP2.TestDate

	WHERE
	    -- ADS 2016-12-06 Currently we don't keep track of EVERY status change on 
		-- every vehicle, so we can't reliably check what a vehicles's status was when the 
		-- test was run. WE only track when a vehicle was retired, moved to back-up, etc.
		-- In the future, if they need more historical data, they may need a status change table.
		( [VehicleStatus].RecordValue IN ('In Use', 'Light Use', 'Back Up', 'Low Use') AND
		CF_Profile_Terminal.IDProfileAccount = @IDProfileAccount AND
		@IDProfileTerminal IN (0, CF_Profile_Terminal.IDProfileTerminal) AND
		@IDProfileFleet IN (0, CF_Vehicles.IDProfileFleet) AND
		([CF_Engines].[IDEngines] IS NULL OR [EngineFuelType].RecordValue IN ('Diesel')) AND
		[CARBGroup].RecordValue IN ('14,000 GVWR or less', 'Urban Bus', 'PAU', 'TRU', 'Group 1', 'Group 2', 'Group 3', 'Group 4', 'On Road', 'Transit Fleet Vehicle', 'CHE'))
		
	ORDER BY
		[Location] ASC,
		RIGHT(REPLICATE('0', 50) + CF_Vehicles.UnitNo, 50)
END

/*


 -- ADS 2016-12-06 Currently we don't keep track of EVERY status change on 
		-- every vehicle, so we can't reliably check what a vehicles's status was when the 
		-- test was run. WE only track when a vehicle was retired, moved to back-up, etc.
		-- In the future, if they need more historical data, they may need a status change table.
		( [VehicleStatus].RecordValue IN ('In Use', 'Light Use', 'Back Up', 'Low Use') OR
		  [VehicleStatus].RecordValue = 'Retired' AND 
		  -- 2016-12-06 ADS This seems redundant since the test date would be less than the retire status
		  -- date and that would have to be higher than the through date, but it might make the query size
		  -- smaller.
		  ( @FromDate Is NULL OR [CF_Vehicles].ActualRetirementDate IS NULL OR [CF_Vehicles].ActualRetirementDate > @FromDate) ) AND
		CF_Profile_Terminal.IDProfileAccount = @IDProfileAccount AND
		@IDProfileTerminal IN (0, CF_Profile_Terminal.IDProfileTerminal) AND
		@IDProfileFleet IN (0, CF_Vehicles.IDProfileFleet) AND
		([CF_Engines].[IDEngines] Is NULL OR [EngineFuelType].RecordValue IN ('Diesel')) AND
		[CARBGroup].RecordValue IN ('14,000 GVWR or less', 'Urban Bus', 'PAU', 'TRU', 'Group 1', 'Group 2', 'Group 3', 'Group 4', 'On Road', 'Transit Fleet Vehicle', 'CHE') AND
		1=1



*/