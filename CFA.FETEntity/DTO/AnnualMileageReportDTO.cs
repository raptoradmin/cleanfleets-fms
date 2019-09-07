using System;
using System.Collections.Generic;
using System.Text;

namespace CFA.FETEntity.DTO
{
    [Serializable]
    public class AnnualMileageReportDTO
    {
        public string Location { get; set; }
        public string UnitNumber { get; set; }
        public string VIN { get; set; }
        public string MileageDateTwoYearsAgo { get; set; }
        public string MileageTwoYearsAgo { get; set; }
        public string MileageDateLastYear { get; set; }
        public string MileageLastYear { get; set; }
        public string MileageDateCurrentYear { get; set; }
        public string MileageCurrentYear { get; set; }
        public string MilesTwoYearsAgo { get; set; }
        public string MilesLastYear { get; set; }
        public string MilesAverage { get; set; }
    }
}
