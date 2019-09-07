
CREATE PROCEDURE [dbo].[UpdateVehicleMileage] (@IDVehicles uniqueidentifier) AS
	SET NOCOUNT ON
	DECLARE @EstimatedAnnualMiles int
	
	IF EXISTS(SELECT * FROM CF_Vehicles_Log_Mileage 
	  WHERE IDVehicles = @IDVehicles
	  AND ISNULL(Mileage,-1) >= 0 )
	BEGIN
		UPDATE CF_Vehicles SET ActualMiles = ISNULL((SELECT TOP 1 Mileage 
		   FROM CF_Vehicles_Log_Mileage 
		   WHERE IDVehicles = CF_Vehicles.IDVehicles 
		   AND ISNULL(Mileage,-1) >= 0
		   ORDER BY MileageDate DESC),ActualMiles)
		  WHERE CF_Vehicles.IDVehicles = @IDVehicles
		  
		  
		-- determine estimated annual miles using all records... do we use some sort of trending to average per period
		;WITH Mileage_Log_CTE AS (
			SELECT CAST(Mileage as decimal(10,2)) AS Mileage, MileageDate, ROW_NUMBER() OVER(ORDER BY MileageDate) AS RowNumber
			FROM CF_Vehicles_Log_Mileage
			WHERE IDVehicles = @IDVehicles
			AND ISNULL(Mileage,-1) >= 0 
			UNION SELECT 0, COALESCE(ActualInServiceDate, EstimatedInServiceDate ), 0 
			FROM CF_Vehicles
			WHERE IDVehicles = @IDVehicles
			AND COALESCE(ActualInServiceDate, EstimatedInServiceDate ) IS NOT NULL
		), Mileage_Intermediate_CTE AS (
			SELECT  MLC2.Mileage - MLC.Mileage AS MileageDifference, DATEDIFF(day, MLC.MileageDate, MLC2.MileageDate) AS RecordDateDifference, 
			  (MLC2.Mileage - MLC.Mileage) / ISNULL(NULLIF(DATEDIFF(day, MLC.MileageDate, MLC2.MileageDate),0),1) AS MilesPerDay,
			  MLC2.RowNumber
			  FROM Mileage_Log_CTE AS MLC
			  LEFT JOIN Mileage_Log_CTE AS MLC2 ON MLC.RowNumber +1 = MLC2.RowNumber
		)
		/*SELECT * FROM Mileage_Intermediate_CTE
		WHERE ISNULL(MilesPerDay,0) > 0
		COMPUTE AVG(MilesPerDay)*/
		SELECT @EstimatedAnnualMiles = AVG(MilesPerDay) * 365.25 FROM Mileage_Intermediate_CTE
	
		
		
		UPDATE CF_Vehicles SET AnnualMiles = @EstimatedAnnualMiles WHERE CF_Vehicles.IDVehicles = @IDVehicles
	END
