using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class CfOptionList
    {
        public int IdoptionList { get; set; }
        public string RecordValue { get; set; }
        public string DisplayValue { get; set; }
        public string OptionName { get; set; }
    }
}
