CREATE TABLE [dbo].[CF_Option_List] (
    [IDOptionList] INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [RecordValue]  VARCHAR (50)  NULL,
    [DisplayValue] VARCHAR (100) NULL,
    [OptionName]   VARCHAR (50)  NULL,
    CONSTRAINT [PK_CF_Option_List] PRIMARY KEY CLUSTERED ([IDOptionList] ASC)
);

