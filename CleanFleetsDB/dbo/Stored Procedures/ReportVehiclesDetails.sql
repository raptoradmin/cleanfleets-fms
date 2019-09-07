



CREATE PROCEDURE [dbo].[ReportVehiclesDetails]
    @IDProfileFleet  int = null,
    @IDProfileAccount int = null,
    @IDProfileTerminal int = null,
    @IDCarbGroup int = null,
    @IDRuleCode int = null,
    @UserID uniqueidentifier = null
AS
BEGIN

	DECLARE @FileTypes TABLE (
		id int NOT NULL,
		FileType varchar(30)
	);
	

	
	SELECT 
		dbo.CF_Vehicles.IDVehicles,
		dbo.CF_Vehicles.UnitNo,
		dbo.CF_Vehicles.LicensePlateState,
		dbo.CF_Vehicles.LicensePlateNo,
		dbo.CF_Vehicles.ChassisVIN,
		dbo.CF_Vehicles.AnnualMiles,
		dbo.CF_Vehicles.AnnualHours,
		dbo.CF_Vehicles.ActualMiles,
		dbo.CF_Vehicles.ActualHours,
		dbo.CF_Vehicles.GrossVehicleWeight,
		dbo.CF_Vehicles.ActualInServiceDate,
		dbo.CF_Vehicles.EstimatedInServiceDate,
		dbo.CF_Vehicles.PlannedComplianceDate,
		dbo.CF_Vehicles.ActualComplianceDate,
		dbo.CF_Vehicles.LastOpacityTestDate,
		dbo.CF_Vehicles.BackupStatusDate,
		dbo.CF_Vehicles.RetireStatusDate,
		dbo.CF_Vehicles.EstReplacementCost,
		dbo.CF_Vehicles.Notes,
		dbo.CF_Vehicles.PlannedRetirementDate,
		dbo.CF_Vehicles.ActualRetirementDate,
		--dbo.GetIDOptionListRecordValue(dbo.CF_Vehicles.IDWeightDefinition) AS WeightDefinition,
		dbo.CF_Profile_Fleet.FleetName,
		dbo.CF_Profile_Terminal.TerminalName,
		dbo.CF_Profile_Account.AccountName,
		dbo.CF_Engines.SerialNum,
		dbo.CF_Engines.SeriesModelNo,
		dbo.CF_Engines.Horsepower,
		dbo.CF_Engines.Displacement,
		dbo.CF_Engines.EstRetrofitCost,
		dbo.CF_Engines.FamilyName,
		dbo.CF_Engines.EngineModel,
		dbo.CF_DECS.DECSName,
		dbo.CF_DECS.SerialNo,
		dbo.CF_DECS.DECSModelNo,
		dbo.CF_DECS.DECSInstallationDate,
		_WeightDefinition.DisplayValue AS WeightDefinition,
		_EquipmentType.DisplayValue AS EquipmentType,
		_VehicleStatus.DisplayValue AS VehicleStatus,
		_CARBGroup.DisplayValue AS CARBGroup,
		_ChassisMake.DisplayValue AS ChassisMake,
		_ChassisModelYear.DisplayValue AS ChassisModelYear,
		_SpecialProvision.DisplayValue AS SpecialProvision,
		_EngineStatus.DisplayValue AS EngineStatus,
		_EngineFuelType.DisplayValue AS EngineFuelType,
		_EngineManufacturer.DisplayValue AS EngineManufacturer,
		_ModelYear.DisplayValue AS ModelYear,
		_EngineStatus.DisplayValue AS EngineStatus,
		_EngineFuelType.DisplayValue AS EngineFuelType,
		_EngineManufacturer.DisplayValue AS DisplayValue,
		_ModelYear.DisplayValue AS ModelYear,
		_DECSManufacturer.DisplayValue AS DECSManufacturer,
		_DECSLevel.DisplayValue AS DECSLevel,
		_RuleCode.DisplayValue AS RuleCode,
		_RuleCode.IDOptionList AS IDRuleCode,
		(SELECT COUNT(*) FROM dbo.CF_Files WHERE dbo.CF_Files.IDVehicles = dbo.CF_Vehicles.IDVehicles AND CF_Files.IDDocumentType = 636 ) as ComplianceCertCount, 
		(SELECT COUNT(*) FROM dbo.CF_Files WHERE dbo.CF_Files.IDVehicles = dbo.CF_Vehicles.IDVehicles AND CF_Files.IDDocumentType = 637 ) as FleetSummaryCount, 
		(SELECT COUNT(*) FROM dbo.CF_Files WHERE dbo.CF_Files.IDVehicles = dbo.CF_Vehicles.IDVehicles AND CF_Files.IDDocumentType = 655 ) as OpacityTestCount,
		(SELECT COUNT(*) FROM dbo.CF_Files WHERE dbo.CF_Files.IDVehicles = dbo.CF_Vehicles.IDVehicles AND CF_Files.IDDocumentType IS NULL ) as UnspecifiedFileCount

	FROM dbo.CF_Vehicles
	

	
	INNER JOIN CF_Profile_Fleet
		ON dbo.CF_Vehicles.IDProfileFleet = dbo.CF_Profile_Fleet.IDProfileFleet
	INNER JOIN CF_Profile_Terminal
		ON dbo.CF_Profile_Fleet.IDProfileTerminal = dbo.CF_Profile_Terminal.IDProfileTerminal
	INNER JOIN CF_Profile_Account
		ON dbo.CF_Profile_Terminal.IDProfileAccount = dbo.CF_Profile_Account.IDProfileAccount
	
	LEFT OUTER JOIN CF_Option_List AS _WeightDefinition
		ON dbo.CF_Vehicles.IDWeightDefinition = _WeightDefinition.IDOptionList
	LEFT OUTER JOIN dbo.CF_Option_List AS _EquipmentType
		ON dbo.CF_Vehicles.IDEquipmentType = _EquipmentType.IDOptionList
	LEFT OUTER JOIN dbo.CF_Option_List AS _VehicleStatus
		ON dbo.CF_Vehicles.IDVehicleStatus = _VehicleStatus.IDOptionList
	LEFT OUTER JOIN dbo.CF_Option_List AS _CARBGroup
		ON dbo.CF_Vehicles.IDCARBGroup = _CARBGroup.IDOptionList
	LEFT OUTER JOIN dbo.CF_Option_List AS _ChassisMake
		ON dbo.CF_Vehicles.IDChassisMake = _ChassisMake.IDOptionList
	LEFT OUTER JOIN dbo.CF_Option_List AS _ChassisModelYear
		ON dbo.CF_Vehicles.IDChassisModelYear = _ChassisModelYear.IDOptionList
	LEFT OUTER JOIN dbo.CF_Option_List AS _SpecialProvision
		ON dbo.CF_Vehicles.IDSpecialProvision = _SpecialProvision.IDOptionList
	LEFT OUTER JOIN dbo.CF_Option_List AS _RuleCode
		ON dbo.CF_Profile_Fleet.IDRuleCode = _RuleCode.IDOptionList 
		
	LEFT OUTER JOIN (
		dbo.CF_Engines
		LEFT OUTER JOIN dbo.CF_Option_List AS _EngineStatus
			ON dbo.CF_Engines.IDEngineStatus = _EngineStatus.IDOptionList
		LEFT OUTER JOIN dbo.CF_Option_List AS _EngineFuelType
			ON dbo.CF_Engines.IDEngineFuelType = _EngineFuelType.IDOptionList	
		LEFT OUTER JOIN dbo.CF_Option_List AS _EngineManufacturer
			ON dbo.CF_Engines.IDEngineManufacturer = _EngineManufacturer.IDOptionList
		LEFT OUTER JOIN dbo.CF_Option_List AS _ModelYear
			ON dbo.CF_Engines.IDModelYear = _ModelYear.IDOptionList
		)
		ON dbo.CF_Vehicles.IDVehicles = dbo.CF_Engines.IDVehicles
		
	LEFT OUTER JOIN (
		dbo.CF_DECS
		LEFT OUTER JOIN dbo.CF_Option_List AS _DECSManufacturer
			ON dbo.CF_DECS.IDDECSManufacturer = _DECSManufacturer.IDOptionList
		LEFT OUTER JOIN dbo.CF_Option_List AS _DECSLevel
			ON dbo.CF_DECS.IDDECSLevel = _DECSLevel.IDOptionList
		)
		ON dbo.CF_Engines.IDEngines = dbo.CF_DECS.IDEngines
		

	
	WHERE
		ISNULL(@IDProfileFleet,0) IN (0, CF_Vehicles.IDProfileFleet)
		AND  ISNULL(@IDProfileAccount,0) IN (0, CF_Profile_Terminal.IDProfileAccount)
		AND  ISNULL(@IDProfileTerminal,0) IN (0, CF_Profile_Terminal.IDProfileTerminal)
		AND  ISNULL(@IDCarbGroup,0) IN (0, ISNULL(CF_Vehicles.IDCARBGroup, 0))
		AND  ISNULL(@IDRuleCode,0) IN (0, ISNULL(CF_Profile_Fleet.IDRuleCode, 0))
		AND ((@UserID IS NULL) OR ([dbo].[GetTerminalPermission](CF_Profile_Terminal.IDProfileTerminal, @UserId) IN ('A','B')))
		
END



