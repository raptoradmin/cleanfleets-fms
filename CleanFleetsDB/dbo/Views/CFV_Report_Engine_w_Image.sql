CREATE VIEW [dbo].[CFV_Report_Engine_w_Image]
AS
SELECT     dbo.CF_Engines.IDEngines, dbo.CF_Engines.IDVehicles, dbo.CFV_Images_Default.IDImages, dbo.CF_Engines.SerialNum, dbo.CF_Engines.FamilyName, 
                      dbo.CF_Engines.SeriesModelNo, dbo.CF_Engines.Horsepower, dbo.CF_Engines.Hours, dbo.CF_Engines.Miles,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List
                            WHERE      (dbo.CF_Engines.IDEngineManufacturer = IDOptionList)) AS EngineManufacturer,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List AS CF_Option_List_2
                            WHERE      (dbo.CF_Engines.IDEngineStatus = IDOptionList)) AS EngineStatus,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List AS CF_Option_List_3
                            WHERE      (dbo.CF_Engines.IDEngineFuelType = IDOptionList)) AS EngineFuelType,
                          (SELECT     DisplayValue
                            FROM          dbo.CF_Option_List AS CF_Option_List_4
                            WHERE      (dbo.CF_Engines.IDModelYear = IDOptionList)) AS ModelYear, dbo.CFV_Images_Default.Image, dbo.CF_Engines.EngineModel
FROM         dbo.CF_Engines LEFT OUTER JOIN
                      dbo.CFV_Images_Default ON dbo.CF_Engines.IDEngines = dbo.CFV_Images_Default.IDEngines
