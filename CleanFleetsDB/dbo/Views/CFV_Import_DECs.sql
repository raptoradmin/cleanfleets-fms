CREATE VIEW [dbo].[CFV_Import_DECs]
AS
SELECT        Account,
                             (SELECT        IDProfileAccount
                               FROM            dbo.CF_Profile_Account
                               WHERE        (AccountName = dbo.CF_Import.Account)) AS IDProfileAccount,
                             (SELECT        IDEngines
                               FROM            dbo.CF_Engines
                               WHERE        (SerialNum = dbo.CF_Import.SerialNum)) AS IDEngines, SerialNum AS EngineSerialNum, DECSName, SerialNo, DECSManufacturer,
                             (SELECT        IDOptionList
                               FROM            dbo.CF_Option_List
                               WHERE        (DisplayValue = dbo.CF_Import.DECSManufacturer) AND (OptionName LIKE '%DECSManufacturer%')) AS IDDECSManufacturer, DECSLevel,
                             (SELECT        IDOptionList
                               FROM            dbo.CF_Option_List AS CF_Option_List_1
                               WHERE        (DisplayValue = dbo.CF_Import.DECSLevel) AND (OptionName LIKE '%DECSLevel%')) AS IDDECSLevel, DECSModelNo, 
                         DECSInstallationDate
FROM            dbo.CF_Import
WHERE        (DECSName IS NOT NULL)
