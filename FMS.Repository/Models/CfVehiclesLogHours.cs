using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class CfVehiclesLogHours
    {
        public Guid IdhoursLog { get; set; }
        public Guid? Idvehicles { get; set; }
        public DateTime? EnterDate { get; set; }
        public Guid? IdmodifiedUser { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public int? Hours { get; set; }
        public DateTime? HoursDate { get; set; }
        public string Notes { get; set; }
    }
}
