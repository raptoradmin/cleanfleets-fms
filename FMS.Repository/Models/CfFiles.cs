using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class CfFiles
    {
        public Guid Idfile { get; set; }
        public DateTime? EnterDate { get; set; }
        public Guid? IdmodifiedUser { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public int? IddocumentType { get; set; }
        public string Title { get; set; }
        public string FileName { get; set; }
        public string FileSize { get; set; }
        public string FilePath { get; set; }
        public int? IdprofileAccount { get; set; }
        public int? IdprofileTerminal { get; set; }
        public int? IdprofileFleet { get; set; }
        public Guid? Idvehicles { get; set; }
        public Guid? Idengines { get; set; }
        public Guid? Iddecs { get; set; }
        public string Notes { get; set; }
    }
}
