CREATE FUNCTION [dbo].[GetIDOptionListRecordValue](@IDOptionList int) returns varchar(50)
BEGIN
	DECLARE @RecordValue varchar(50)
	-- Because IDOptionList is guaranteed to be unique, we don't need to specify ID Option Name, even though it'd help with self-documentation
	SELECT @RecordValue = RecordValue FROM CF_Option_List WHERE IDOptionList = @IDOptionList
	RETURN @RecordValue
END
