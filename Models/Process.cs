using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LDTS.Models
{
    public class Process
    {
        public int PID { get; set; }
        public string Pname { get; set; }
        public string Description { get; set; }
        public int Pindex { get; set; }
        public DateTime CreateDate { get; set; }
        public string CreateMan { get; set; }
        public string old_filename { get; set; }
        public string new_filename { get; set; }
    }

}