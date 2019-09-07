CREATE TABLE [dbo].[CF_Compliance_Milestones] (
    [IDMilestones]         INT            IDENTITY (1, 1) NOT NULL,
    [MilestoneDate]        DATETIME       NULL,
    [MilestoneName]        VARCHAR (50)   NULL,
    [MilestoneDescription] VARCHAR (1000) NULL,
    CONSTRAINT [PK_CF_Compliance_Milestones] PRIMARY KEY CLUSTERED ([IDMilestones] ASC)
);

