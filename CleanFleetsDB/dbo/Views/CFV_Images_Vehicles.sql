CREATE VIEW [dbo].[CFV_Images_Vehicles]
AS
SELECT     TOP (100) PERCENT dbo.CF_Profile_Account.AccountName, dbo.CF_Profile_Terminal.TerminalName, dbo.CF_Profile_Fleet.FleetName, dbo.CF_Images.EnterDate, 
                      dbo.CF_Vehicles.IDVehicles, dbo.CF_Vehicles.LicensePlateNo, dbo.CF_Vehicles.ChassisVIN, dbo.CF_Vehicles.UnitNo, dbo.CF_Images.FileName
FROM         dbo.CF_Vehicles INNER JOIN
                      dbo.CF_Images ON dbo.CF_Vehicles.IDVehicles = dbo.CF_Images.IDVehicles INNER JOIN
                      dbo.CF_Profile_Fleet ON dbo.CF_Vehicles.IDProfileFleet = dbo.CF_Profile_Fleet.IDProfileFleet INNER JOIN
                      dbo.CF_Profile_Terminal ON dbo.CF_Profile_Fleet.IDProfileTerminal = dbo.CF_Profile_Terminal.IDProfileTerminal INNER JOIN
                      dbo.CF_Profile_Account ON dbo.CF_Profile_Account.IDProfileAccount = dbo.CF_Profile_Terminal.IDProfileAccount
ORDER BY dbo.CF_Profile_Account.AccountName
