using System;
using System.Collections.Generic;
using System.Text;

namespace CFA.FETEntity.DTO
{
    [Serializable]
    public class VehicleDTO
    {
        public Guid VehicleId { get; set; }
        public Guid? ModifiedUserId { get; set; }
        public string EnterDate { get; set; }
        public string ModifiedDate { get; set; }
        public int? FleetId { get; set; }
        public int? EquipmentTypeId { get; set; }
        public int? EquipmentCategoryId { get; set; }
        public int? SpecialProvisionId { get; set; }
        public int? VehicleStatusId { get; set; }
        public int? CarbGroupId { get; set; }
        public int? ChassisModelYearId { get; set; }
        public int? RuleCodeId { get; set; }
        public int? ChassisMakeId { get; set; }
        public int? IdweightDefinition { get; set; }
        public string ChassisModel { get; set; }
        public string LicensePlateState { get; set; }
        public string LicensePlateNo { get; set; }
        public string ChassisVin { get; set; }
        public string UnitNo { get; set; }
        public string Description { get; set; }
        public string AnnualMiles { get; set; }
        public string AnnualHours { get; set; }
        public string ActualMiles { get; set; }
        public string ActualHours { get; set; }

        public DateTime? ActualInServiceDate { get; set; }
        public DateTime? PlannedComplianceDate { get; set; }
        public DateTime? PlannedRetirementDate { get; set; }
        public DateTime? ActualComplianceDate { get; set; }
        public DateTime? ActualRetirementDate { get; set; }
        public DateTime? RetireStatusDate { get; set; }

        public string EstimatedInServiceDate { get; set; }
        public string GrossVehicleWeight { get; set; }
        public string BackupStatusDate { get; set; }
        public string Notes { get; set; }
        public string NotesCf { get; set; }
        public string EstReplacementCost { get; set; }
        public string ReplacementAmount { get; set; }
        public string RequestedGrantAmount { get; set; }
        public string UpdateVehicleInformation { get; set; }
        public string LastOpacityTestDate { get; set; }


    }
}
