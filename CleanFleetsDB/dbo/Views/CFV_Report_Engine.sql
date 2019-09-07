CREATE VIEW [dbo].[CFV_Report_Engine]
AS
SELECT        TOP (100) PERCENT IDEngines, IDVehicles, SerialNum, FamilyName, SeriesModelNo, Horsepower, Hours, Miles,
                             (SELECT        DisplayValue
                               FROM            dbo.CF_Option_List
                               WHERE        (dbo.CF_Engines.IDEngineManufacturer = IDOptionList)) AS EngineManufacturer,
                             (SELECT        DisplayValue
                               FROM            dbo.CF_Option_List AS CF_Option_List_2
                               WHERE        (dbo.CF_Engines.IDEngineStatus = IDOptionList)) AS EngineStatus,
                             (SELECT        DisplayValue
                               FROM            dbo.CF_Option_List AS CF_Option_List_3
                               WHERE        (dbo.CF_Engines.IDEngineFuelType = IDOptionList)) AS EngineFuelType,
                             (SELECT        DisplayValue
                               FROM            dbo.CF_Option_List AS CF_Option_List_4
                               WHERE        (dbo.CF_Engines.IDModelYear = IDOptionList)) AS ModelYear, EngineModel, Displacement
FROM            dbo.CF_Engines
ORDER BY IDVehicles
