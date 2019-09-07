using System;
using System.Collections.Generic;
using System.Text;

namespace CFA.FETEntity.Criteria
{
    public class AnnualMileageReportSearchCriteria
    {
        public int AccountId { get; set; }
        public int TerminalId { get; set; }
        public int FleetId { get; set; }
        public DateTime FromDate { get; set; }
        public DateTime ToDate { get; set; }
    }
}
