using System;
using System.Collections.Generic;
using System.Text;

namespace CFA.FETEntity.DTO
{
    [Serializable]
    public class AccountDTO
    {
        public int AccountId { get; set; }
        public Guid? ModifiedUserId { get; set; }
        public int? Test { get; set; }
        public DateTime? EnterDate { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public int? AccountParentId { get; set; }
        public int? SalesRepId { get; set; }
        public int? CsrId { get; set; }
        public int? PrimaryContactId{ get; set; }
        public string IsCorpHq { get; set; }
        public string AccountName { get; set; }
        public string AccountNum { get; set; }
        public string ContractNum { get; set; }
        public string ReferredBy { get; set; }
        public int? Class78BactReplacementScheduleId { get; set; }
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
        public string PsipNotificationEmail { get; set; }
        public string PsipMonth { get; set; }
        public string ImapUsername { get; set; }
        public string ImapPassword { get; set; }
        public string ImapDraftsFolder { get; set; }

        public List<TerminalDTO> Terminals { get; set; }
        public List<GrantDataDTO> GrantDataApplications { get; set; }
    }
}
