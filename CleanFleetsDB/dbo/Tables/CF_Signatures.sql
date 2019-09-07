CREATE TABLE [dbo].[CF_Signatures] (
    [IDSignature]    UNIQUEIDENTIFIER NOT NULL,
    [EnterDate]      DATETIME         NULL,
    [IDModifiedUser] UNIQUEIDENTIFIER NULL,
    [ModifiedDate]   DATETIME         NULL,
    [FilePath]       VARCHAR (200)    NULL,
    [FirstName]      VARCHAR (50)     NULL,
    [LastName]       VARCHAR (50)     NULL,
    CONSTRAINT [PK_CF_Signatures] PRIMARY KEY CLUSTERED ([IDSignature] ASC)
);

