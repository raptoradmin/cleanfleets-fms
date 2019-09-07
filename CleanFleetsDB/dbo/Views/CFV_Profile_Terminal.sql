CREATE VIEW [dbo].[CFV_Profile_Terminal]
AS
SELECT     IDProfileTerminal, IDModifiedUser, EnterDate, ModifiedDate,
                          (SELECT     AccountName
                            FROM          dbo.CF_Profile_Account
                            WHERE      (dbo.CF_Profile_Terminal.IDProfileAccount = IDProfileAccount)) AS AccountName, IDProfileAccount, IDPrimaryContact, TerminalName, 
                      Address1, Address2, City, State, County, Country, Zip, Telephone1, Ext1, Telephone2, Ext2, Telephone3, Ext3, Fax1, Fax2, Email, WebSite, Notes, 
                      NotesCF
FROM         dbo.CF_Profile_Terminal
