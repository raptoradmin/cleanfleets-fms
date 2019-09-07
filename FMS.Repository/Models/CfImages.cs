using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class CfImages
    {
        public Guid Idimages { get; set; }
        public Guid? IdmodifiedUser { get; set; }
        public bool? DefaultImage { get; set; }
        public DateTime? EnterDate { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public Guid? Idvehicles { get; set; }
        public Guid? Idengines { get; set; }
        public Guid? Iddecs { get; set; }
        public string Title { get; set; }
        public string FilePath { get; set; }
        public string FileName { get; set; }
        public Guid? UserId { get; set; }
    }
}
