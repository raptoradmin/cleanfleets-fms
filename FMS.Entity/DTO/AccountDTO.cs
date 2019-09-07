using System;
using System.Collections.Generic;
using System.Text;
using FMS.Entity.Interface;

namespace FMS.Entity.DTO
{
    public class AccountDTO : IBaseEntity
    {
        public int IdprofileAccount { get; set; }
        public Guid? IdmodifiedUser { get; set; }
        public int? Test { get; set; }
        public DateTime? EnterDate { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public int? IdaccountParent { get; set; }
        public int? IdsalesRep { get; set; }
        public int? Idcsr { get; set; }
        public int? IdprimaryContact { get; set; }
        public string IsCorpHq { get; set; }
        public string AccountName { get; set; }
        public string AccountNum { get; set; }
        public string ContractNum { get; set; }
        public string ReferredBy { get; set; }
        public int? Idclass78BactreplacementSchedule { get; set; }
        public string PayType { get; set; }
        public int? Discount { get; set; }
        public DateTime? DiscountUntilDate { get; set; }
        public string Region { get; set; }
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
        public string Fax1 { get; set; }
        public string Fax2 { get; set; }
        public string Email { get; set; }
        public string WebSite { get; set; }
        public string Notes { get; set; }
        public string NotesCf { get; set; }
        public string PsipnotificationEmail { get; set; }
        public string Psipmonth { get; set; }
        public string Imapusername { get; set; }
        public string Imappassword { get; set; }
        public string ImapdraftsFolder { get; set; }

    }
}
