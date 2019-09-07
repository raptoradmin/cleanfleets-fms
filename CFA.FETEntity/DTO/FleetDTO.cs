using System;
using System.Collections.Generic;
using System.Text;

namespace CFA.FETEntity.DTO
{
    [Serializable]
    public class FleetDTO
    {
        public FleetDTO()
        {
            Vehicles = new HashSet<VehicleDTO>();
        }

        public int FleetId { get; set; }
        public Guid? ModifiedUserId { get; set; }
        public DateTime? EnterDate { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public int? TerminalId { get; set; }
        public int? PrimaryContactId { get; set; }
        public int? RuleCodeId { get; set; }
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

        public TerminalDTO Terminal { get; set; }
        public ICollection<VehicleDTO> Vehicles { get; set; }
    }
}
