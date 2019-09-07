using System;
using System.Collections.Generic;
using System.Text;

namespace CFA.FETEntity.DTO
{
    [Serializable]
    public partial class TerminalDTO
    {
        public int TerminalId { get; set; }
        public int? AccountId { get; set; }
        public string AccountName { get; set; }
        public string TerminalName { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string County { get; set; }
        public string Zip { get; set; }
        public string Telephone1 { get; set; }
        public string Ext1 { get; set; }
        public string Telephone2 { get; set; }
        public string Ext2 { get; set; }
        public string Telephone3 { get; set; }
        public string Ext3 { get; set; }
        public string Fax1 { get; set; }
        public string Fax2 { get; set; }
        public string Email { get; set; }
        public string WebSite { get; set; }
        public string Notes { get; set; }
        public string NotesCf { get; set; }
        public AccountDTO Account { get; set; }
        public List<FleetDTO> Fleets {get; set;}
        public List<TerminalCountyDTO> CountiesOfOperation { get; set; }


    }
}
