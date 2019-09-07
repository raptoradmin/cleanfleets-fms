using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class CfMenuConsole
    {
        public int DataFieldId { get; set; }
        public int? DataFieldParentId { get; set; }
        public string DataTextField { get; set; }
        public string DataNavigateUrlField { get; set; }
        public string ImageUrl { get; set; }
    }
}
