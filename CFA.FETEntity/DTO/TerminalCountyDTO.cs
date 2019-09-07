using System;
using System.Collections.Generic;
using System.Text;

namespace CFA.FETEntity.DTO
{
    [Serializable]
    public class TerminalCountyDTO
    {
        public long TerminalCountyId { get; set; }
        public int AccountId { get; set; } 
        public int TerminalId { get; set; }
        public string CountyName { get; set; }
        public string StateAbbreviation { get; set; }
        public int NumberOfTrucks { get; set; }
    }
}
