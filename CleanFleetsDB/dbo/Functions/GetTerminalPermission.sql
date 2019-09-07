-- =============================================
-- Author:		Ian Reif
-- Create date: 09/13/2012
-- Description:	Returns the users permission level for the requested terminal. If the user is an employee then 
--				permission level 'A' is always returned
-- =============================================
CREATE FUNCTION [dbo].[GetTerminalPermission](@IDProfileTerminal int, @UserId uniqueidentifier) 
  RETURNS char(1)
  AS
  BEGIN
	DECLARE @PermissionLevel char(1),@Result char(1), @IDProfileContact int
	SELECT @Result = 'Z'
	--Get IDProfile contact for the user to use to check if they are an employee
	DECLARE personcursor CURSOR FOR
	  SELECT IDProfileContact
	  FROM CF_Profile_Contact
	  WHERE UserId = @UserId
	OPEN personcursor
	FETCH NEXT FROM personcursor INTO @IDProfileContact
	IF @@FETCH_STATUS = 0
	BEGIN
		--Check if the user is an employee if they are return full access permission level 'A'
		IF EXISTS (SELECT IDProfileAccount FROM CFV_Profile_Employee WHERE IDProfileContact = RTRIM(ISNULL(@IDProfileContact, 0)))
		BEGIN
			SELECT @Result = 'A'
			return @Result
		END
	END
	ELSE
	BEGIN
		SELECT @Result = 'Z'
	END
	CLOSE personcursor
	DEALLOCATE personcursor
	--Get permission level for requested user and terminal
	DECLARE terminalpermissionscursor CURSOR FOR
	  SELECT PermissionLevel
	  FROM CF_UserTerminals 
	  WHERE IDProfileTerminal = RTRIM(ISNULL(@IDProfileTerminal, 0)) AND UserId = @UserId
	OPEN terminalpermissionscursor
	FETCH NEXT FROM terminalpermissionscursor INTO @PermissionLevel
	
	IF @@FETCH_STATUS = 0
	BEGIN
		SELECT @Result = @PermissionLevel
	END
	ELSE
	BEGIN
		SELECT @Result = 'Z'
	END
	CLOSE terminalpermissionscursor
	DEALLOCATE terminalpermissionscursor
	return @Result
  END
