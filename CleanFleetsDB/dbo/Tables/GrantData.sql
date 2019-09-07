CREATE TABLE [dbo].[GrantData]
(
	[GrantDataId] BIGINT NOT NULL,
	[IDProfileAccount] INT NULL, 
    [Comments] VARCHAR(4000) NULL, 
    CONSTRAINT [PK_GrantData] PRIMARY KEY CLUSTERED ([GrantDataId] ASC),
	CONSTRAINT [FK_GrantData_CF_Profile_Account] FOREIGN KEY ([IDProfileAccount]) REFERENCES [dbo].[CF_Profile_Account] ([IDProfileAccount])
)
