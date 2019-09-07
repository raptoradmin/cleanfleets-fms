using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class CfDecs
    {
        public Guid Iddecs { get; set; }
        public Guid? IdmodifiedUser { get; set; }
        public DateTime? EnterDate { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public int? IdprofileAccount { get; set; }
        public Guid? Idengines { get; set; }
        public string SerialNo { get; set; }
        public string Decsname { get; set; }
        public int? Iddecsmanufacturer { get; set; }
        public int? Iddecslevel { get; set; }
        public string DecsmodelNo { get; set; }
        public DateTime? DecsinstallationDate { get; set; }
        public string Notes { get; set; }
        public string NotesCf { get; set; }

        public CfEngines IdenginesNavigation { get; set; }
    }
}
