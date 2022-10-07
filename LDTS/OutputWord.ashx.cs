using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using LDTS.Models;
using LDTS.Service;
using LDTS.Utils;
using Newtonsoft.Json.Linq;
using TemplateEngine.Docx;

namespace LDTS
{
    /// <summary>
    /// OutputWord 的摘要描述
    /// </summary>
    public class OutputWord : IHttpHandler
    {
        static readonly Logger logger = new Logger("OutputWord");

        public void ProcessRequest(HttpContext context)
        {
            string AID = context.Request["AID"];
            string new_filename = PublicUtil.GenFilename(".docx");
            string new_filepath = HttpContext.Current.Server.MapPath("~/Template/") + new_filename;
            UnitBasedata unitBasedata = UnitService.GetUnit();
            try
            {
                context.Response.Clear();
                context.Response.Buffer = true;
                context.Response.Charset = "utf-8";
                context.Response.ContentEncoding = Encoding.GetEncoding("utf-8");
                context.Response.ContentType = "application/vnd.ms-word";

                ReportAnswer ra = ReportAnswerService.GetReportAnswer(AID);

                if (ra == null || ra.OutputTemplate.Length < 6)
                {
                    context.Response.StatusCode = (int)HttpStatusCode.BadRequest;
                }
                else
                {
                    context.Response.AddHeader("Content-Disposition", $"attachment;filename={ra.Title}_{ra.ExtendName}.docx");
                    File.Copy(HttpContext.Current.Server.MapPath("~/Upload/") + ra.OutputTemplate, new_filepath);
                    JObject obj = JObject.Parse(ra.OutputJson);
                    Content valuesToFill;
                    TableContent tableFill;
                    JArray rows, cols;
                    bool hasSN = false;
                    int rowSN = 0;

                    using (var outputDocument = new TemplateProcessor(new_filepath).SetRemoveContentControls(true))
                    {
                        // 表頭處理
                        byte[] imgMark = PublicUtil.readImage(unitBasedata.UnitWatermark);
                        valuesToFill = new Content(new ImageContent("Watermark", imgMark));
                        outputDocument.FillContent(valuesToFill);

                        foreach (var group in obj["Groups"])
                        {
                            switch (group["GroupType"].Value<string>())
                            {
                                case "normal":
                                    foreach (var question in group["Questions"])
                                    {
                                        var Answers = (JArray)question["Answers"];
                                        if (Answers == null || Answers.Count < 1)
                                            continue;
                                        var Fills = (JArray)question["fillings"];
                                        if (Fills != null)
                                        {
                                            for (int i = 0; i < Fills.Count; i++)
                                            {
                                                valuesToFill = new Content(new FieldContent($"{question["QuestionID"]}${i + 1}", Fills[i]["value"].Value<string>()));
                                                outputDocument.FillContent(valuesToFill);
                                            }
                                        }
                                        switch (question["QuestionType"].Value<string>())
                                        {
                                            case "text":
                                            case "number":
                                                valuesToFill = new Content(new FieldContent((string)question["QuestionID"], Answers[0]["value"].Value<string>()));
                                                outputDocument.FillContent(valuesToFill);
                                                break;
                                            case "date":
                                                DateTimeOffset dateTimeOffset = DateTimeOffset.FromUnixTimeMilliseconds(Answers[0]["value"].Value<long>());
                                                valuesToFill = new Content(new FieldContent(question["QuestionID"].Value<string>(), dateTimeOffset.ToLocalTime().ToString("yyyy/MM/dd")));
                                                outputDocument.FillContent(valuesToFill);
                                                break;
                                            case "sign":
                                                if (0 < Answers[0]["value"].Value<int>())
                                                {
                                                    var rotate = question["rotate"];
                                                    byte[] img = (rotate != null && (bool)rotate == true) ? PublicUtil.readImageR(Answers[0]["value"].Value<int>()) : PublicUtil.readImage(Answers[0]["value"].Value<int>());
                                                    valuesToFill = new Content(new ImageContent(question["QuestionID"].Value<string>(), img));
                                                    outputDocument.FillContent(valuesToFill);
                                                }
                                                break;
                                            case "radio":
                                                for (int i = 0; i < Answers.Count; i++)
                                                {
                                                    valuesToFill = new Content(new FieldContent($"{question["QuestionID"]}#{i + 1}", Answers[i]["value"].Value<bool>() ? "●" : "○"));
                                                    outputDocument.FillContent(valuesToFill);

                                                    var fills = (JArray)Answers[i]["fillings"];
                                                    if (fills != null && fills.Count > 0)
                                                    {
                                                        for (int j = 0; j < fills.Count; j++)
                                                        {
                                                            valuesToFill = new Content(new FieldContent($"{question["QuestionID"]}#{i + 1}${j + 1}", fills[j]["value"].Value<string>()));
                                                            outputDocument.FillContent(valuesToFill);
                                                        }
                                                    }
                                                }
                                                break;
                                            case "checkbox":
                                            case "CheckboxMixImage":
                                                for (int i = 0; i < Answers.Count; i++)
                                                {
                                                    valuesToFill = new Content(new FieldContent($"{question["QuestionID"]}#{i + 1}", Answers[i]["value"].Value<bool>() ? "■" : "□"));
                                                    outputDocument.FillContent(valuesToFill);

                                                    var fills = (JArray)Answers[i]["fillings"];
                                                    if (fills != null && fills.Count > 0)
                                                    {
                                                        for (int j = 0; j < fills.Count; j++)
                                                        {
                                                            valuesToFill = new Content(new FieldContent($"{question["QuestionID"]}#{i + 1}${j + 1}", fills[j]["value"].Value<string>()));
                                                            outputDocument.FillContent(valuesToFill);
                                                        }
                                                    }
                                                }
                                                break;
                                            case "RadioMixCheckbox":
                                                for (int i = 0; i < Answers.Count; i++)
                                                {
                                                    valuesToFill = new Content(new FieldContent($"{question["QuestionID"]}#{i + 1}", Answers[i]["value"].Value<bool>() ? "●" : "○"));
                                                    outputDocument.FillContent(valuesToFill);
                                                    var fills = (JArray)Answers[i]["fillings"];
                                                    if (fills != null && fills.Count > 0)
                                                    {
                                                        for (int j = 0; j < fills.Count; j++)
                                                        {
                                                            valuesToFill = new Content(new FieldContent($"{question["QuestionID"]}#{i + 1}${j + 1}", fills[j]["value"].Value<string>()));
                                                            outputDocument.FillContent(valuesToFill);
                                                        }
                                                    }

                                                    var checks = (JArray)Answers[i]["Answers"];
                                                    if (checks != null && checks.Count > 0)
                                                    {
                                                        for (int j = 0; j < checks.Count; j++)
                                                        {
                                                            valuesToFill = new Content(new FieldContent($"{question["QuestionID"]}#{i + 1}#{j + 1}", checks[j]["value"].Value<bool>() ? "■" : "□"));
                                                            outputDocument.FillContent(valuesToFill);

                                                            var fillsuns = (JArray)checks[j]["fillings"];
                                                            if (fillsuns != null && fillsuns.Count > 0)
                                                            {
                                                                for (int k = 0; k < fillsuns.Count; k++)
                                                                {
                                                                    valuesToFill = new Content(new FieldContent($"{question["QuestionID"]}#{i + 1}#{j + 1}${k + 1}", fillsuns[k]["value"].Value<string>()));
                                                                    outputDocument.FillContent(valuesToFill);
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                                break;
                                        }
                                    }
                                    break;
                                case "table":
                                    rows = (JArray)group["Rows"];
                                    if (rows.Count > 0)
                                    {
                                        for (int i = 0; i < rows.Count; i++)
                                        {
                                            cols = (JArray)rows[i]["Cols"];
                                            for (int j = 0; j < cols.Count; j++)
                                            {
                                                var Answers = (JArray)cols[j]["Answers"];
                                                if (Answers == null || Answers.Count < 1)
                                                    continue;
                                                var Fills = (JArray)cols[j]["fillings"];
                                                if (Fills != null)
                                                {
                                                    for (int k = 0; k < Fills.Count; k++)
                                                    {
                                                        valuesToFill = new Content(new FieldContent($"{group["GroupID"]}#{i + 1}#{j + 1}${k + 1}", Fills[k]["value"].Value<string>()));
                                                        outputDocument.FillContent(valuesToFill);
                                                    }
                                                }
                                                switch (cols[j]["QuestionType"].Value<string>())
                                                {
                                                    case "text":
                                                    case "number":
                                                        valuesToFill = new Content(new FieldContent($"{group["GroupID"]}#{i + 1}#{j + 1}", Answers[0]["value"].Value<string>()));
                                                        outputDocument.FillContent(valuesToFill);
                                                        break;
                                                    case "date":
                                                        if (Answers[0]["value"].Value<long>() == 0)
                                                        {
                                                            valuesToFill = new Content(new FieldContent($"{group["GroupID"]}#{i + 1}#{j + 1}", " "));
                                                            outputDocument.FillContent(valuesToFill);

                                                        }
                                                        else
                                                        {
                                                            DateTimeOffset dateTimeOffset = DateTimeOffset.FromUnixTimeMilliseconds(Answers[0]["value"].Value<long>());
                                                            valuesToFill = new Content(new FieldContent($"{group["GroupID"]}#{i + 1}#{j + 1}", dateTimeOffset.ToLocalTime().ToString("yyyy/MM/dd")));
                                                            outputDocument.FillContent(valuesToFill);
                                                        }
                                                        break;
                                                    case "sign":
                                                        if (0 < Answers[0]["value"].Value<int>())
                                                        {
                                                            var rotate = cols[j]["rotate"];
                                                            byte[] img = (rotate != null && (bool)rotate == true) ? PublicUtil.readImageR(Answers[0]["value"].Value<int>()) : PublicUtil.readImage(Answers[0]["value"].Value<int>());
                                                            valuesToFill = new Content(new ImageContent($"{group["GroupID"]}#{i + 1}#{j + 1}", img));
                                                            outputDocument.FillContent(valuesToFill);
                                                        }
                                                        break;
                                                    case "checkbox":
                                                    case "CheckboxMixImage":
                                                        for (int k = 0; k < Answers.Count; k++)
                                                        {
                                                            valuesToFill = new Content(new FieldContent($"{group["GroupID"]}#{i + 1}#{j + 1}#{k + 1}", Answers[k]["value"].Value<bool>() ? "■" : "□"));
                                                            outputDocument.FillContent(valuesToFill);

                                                            var fills = (JArray)Answers[k]["fillings"];
                                                            if (fills != null && fills.Count > 0)
                                                            {
                                                                for (int l = 0; l < fills.Count; l++)
                                                                {
                                                                    valuesToFill = new Content(new FieldContent($"{group["GroupID"]}#{i + 1}#{j + 1}#{k + 1}${l + 1}", fills[l]["value"].Value<string>()));
                                                                    outputDocument.FillContent(valuesToFill);
                                                                }
                                                            }
                                                        }
                                                        break;
                                                    case "radio":
                                                        for (int k = 0; k < Answers.Count; k++)
                                                        {
                                                            valuesToFill = new Content(new FieldContent($"{group["GroupID"]}#{i + 1}#{j + 1}#{k + 1}", Answers[k]["value"].Value<bool>() ? "●" : "○"));
                                                            outputDocument.FillContent(valuesToFill);

                                                            var fills = (JArray)Answers[k]["fillings"];
                                                            if (fills != null && fills.Count > 0)
                                                            {
                                                                for (int l = 0; l < fills.Count; l++)
                                                                {
                                                                    valuesToFill = new Content(new FieldContent($"{group["GroupID"]}#{i + 1}#{j + 1}#{k + 1}${l + 1}", fills[l]["value"].Value<string>()));
                                                                    outputDocument.FillContent(valuesToFill);
                                                                }
                                                            }
                                                        }
                                                        break;
                                                    case "RadioMixCheckbox":
                                                        for (int k = 0; k < Answers.Count; k++)
                                                        {
                                                            valuesToFill = new Content(new FieldContent($"{group["GroupID"]}#{i + 1}#{j + 1}#{k + 1}", Answers[k]["value"].Value<bool>() ? "●" : "○"));
                                                            outputDocument.FillContent(valuesToFill);

                                                            var fills = (JArray)Answers[k]["fillings"];
                                                            if (fills != null && fills.Count > 0)
                                                            {
                                                                for (int l = 0; l < fills.Count; l++)
                                                                {
                                                                    valuesToFill = new Content(new FieldContent($"{group["GroupID"]}#{i + 1}#{j + 1}#{k + 1}${l + 1}", fills[l]["value"].Value<string>()));
                                                                    outputDocument.FillContent(valuesToFill);
                                                                }
                                                            }

                                                            var checks = (JArray)Answers[k]["Answers"];
                                                            if (checks != null && checks.Count > 0)
                                                            {
                                                                for (int l = 0; l < checks.Count; l++)
                                                                {
                                                                    valuesToFill = new Content(new FieldContent($"{group["GroupID"]}#{i + 1}#{j + 1}#{k + 1}#{l + 1}", checks[l]["value"].Value<bool>() ? "■" : "□"));
                                                                    outputDocument.FillContent(valuesToFill);

                                                                    var fillsons = (JArray)checks[l]["fillings"];
                                                                    if (fillsons != null && fillsons.Count > 0)
                                                                    {
                                                                        for (int m = 0; m < fillsons.Count; m++)
                                                                        {
                                                                            valuesToFill = new Content(new FieldContent($"{group["GroupID"]}#{i + 1}#{j + 1}#{k + 1}#{l + 1}${m + 1}", fillsons[m]["value"].Value<string>()));
                                                                            outputDocument.FillContent(valuesToFill);
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        break;
                                                }
                                            }
                                        }
                                    }
                                    break;
                                case "row":
                                    tableFill = new TableContent(group["GroupID"].Value<string>());
                                    rows = (JArray)group["Rows"];
                                    if (rows.Count > 0)
                                    {
                                        hasSN = group["hasSN"].Value<int>() > -1;
                                        rowSN = group["hasSN"].Value<int>() < 0 ? 0 : group["hasSN"].Value<int>();
                                        for (int i = 2; i < rows.Count; i++)
                                        {
                                            cols = rows[i]["Cols"].Value<JArray>();
                                            tableFill.AddRow(GetRowList(cols, rowSN + i - 2, hasSN).ToArray());
                                        }
                                        valuesToFill = new Content(tableFill);
                                        outputDocument.FillContent(valuesToFill);
                                    }
                                    break;
                            }
                        }
                        outputDocument.SaveChanges();
                    }
                    context.Response.StatusCode = (int)HttpStatusCode.OK;
                    context.Response.WriteFile(new_filepath);
                }
            }
            catch (Exception ex)
            {
                logger.FATAL(ex.Message);
                context.Response.StatusCode = (int)HttpStatusCode.Conflict;
            }
            finally
            {
                context.Response.Flush();
                File.Delete(new_filepath);
            }
        }

        private List<IContentItem> GetRowList(JArray cols, int rowIndex, bool hasSN)
        {
            List<IContentItem> fi = new List<IContentItem>();
            string Temp;

            try
            {
                if (hasSN)
                    fi.Add(new FieldContent("sn", rowIndex.ToString()));

                for (int i = 0; i < cols.Count; i++)
                {
                    Temp = cols[i]["QuestionText"].Value<string>();

                    var Fills = (JArray)cols[i]["fillings"];
                    if (Fills != null)
                    {
                        for (int j = 0; j < Fills.Count; i++)
                        {
                            Temp = Temp.Replace($"##^{j + 1}", Fills[j]["value"].Value<string>());
                        }
                    }
                    if (Temp.Length > 0)
                        Temp += Environment.NewLine;

                    switch (cols[i]["QuestionType"].Value<string>())
                    {
                        case "text":
                        case "number":
                            Temp += cols[i]["Answers"][0]["value"].Value<string>();
                            fi.Add(new FieldContent($"col{i + 1}", Temp));
                            break;
                        case "date":
                            DateTimeOffset dateTimeOffset = DateTimeOffset.FromUnixTimeMilliseconds(cols[i]["Answers"][0]["value"].Value<long>());
                            Temp += dateTimeOffset.ToLocalTime().ToString("yyyy/MM/dd");
                            fi.Add(new FieldContent($"col{i + 1}", Temp));
                            break;
                        case "sign":
                            JArray s_answers = cols[i]["Answers"].Value<JArray>();
                            if (s_answers != null && s_answers.Count > 0 && s_answers[0]["value"].Value<int>() > 0)
                            {
                                var rotate = s_answers[0]["rotate"];
                                byte[] img = (rotate != null && (bool)rotate == true) ? PublicUtil.readImageR(s_answers[0]["value"].Value<int>()) : PublicUtil.readImage(s_answers[0]["value"].Value<int>());
                                fi.Add(new ImageContent($"col{i + 1}", img));
                            }
                            break;
                        case "checkbox":
                        case "CheckboxMixImage":
                            JArray answeroptions = cols[i]["AnswerOptions"].Value<JArray>();
                            JArray answers = cols[i]["Answers"].Value<JArray>();
                            for (int j = 0; j < answers.Count; j++)
                            {
                                Temp += answers[j]["value"].Value<bool>() ? "■" : "□";
                                Temp += $" {answeroptions[j]["AnsText"].Value<string>()} " + Environment.NewLine;

                                var Fillsons = (JArray)answers[j]["fillings"];
                                if (Fillsons != null)
                                {
                                    for (int k = 0; k < Fillsons.Count; i++)
                                    {
                                        Temp = Temp.Replace($"##^{k + 1}", Fillsons[k]["value"].Value<string>());
                                    }
                                }
                            }
                            fi.Add(new FieldContent($"col{i + 1}", Temp));
                            break;
                        case "radio":
                            JArray r_answeroptions = cols[i]["AnswerOptions"].Value<JArray>();
                            JArray r_answers = cols[i]["Answers"].Value<JArray>();//第一層
                            for (int j = 0; j < r_answers.Count; j++)
                            {
                                Temp += r_answers[j]["value"].Value<bool>() ? "●" : "○";
                                Temp += $" {r_answeroptions[j]["AnsText"].Value<string>()} " + Environment.NewLine;

                                var Fillsons = (JArray)r_answers[j]["fillings"];
                                if (Fillsons != null)
                                {
                                    for (int k = 0; k < Fillsons.Count; k++)
                                    {
                                        Temp = Temp.Replace($"##^{k + 1}", Fillsons[k]["value"].Value<string>());
                                    }
                                }
                            }
                            fi.Add(new FieldContent($"col{i + 1}", Temp));
                            break;
                        case "RadioMixCheckbox":
                            JArray r_answeroptions_1 = cols[i]["AnswerOptions"].Value<JArray>();
                            JArray r_answers_1 = cols[i]["Answers"].Value<JArray>();//第一層
                            for (int j = 0; j < r_answers_1.Count; j++)
                            {
                                Temp += r_answers_1[j]["value"].Value<bool>() ? "●" : "○";
                                Temp += $" {r_answeroptions_1[j]["AnsText"].Value<string>()} " + Environment.NewLine;

                                var Fillsons = (JArray)r_answers_1[j]["fillings"];
                                if (Fillsons != null)
                                {
                                    for (int k = 0; k < Fillsons.Count; i++)
                                    {
                                        Temp = Temp.Replace($"##^{k + 1}", Fillsons[k]["value"].Value<string>());
                                    }
                                }

                                JArray r_answeroptions_2 = r_answeroptions_1[j]["AnswerOptions"].Value<JArray>();
                                JArray r_answers_2 = r_answers_1[j]["Answers"].Value<JArray>();//第二層
                                for (int k = 0; k < r_answers_1.Count; k++)
                                {
                                    var fills2 = (JArray)r_answers_2[k]["Answers"];

                                    Temp += r_answers_2[k]["value"].Value<bool>() ? "\t■" : "\t□";
                                    Temp += $" {r_answeroptions_2[k]["AnsText"].Value<string>()} " + Environment.NewLine;

                                    var Fillsons2 = (JArray)r_answers_2[k]["fillings"];
                                    if (Fillsons2 != null)
                                    {
                                        for (int l = 0; l < Fillsons2.Count; l++)
                                        {
                                            Temp = Temp.Replace($"##^{l + 1}", Fillsons2[l]["value"].Value<string>());
                                        }
                                    }
                                }
                            }
                            fi.Add(new FieldContent($"col{i + 1}", Temp));
                            break;
                    }
                }
            }
            catch (Exception ex)
            {
                logger.ERROR($"GetRowList : {ex.Message}");
            }

            return fi;
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}