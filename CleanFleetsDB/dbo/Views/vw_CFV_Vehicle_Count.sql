CREATE VIEW [dbo].[vw_CFV_Vehicle_Count]
AS
SELECT     COUNT(dbo.CF_Vehicles.IDVehicles) AS Count, dbo.CF_Profile_Fleet.IDProfileFleet
FROM         dbo.CF_Profile_Account INNER JOIN
                      dbo.CF_Profile_Terminal ON dbo.CF_Profile_Account.IDProfileAccount = dbo.CF_Profile_Terminal.IDProfileAccount INNER JOIN
                      dbo.CF_Profile_Fleet ON dbo.CF_Profile_Terminal.IDProfileTerminal = dbo.CF_Profile_Fleet.IDProfileTerminal INNER JOIN
                      dbo.CF_Vehicles ON dbo.CF_Profile_Fleet.IDProfileFleet = dbo.CF_Vehicles.IDProfileFleet
GROUP BY dbo.CF_Profile_Fleet.IDProfileFleet
