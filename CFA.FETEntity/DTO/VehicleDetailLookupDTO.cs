using System;
using System.Collections.Generic;
using System.Text;

namespace CFA.FETEntity.DTO
{
    [Serializable]
    public class VehicleDetailLookupDTO
    {
        public Dictionary<string,string> State { get; set; }
        public Dictionary<string, string> EquipmentType { get; set; }
        public Dictionary<string, string> SpecialProvision { get; set; }
        public Dictionary<string, string> VehicleStatus { get; set; }
        public Dictionary<string, string> CarbGroup { get; set; }
        public Dictionary<string, string> Make { get; set; }
        public Dictionary<string, string> ModelYear { get; set; }
        public Dictionary<string, string> InServiceDate { get; set; }
    }
}
