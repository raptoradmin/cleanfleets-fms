using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class CfVehiclesLogMilageOld
    {
        public int IdmilageLog { get; set; }
        public int? Idvehicles { get; set; }
        public DateTime? EnterDate { get; set; }
        public Guid? IdmodifiedUser { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public decimal? BeginMilage { get; set; }
        public DateTime? BeginMilageDate { get; set; }
        public decimal? EndMilage { get; set; }
        public DateTime? EndMilageDate { get; set; }
        public string Notes { get; set; }
        public string NotesCf { get; set; }
    }
}
