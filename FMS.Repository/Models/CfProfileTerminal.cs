﻿using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class CfProfileTerminal
    {
        public CfProfileTerminal()
        {
            CfProfileFleet = new HashSet<CfProfileFleet>();
        }

        public int IdprofileTerminal { get; set; }
        public Guid? IdmodifiedUser { get; set; }
        public DateTime? EnterDate { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public int? IdprofileAccount { get; set; }
        public int? IdprimaryContact { get; set; }
        public string TerminalName { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string County { get; set; }
        public string Country { get; set; }
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

        public CfProfileAccount IdprofileAccountNavigation { get; set; }
        public ICollection<CfProfileFleet> CfProfileFleet { get; set; }
    }
}