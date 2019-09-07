using System;
using System.Collections.Generic;
using System.Text;
using FMS.Business;
using FMS.Entity.DTO;

namespace FMS.ServiceFacade
{
    public class TerminalService : IDisposable 
    {
        private TerminalBLL bll = new TerminalBLL();
        public List<TerminalDTO> GetTerminalList()
        {
            return (bll).GetTerminalList();
        }

        public void Dispose()
        {
            bll = null;
        }
    }
}
