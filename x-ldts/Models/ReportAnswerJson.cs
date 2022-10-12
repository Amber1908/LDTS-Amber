using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LDTS.Models
{
    public class ReportAnswerJson
    {
        public string insertorUpdate { get; set; }
        public string admin_id{ get; set; }
        public int QID { get; set; }
        public int AID { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string ExtendName { get; set; }
        public string OutputJson { get; set; }
        public int Status { get; set; }
    }
}