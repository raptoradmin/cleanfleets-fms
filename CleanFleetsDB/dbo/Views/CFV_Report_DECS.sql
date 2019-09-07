CREATE VIEW [dbo].[CFV_Report_DECS]
AS
SELECT     IDDECS, IDModifiedUser, EnterDate, ModifiedDate, IDProfileAccount, IDEngines, SerialNo, DECSName, IDDECSManufacturer,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List
                            WHERE      (dbo.CF_DECS.IDDECSManufacturer = IDOptionList)) AS DECSManufacturer, IDDECSLevel,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List AS CF_Option_List_1
                            WHERE      (dbo.CF_DECS.IDDECSLevel = IDOptionList)) AS DECSLevel, DECSModelNo, DECSInstallationDate, Notes, NotesCF
FROM         dbo.CF_DECS
