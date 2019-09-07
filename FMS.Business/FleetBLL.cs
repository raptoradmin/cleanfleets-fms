using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FMS.Entity.DTO;
namespace FMS.Business
{
    public class FleetBLL : BaseBusiness 
    {
        public List<FleetDTO> GetFleetList()
        {

            return new List<FleetDTO>();
        }

        public Dictionary<string, string> GetFleetListing(string terminalId)
        {
            if (string.IsNullOrWhiteSpace(terminalId)) throw new ArgumentException("TerminalId required at FleetBLL.GetFleetListing.");

            var list = new Dictionary<string, string>();
            foreach (var a in context.CfProfileFleet.Where(x => Convert.ToInt32(terminalId) == x.IdprofileTerminal).ToList().OrderBy(o => o.FleetName))
            {
                var id = a.IdprofileFleet.ToString();
                list.Add(
                   id,
                    a.FleetName
                );
            }
            return list;
        }
    }
}
