using System;
using System.Collections.Generic;
using System.Text;

namespace FMS.Entity.DTO
{
    public class FleetDTO
    {
        public int IdprofileFleet { get; set; }
        public Guid? IdmodifiedUser { get; set; }
        public DateTime? EnterDate { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public int? IdprofileTerminal { get; set; }
        public int? IdprimaryContact { get; set; }
        public int? IdruleCode { get; set; }
        public string FleetName { get; set; }
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
    }
}
