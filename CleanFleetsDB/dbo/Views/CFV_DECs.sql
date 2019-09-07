CREATE VIEW [dbo].[CFV_DECs]
AS
SELECT        TOP (100) PERCENT CAST(dbo.CF_DECS.IDDECS AS NVarChar(36)) AS IDDECS, dbo.CF_Engines.IDEngines AS Expr1, dbo.CF_DECS.IDEngines, 
                         dbo.CF_Vehicles.IDVehicles, dbo.CF_DECS.IDModifiedUser, dbo.CF_DECS.EnterDate, dbo.CF_DECS.ModifiedDate, dbo.CF_DECS.IDProfileAccount,
                             (SELECT        AccountName
                               FROM            dbo.CF_Profile_Account
                               WHERE        (dbo.CF_DECS.IDProfileAccount = IDProfileAccount)) AS AccountName, dbo.CF_DECS.DECSName, dbo.CF_DECS.SerialNo, 
                         dbo.CF_DECS.IDDECSManufacturer,
                             (SELECT        DisplayValue
                               FROM            dbo.CF_Option_List
                               WHERE        (dbo.CF_DECS.IDDECSManufacturer = IDOptionList)) AS DECSManufacturer, dbo.CF_DECS.IDDECSLevel,
                             (SELECT        DisplayValue
                               FROM            dbo.CF_Option_List AS CF_Option_List_1
                               WHERE        (dbo.CF_DECS.IDDECSLevel = IDOptionList)) AS DECSLevel, dbo.CF_DECS.DECSModelNo, dbo.CF_DECS.DECSInstallationDate, 
                         dbo.CF_DECS.Notes, dbo.CF_DECS.NotesCF
FROM            dbo.CF_Vehicles RIGHT OUTER JOIN
                         dbo.CF_Engines ON dbo.CF_Vehicles.IDVehicles = dbo.CF_Engines.IDVehicles RIGHT OUTER JOIN
                         dbo.CF_DECS ON dbo.CF_Engines.IDEngines = dbo.CF_DECS.IDEngines
