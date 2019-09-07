using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class CfProfileContact
    {
        public int IdprofileContact { get; set; }
        public Guid UserId { get; set; }
        public int? IdprofileAccount { get; set; }
        public int? IdclientAccessLevel { get; set; }
        public string UserRole { get; set; }
        public Guid? IdmodifiedUser { get; set; }
        public DateTime? EnterDate { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public int? Idprefix { get; set; }
        public int? Idpostfix { get; set; }
        public int? Idtitle { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public string Mi { get; set; }
        public string Title { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string County { get; set; }
        public string Country { get; set; }
        public string Zip { get; set; }
        public string MailMergeCode { get; set; }
        public string Telephone1 { get; set; }
        public string Ext1 { get; set; }
        public string Telephone2 { get; set; }
        public string Ext2 { get; set; }
        public string Telephone3 { get; set; }
        public string Ext3 { get; set; }
        public string CellPhone { get; set; }
        public string Fax1 { get; set; }
        public string Fax2 { get; set; }
        public string EmailMergeCode { get; set; }
        public string WebSite { get; set; }
        public string Notes { get; set; }
        public string NotesCf { get; set; }
        public string Imapusername { get; set; }
        public string Imappassword { get; set; }
        public string ImapdraftsFolder { get; set; }
    }
}
