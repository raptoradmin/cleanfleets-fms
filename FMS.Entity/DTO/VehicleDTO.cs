using System;
using System.Collections.Generic;
using System.Text;

namespace FMS.Entity.DTO
{
    public class VehicleDTO
    {
        public Guid Idvehicles { get; set; }
        public Guid? IdmodifiedUser { get; set; }
        public DateTime? EnterDate { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public int? IdprofileFleet { get; set; }
        public int? IdequipmentType { get; set; }
        public int? IdequipmentCategory { get; set; }
        public int? IdspecialProvision { get; set; }
        public int? IdvehicleStatus { get; set; }
        public int? Idcarbgroup { get; set; }
        public int? IdchassisModelYear { get; set; }
        public int? IdruleCode { get; set; }
        public int? IdchassisMake { get; set; }
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
        public DateTime? EstimatedInServiceDate { get; set; }
        public string GrossVehicleWeight { get; set; }
        public DateTime? PlannedComplianceDate { get; set; }
        public DateTime? ActualComplianceDate { get; set; }
        public DateTime? BackupStatusDate { get; set; }
        public DateTime? RetireStatusDate { get; set; }
        public string Notes { get; set; }
        public string NotesCf { get; set; }
        public decimal? EstReplacementCost { get; set; }
        public DateTime? PlannedRetirementDate { get; set; }
        public DateTime? ActualRetirementDate { get; set; }
        public string UpdateVehicleInformation { get; set; }
        public DateTime? LastOpacityTestDate { get; set; }
        public int? IdweightDefinition { get; set; }

    }
}
