using FMS.Entity.DTO;
using System;
using System.Collections.Generic;
using System.Text;

namespace FMS.Business
{
    public class VehicleBLL
    {
        public List<AnnualMileageReportDTO> GetAnnualMileageReport(string accountId, string terminalId, string fleetId, string fromDate, string toDate)
        {
            return new List<AnnualMileageReportDTO>();
        }
    }
}
