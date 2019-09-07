using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class CfComplianceMilestones
    {
        public int Idmilestones { get; set; }
        public DateTime? MilestoneDate { get; set; }
        public string MilestoneName { get; set; }
        public string MilestoneDescription { get; set; }
    }
}
