using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class CfVehiclesLogOpacityTests
    {
        public Guid IdopacityTestsLog { get; set; }
        public Guid? Idvehicles { get; set; }
        public DateTime? EnterDate { get; set; }
        public Guid? IdmodifiedUser { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public DateTime? TestDate { get; set; }
        public string TestedBy { get; set; }
        public decimal? AverageOpacity { get; set; }
        public string TestResult { get; set; }
        public string RawTestResults { get; set; }
        public string ScannerModel { get; set; }
    }
}
