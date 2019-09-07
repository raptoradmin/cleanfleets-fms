CREATE VIEW [dbo].[CFV_DECs_Detached]
AS
SELECT        IDDECS, IDModifiedUser, EnterDate, ModifiedDate, IDEngines, DECSName, SerialNo, IDDECSManufacturer,
                             (SELECT        DisplayValue
                               FROM            dbo.CF_Option_List
                               WHERE        (dbo.CF_DECS.IDDECSManufacturer = IDOptionList)) AS DECSManufacturer, IDDECSLevel,
                             (SELECT        DisplayValue
                               FROM            dbo.CF_Option_List AS CF_Option_List_1
                               WHERE        (dbo.CF_DECS.IDDECSLevel = IDOptionList)) AS DECSLevel, DECSModelNo, DECSInstallationDate, Notes, NotesCF, IDProfileAccount,
                             (SELECT        AccountName
                               FROM            dbo.CF_Profile_Account
                               WHERE        (dbo.CF_DECS.IDProfileAccount = IDProfileAccount)) AS AccountName
FROM            dbo.CF_DECS
WHERE        (IDEngines IS NULL)
