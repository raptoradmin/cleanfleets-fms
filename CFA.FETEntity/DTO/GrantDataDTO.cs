using System;
using System.Collections.Generic;

namespace CFA.FETEntity.DTO
{
    [Serializable]
    public class GrantDataDTO : BaseEntity<GrantDataDTO>, IBaseEntity
    {
        public GrantDataDTO()
        {
            CreateDate = DateTime.Now.ToString();

        }

        public long GrantDataId { get; set; }
        public int? AccountId { get; set; }
        public string StateId { get; set; }

        public string Company { get; set; }

        public string RepresentativeName { get; set; }
        public string RepresentativePhone { get; set; }
        public string RepresentativeEmailAddress { get; set; }

        public string AltRepresentativeName { get; set; }
        public string AltRepresentativePhone { get; set; }
        public string AltRepresentativeEmailAddress { get; set; }

        public string Alt2RepresentativeName { get; set; }
        public string Alt2RepresentativePhone { get; set; }
        public string Alt2RepresentativeEmailAddress { get; set; }

        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Zip { get; set; }

        public string TypeEntity { get; set; } //Public/Private
        public string Comments { get; set; } //CT project summary

        //Florida

        public int? TrucksOwned { get; set; }
        public string TypeTrucksOwned { get; set; }
        public int? CountiesInOperation { get; set; }
        public string TruckReplacementSchedule { get; set; }
        public string TruckReplacementProcess { get; set; }

        public List<TerminalCountyDTO> TerminalCountyList { get; set; }
        public List<GrantDataVehicleClassDTO> VehicleClassList{ get; set; }

        //Connecticut
        //Part I
        public Boolean CTPreviousProposal { get; set; } //yes/no
        //Additional checkboxes based on CTAdditionalProposals > 0  
        public int CTAdditionalProposals { get; set; }


        //Part II A
        public string ProjectTitle { get; set; }
        public bool ReplacementRepowerProject { get; set; } //always true
        public bool CompletedPartVI { get; set; }
        public bool FiveYearCertificate { get; set; }
        public bool SiteControl { get; set; }
        public bool SchoolBus { get; set; }
        public string ContractDuration { get; set; }
        public DateTime ContractExpirationDate { get; set; }
        public string ProjectSummary { get; set; }
        public string FundingSource { get; set; }
        public string FundingTimeline { get; set; }

        //Part II B - GrantDataCTReplacementExpense
        public string VehicleMake { get; set; }
        public string VehicleModel { get; set; }
        public string VehicleYear { get; set; }

        public string EngineMake { get; set; }
        public string EngineMakeModel { get; set; }
        public string EngineYear { get; set; }

        public string ProjectedMileage { get; set; }
        public string ReplacementCount { get; set; }
        public string ReplacementCost { get; set; }

        public List<GrantDataCTReplacementExpenseDTO> ReplacementExpense{ get; set; }
}
}
