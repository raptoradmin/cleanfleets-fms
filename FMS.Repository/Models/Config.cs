using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class Config
    {
        public int Uid { get; set; }
        public string CreationUserName { get; set; }
        public DateTime? CreationDate { get; set; }
        public string ParameterCode { get; set; }
        public string ParameterValue { get; set; }
    }
}
