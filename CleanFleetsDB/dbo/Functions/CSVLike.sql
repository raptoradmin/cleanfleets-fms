

CREATE FUNCTION [dbo].[CSVLike](@CSVString varchar(8000), @FieldValue sql_variant) 
RETURNS bit 
AS
BEGIN
	DECLARE @Result bit, @FieldValueStr varchar(8000)

	SELECT @Result = 0

	IF RTRIM(ISNULL(@CSVString,',')) = ','
	BEGIN
		SELECT @Result = 1
	END
	ELSE IF CHARINDEX('char', CONVERT(varchar(30), SQL_VARIANT_PROPERTY(@FieldValue, 'BaseType'))) > 0
	BEGIN
		SELECT @FieldValueStr = CAST(@FieldValue as varchar(8000))
		IF @CSVString LIKE '%,' + RTRIM(ISNULL(@FieldValueStr,'')) + ',%'
		BEGIN
			SELECT @Result = 1
		END
	END
	ELSE -- assume integer
	BEGIN
		SELECT @FieldValueStr = LTRIM(STR(CAST(@FieldValue as int)))
		IF @CSVString LIKE '%,' + ISNULL(@FieldValueStr,'') + ',%'
		BEGIN
			SELECT @Result = 1
		END
	END

	RETURN @Result

END


