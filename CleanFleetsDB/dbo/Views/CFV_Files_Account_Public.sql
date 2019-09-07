CREATE VIEW [dbo].[CFV_Files_Account_Public] AS 
	SELECT IDFile, EnterDate, IDModifiedUser, ModifiedDate, 
	(SELECT DisplayValue FROM CF_Option_List WHERE LOWER(RTRIM(OptionName)) = 'documenttype'
	 AND IDOptionList = IDDocumentType) AS DocumentType,
	(SELECT RecordValue FROM CF_Option_List WHERE LOWER(RTRIM(OptionName)) = 'documenttype'
	 AND IDOptionList = IDDocumentType) AS DocumentTypeRecordValue,
	IDDocumentType, Title, FileName, FileSize, FilePath, IDProfileAccount, IDProfileTerminal, IDProfileFleet, 
	  IDVehicles, IDEngines, IDDECS, Notes
	FROM            dbo.CF_Files
	WHERE --[IDProfileAccount] = @IDProfileAccount 
	ISNULL(IDProfileTerminal,0) = 0 
	AND ISNULL(IDProfileFleet,0) = 0 
	AND IDVehicles IS NULL 
	AND IDEngines IS NULL 
	AND IDDECS IS NULL
