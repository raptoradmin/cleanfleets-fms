

CREATE FUNCTION [dbo].[CommaWrap](@InStr sql_variant) RETURNS varchar(8000)
AS
BEGIN
	DECLARE @Str varchar(8000)

	SELECT @Str = CAST(@InStr as varchar(8000))

	
	SELECT @Str = RTRIM(ISNULL(@Str,','))
	IF LEFT(@Str,1) <> ',' SELECT @Str = ',' + @Str
	IF RIGHT(@Str,1) <> ',' SELECT @Str = @Str + ','
	RETURN @Str
END


