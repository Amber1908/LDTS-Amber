using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LDTS.Models
{
    public class Admin_WorkRecord
    {
        public int sn { get; set; }
        public string admin_id { get; set; }
        public string work_content { get; set; }
        public DateTime createtime { get; set; }
    }
}