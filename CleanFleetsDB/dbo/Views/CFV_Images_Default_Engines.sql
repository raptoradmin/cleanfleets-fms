CREATE VIEW [dbo].[CFV_Images_Default_Engines]
AS
SELECT     IDImages, IDEngines, IDDECS, Image
FROM         dbo.CFV_Images_Default
WHERE     (IDDECS IS NULL) AND (NOT (IDEngines IS NULL))
