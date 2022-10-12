using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LDTS.Models
{
    public class ReportQuestionFile
    {
        public int QID { get; set; }
        public string Version { get; set; }
        public string TemplateFile { get; set; }
        public DateTime CreateDate { get; set; }
    }
}