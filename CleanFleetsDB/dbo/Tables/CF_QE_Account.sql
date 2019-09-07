CREATE TABLE [dbo].[CF_QE_Account] (
    [IDAccount]   INT            IDENTITY (1, 1) NOT NULL,
    [AccountName] NVARCHAR (150) NULL,
    CONSTRAINT [PK_CF_QE_Account] PRIMARY KEY CLUSTERED ([IDAccount] ASC)
);

