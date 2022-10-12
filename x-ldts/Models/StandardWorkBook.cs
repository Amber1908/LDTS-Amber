using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LDTS.Models
{
    public class StandardWorkBook
    {
        public int SID { get; set; }
        public string Sname { get; set; }
        public int Sindex { get; set; }
        public string old_filename { get; set; }
        public string new_filename { get; set; }
        public DateTime CreateDate { get; set; }
        public string Description { get; set; }
        public string CreateMan { get; set; }
    }
}