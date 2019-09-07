
IF EXISTS (SELECT name from sys.indexes WHERE name = N'IX_CF_Vehicles_Log_OpacityTests_TestDate')
DROP INDEX IS_CF_Vehicles_Log_OpacityTests_TestDate ON dbo.CF_Vehicles_Log_OpacityTests;
GO
CREATE NONCLUSTERED INDEX IX_CF_Vehicles_Log_OpacityTests_TestDate
ON dbo.CF_Vehicles_Log_OpacityTests (TestDate);
GO