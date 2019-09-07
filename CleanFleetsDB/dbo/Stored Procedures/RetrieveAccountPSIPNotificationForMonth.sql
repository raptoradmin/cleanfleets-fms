
create PROCEDURE [dbo].[RetrieveAccountPSIPNotificationForMonth]

AS

BEGIN

	DECLARE
			@MonthName	varchar(20)

	SET @MonthName = DATENAME(mm, GETDATE())

	SELECT
			IDProfileAccount,
			AccountName
		FROM
			CF_Profile_Account
		WHERE
			PSIPNotificationEmail = 'Y' AND
			LOWER(PSIPMonth) = LOWER(@MonthName)

END
