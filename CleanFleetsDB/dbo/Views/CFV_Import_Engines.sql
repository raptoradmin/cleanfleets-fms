CREATE VIEW [dbo].[CFV_Import_Engines]
AS
SELECT        TOP (100) PERCENT Account,
                             (SELECT        IDProfileAccount
                               FROM            dbo.CF_Profile_Account
                               WHERE        (AccountName = dbo.CF_Import.Account)) AS IDProfileAccount, ChassisVIN,
                             (SELECT        IDVehicles
                               FROM            dbo.CF_Vehicles
                               WHERE        (ChassisVIN = dbo.CF_Import.ChassisVIN)) AS IDVehicles, EngineManufacturer,
                             (SELECT        IDOptionList
                               FROM            dbo.CF_Option_List
                               WHERE        (DisplayValue = dbo.CF_Import.EngineManufacturer) AND (OptionName LIKE '%EngineManufacturer%')) AS IDEngineManufacturer, 
                         EngineModel, EngineStatus,
                             (SELECT        IDOptionList
                               FROM            dbo.CF_Option_List AS CF_Option_List_2
                               WHERE        (DisplayValue = dbo.CF_Import.EngineStatus) AND (OptionName LIKE '%EngineStatus%')) AS IDEngineStatus, EngineFuelType,
                             (SELECT        IDOptionList
                               FROM            dbo.CF_Option_List AS CF_Option_List_3
                               WHERE        (DisplayValue = dbo.CF_Import.EngineFuelType) AND (OptionName LIKE '%EngineFuelType%')) AS IDEngineFuelType, ModelYear,
                             (SELECT        IDOptionList
                               FROM            dbo.CF_Option_List AS CF_Option_List_5
                               WHERE        (DisplayValue = dbo.CF_Import.ModelYear) AND (OptionName LIKE '%Year%')) AS IDModelYear, SerialNum, FamilyName, SeriesModelNo, 
                         Horsepower, Displacement, EstRetrofitCost
FROM            dbo.CF_Import
ORDER BY SerialNum
