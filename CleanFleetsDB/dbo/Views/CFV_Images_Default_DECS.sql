CREATE VIEW [dbo].[CFV_Images_Default_DECS]
AS
SELECT     IDImages, IDEngines, IDDECS, Image
FROM         dbo.CFV_Images_Default
WHERE     (NOT (IDDECS IS NULL))
