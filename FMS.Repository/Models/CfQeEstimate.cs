using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class CfQeEstimate
    {
        public int IdestimateEntry { get; set; }
        public int Idqeaccount { get; set; }
        public int? IdgrossVehicleWeight { get; set; }
        public int? IdchassisModelYear { get; set; }
        public int? QuantityVehicles { get; set; }
        public decimal? EstReplacementCost { get; set; }
        public decimal? EstRetrofitCost { get; set; }
    }
}
