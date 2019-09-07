


CREATE FUNCTION [dbo].[ASCIITable](@Str varchar(8000)) 
  RETURNS @ASCII TABLE(RowNumber int IDENTITY(1,1), [Character] char(1), [ASCIIValue] int)
AS
BEGIN
	DECLARE @i int, @char char(1)
	WHILE ISNULL(@i,1) <= LEN(@Str)
	BEGIN
		SELECT @char = SUBSTRING(@Str, ISNULL(@i,1), 1)
		INSERT INTO @ASCII ([Character], [ASCIIValue])
		  VALUES( @char, ASCII(@char))
		SELECT @i = ISNULL(@i,1) + 1
	END
	RETURN
	
	
END


