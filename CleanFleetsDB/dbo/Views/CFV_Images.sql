CREATE VIEW [dbo].[CFV_Images]
AS
SELECT     IDImages, IDModifiedUser, IDVehicles, IDEngines, IDDECS, Title, FilePath, FileName, FilePath + FileName AS Image
FROM         dbo.CF_Images
