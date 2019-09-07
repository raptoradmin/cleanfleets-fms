CREATE TABLE [dbo].[CF_Vehicles] (
    [IDVehicles]               UNIQUEIDENTIFIER NOT NULL,
    [IDModifiedUser]           UNIQUEIDENTIFIER NULL,
    [EnterDate]                DATETIME         CONSTRAINT [DF_CF_Vehicles_EnterDate] DEFAULT (getdate()) NULL,
    [ModifiedDate]             DATETIME         NULL,
    [IDProfileFleet]           INT              NULL,
    [IDEquipmentType]          INT              CONSTRAINT [DF_CF_Vehicles_IDEquipmentType] DEFAULT ((0)) NULL,
    [IDEquipmentCategory]      INT              CONSTRAINT [DF_CF_Vehicles_IDEquipmentCategory] DEFAULT ((0)) NULL,
    [IDSpecialProvision]       INT              CONSTRAINT [DF_CF_Vehicles_IDSpecialProvision] DEFAULT ((0)) NULL,
    [IDVehicleStatus]          INT              CONSTRAINT [DF_CF_Vehicles_IDVehicleStatus] DEFAULT ((0)) NULL,
    [IDCARBGroup]              INT              CONSTRAINT [DF_CF_Vehicles_IDCARBGroup] DEFAULT ((0)) NULL,
    [IDChassisModelYear]       INT              CONSTRAINT [DF_CF_Vehicles_IDChassisModelYear] DEFAULT ((0)) NULL,
    [IDRuleCode]               INT              CONSTRAINT [DF_CF_Vehicles_IDRuleCode] DEFAULT ((0)) NULL,
    [IDChassisMake]            INT              CONSTRAINT [DF_CF_Vehicles_IDChassisMake] DEFAULT ((0)) NULL,
    [ChassisModel]             VARCHAR (50)     NULL,
    [LicensePlateState]        CHAR (2)         NULL,
    [LicensePlateNo]           VARCHAR (50)     NOT NULL,
    [ChassisVIN]               VARCHAR (50)     NOT NULL,
    [UnitNo]                   VARCHAR (50)     NULL,
    [Description]              VARCHAR (MAX)    NULL,
    [AnnualMiles]              VARCHAR (50)     NULL,
    [AnnualHours]              VARCHAR (50)     NULL,
    [ActualMiles]              VARCHAR (50)     NULL,
    [ActualHours]              VARCHAR (50)     NULL,
    [ActualInServiceDate]      DATETIME         NULL,
    [EstimatedInServiceDate]   DATETIME         NULL,
    [GrossVehicleWeight]       VARCHAR (50)     NULL,
    [PlannedComplianceDate]    DATETIME         NULL,
    [ActualComplianceDate]     DATETIME         NULL,
    [BackupStatusDate]         DATETIME         NULL,
    [RetireStatusDate]         DATETIME         NULL,
    [Notes]                    VARCHAR (MAX)    NULL,
    [NotesCF]                  VARCHAR (MAX)    NULL,
    [EstReplacementCost]       MONEY            NULL,
    [PlannedRetirementDate]    DATETIME         NULL,
    [ActualRetirementDate]     DATETIME         NULL,
    [UpdateVehicleInformation] CHAR (1)         NULL,
    [LastOpacityTestDate]      DATETIME         NULL,
    [IDWeightDefinition]       INT              NULL,
    CONSTRAINT [PK_CF_Vehicles] PRIMARY KEY CLUSTERED ([IDVehicles] ASC),
    CONSTRAINT [FK_CF_Vehicles_CF_Profile_Fleet] FOREIGN KEY ([IDProfileFleet]) REFERENCES [dbo].[CF_Profile_Fleet] ([IDProfileFleet]) ON DELETE CASCADE,
    CONSTRAINT [IX_ChassisVIN] UNIQUE NONCLUSTERED ([ChassisVIN] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_CLicensePlateState+CLicensePlateNo]
    ON [dbo].[CF_Vehicles]([LicensePlateState] ASC, [LicensePlateNo] ASC);

