CREATE VIEW [dbo].[CFV_Report_DECS_w_Image]
AS
SELECT     dbo.CF_DECS.IDDECS, dbo.CF_DECS.IDModifiedUser, dbo.CF_DECS.EnterDate, dbo.CF_DECS.ModifiedDate, dbo.CF_DECS.IDProfileAccount, 
                      dbo.CF_DECS.IDEngines, dbo.CF_DECS.SerialNo, dbo.CF_DECS.DECSName, dbo.CF_DECS.IDDECSManufacturer,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List
                            WHERE      (dbo.CF_DECS.IDDECSManufacturer = IDOptionList)) AS DECSManufacturer, dbo.CF_DECS.IDDECSLevel,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List AS CF_Option_List_1
                            WHERE      (dbo.CF_DECS.IDDECSLevel = IDOptionList)) AS DECSLevel, dbo.CF_DECS.DECSModelNo, dbo.CF_DECS.DECSInstallationDate, dbo.CF_DECS.Notes, 
                      dbo.CF_DECS.NotesCF, dbo.CFV_Images_Default.Image
FROM         dbo.CF_DECS LEFT OUTER JOIN
                      dbo.CFV_Images_Default ON dbo.CF_DECS.IDDECS = dbo.CFV_Images_Default.IDDECS
