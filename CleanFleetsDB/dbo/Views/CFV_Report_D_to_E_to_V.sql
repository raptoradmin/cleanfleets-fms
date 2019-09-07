


CREATE VIEW [dbo].[CFV_Report_D_to_E_to_V]
AS
SELECT     CAST(dbo.CFV_Report_Vehicle.IDVehicles AS NVarChar(36)) AS IDVehicles, dbo.CFV_Report_Engine.IDEngines, dbo.CFV_Report_Engine.SerialNum, 
                      dbo.CFV_Report_Engine.FamilyName, dbo.CFV_Report_Engine.SeriesModelNo, dbo.CFV_Report_Engine.Horsepower, dbo.CFV_Report_Engine.Hours, 
                      dbo.CFV_Report_Engine.Miles, dbo.CFV_Report_Engine.EngineManufacturer, dbo.CFV_Report_Engine.EngineModel, dbo.CFV_Report_Engine.EngineStatus, 
                      dbo.CFV_Report_Engine.EngineFuelType, dbo.CFV_Report_Engine.ModelYear, dbo.CFV_Report_DECS.IDDECS, dbo.CFV_Report_DECS.SerialNo, 
                      dbo.CFV_Report_DECS.DECSName, dbo.CFV_Report_DECS.IDDECSManufacturer, dbo.CFV_Report_DECS.DECSManufacturer, dbo.CFV_Report_DECS.IDDECSLevel, 
                      dbo.CFV_Report_DECS.DECSLevel, dbo.CFV_Report_DECS.DECSInstallationDate, ISNULL(dbo.CFV_Images_Default_Engines.Image, '~/images/noimage.gif') 
                      AS ImageEngine, ISNULL(dbo.CFV_Images_Default_DECS.Image, '~/images/noimage.gif') AS ImageDECS, dbo.CFV_Report_Engine.Displacement, 
                      dbo.CFV_Report_Vehicle.IDProfileFleet, dbo.CFV_Report_Vehicle.UnitNo, dbo.CFV_Report_Vehicle.ChassisVIN, dbo.CFV_Report_Vehicle.GrossVehicleWeight,
                      dbo.CFV_Report_Vehicle.WeightDefinition, dbo.CFV_Report_Vehicle.ChassisModelYear, dbo.CFV_Report_Vehicle.SpecialProvision,
                      dbo.CFV_Report_Vehicle.RuleCode, dbo.CFV_Report_Vehicle.CARBGroup, dbo.CFV_Report_Vehicle.IDCARBGroup, dbo.CFV_Report_Vehicle.RetireStatusDate, 
                      ISNULL(dbo.CFV_Images_Default_Vehicles.Image, '~/images/noimage.gif') AS ImageVehicle, dbo.CFV_Report_Vehicle.PlannedComplianceDate, 
                      dbo.CFV_Report_Vehicle.ActualComplianceDate, dbo.CFV_Report_Vehicle.VehicleStatus
FROM         dbo.CFV_Images_Default_Vehicles RIGHT OUTER JOIN
                      dbo.CFV_Report_Vehicle ON dbo.CFV_Images_Default_Vehicles.IDVehicles = dbo.CFV_Report_Vehicle.IDVehicles LEFT OUTER JOIN
                      dbo.CFV_Report_DECS RIGHT OUTER JOIN
                      dbo.CFV_Report_Engine ON dbo.CFV_Report_DECS.IDEngines = dbo.CFV_Report_Engine.IDEngines ON 
                      dbo.CFV_Report_Vehicle.IDVehicles = dbo.CFV_Report_Engine.IDVehicles LEFT OUTER JOIN
                      dbo.CFV_Images_Default_DECS ON dbo.CFV_Report_DECS.IDDECS = dbo.CFV_Images_Default_DECS.IDDECS LEFT OUTER JOIN
                      dbo.CFV_Images_Default_Engines ON dbo.CFV_Report_Engine.IDEngines = dbo.CFV_Images_Default_Engines.IDEngines



