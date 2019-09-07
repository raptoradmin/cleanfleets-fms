using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class AspnetUsersInRoles
    {
        public Guid UserId { get; set; }
        public Guid RoleId { get; set; }

        public AspnetRoles Role { get; set; }
        public AspnetUsers User { get; set; }
    }
}
