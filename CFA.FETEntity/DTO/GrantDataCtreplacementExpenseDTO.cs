using System;
using System.Collections.Generic;
using System.Text;

namespace CFA.FETEntity.DTO
{
    [Serializable]
    public class GrantDataCTReplacementExpenseDTO
    {
        public long GrantDataId { get; set; }
        public string VehicleMake { get; set; }
        public string VehicleModel { get; set; }
        public string VehicleYear { get; set; }

        public string EngineMake { get; set; }
        public string EngineModel { get; set; }
        public string EngineYear { get; set; }

        public string ProjectedMileage { get; set; }
        public string ReplacementCount { get; set; }
        public string ReplacementCost { get; set; }
    }
}
