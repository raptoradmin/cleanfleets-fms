
CREATE PROCEDURE [dbo].[RetrieveConfigValue]

	@ParameterCode		varchar(10)

AS

BEGIN

	SELECT
			Config.ParameterValue,
			ConfigDsc.ParameterDescription
		FROM
			Config INNER JOIN ConfigDsc ON
					Config.ParameterCode = ConfigDsc.ParameterCode
		WHERE
			Config.ParameterCode = @ParameterCode
END



