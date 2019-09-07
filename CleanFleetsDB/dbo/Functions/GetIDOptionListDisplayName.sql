
CREATE FUNCTION [dbo].[GetIDOptionListDisplayName](@IDOptionList int) returns varchar(50)
BEGIN
	DECLARE @DisplayValue varchar(100)
	-- Because IDOptionList is guaranteed to be unique, we don't need to specify ID Option Name, even though it'd help with self-documentation
	SELECT @DisplayValue = DisplayValue FROM CF_Option_List WHERE IDOptionList = @IDOptionList
	RETURN @DisplayValue
END
