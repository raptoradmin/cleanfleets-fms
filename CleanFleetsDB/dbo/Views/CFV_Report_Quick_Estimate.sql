CREATE VIEW [dbo].[CFV_Report_Quick_Estimate]
AS
SELECT        dbo.CF_Profile_Account.IDProfileAccount, dbo.CF_Profile_Account.AccountName, dbo.CF_Profile_Terminal.TerminalName, dbo.CF_Profile_Fleet.FleetName, 
                         dbo.CF_Vehicles.UnitNo, dbo.CF_Vehicles.LicensePlateNo,
                             (SELECT        DisplayValue
                               FROM            dbo.CF_Option_List
                               WHERE        (dbo.CF_Vehicles.IDChassisModelYear = IDOptionList)) AS Year, dbo.CF_Vehicles.EstReplacementCost, dbo.CF_Engines.EstRetrofitCost
FROM            dbo.CF_Profile_Account INNER JOIN
                         dbo.CF_Profile_Terminal ON dbo.CF_Profile_Account.IDProfileAccount = dbo.CF_Profile_Terminal.IDProfileAccount INNER JOIN
                         dbo.CF_Profile_Fleet ON dbo.CF_Profile_Terminal.IDProfileTerminal = dbo.CF_Profile_Fleet.IDProfileTerminal INNER JOIN
                         dbo.CF_Vehicles ON dbo.CF_Profile_Fleet.IDProfileFleet = dbo.CF_Vehicles.IDProfileFleet LEFT OUTER JOIN
                         dbo.CF_Engines ON dbo.CF_Vehicles.IDVehicles = dbo.CF_Engines.IDVehicles
WHERE        (dbo.CF_Engines.IDVehicles IS NOT NULL)
