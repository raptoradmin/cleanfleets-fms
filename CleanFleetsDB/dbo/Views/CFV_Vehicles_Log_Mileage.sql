CREATE VIEW [dbo].[CFV_Vehicles_Log_Mileage]
AS
SELECT        IDMileageLog, CAST(IDVehicles AS NVarChar(36)) AS IDVehicles, EnterDate, IDModifiedUser, ModifiedDate, Mileage, MileageDate, Notes
FROM            dbo.CF_Vehicles_Log_Mileage
