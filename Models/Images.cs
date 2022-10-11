using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LDTS.Models
{
    public class Images
    {
        public int image_id { get; set; }
        public Byte[] image_bytes { get; set; }
        public string memo { get; set; }
        public DateTime createtime { get; set; }
    }
}