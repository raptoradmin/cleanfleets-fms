CREATE VIEW [dbo].[CFV_Files_Engines]
AS
SELECT        IDFile, EnterDate, IDModifiedUser, ModifiedDate, Title, FileName, FileSize, FilePath, IDProfileAccount, IDProfileTerminal, IDProfileFleet, IDVehicles, 
                         IDEngines, IDDECS, Notes
FROM            dbo.CF_Files
WHERE        (IDDECS IS NULL) AND (IDEngines IS NOT NULL)
