CREATE TABLE [dbo].[ConfigDsc] (
    [UID]                  INT          IDENTITY (1, 1) NOT NULL,
    [ParameterCode]        VARCHAR (10) NOT NULL,
    [ParameterDescription] VARCHAR (60) NULL,
    CONSTRAINT [PK_ConfigDsc] PRIMARY KEY CLUSTERED ([UID] ASC)
);

