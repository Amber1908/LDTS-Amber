using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LDTS.Models
{
    public class ReProcessQuestion
    {
        public int PID { get; set; }
        public int QID { get; set; }
        public DateTime CreateDate { get; set; }
    }
}