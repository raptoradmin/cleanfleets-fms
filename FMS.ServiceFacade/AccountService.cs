using System;
using System.Collections.Generic;
using System.Text;
using FMS.Business;
using FMS.Entity.DTO;

namespace FMS.ServiceFacade
{
    public class AccountService : IDisposable 
    {
        private AccountBLL bll = new AccountBLL();
        public List<AccountDTO> GetAccountList()
        {
            return  (bll).GetAccountList();
        }

        //public List<AccountListingDTO> GetAccountListing()
        //{
        //    return (bll).GetAccountListing();
        //}

        public void Dispose()
        {
            bll = null;
        }
    }
}
