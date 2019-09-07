CREATE PROCEDURE [dbo].[UpdateVehicleInformation] AS
BEGIN
	SET NOCOUNT ON
	DECLARE @IDVehicles uniqueidentifier
	
	
	BEGIN TRANSACTION
	
	DECLARE VehiclesCursor CURSOR FOR
	  SELECT DISTINCT IDVehicles
	  FROM CF_Vehicles
	  WHERE RTRIM(ISNULL(UpdateVehicleInformation,'')) <> 'N'
	OPEN VehiclesCursor
	FETCH NEXT FROM VehiclesCursor INTO @IDVehicles
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		EXECUTE UpdateVehicleHours @IDVehicles = @IDVehicles
		EXECUTE UpdateVehicleMileage @IDVehicles = @IDVehicles
		
		FETCH NEXT FROM VehiclesCursor INTO @IDVehicles
	END
	CLOSE VehiclesCursor
	DEALLOCATE VehiclesCursor
	
	UPDATE CF_Vehicles SET UpdateVehicleInformation = 'N' WHERE RTRIM(ISNULL(UpdateVehicleInformation,'')) <> 'N' 
	
	
	COMMIT TRANSACTION
	
END
