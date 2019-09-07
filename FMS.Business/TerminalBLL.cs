using System;
using System.Collections.Generic;
using System.Text;
using System.Linq;
using FMS.Repository;
using FMS.Entity.DTO;

namespace FMS.Business
{
    public class TerminalBLL : BaseBusiness
    {
        public List<TerminalDTO> GetTerminalList()
        {
            return new List<TerminalDTO>();
        }

        public Dictionary<string, string> GetTerminalListing(string accountId)
        {
            if (string.IsNullOrWhiteSpace(accountId)) throw new ArgumentException("AccountId required at TerminalBLL.GetTerminalListing.");

            var acctId = Convert.ToInt32(accountId);
            var list = new Dictionary<string, string>();
            foreach (var t in (context.CfProfileTerminal).Where(x => acctId == x.IdprofileAccount).ToList().OrderBy(o => o.TerminalName))
            {
                var id = t.IdprofileTerminal.ToString();
                list.Add(
                    id,
                    t.TerminalName
                );
            }
            return list;
        }
    }
}
