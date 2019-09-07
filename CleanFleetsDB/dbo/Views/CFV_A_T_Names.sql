CREATE VIEW [dbo].[CFV_A_T_Names]
AS
SELECT     dbo.CF_Profile_Account.IDProfileAccount, dbo.CF_Profile_Account.AccountName, dbo.CF_Profile_Terminal.IDProfileTerminal, 
                      dbo.CF_Profile_Terminal.TerminalName
FROM         dbo.CF_Profile_Account INNER JOIN
                      dbo.CF_Profile_Terminal ON dbo.CF_Profile_Account.IDProfileAccount = dbo.CF_Profile_Terminal.IDProfileAccount
