



-- =============================================
-- Author:		Matt Honeycutt
-- Create date: 06/21/2010
-- Description:	This procedures generates a list of all Tables, Stored Procedures, and User Defined Functions ordered by 
--   modification date descending for the purpose of making sure all recently updated system objects
--   are included with each deployment.
-- =============================================
CREATE PROCEDURE [dbo].[GetRecentlyModifiedSystemObjects] (@ModificationDateFrom datetime = NULL) AS

	SET NOCOUNT ON /* This disables the # of rows affected messages */
    /* When using an UPDATE and a later SELECT, these messages can sometimes cause vague errors */

	IF RTRIM(@ModificationDateFrom) = ''
	BEGIN
		SELECT @ModificationDateFrom = NULL
	END

	SELECT name AS SystemObjectName, type_desc AS SystemObjectDescription, modify_date AS ModificationDate
	  FROM sys.objects
	  WHERE UPPER(RTRIM(ISNULL(type, ''))) IN ('U', 'P', 'FN') -- USER_TABLE, SQL_STORED_PROCEDURE, SQL_SCALAR_FUNCTION
	  AND (@ModificationDateFrom IS NULL OR modify_date >= @ModificationDateFrom)
	  ORDER BY modify_date DESC, type_desc 


