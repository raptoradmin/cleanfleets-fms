using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class CfVehiclesLogMileage
    {
        public Guid IdmileageLog { get; set; }
        public Guid? Idvehicles { get; set; }
        public DateTime? EnterDate { get; set; }
        public Guid? IdmodifiedUser { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public int? Mileage { get; set; }
        public DateTime? MileageDate { get; set; }
        public string Notes { get; set; }
    }
}
