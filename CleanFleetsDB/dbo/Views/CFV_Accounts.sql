CREATE VIEW [dbo].[CFV_Accounts]
AS
SELECT DISTINCT IDProfileAccount, AccountName
FROM            dbo.CF_Profile_Account
