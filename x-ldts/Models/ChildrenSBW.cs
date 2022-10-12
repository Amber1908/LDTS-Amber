using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using LDTS.Models;

namespace LDTS.Models
{
    public class ChildrenSBW
    {
        public int SID { get; set; }
        public string Sname { get; set; }
        public List<ChildForm> ChildrenSWBforms { get; set; }
    }
}