
CREATE PROCEDURE [dbo].[UpsertConfigValue]

	@ParameterCode		varchar(10),
	@ParameterValue		varchar(500),
	@ParameterDesc		varchar(60) = ''

AS

BEGIN

	IF EXISTS (SELECT * FROM Config WHERE ParameterCode = @ParameterCode)
		BEGIN
			UPDATE
					Config
				SET
					ParameterValue = @ParameterValue
				WHERE
					ParameterCode = @ParameterCode

			IF @ParameterDesc <> ''
				BEGIN
					UPDATE
							ConfigDsc
						SET
							ParameterDescription = @ParameterDesc
						WHERE
							ParameterCode = @ParameterCode
				END
		END
	ELSE
		BEGIN
			INSERT INTO
				Config
					(
						ParameterCode,
						ParameterValue
					)
				VALUES
					(
						@ParameterCode,
						@ParameterValue
					)

			INSERT INTO
				ConfigDsc
					(
						ParameterCode,
						ParameterDescription
					)
				VALUES
					(
						@ParameterCode,
						@ParameterDesc
					)
		END
END



