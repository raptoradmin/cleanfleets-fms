using System;
using System.Collections.Generic;
using System.Text;
using FMS.Business;
using FMS.Entity.Criteria;
using FMS.Entity.DTO;
namespace FMS.ServiceFacade
{
    public class AnnualMileageReportService : IDisposable 
    {
        public Dictionary<string, string> GetAccountListing()
        {
            return (new AccountBLL()).GetAccountListing();
        }

        public Dictionary<string, string> GetTerminalListing(string accountId)
        {
            return (new TerminalBLL()).GetTerminalListing(accountId);
        }

        public Dictionary<string, string> GetFleetListing(string accountId)
        {
            return (new FleetBLL()).GetFleetListing(accountId);
        }

        public List<AnnualMileageReportDTO> GetAnnualMileageReportData(AnnualMileageReportSearchCriteria criteria)
        {
            return new AnnualMileageReportBLL().GetAnnualMileageReport(criteria);
            //return new List<AnnualMileageReportDTO>();
        }

        public void Dispose()
        {
            
        }

    }
}
