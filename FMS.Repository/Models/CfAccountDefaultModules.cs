using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class CfAccountDefaultModules
    {
        public int IdaccountDefaultModules { get; set; }
        public int? IdprofileAccount { get; set; }
        public int? IddefaultModule { get; set; }
        public string IsDisplayed { get; set; }
    }
}
