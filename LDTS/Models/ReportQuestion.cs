using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LDTS.Models
{
    public class ReportQuestion
    {
        public int QID { get; set; }
        public string Title { get; set; }
        public string OutputJson { get; set; }
        public DateTime CreateDate { get; set; }
        public string CreateMan { get; set; }
        public int Status { get; set; }
        public string Description { get; set; }
        public string Version { get; set; }
        public DateTime LastupDate { get; set; }
        public string LastupMan { get; set; }

    }
}