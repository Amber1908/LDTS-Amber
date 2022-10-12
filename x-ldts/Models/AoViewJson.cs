using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace LDTS.Models
{
    public class AoViewJson
    {
        public string admin_id { get; set; }
        public int PID { get; set; }
        public string Pname { get; set; }
        public List<ChildrenSBW> ChildrenSwbs { get; set; }
        public List<ChildForm> ChildrenForms { get; set; }
    }
}