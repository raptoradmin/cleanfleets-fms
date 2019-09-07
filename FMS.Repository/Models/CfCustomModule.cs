using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class CfCustomModule
    {
        public int IdcustomModule { get; set; }
        public int? IdprofileAccount { get; set; }
        public string ModuleName { get; set; }
    }
}
