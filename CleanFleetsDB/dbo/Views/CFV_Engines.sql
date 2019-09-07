CREATE VIEW [dbo].[CFV_Engines]
AS
SELECT        CAST(IDEngines AS NVarChar(36)) AS IDEngines, IDModifiedUser, EnterDate, ModifiedDate, IDVehicles, IDProfileAccount,
                             (SELECT        AccountName
                               FROM            dbo.CF_Profile_Account
                               WHERE        (dbo.CF_Engines.IDProfileAccount = IDProfileAccount)) AS AccountName, IDEngineManufacturer,
                             (SELECT        DisplayValue
                               FROM            dbo.CF_Option_List
                               WHERE        (dbo.CF_Engines.IDEngineManufacturer = IDOptionList)) AS EngineManufacturer, EngineModel, IDEngineStatus,
                             (SELECT        DisplayValue
                               FROM            dbo.CF_Option_List AS CF_Option_List_2
                               WHERE        (dbo.CF_Engines.IDEngineStatus = IDOptionList)) AS EngineStatus, IDEngineFuelType,
                             (SELECT        DisplayValue
                               FROM            dbo.CF_Option_List AS CF_Option_List_3
                               WHERE        (dbo.CF_Engines.IDEngineFuelType = IDOptionList)) AS EngineFuelType, IDModelYear,
                             (SELECT        DisplayValue
                               FROM            dbo.CF_Option_List AS CF_Option_List_4
                               WHERE        (dbo.CF_Engines.IDModelYear = IDOptionList)) AS ModelYear, SerialNum, Description, FamilyName, SeriesModelNo, Horsepower, Notes, 
                         NotesCF, Displacement, EstRetrofitCost, Hours, Miles
FROM            dbo.CF_Engines
