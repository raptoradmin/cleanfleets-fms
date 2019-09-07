-- =============================================
-- Author:		Ian Reif
-- Create date: 09/14/2012
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[GetAccountTerminals](@IDProfileAccount int, @Result char(100) OUTPUT)
AS
SET NOCOUNT ON
BEGIN
	DECLARE @PermissionLevel char(1), @IDProfileTerminal int, @UserID uniqueidentifier
	
	
	--Get all terminals in the fleet along with the users permission level for the terminal
    SELECT 'G' AS PermissionLevel, IDProfileTerminal, TerminalName, 'None' AS DisplayValue
	FROM CF_Profile_Terminal
	WHERE CF_Profile_Terminal.IDProfileAccount = @IDProfileAccount 
	
END
