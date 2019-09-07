using System;
using System.Collections.Generic;
using System.Text;

namespace CFA.FETEntity.DTO
{
    [Serializable]
    public class GrantDataVehicleClassDTO : BaseEntity<GrantDataVehicleClassDTO>, IBaseEntity
    {
        public GrantDataVehicleClassDTO()
        {
            CreateDate = DateTime.Now.ToString();
        }
        public long GrantDataVehicleClassId { get; set; }
        public long GrantDataId { get; set; }
        public int VehicleYear { get; set; }
        public int VehicleClass { get; set; }
        public int VehicleCount { get; set; }
        public int AverageMiles { get; set; }
        public int AverageGallons { get; set; }
        public int AverageIdleHours { get; set; }
        public int LifeExpectancy { get; set; }

        public string CTVehicleMake {get;set;} 
        public string CTVehicleModel { get; set; }
        public string CTCost { get; set; }
        public string CTMileage { get; set; }
        public string EngineMake { get; set; }
        public string EngineModel { get; set; }
        public string EngineSerialNumber { get; set; }
        public string CTReplacementType { get; set; }
        public string CTNumberOfReplacments { get; set; }
        public string Warning { get; set; }
    }
}
