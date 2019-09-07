using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class ConfigDsc
    {
        public int Uid { get; set; }
        public string ParameterCode { get; set; }
        public string ParameterDescription { get; set; }
    }
}
