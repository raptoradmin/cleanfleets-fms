using System;
using System.Collections.Generic;
using System.Text;
using FMS.Entity.DTO;
using FMS.Repository;
using Microsoft.EntityFrameworkCore;
using System.Linq;

namespace FMS.Business
{
    public class AccountBLL : BaseBusiness 
    {
        
        public List<AccountDTO> GetAccountList()
        {
                
            return new List<AccountDTO>();
        }

        public Dictionary<string, string> GetAccountListing()
        {
                var list = new Dictionary<string, string>();
                foreach (var a in context.CfProfileAccount.OrderBy(o => o.AccountName))
                {
                    var id = a.IdprofileAccount.ToString();
                    list.Add( 
                       id,
                        a.AccountName
                    );
                }
                return list;
        }
        
    }
}
