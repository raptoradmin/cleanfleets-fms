CREATE VIEW [dbo].[CFV_Vehicles_by_Account]
AS
SELECT     dbo.CF_Profile_Account.AccountName, dbo.CF_Profile_Terminal.TerminalName, dbo.CF_Profile_Fleet.FleetName, dbo.CF_Vehicles.UnitNo, 
                      dbo.CF_Vehicles.LicensePlateState, dbo.CF_Vehicles.LicensePlateNo
FROM         dbo.CF_Profile_Account INNER JOIN
                      dbo.CF_Profile_Terminal ON dbo.CF_Profile_Account.IDProfileAccount = dbo.CF_Profile_Terminal.IDProfileAccount INNER JOIN
                      dbo.CF_Profile_Fleet ON dbo.CF_Profile_Terminal.IDProfileTerminal = dbo.CF_Profile_Fleet.IDProfileTerminal INNER JOIN
                      dbo.CF_Vehicles ON dbo.CF_Profile_Fleet.IDProfileFleet = dbo.CF_Vehicles.IDProfileFleet
