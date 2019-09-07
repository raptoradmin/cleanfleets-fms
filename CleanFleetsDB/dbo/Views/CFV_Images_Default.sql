CREATE VIEW [dbo].[CFV_Images_Default]
AS
SELECT     IDImages, IDModifiedUser, IDVehicles, DefaultImage, IDEngines, IDDECS, Title, FilePath, FileName, FilePath + '/' + FileName AS Image
FROM         dbo.CF_Images
WHERE     (DefaultImage = 1)
