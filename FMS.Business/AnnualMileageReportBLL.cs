using FMS.Entity.Criteria;
using FMS.Entity.DTO;
using FMS.Repository.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace FMS.Business
{
    public class AnnualMileageReportBLL : BaseBusiness 
    {
        public List<AnnualMileageReportDTO> GetAnnualMileageReport(AnnualMileageReportSearchCriteria criteria)
        {
            var vehicles = (from v in context.CfVehicles
                            join f in context.CfProfileFleet on v.IdprofileFleet equals f.IdprofileFleet
                            join t in context.CfProfileTerminal on f.IdprofileTerminal equals t.IdprofileTerminal
                            join a in context.CfProfileAccount on t.IdprofileAccount equals a.IdprofileAccount
                            where a.IdprofileAccount == criteria.AccountId
                            select new
                            {
                                Vehicle = v,
                                Fleet = f,
                                Terminal = t,
                                Account = a
                            });

            if (criteria.FleetId != 0)
            {
                vehicles = vehicles.Where(v => criteria.FleetId == v.Fleet.IdprofileFleet);
            }
            if (criteria.TerminalId != 0)
            {
                vehicles = vehicles.Where(v => criteria.TerminalId == v.Terminal.IdprofileTerminal);
            }
            vehicles.ToList();

            var list = new List<AnnualMileageReportDTO>();
            foreach (var v in vehicles)
            {
                var dto = new AnnualMileageReportDTO {
                    Location = string.Format("{0}/{1}", v.Terminal.TerminalName, v.Fleet.FleetName),
                    UnitNumber = v.Vehicle.UnitNo.ToString(),
                    VIN = v.Vehicle.ChassisVin
                };

                var m2 = (from m in context.CfVehiclesLogMileage
                          where v.Vehicle.Idvehicles == m.Idvehicles && (DateTime.Now.Year - 2) == ((DateTime)m.MileageDate).Year
                          select m).OrderByDescending(d => d.EnterDate).FirstOrDefault();
                if (null != m2)
                {
                    dto.MileageDateTwoYearsAgo = ((DateTime)m2.MileageDate).ToShortDateString();
                    dto.MileageTwoYearsAgo = m2.Mileage.ToString();
                }
                else
                {
                    dto.MileageDateTwoYearsAgo =
                    dto.MileageTwoYearsAgo = string.Empty;
                }

                var m1 = (from m in context.CfVehiclesLogMileage
                          where v.Vehicle.Idvehicles == m.Idvehicles && (DateTime.Now.Year - 1) == ((DateTime)m.MileageDate).Year
                          select m).OrderByDescending(d => d.EnterDate).FirstOrDefault();
                if (null != m1)
                {
                    dto.MileageDateLastYear = ((DateTime)m1.MileageDate).ToShortDateString();
                    dto.MileageLastYear = m1.Mileage.ToString();
                }
                else
                {
                    dto.MileageDateLastYear =
                    dto.MileageLastYear = string.Empty;
                }


                var mc = (from m in context.CfVehiclesLogMileage
                          where v.Vehicle.Idvehicles == m.Idvehicles && (DateTime.Now.Year) == ((DateTime)m.MileageDate).Year
                          select m).OrderByDescending(d => d.EnterDate).FirstOrDefault();

                if (null != mc)
                {
                    dto.MileageDateCurrentYear = ((DateTime)mc.MileageDate).ToShortDateString();
                    dto.MileageCurrentYear = mc.Mileage.ToString();
                }
                else
                {
                    dto.MileageDateCurrentYear =
                    dto.MileageCurrentYear = string.Empty;
                }

                var mileage2 = 0;
                var mileage1 = 0;
                var mileagec = 0;
                //dtm = "do the math"
                bool dtm2 = Int32.TryParse(dto.MileageTwoYearsAgo, out mileage2);
                bool dtm1 = Int32.TryParse(dto.MileageLastYear, out mileage1);
                bool dtmc = Int32.TryParse(dto.MileageCurrentYear, out mileagec);

                if (dtm2 && dtm1)
                {
                    dto.MilesTwoYearsAgo = (mileage1 - mileage2).ToString();
                }
                else
                {
                    dto.MilesTwoYearsAgo = 
                    dto.MilesAverage = "Missing Entry";
                }

                if (dtm1 && dtmc)
                {
                    dto.MilesLastYear = (mileagec - mileage1).ToString();
                }
                else
                {
                    dto.MilesLastYear =
                    dto.MilesAverage = "Missing Entry";
                }


                if (dtm1 && dtm2 && dtmc) dto.MilesAverage = ((Convert.ToInt32(dto.MilesLastYear) + Convert.ToInt32(dto.MilesTwoYearsAgo)) / 2).ToString();

                list.Add(dto);
            }
            list = list.OrderBy(ob => ob.Location).ThenBy(tb => tb.UnitNumber).ToList();

            return list;
        }         
    }
}
