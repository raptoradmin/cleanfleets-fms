



CREATE PROCEDURE [dbo].[VehiclesByCarbGroupForCSVExport] (
	@IDProfileAccount int,
	@UserId uniqueidentifier)
AS
BEGIN

	SELECT AccountName, T.TerminalName, F.FleetName, UnitNo, LicensePlateState, LicensePlateNo, ChassisVin, EquipmentType, 
		SpecialProvision, VehicleStatus, CARBGroup, ChassisMake, ChassisModel, ChassisModelYear, AnnualMiles, AnnualHours, 
		ActualMiles, ActualHours, GrossVehicleWeight, CONVERT(VARCHAR(10), InServiceDate, 23) AS InServiceDate, 
		CONVERT(VARCHAR(10), ActualInServiceDate, 23) AS ActualInServiceDate, CONVERT(VARCHAR(10), EstimatedInServiceDate, 23) AS EstimatedInServiceDate, 
		CONVERT(VARCHAR(10), PlannedComplianceDate, 23) AS PlannedComplianceDate, CONVERT(VARCHAR(10), ActualComplianceDate, 23) AS ActualComplianceDate,
		CONVERT(VARCHAR(10), BackupStatusDate, 23) AS BackupStatusDate, CONVERT(VARCHAR(10), RetireStatusDate, 23) AS RetireStatusDate, 
		EstReplacementCost, RVD.Notes, CONVERT(VARCHAR(10), PlannedRetirementDate, 23) AS PlannedRetirementDate, CONVERT(VARCHAR(10), ActualRetirementDate, 23) AS ActualRetirementDate, 
		EngineManufacturer, EngineModel, EngineStatus, EngineFuelType, ModelYear, 
		SerialNum AS EngineSerialNum, FamilyName, SeriesModelNo, Horsepower, Displacement, EstRetrofitCost, DECSName, SerialNo AS DECSSerialNo, DECSManufacturer, 
		DECSLevel, DECSModelNo, CONVERT(VARCHAR(10), DECSInstallationDate, 23) AS DECSInstallationDate 
	FROM [CFV_Report_Vehicles_Details] RVD 
	INNER JOIN CF_Profile_Fleet F ON RVD.IDProfileFleet = F.IDProfileFleet 
	INNER JOIN CF_Profile_Terminal T ON F.IDProfileTerminal = T.IDProfileTerminal 
	WHERE ISNULL(@IDProfileAccount,0) IN (0, T.IDProfileAccount) 
	--AND ISNULL(@IDProfileTerminal,0) IN (0, T.IDProfileTerminal)  
	--AND ISNULL(@IDProfileFleet,0) IN (0, F.IDProfileFleet)
	--AND ISNULL(@IDCARBGroup,0) IN (0, ISNULL(IDCARBGroup,0))
	--AND ISNULL(@IDRuleCode,0) IN (0, ISNULL(F.IDRuleCode,0)) 
	AND [dbo].[GetTerminalPermission](T.IDProfileTerminal, @UserId) IN ('A','B') 
	ORDER BY CARBGroup
	

END






