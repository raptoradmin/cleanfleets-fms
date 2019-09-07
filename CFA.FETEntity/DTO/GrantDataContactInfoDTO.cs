using System;
using System.Collections.Generic;
using System.Text;

namespace CFA.FETEntity.DTO
{
    [Serializable]
    public class GrantDataContactInfoDTO: BaseEntity<GrantDataContactInfoDTO>, IBaseEntity 
    {
        
        public GrantDataContactInfoDTO()
        {
            CreateDate = DateTime.Now.ToString();
        }
        public int GrantDataContactInfoId { get; set; }
        public long GrantDataId { get; set; }
        public string Name { get; set; }
        public string Company { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string CityStateZip { get; set; }
        public string Phone { get; set; }
        public string EmailAddress { get; set; }

        public int NumberTrucksOwned { get; set; }
        public string TypeTrucksOwned { get; set; }
        public string TypeEntity { get; set; }
        public int NumberCountiesInOperation { get; set; }
        public string TruckReplacementSchedule { get; set; }
        public string TruckReplacementProcess { get; set; }


    }
}
