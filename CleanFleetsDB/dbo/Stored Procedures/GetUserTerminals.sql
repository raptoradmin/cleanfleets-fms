-- =============================================
-- Author:		Ian Reif
-- Create date: 09/13/2012
-- Description:	If any terminals are missing for the users account they are created with permission level 'G'
--				Then all terminals for the user account are returned along with the permission level
-- =============================================
CREATE PROCEDURE [dbo].[GetUserTerminals](@IDProfileContact int, @IDProfileAccount int, @Result char(100) OUTPUT)
AS
SET NOCOUNT ON
BEGIN
	DECLARE @PermissionLevel char(1), @IDProfileTerminal int, @UserID uniqueidentifier
	
	DECLARE personcursor CURSOR FOR
	  SELECT UserID
	  FROM CF_Profile_Contact
	  WHERE IDProfileContact = @IDProfileContact
	OPEN personcursor
	FETCH NEXT FROM personcursor INTO @UserID
	IF @@FETCH_STATUS <> 0
	BEGIN
		SELECT @Result = 'No user found'
		CLOSE personcursor
		DEALLOCATE personcursor
		return
	END
	CLOSE personcursor
	DEALLOCATE personcursor
	--Get all terminals in the fleet along with the users permission level for the terminal
	DECLARE userterminalscursor CURSOR FOR
	  SELECT CF_UserTerminals.PermissionLevel, CF_Profile_Terminal.IDProfileTerminal
	  FROM CF_Profile_Terminal LEFT JOIN CF_UserTerminals 
        ON CF_Profile_Terminal.IDProfileTerminal = CF_UserTerminals.IDProfileTerminal AND CF_UserTerminals.UserId = @UserId
	  WHERE CF_Profile_Terminal.IDProfileAccount = @IDProfileAccount 
	OPEN userterminalscursor
	FETCH NEXT FROM userterminalscursor INTO @PermissionLevel, @IDProfileTerminal
	WHILE @@FETCH_STATUS = 0
	BEGIN
		--If PermissionLevel is null or empty then create an entry in CF_UserTerminals for the current terminal
		--set permission level to the default no permissions level 'G'
		IF NOT RTRIM(ISNULL(@PermissionLevel, '')) > ''
		BEGIN
			
			IF @@FETCH_STATUS = 0
			BEGIN
				INSERT INTO CF_UserTerminals (IDProfileTerminal, UserId, PermissionLevel)
				  VALUES (@IDProfileTerminal, @UserID, 'G')
			END
		END
		FETCH NEXT FROM userterminalscursor INTO @PermissionLevel, @IDProfileTerminal
	END
    CLOSE userterminalscursor
    DEALLOCATE userterminalscursor
    --Return all user terminals and their associated permission level
    SELECT CF_UserTerminals.*, CF_Profile_Terminal.TerminalName, CF_Option_List.DisplayValue
    FROM CF_UserTerminals INNER JOIN CF_Option_List
      ON CF_UserTerminals.PermissionLevel = CF_Option_List.RecordValue AND CF_Option_List.OptionName = 'TerminalPermissions'
      INNER JOIN CF_Profile_Terminal
      ON CF_UserTerminals.IDProfileTerminal = CF_Profile_Terminal.IDProfileTerminal
    WHERE UserId = @UserID
END
