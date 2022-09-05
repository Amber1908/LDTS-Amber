using System;
using System.Drawing;
using System.Web.UI.WebControls;
using LDTS.Models;
using LDTS.Service;

namespace LDTS
{
    public partial class AlertSettingList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            string ot;
            string[] ots;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                ot = e.Row.Cells[2].Text;
                switch (ot)
                {
                    case "1":
                        e.Row.Cells[2].Text = "年";
                        break;
                    case "2":
                        e.Row.Cells[2].Text = "季";
                        break;
                    case "3":
                        e.Row.Cells[2].Text = "月";
                        break;
                    case "4":
                        e.Row.Cells[2].Text = "週";
                        break;
                }

                ot = e.Row.Cells[3].Text;
                ots = ot.Split(',');
                ot = "<ul>";
                foreach (var s in ots)
                {
                    ot += $"<li>{s}</li>";
                }
                ot += "</ul>";
                e.Row.Cells[3].Text = ot;

                ot = e.Row.Cells[4].Text;
                ots = ot.Split(',');
                ot = "<ul>";
                foreach (var s in ots)
                {
                    ReportQuestion rq = ReportQuestiovService.GetReportQuestions(s);
                    if(rq != null)
                        ot += $"<li class='formnamelist' style=\"cursor: pointer;\">{rq.Title}</li>";
                }
                ot += "</ul>";
                e.Row.Cells[4].Text = ot;

                ot = e.Row.Cells[5].Text;
                switch (ot)
                {
                    case "1":
                        e.Row.Cells[5].Text = "啟用";
                        e.Row.Cells[5].ForeColor = Color.Lime;
                        break;
                    default:
                        e.Row.Cells[5].Text = "停用";
                        e.Row.Cells[5].ForeColor = Color.Silver;
                        break;
                }



                LinkButton del = e.Row.Cells[7].Controls[0] as LinkButton;
                del.Attributes.Add("onclick", "return confirm('確定要刪除提醒 : " + e.Row.Cells[1].Text + " ?');");
            }
        }
    }
}