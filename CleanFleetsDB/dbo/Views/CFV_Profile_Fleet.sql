CREATE VIEW [dbo].[CFV_Profile_Fleet]
AS
SELECT     dbo.CF_Profile_Fleet.IDProfileFleet, dbo.CF_Profile_Fleet.IDModifiedUser, dbo.CF_Profile_Fleet.EnterDate, dbo.CF_Profile_Fleet.ModifiedDate,
                          (SELECT     IDProfileAccount
                            FROM          dbo.CF_Profile_Terminal
                            WHERE      (dbo.CF_Profile_Fleet.IDProfileTerminal = IDProfileTerminal)) AS IDProfileAccount, dbo.CF_Profile_Fleet.IDProfileTerminal,
                          (SELECT     TerminalName
                            FROM          dbo.CF_Profile_Terminal AS CF_Profile_Terminal_1
                            WHERE      (dbo.CF_Profile_Fleet.IDProfileTerminal = IDProfileTerminal)) AS TerminalName, dbo.CF_Profile_Fleet.IDRuleCode,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List
                            WHERE      (dbo.CF_Profile_Fleet.IDRuleCode = IDOptionList)) AS RuleCode, dbo.CF_Profile_Fleet.IDPrimaryContact, dbo.CF_Profile_Fleet.FleetName, 
                      dbo.CF_Profile_Fleet.Address1, dbo.CF_Profile_Fleet.Address2, dbo.CF_Profile_Fleet.City, dbo.CF_Profile_Fleet.State, dbo.CF_Profile_Fleet.County, 
                      dbo.CF_Profile_Fleet.Country, dbo.CF_Profile_Fleet.Zip, dbo.CF_Profile_Fleet.Telephone1, dbo.CF_Profile_Fleet.Ext1, dbo.CF_Profile_Fleet.Telephone2, 
                      dbo.CF_Profile_Fleet.Ext2, dbo.CF_Profile_Fleet.Telephone3, dbo.CF_Profile_Fleet.Ext3, dbo.CF_Profile_Fleet.Fax1, dbo.CF_Profile_Fleet.Fax2, 
                      dbo.CF_Profile_Fleet.Email, dbo.CF_Profile_Fleet.WebSite, dbo.CF_Profile_Fleet.Notes, dbo.CF_Profile_Fleet.NotesCF, 
                      dbo.vw_CFV_Vehicle_Count.Count AS TotalVehicles
FROM         dbo.CF_Profile_Fleet LEFT OUTER JOIN
                      dbo.vw_CFV_Vehicle_Count ON dbo.CF_Profile_Fleet.IDProfileFleet = dbo.vw_CFV_Vehicle_Count.IDProfileFleet
