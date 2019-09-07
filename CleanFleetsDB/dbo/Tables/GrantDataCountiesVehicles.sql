CREATE TABLE [dbo].[GrantDataCountiesVehicles]
(
	[GrantDataCountiesVehiclesId] BIGINT NOT NULL,
	[GrantDataId] BIGINT NOT NULL, 
    [StateId] INT NULL, 
    [County] VARCHAR(50) NOT NULL, 
    [VehicleCount] INT NOT NULL, 
    CONSTRAINT [PK_GrantDataCountiesVehicles] PRIMARY KEY CLUSTERED ([GrantDataCountiesVehiclesId] ASC),
	CONSTRAINT [FK_GrantDataCountiesVehicles_GrantData] FOREIGN KEY ([GrantDataId]) REFERENCES [dbo].[GrantData] ([GrantDataId])
)
