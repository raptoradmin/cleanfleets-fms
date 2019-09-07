
/*
	Engine Model Year Replacement Schedule
	Author: Matthew Grigas
	Date: 1/20/2012
	Description: 

*/
CREATE PROCEDURE [dbo].[QueryEMYRS](@IDProfileFleet int, @IDProfileTerminal int, @IDProfileAccount int, @VehicleWeightClass char(10), @UserId uniqueidentifier) AS
	SET NOCOUNT ON
	
	DECLARE @EngineModelYear char(4), @UnitNo varchar(50), @UnitNoStr  varchar(8000)
	
	
	CREATE TABLE #Query (UID int NOT NULL IDENTITY(1,1), EngineModelYear char(4), UnitNoStr varchar(8000))
	
	
	
	SELECT DISTINCT CF_Vehicles.UnitNo,
	  CASE 
	   WHEN CAST([dbo].[GetIDOptionListRecordValue](CF_Engines.IDModelYear) as int) < 1994 THEN '1993' 
	   ELSE [dbo].[GetIDOptionListRecordValue](CF_Engines.IDModelYear) 
	  END AS EngineModelYear
	  
	  INTO #Vehicles
	  FROM CF_Engines 
	  INNER JOIN CF_Vehicles ON CF_Vehicles.IDVehicles = CF_Engines.IDVehicles -- possible that an engine could be joined twice
	  INNER JOIN CF_Profile_Fleet ON CF_Vehicles.IDProfileFleet = CF_Profile_Fleet.IDProfileFleet
	  INNER JOIN CF_Profile_Terminal ON CF_Profile_Fleet.IDProfileTerminal = CF_Profile_Terminal.IDProfileTerminal
	  WHERE @IDProfileFleet IN (0, CF_Vehicles.IDProfileFleet)
	  AND @IDProfileTerminal IN (0, CF_Profile_Terminal.IDProfileTerminal)
	  AND @IDProfileAccount IN (0, CF_Profile_Terminal.IDProfileAccount)
	  AND ISNUMERIC(REPLACE(CF_Vehicles.GrossVehicleWeight,',',''))=1
	  AND ((@VehicleWeightClass = '7-8' 
	   AND CAST(REPLACE(CF_Vehicles.GrossVehicleWeight,',','') as decimal) > 26000.0)
	  OR (@VehicleWeightClass = '4-6'
	   AND CAST(REPLACE(CF_Vehicles.GrossVehicleWeight,',','') as decimal) >= 14000.0 AND CAST(REPLACE(CF_Vehicles.GrossVehicleWeight,',','') as DECIMAL) <= 26000.0
	   --09/15/2012 IR: only include vehicles from terminals the user has permissions for
	  )) AND [dbo].[GetTerminalPermission](CF_Profile_Terminal.IDProfileTerminal, @UserId) IN ('A','B') 
	  
	  
	DECLARE ModelYearCursor CURSOR FOR
	  SELECT DISTINCT EngineModelYear
	  FROM #Vehicles
	  ORDER BY EngineModelYear
	OPEN ModelYearCursor
	FETCH NEXT FROM ModelYearCursor INTO @EngineModelYear
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @UnitNoStr = ''
		
		DECLARE UnitNoCursor CURSOR FOR
		  SELECT UnitNo
		  FROM #Vehicles
		  WHERE EngineModelYear = @EngineModelYear
		  ORDER BY UnitNo
		OPEN UnitNoCursor
		FETCH NEXT FROM UnitNoCursor INTO @UnitNo
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @UnitNoStr = @UnitNoStr + RTRIM(ISNULL(@UnitNo,'MISSING')) + ', ' + CHAR(10)
			
			FETCH NEXT FROM UnitNoCursor INTO @UnitNo
		END
		CLOSE UnitNoCursor
		DEALLOCATE UnitNoCursor
		
		IF RIGHT(@UnitNoStr,3) = ', ' + CHAR(10) 
		BEGIN
			SELECT @UnitNoStr = LEFT(@UnitNoStr, LEN(@UnitNoStr)-3)
		END
		
		IF RTRIM(ISNULL(@UnitNoStr,'')) > ''
		BEGIN
			INSERT INTO #Query (EngineModelYear, UnitNoStr) 
			  VALUES (@EngineModelYear, @UnitNoStr)
		END
		
		FETCH NEXT FROM ModelYearCursor INTO @EngineModelYear
	END
	CLOSE ModelYearCursor
	DEALLOCATE ModelYearCursor
	
	SELECT * FROM #Query ORDER BY EngineModelYear