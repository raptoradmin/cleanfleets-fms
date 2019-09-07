using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class CfVehiclesLogHoursOld
    {
        public int IdhoursLog { get; set; }
        public int? Idvehicles { get; set; }
        public DateTime? EnterDate { get; set; }
        public Guid? IdmodifiedUser { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public decimal? BeginHours { get; set; }
        public DateTime? BeginHoursDate { get; set; }
        public decimal? EndHours { get; set; }
        public DateTime? EndHoursDate { get; set; }
        public string Notes { get; set; }
        public string NotesCf { get; set; }
    }
}
