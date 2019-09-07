CREATE TABLE [dbo].[GrantDataVehicleDetail]
(
	[GrantDataVehicleDetailId] BIGINT NOT NULL PRIMARY KEY, 
    [GrantDataId] BIGINT NOT NULL, 
    [VehicleDetailYear] INT NOT NULL, 
    [VehicleClass] INT NOT NULL, 
    [VehicleCount] INT NOT NULL, 
    [AverageMiles] INT NOT NULL, 
    [AverageGallons] INT NOT NULL, 
    [AverageIdleHours] INT NOT NULL, 
    [LifeExpectancy] INT NOT NULL
)
