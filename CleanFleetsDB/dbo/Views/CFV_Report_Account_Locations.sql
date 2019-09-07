CREATE VIEW [dbo].[CFV_Report_Account_Locations]
AS
SELECT        dbo.CF_Profile_Account.IDProfileAccount, dbo.CF_Profile_Account.AccountName, dbo.CF_Profile_Account.Address1 AS AccountStreet, 
                         dbo.CF_Profile_Account.City AS AccountCity, dbo.CF_Profile_Account.State AS AccountState, dbo.CF_Profile_Account.County AS AccountCounty, 
                         dbo.CF_Profile_Account.Zip AS AccountZip, dbo.CF_Profile_Account.Telephone1 AS AccountTelephone1, dbo.CF_Profile_Terminal.IDProfileTerminal, 
                         dbo.CF_Profile_Terminal.TerminalName, dbo.CF_Profile_Terminal.Address1 AS TerminalStreet, dbo.CF_Profile_Terminal.City AS TerminalCity, 
                         dbo.CF_Profile_Terminal.State AS TerminalState, dbo.CF_Profile_Terminal.County AS TerminalCounty, dbo.CF_Profile_Terminal.Zip AS TerminalZip, 
                         dbo.CF_Profile_Terminal.Telephone1 AS TerminalTelephone1, dbo.CF_Profile_Fleet.IDProfileFleet, dbo.CF_Profile_Fleet.FleetName, 
                         dbo.CF_Profile_Fleet.Address1 AS FleetStreet, dbo.CF_Profile_Fleet.City AS FleetCity, dbo.CF_Profile_Fleet.State AS FleetSate, 
                         dbo.CF_Profile_Fleet.County AS FleetCounty, dbo.CF_Profile_Fleet.Zip AS FleetZip, dbo.CF_Profile_Fleet.Telephone1 AS FleetTelephone1
FROM            dbo.CF_Profile_Account INNER JOIN
                         dbo.CF_Profile_Terminal ON dbo.CF_Profile_Account.IDProfileAccount = dbo.CF_Profile_Terminal.IDProfileAccount INNER JOIN
                         dbo.CF_Profile_Fleet ON dbo.CF_Profile_Terminal.IDProfileTerminal = dbo.CF_Profile_Fleet.IDProfileTerminal
