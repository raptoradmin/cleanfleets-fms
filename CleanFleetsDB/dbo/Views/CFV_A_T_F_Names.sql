CREATE VIEW [dbo].[CFV_A_T_F_Names]
AS
SELECT        TOP (100) PERCENT dbo.CF_Profile_Account.IDProfileAccount, dbo.CF_Profile_Account.AccountName, dbo.CF_Profile_Terminal.IDProfileTerminal, 
                         dbo.CF_Profile_Terminal.TerminalName, dbo.CF_Profile_Fleet.IDProfileFleet, dbo.CF_Profile_Fleet.FleetName
FROM            dbo.CF_Profile_Account INNER JOIN
                         dbo.CF_Profile_Terminal ON dbo.CF_Profile_Account.IDProfileAccount = dbo.CF_Profile_Terminal.IDProfileAccount RIGHT OUTER JOIN
                         dbo.CF_Profile_Fleet ON dbo.CF_Profile_Terminal.IDProfileTerminal = dbo.CF_Profile_Fleet.IDProfileTerminal
ORDER BY dbo.CF_Profile_Account.AccountName, dbo.CF_Profile_Terminal.TerminalName, dbo.CF_Profile_Fleet.FleetName
