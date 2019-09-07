using System;
using System.Collections.Generic;

namespace FMS.Repository.Models
{
    public partial class CfEngines
    {
        public CfEngines()
        {
            CfDecs = new HashSet<CfDecs>();
        }

        public Guid Idengines { get; set; }
        public Guid? IdmodifiedUser { get; set; }
        public DateTime? EnterDate { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public int? IdprofileAccount { get; set; }
        public Guid? Idvehicles { get; set; }
        public int? IdengineManufacturer { get; set; }
        public string EngineModel { get; set; }
        public int? IdengineStatus { get; set; }
        public int? IdengineFuelType { get; set; }
        public int? IdmodelYear { get; set; }
        public string SerialNum { get; set; }
        public string FamilyName { get; set; }
        public string SeriesModelNo { get; set; }
        public string Horsepower { get; set; }
        public string Description { get; set; }
        public string Hours { get; set; }
        public string Miles { get; set; }
        public string Notes { get; set; }
        public string NotesCf { get; set; }
        public string Displacement { get; set; }
        public decimal? EstRetrofitCost { get; set; }

        public CfVehicles IdvehiclesNavigation { get; set; }
        public ICollection<CfDecs> CfDecs { get; set; }
    }
}
