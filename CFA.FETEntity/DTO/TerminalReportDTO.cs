using System;
using System.Collections.Generic;
using System.Text;

namespace CFA.FETEntity.DTO
{
    [Serializable]
    public class TerminalReportDTO
    {
        public string AccountName { get; set; }
        public string TerminalName { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Zip { get; set; }
        public string Telephone1 { get; set; }
        public string Ext1 { get; set; }
        public string Fax1 { get; set; }
        public string CountiesOfOperation { get; set; }
    }
}
