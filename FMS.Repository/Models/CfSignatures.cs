using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class CfSignatures
    {
        public Guid Idsignature { get; set; }
        public DateTime? EnterDate { get; set; }
        public Guid? IdmodifiedUser { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public string FilePath { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
    }
}
