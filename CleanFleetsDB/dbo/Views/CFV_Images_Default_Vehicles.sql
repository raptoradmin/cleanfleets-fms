CREATE VIEW [dbo].[CFV_Images_Default_Vehicles]
AS
SELECT     IDImages, IDVehicles, IDEngines, IDDECS, Image
FROM         dbo.CFV_Images_Default
WHERE     (NOT (IDVehicles IS NULL))
