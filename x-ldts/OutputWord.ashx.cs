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
                                            case "filling":
                                                for (int i = 0; i < Answers.Count; i++)
                                                {
                                                    valuesToFill = new Content(new FieldContent($"{question["QuestionID"]}#{i + 1}", Answers[i]["value"].Value<string>()));
                                                    outputDocument.FillContent(valuesToFill);
                                                }
                                                break;
                                            case "radio":
                                            case "RadioMixFilling":
                                                for (int i = 0; i < Answers.Count; i++)
                                                {
                                                    valuesToFill = new Content(new FieldContent($"{question["QuestionID"]}#{i + 1}", Answers[i]["value"].Value<bool>() ? "●" : "○"));
                                                    outputDocument.FillContent(valuesToFill);

                                                    var fills = (JArray)Answers[i]["Answers"];
                                                    if (fills != null && fills.Count > 0)
                                                    {
                                                        for (int j = 0; j < fills.Count; j++)
                                                        {
                                                            valuesToFill = new Content(new FieldContent($"{question["QuestionID"]}#{i + 1}#{j + 1}", fills[j]["value"].Value<string>()));
                                                            outputDocument.FillContent(valuesToFill);
                                                        }
                                                    }
                                                }
                                                break;
                                            case "checkbox":
                                            case "CheckboxMixImage":
                                            case "CheckboxMixFilling":
                                                for (int i = 0; i < Answers.Count; i++)
                                                {
                                                    valuesToFill = new Content(new FieldContent($"{question["QuestionID"]}#{i + 1}", Answers[i]["value"].Value<bool>() ? "■" : "□"));
                                                    outputDocument.FillContent(valuesToFill);

                                                    var fills = (JArray)Answers[i]["Answers"];
                                                    if (fills != null && fills.Count > 0)
                                                    {
                                                        for (int j = 0; j < fills.Count; j++)
                                                        {
                                                            valuesToFill = new Content(new FieldContent($"{question["QuestionID"]}#{i + 1}#{j + 1}", fills[j]["value"].Value<string>()));
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

                                                    var fills = (JArray)Answers[i]["Answers"];
                                                    if (fills != null && fills.Count > 0)
                                                    {
                                                        for (int j = 0; j < fills.Count; j++)
                                                        {
                                                            valuesToFill = new Content(new FieldContent($"{question["QuestionID"]}#{i + 1}#{j + 1}", fills[j]["value"].Value<bool>() ? "■" : "□"));
                                                            outputDocument.FillContent(valuesToFill);
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
                                                switch (cols[j]["QuestionType"].Value<string>())
                                                {
                                                    case "text":
                                                    case "number":
                                                        valuesToFill = new Content(new FieldContent($"{group["GroupID"]}#{i + 1}#{j + 1}", Answers[0]["value"].Value<string>()));
                                                        outputDocument.FillContent(valuesToFill);
                                                        break;
                                                    case "date":
                                                        if (Answers[0]["value"].Value<long>()==0)
                                                        {
                                                            valuesToFill = new Content(new FieldContent($"{group["GroupID"]}#{i + 1}#{j + 1}"," "));
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
                                                    case "filling":
                                                        for (int k = 0; i < Answers.Count; i++)
                                                        {
                                                            valuesToFill = new Content(new FieldContent($"{group["GroupID"]}#{i + 1}#{j + 1}#{k + 1}", Answers[i]["value"].Value<string>()));
                                                            outputDocument.FillContent(valuesToFill);
                                                        }
                                                        break;
                                                    case "checkbox":
                                                    case "CheckboxMixImage":
                                                    case "CheckboxMixFilling":
                                                        for (int k = 0; k < Answers.Count; k++)
                                                        {
                                                            valuesToFill = new Content(new FieldContent($"{group["GroupID"]}#{i + 1}#{j + 1}#{k + 1}", Answers[k]["value"].Value<bool>() ? "■" : "□"));
                                                            outputDocument.FillContent(valuesToFill);

                                                            var fills = (JArray)Answers[k]["Answers"];
                                                            if (fills != null && fills.Count > 0)
                                                            {
                                                                for (int l = 0; l < fills.Count; l++)
                                                                {
                                                                    valuesToFill = new Content(new FieldContent($"{group["GroupID"]}#{i + 1}#{j + 1}#{k + 1}#{l + 1}", fills[l]["value"].Value<string>()));
                                                                    outputDocument.FillContent(valuesToFill);
                                                                }
                                                            }
                                                        }
                                                        break;
                                                    case "radio":
                                                    case "RadioMixFilling":
                                                        for (int k = 0; k < Answers.Count; k++)
                                                        {
                                                            valuesToFill = new Content(new FieldContent($"{group["GroupID"]}#{i + 1}#{j + 1}#{k + 1}", Answers[k]["value"].Value<bool>() ? "●" : "○"));
                                                            outputDocument.FillContent(valuesToFill);

                                                            var fills = (JArray)Answers[k]["Answers"];
                                                            if (fills != null && fills.Count > 0)
                                                            {
                                                                for (int l = 0; l < fills.Count; l++)
                                                                {
                                                                    valuesToFill = new Content(new FieldContent($"{group["GroupID"]}#{i + 1}#{j + 1}#{k + 1}#{l + 1}", fills[l]["value"].Value<string>()));
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

                                                            var fills = (JArray)Answers[k]["Answers"];
                                                            if (fills != null && fills.Count > 0)
                                                            {
                                                                for (int l = 0; l < fills.Count; l++)
                                                                {
                                                                    valuesToFill = new Content(new FieldContent($"{group["GroupID"]}#{i + 1}#{j + 1}#{k + 1}#{l + 1}", fills[l]["value"].Value<bool>() ? "■" : "□"));
                                                                    outputDocument.FillContent(valuesToFill);
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
                                        hasSN = group["hasSN"].Value<int>() < 0;
                                        rowSN = group["hasSN"].Value<int>() < 0 ? 0 : group["hasSN"].Value<int>();
                                        for (int i = 1; i < rows.Count; i++)
                                        {
                                            cols = rows[i]["Cols"].Value<JArray>();
                                            tableFill.AddRow(GetRowList(cols, rowSN + i, hasSN).ToArray());
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
                    fi.Add(new FieldContent("SN", rowIndex.ToString()));

                for (int i = 0; i < cols.Count; i++)
                {
                    switch (cols[i]["QuestionType"].Value<string>())
                    {
                        case "display":
                        case "text":
                        case "number":
                            fi.Add(new FieldContent($"col{i + 1}", cols[i]["Answers"][0]["value"].Value<string>()));
                            break;
                        case "radio":
                            Temp = "";
                            JArray r_answeroptions = cols[i]["AnswerOptions"].Value<JArray>();
                            JArray r_answers = cols[i]["Answers"].Value<JArray>();//第一層
                            for (int j = 0; j < r_answers.Count; j++)
                            {
                                var fills = (JArray)r_answers[j]["Answers"];

                                Temp += r_answers[j]["value"].Value<bool>() ? "●" : "○";
                                Temp += $" {r_answeroptions[j]["AnsText"].Value<string>()} ";
                            }
                            fi.Add(new FieldContent($"col{i + 1}", Temp));
                            break;
                        case "checkbox":
                            Temp = "";
                            JArray answeroptions = cols[i]["AnswerOptions"].Value<JArray>();
                            JArray answers = cols[i]["Answers"].Value<JArray>();
                            for (int j = 0; j < answers.Count; j++)
                            {
                                Temp += answers[j]["value"].Value<bool>() ? "■" : "□";
                                Temp += $" {answeroptions[j]["AnsText"].Value<string>()} ";
                            }
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