











CREATE VIEW [dbo].[CFV_Report_Vehicles_Details]
AS
SELECT     TOP (100) PERCENT dbo.CFV_Vehicles.TerminalName, dbo.CFV_Vehicles.IDVehicles, 
					  dbo.CFV_Vehicles.IDProfileAccount,dbo.CFV_Vehicles.AccountName, dbo.CFV_Vehicles.IDProfileTerminal, dbo.CFV_Vehicles.IDProfileFleet, 
					  dbo.CFV_Vehicles.FleetName, dbo.CFV_Vehicles.EquipmentType, dbo.CFV_Vehicles.EquipmentCategory, dbo.CFV_Vehicles.ChassisModel,
                      dbo.CFV_Vehicles.VehicleStatus, dbo.CFV_Vehicles.CARBGroup, dbo.CFV_Vehicles.IDCARBGroup, dbo.CFV_Vehicles.ChassisMake, dbo.CFV_Vehicles.ChassisModelYear, 
                      dbo.CFV_Vehicles.LicensePlateState, dbo.CFV_Vehicles.LicensePlateNo, dbo.CFV_Vehicles.ChassisVIN, dbo.CFV_Vehicles.UnitNo, dbo.CFV_Vehicles.AnnualMiles, dbo.CFV_Vehicles.AnnualHours, 
                      dbo.CFV_Vehicles.ActualMiles, dbo.CFV_Vehicles.ActualHours, dbo.CFV_Vehicles.GrossVehicleWeight, dbo.CFV_Vehicles.WeightDefinition, dbo.CFV_Vehicles.PlannedComplianceDate, 
                      dbo.CFV_Vehicles.ActualComplianceDate, dbo.CFV_Vehicles.BackupStatusDate, dbo.CFV_Vehicles.RetireStatusDate, dbo.CFV_Vehicles.EstReplacementCost, 
                      dbo.CFV_Vehicles.PlannedRetirementDate, dbo.CFV_Vehicles.ActualRetirementDate, dbo.CFV_Engines.IDEngines, dbo.CFV_Engines.EngineManufacturer, 
                      dbo.CFV_Engines.EngineModel, dbo.CFV_Engines.EngineStatus, dbo.CFV_Engines.EngineFuelType, dbo.CFV_Engines.ModelYear, dbo.CFV_Engines.SerialNum, 
                      dbo.CFV_Engines.FamilyName, dbo.CFV_Engines.SeriesModelNo, dbo.CFV_Engines.Horsepower, dbo.CFV_Engines.Displacement, dbo.CFV_Engines.EstRetrofitCost, 
                      dbo.CFV_DECs.IDDECS, dbo.CFV_DECs.DECSName, dbo.CFV_DECs.SerialNo, dbo.CFV_DECs.DECSManufacturer, dbo.CFV_DECs.DECSLevel, 
                      dbo.CFV_Vehicles.InServiceDate, dbo.CFV_Vehicles.ActualInServiceDate, dbo.CFV_Vehicles.EstimatedInServiceDate, dbo.CFV_Vehicles.Notes,
                      dbo.CFV_DECs.DECSModelNo, dbo.CFV_DECs.DECSInstallationDate,
                      dbo.CFV_Engines.ModelYear AS EngineModelYear,
                      dbo.CFV_Vehicles.SpecialProvision,
                      dbo.CF_Profile_Fleet.IDRuleCode
FROM         dbo.CFV_Vehicles 
  LEFT OUTER JOIN dbo.CF_Profile_Fleet ON dbo.CFV_Vehicles.IDProfileFleet = dbo.CF_Profile_Fleet.IDProfileFleet
  LEFT OUTER JOIN dbo.CFV_Engines ON dbo.CFV_Vehicles.IDVehicles = dbo.CFV_Engines.IDVehicles
  LEFT OUTER JOIN dbo.CFV_DECs ON dbo.CFV_Engines.IDEngines = dbo.CFV_DECs.IDEngines
WHERE     (dbo.CFV_Vehicles.IDVehicles IS NOT NULL)
ORDER BY dbo.CFV_Vehicles.IDVehicles












