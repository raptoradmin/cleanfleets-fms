using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class CfUserTerminals
    {
        public int IduserTerminals { get; set; }
        public int IdprofileTerminal { get; set; }
        public Guid UserId { get; set; }
        public string PermissionLevel { get; set; }
    }
}
