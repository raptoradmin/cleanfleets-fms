CREATE TABLE [dbo].[Config] (
    [UID]              INT           IDENTITY (1, 1) NOT NULL,
    [CreationUserName] CHAR (16)     NULL,
    [CreationDate]     DATETIME      NULL,
    [ParameterCode]    VARCHAR (10)  NULL,
    [ParameterValue]   VARCHAR (500) NULL,
    CONSTRAINT [PK_Config] PRIMARY KEY CLUSTERED ([UID] ASC)
);

