
CREATE PROCEDURE [dbo].[UpdateVehicleHours] (@IDVehicles uniqueidentifier) AS
	SET NOCOUNT ON
	
	DECLARE @EstimatedAnnualHours int
	
	
	IF EXISTS(SELECT * FROM CF_Vehicles_Log_Hours 
	  WHERE IDVehicles = @IDVehicles
	  AND ISNULL(Hours,-1) >= 0 )
	BEGIN
		UPDATE CF_Vehicles SET ActualHours = ISNULL((SELECT TOP 1 Hours 
		   FROM CF_Vehicles_Log_Hours 
		   WHERE IDVehicles = CF_Vehicles.IDVehicles 
		   AND ISNULL(Hours,-1) >= 0
		   ORDER BY HoursDate DESC), ActualHours)
		  WHERE CF_Vehicles.IDVehicles = @IDVehicles
		  
		  
		  -- determine estimated annual Hours using all records... do we use some sort of trending to average per period
		;WITH Hours_Log_CTE AS (
			SELECT CAST(Hours as decimal(10,2)) AS Hours, HoursDate, ROW_NUMBER() OVER(ORDER BY HoursDate) AS RowNumber
			FROM CF_Vehicles_Log_Hours
			WHERE IDVehicles = @IDVehicles
			AND ISNULL(Hours,-1) >= 0 
			UNION SELECT 0, COALESCE(ActualInServiceDate, EstimatedInServiceDate ), 0 
			FROM CF_Vehicles
			WHERE IDVehicles = @IDVehicles
			AND COALESCE(ActualInServiceDate, EstimatedInServiceDate ) IS NOT NULL
		), Hours_Intermediate_CTE AS (
			SELECT  MLC2.Hours - MLC.Hours AS HoursDifference, DATEDIFF(day, MLC.HoursDate, MLC2.HoursDate) AS RecordDateDifference, 
			  (MLC2.Hours - MLC.Hours) / ISNULL(NULLIF(DATEDIFF(day, MLC.HoursDate, MLC2.HoursDate),0),1) AS HoursPerDay,
			  MLC2.RowNumber
			  FROM Hours_Log_CTE AS MLC
			  LEFT JOIN Hours_Log_CTE AS MLC2 ON MLC.RowNumber +1 = MLC2.RowNumber
		)
		/*SELECT * FROM Hours_Intermediate_CTE
		WHERE ISNULL(HoursPerDay,0) > 0
		COMPUTE AVG(HoursPerDay)*/
		SELECT @EstimatedAnnualHours = AVG(HoursPerDay) * 365.25 FROM Hours_Intermediate_CTE
	
		
		
		UPDATE CF_Vehicles SET AnnualHours = @EstimatedAnnualHours WHERE CF_Vehicles.IDVehicles = @IDVehicles
		  
	END
