CREATE VIEW [dbo].[CFV_Images_Engines]
AS
SELECT     IDImages, IDModifiedUser, IDVehicles, IDEngines, IDDECS, Title, FilePath, FileName, FilePath + FileName AS Image, DefaultImage, EnterDate, ModifiedDate, 
                      UserID
FROM         dbo.CF_Images
WHERE     (IDEngines IS NOT NULL) AND (IDDECS IS NULL)
