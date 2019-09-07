CREATE VIEW [dbo].[CFV_Images_DECS]
AS
SELECT     dbo.CF_Images.IDImages, dbo.CF_Vehicles.IDVehicles, dbo.CF_Engines.IDEngines, dbo.CF_Images.IDModifiedUser, dbo.CF_Images.IDDECS, dbo.CF_Images.Title, 
                      dbo.CF_Images.FilePath, dbo.CF_Images.FileName, dbo.CF_Images.FilePath + dbo.CF_Images.FileName AS Image, dbo.CF_Images.DefaultImage, 
                      dbo.CF_Images.EnterDate, dbo.CF_Images.ModifiedDate, dbo.CF_Images.UserID
FROM         dbo.CF_Vehicles INNER JOIN
                      dbo.CF_Engines ON dbo.CF_Vehicles.IDVehicles = dbo.CF_Engines.IDVehicles RIGHT OUTER JOIN
                      dbo.CF_Images ON dbo.CF_Engines.IDEngines = dbo.CF_Images.IDEngines
WHERE     (dbo.CF_Images.IDDECS IS NOT NULL)
