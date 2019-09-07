CREATE VIEW [dbo].[CFV_Join_V_E_D]
AS
SELECT        dbo.CF_Vehicles.IDVehicles, dbo.CF_Engines.IDEngines, dbo.CF_DECS.IDDECS, dbo.CF_Vehicles.UnitNo, dbo.CF_Vehicles.ChassisVIN, 
                         dbo.CF_Vehicles.LicensePlateState, dbo.CF_Vehicles.LicensePlateNo
FROM            dbo.CF_DECS RIGHT OUTER JOIN
                         dbo.CF_Engines ON dbo.CF_DECS.IDEngines = dbo.CF_Engines.IDEngines RIGHT OUTER JOIN
                         dbo.CF_Vehicles ON dbo.CF_Engines.IDVehicles = dbo.CF_Vehicles.IDVehicles
