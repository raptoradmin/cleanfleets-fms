using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class CfCustomModuleContents
    {
        public int IdcustomModuleContents { get; set; }
        public int? IdcustomModule { get; set; }
        public Guid? Idfile { get; set; }
        public int? Idtype { get; set; }
    }
}
