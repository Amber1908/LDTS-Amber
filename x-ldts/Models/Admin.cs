using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LDTS.Models
{
    public class Admin
    {
        public string admin_id { get; set; }
        public string admin_password { get; set; }
        public string admin_name { get; set; }
        public string admin_phone { get; set; }
        public string admin_email { get; set; }
        public string admin_job { get; set; }
        public string admin_ao { get; set; }
        public int admin_image { get; set; }
        public int admin_sign { get; set; }
        public int status { get; set; }
        public string memo { get; set; }
        public DateTime createtime { get; set; }
    }
}