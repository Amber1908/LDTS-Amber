using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LDTS.Models
{
    public class UnitBasedata
    {
        public string UnitName { get; set; }
        public string UnitDesc { get; set; }

        //公司統編
        public string UnitID { get; set; }
        public string UnitPhone { get; set; }
        public string UnitAddr { get; set; }
        public string UnitEmail { get; set; }
        public string UnitContact { get; set; }
        public string UnitContactPhone { get; set; }
        public string UnitContactEmail { get; set; }
        public string UnitBoss { get; set; }
        public string UnitBossPhone { get; set; }
        public string UnitBossEmail { get; set; }
        public int UnitIcon { get; set; }
    }
}