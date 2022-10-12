using System;
using LDTS.Models;
using LDTS.Service;

namespace LDTS
{
    public partial class ReportAnswerSearch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (searchText.Text.Length > 0)
            {
                string Swbstr = "";
                var ras = ReportAnswerService.GetAnswersByKey(searchText.Text);

                Swbstr += "<table class=\"table\">";
                Swbstr += "<thead>";
                Swbstr += "<tr>";
                Swbstr += "<th>表單名稱</th><th>自定義名稱</th><th>表單狀態</th><th>版本號</th><th>關鍵字</th><th>建立時間</th><th>編輯</th>";
                Swbstr += "</tr>";
                Swbstr += "</thead>";
                Swbstr += "<tbody>";

                foreach(var ra in ras)
                {
                    Swbstr += "<tr>";
                    Swbstr += $"<td>{ra.Title}</td>";
                    Swbstr += $"<td>{ra.ExtendName}</td>";
                    Swbstr += $"<td>{ReportAnswerService.MatchStatus(ra.Status)}</td>";
                    Swbstr += $"<td>{ra.Version}</td>";
                    Swbstr += $"<td>{ra.Keyword}</td>";
                    Swbstr += $"<td>{ra.CreateDate:yyyy/MM/dd}</td>";
                    Swbstr += $"<td><a href=\"ReportQuestionEdit?aid={ra.AID}\"><i class=\"fa fa-edit\"></i></a></td>";
                    Swbstr += "</tr>";
                }

                Swbstr += "<tbody>";
                Swbstr += "</table>";
                SearchDiv.InnerHtml = Swbstr;
            }
        }
    }
}