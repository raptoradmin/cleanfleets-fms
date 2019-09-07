CREATE VIEW [dbo].[CFV_Files_DECS]
AS
SELECT        TOP (100) PERCENT IDFile, EnterDate, IDModifiedUser, ModifiedDate, Title, FileName, FileSize, FilePath, IDProfileAccount, IDProfileTerminal, IDProfileFleet, 
                         IDVehicles, IDEngines, IDDECS, Notes
FROM            dbo.CF_Files
WHERE        (IDDECS IS NOT NULL)
