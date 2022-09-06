<%@ Page Title="" Language="C#" MasterPageFile="~/LDTS.Master" AutoEventWireup="true" CodeBehind="ReportQuestionEdit.aspx.cs" Inherits="LDTS.ReportQuestionEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <section class="reportQuestionEdit content-header">
        <div class="reportQuestionEditContainer container-fluid">
            <div class="reportQuestionEditTitle row mb-2">
                <div class="col-sm-6">
                    <h1 id="pro">編輯表單</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Default">Home</a></li>
                        <li class="breadcrumb-item"><a href="#">程序書</a></li>
                        <li class="breadcrumb-item">編輯表單</li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="ansMain col-md-3">
                    <div class="card card-warning card-outline">
                        <div class="card-body box-profile">
                            <div class="text-center">
                                <i class="far fa-sticky-note" style="font-size: 30px"></i>
                            </div>
                            <div class="QMainName form-group text-center p-2">
                                <asp:Label ID="Qtitle" runat="server" Font-Size="Large"></asp:Label>
                            </div>
                            <div class="ansExtendName form-group">
                                <label for="ExtendName" style="font-size: 12px; color: #00000080">自訂義名稱</label>
                                <input type="text" runat="server" id="ExtendName" class="form-control form-control-border" value="未命名" />
                            </div>
                            <div class="ansStatus form-group">
                                <label for="Stauts" style="font-size: 12px; color: #00000080">表單狀態</label>
                                <select id="Stauts" class="form-control select2 select2-hidden-accessible" style="width: 100%;" runat="server">
                                    <option value="1">尚未簽核</option>
                                    <option value="2">已簽核</option>
                                </select>
                            </div>
                            <div class="ansDesc form-group">
                                <label for="desc" style="font-size: 12px; color: #00000080">表單描述</label>
                                <asp:TextBox TextMode="MultiLine" ID="desc" runat="server" Rows="5" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="ansEdit col-md-9">
                    <div class="ansEditCard card">
                        <div class="ansEditCardBody card-body">
                            <div class="ansEditForm form-horizontal">
                            </div>
                        </div>
                    </div>
                    <div class="ansApplication d-flex justify-content-end mb-5">
                        <asp:Button runat="server" ID="SaveButton" CssClass="btn btn-primary" Text="儲存" OnClick="SaveButton_Click" />
                    </div>
                </div>
            </div>
        </div>
    </section>
    <asp:TextBox ID="chageData" runat="server" Rows="10" Columns="145" CssClass="d-none"></asp:TextBox>
    <input type="text" id="jsonData" runat="server" class=" " value="" />
    <input type="text" id="adminSign" runat="server" class="d-none" value="" />
    <input type="text" id="AppendFile" runat="server" class="d-none" value="" />
    <input type="text" id="Description" runat="server" class="d-none" value="" />
    <div class="modal fade" id="modal-insert">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title insertTitle">新增</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body insertBody">
                    <p>目前尚無資料…</p>
                </div>
                <div class="modal-footer justify-content-between">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary rowInsert" onclick="Insert(event)">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modal-update">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title insertTitle">編輯</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body updateBody">
                    <p>目前尚無資料…</p>
                </div>
                <div class="modal-footer justify-content-between">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary rowUpdate" onclick="Update(event)">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <asp:TextBox runat="server" ID="Ao" CssClass="d-none" ></asp:TextBox>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jqueryPlaceHolder" runat="server">
    <script>

        window.onload = function () {
            //Signbtn 
            var dataObj = GetJsonData();
            GroupsTemplate(dataObj);
            let rawUrl = window.location.href;
            console.log("rawUrl:" + rawUrl);
            if (rawUrl.includes("sqid") || rawUrl.includes("said")) {
                let breadcrumbItem = document.querySelectorAll(".breadcrumb-item");
                breadcrumbItem[1].cloneNode.innerText = "標準作業書";
            }
            var ao = document.getElementById("mainPlaceHolder_Ao");
            switch (ao.value) {
                case "2":
                    break;
                case "1":
                    var allsign = document.getElementsByClassName("Signbtn");
                    for (var i = 0; i < allsign.length; i++) {
                        console.log(allsign.length);
                        allsign[i].removeAttribute("onclick");
                    }
                    break;
                case "0":
                    var allinputs = document.getElementsByTagName("input");
                    var allsign = document.getElementsByClassName("Signbtn");
                    console.log(allsign.length);
                    for (var i = 0; i < allsign.length; i++) {
                        allsign[i].removeAttribute("onclick");
                    }
                    for (var i = 0; i < allinputs.length; i++) {
                        console.log(allinputs[i].type);
                        //inputBrothers[d].disabled = true;
                        allinputs[i].disabled = true;
                    }
                    break;
                default:
            }

        }
        function Upload(fileName) {
            var fileData = new FormData();
            var files;
            var typeFile = document.getElementsByTagName("input");
            for (var i = 0; i < typeFile.length; i++) {
                if (typeFile[i].type == "file") {
                    files = document.querySelector(".Upload").files[0];
                    break;
                }
            }
            if (files != null) {
                fileData.append(fileName, files);
                fileData.append("fileName", fileName);
                console.log("有檔案" + fileData)
                //上傳
                ajaxUpload = $.ajax({
                    url: "Upload.ashx",
                    type: "post",
                    data: fileData,
                    contentType: false,
                    processData: false,
                    async: false,
                    success: function (fileName) {

                    }
                })
            }
        }
        Date.prototype.Format = function (fmt) {
            //author:wangweizhen
            var o = {
                "M+": this.getMonth() + 1,                 //月份   
                "d+": this.getDate(),                    //日
                "h+": this.getHours(),                   //小時   
                "m+": this.getMinutes(),                 //分   
                "s+": this.getSeconds(),                 //秒   
                "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
                "S": this.getMilliseconds()             //毫秒   
            };
            if (/(y+)/.test(fmt))
                fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
            for (var k in o)
                if (new RegExp("(" + k + ")").test(fmt))
                    fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
            return fmt;
        };
        //抓Json轉Obj
        function GetJsonData() {
            let jsonStr = document.querySelector("#mainPlaceHolder_jsonData").value;
            let JsonObj = JSON.parse(jsonStr);
            return JsonObj;
        }
        //產出畫面的方法 Obj給藥產生畫面的Json轉Obj
        function GroupsTemplate(Obj) {
            const container = document.querySelector(".ansEditForm");//產出畫面的位置
            for (var i = 0; i < Obj.Groups.length; i++) {
                let hasSn = Obj.Groups[i].hasSN;
                let Gsn = i;
                switch (Obj.Groups[i].GroupType) {//先判斷GroupType
                    case "normal":
                        let normalDiv = document.createElement("div");
                        normalDiv.classList.add("row", "normal");
                        container.append(normalDiv);//group of normal 
                        let GroupNameH = document.createElement("h3");
                        GroupNameH.innerText = Obj.Groups[i].GroupName;//group name
                        GroupNameH.classList.add("col-12", "GroupName");
                        normalDiv.append(GroupNameH);

                        let QcardBody = document.createElement("div");//卡片的Body 全部產出的問題會在這邊顯示
                        for (var q = 0; q < Obj.Groups[i].Questions.length; q++) {
                            QcardBody.classList.add("card-body", "row");
                            normalDiv.append(QcardBody);
                            let Qlabel = document.createElement("div");
                            let img = document.createElement("img");
                            if (Obj.Groups[i].Questions[q].QuestionType == "filling") {
                                Qlabel.classList.add("col-12", "pt-2", "d-flex", "justify-content-start");
                            }
                            if (Obj.Groups[i].Questions[q].QuestionType == "display") {
                                Qlabel.classList.add("col-12", "pt-2", "d-flex", "justify-content-start");
                                if (Obj.Groups[i].Questions[q].AnswerOptions.length > 0) {
                                    img.src = "ShowAdminImg?id=" + Obj.Groups[i].Questions[q].AnswerOptions[0].image;
                                    img.style.width = "80%";
                                }
                            } else {
                                Qlabel.classList.add("col-3", "pt-2", "d-flex", "justify-content-start");
                            }

                            QcardBody.append(Qlabel);
                            QcardBody.append(img);
                            let nQuestion = document.createElement("p");//問題的Style 
                            nQuestion.classList.add("nQuestion", "p-1", "myTextColor");
                            if (hasSn > 0) {//有項次
                                nQuestion.innerText = hasSn;
                                hasSn++;
                            }
                            if (Obj.Groups[i].Questions[q].QuestionType == "RadioMixCheckbox" || Obj.Groups[i].Questions[q].QuestionType == "CheckboxMixFilling" || Obj.Groups[i].Questions[q].QuestionType == "RadioMixFilling") {
                                nQuestion.classList.add("mt-5");
                            }
                            nQuestion.innerText += Obj.Groups[i].Questions[q].QuestionText;//QuestionText

                            if (Obj.Groups[i].Questions[q].QuestionType == "filling" && hasSn > 0) {
                                nQuestion.innerText = hasSn - 1;//再填答區顯示

                            } else if (Obj.Groups[i].Questions[q].QuestionType == "filling" && hasSn < 0) {
                                nQuestion.innerText = "";
                            }

                            switch (Obj.Groups[i].Questions[q].QuestionType) {//產出對應的問題
                                case "text":
                                    CreateNormalTypeText(Obj, i, q, QcardBody);//Obj Json來源 i第幾個Group q第幾個問題 QcardBody要放在哪個載體中
                                    break;
                                case "number":
                                    CreateNormalTypeNumber(Obj, i, q, QcardBody);
                                    break;
                                case "radio":
                                    CreateNormalTypeRadio(Obj, i, q, QcardBody);
                                    break;
                                case "checkbox":
                                    CreateNormalTypeCheckbox(Obj, i, q, QcardBody);
                                    break;
                                case "select":
                                    CreateNormalTypeSelect(Obj, i, q, QcardBody);
                                    break;
                                case "image"://上傳圖片
                                case "file":
                                    CreateNormalTypeImage(Obj, i, q, QcardBody);
                                    break;
                                case "date":
                                    CreateNormalTypeDate(Obj, i, q, QcardBody);
                                    break;
                                case "sign":
                                    CreateNormalTypeSign(Obj, i, q, QcardBody);
                                    break;
                                case "filling":
                                    CreateNormalTypeFilling(Obj, i, q, QcardBody);
                                    break;
                                case "CheckboxMixFilling":
                                    CreateNormalTypeCheckboxMixFilling(Obj, i, q, QcardBody);
                                    break;
                                case "RadioMixCheckbox":
                                    CreateNormalTypeRadioMixCheckbox(Obj, i, q, QcardBody);
                                    break;
                                case "RadioMixFilling":
                                    CreateNormalTypeRadioMixFilling(Obj, i, q, QcardBody);
                                    break;
                                case "CheckboxMixImage":
                                    CreateNormalTypeCheckboxMixImage(Obj, i, q, QcardBody);
                                    break;
                                default:
                            }
                            Qlabel.append(nQuestion);
                        }
                        break;
                    case "table":
                        let ansEditFormT = document.querySelector(".ansEditForm");
                        let TampleteStr = "";
                        TampleteStr += "<div class=\"rowPart\">";
                        TampleteStr += "<div class=\"rowPart\">";
                        TampleteStr += "<h3 class=\"rowPart\">" + Obj.Groups[i].GroupName;
                        TampleteStr += "</h3>";
                        TampleteStr += "<div class=\"rowContainer row card mb-4 rowPart\">";
                        TampleteStr += "<div class=\"rowPart\">";
                        TampleteStr += "<div class=\"table-responsive rowPart\" style=\"overflow-x:hidden\">";
                        TampleteStr += "<div class=\"row\">";
                        TampleteStr += "<div class=\"col-sm-12 col-12 rowPart\">";
                        TampleteStr += "<table class=\"table table-bordered dataTable rowPart\" style=\"width: 100%;\">";
                        TampleteStr += "<thead>";//thead
                        TampleteStr += "<tr role=\"row\">";
                        if (Obj.Groups[i].hasSN > 0) {
                            TampleteStr += "<th style=\"width:5%\" class=\"sorting sorting_asc rowPart\">" + "項次";
                            TampleteStr += "</th>";
                        }
                        for (var r = 0; r < Obj.Groups[i].Rows[0].Cols.length; r++) {//首列的標題

                            switch (Obj.Groups[i].Rows[0].Cols[r].QuestionType) {
                                case "display":
                                    TampleteStr += "<th class=\"sorting sorting_asc rowPart\">" + Obj.Groups[i].Rows[0].Cols[r].QuestionText;
                                    TampleteStr += "</th>";
                                    break;
                                case "text":
                                    TampleteStr += "<th class=\"sorting sorting_asc rowPart\">" + Obj.Groups[i].Rows[0].Cols[r].QuestionText;
                                    TampleteStr += "<input type=\"text\" value=\"" + Obj.Groups[i].Rows[0].Cols[r].Answers[0].value + "\">";
                                    TampleteStr += "</th>";
                                    break;
                                default:
                            }
                        }
                        TampleteStr += "</thead>";//thead
                        TampleteStr += "<tbody>";//
                        let No = Obj.Groups[i].hasSN;
                        for (var w = 1; w < Obj.Groups[i].Rows.length; w++) {
                            TampleteStr += "<tr class=\"odd\">";
                            if (Obj.Groups[i].hasSN > 0) {
                                TampleteStr += " <td class=\"dtr-control sorting_1\">";
                                TampleteStr += No;
                                TampleteStr += "</td>";
                                No++;
                            }
                            for (var c = 0; c < Obj.Groups[i].Rows[w].Cols.length; c++) {//答案的顯示 存JSON的答案
                                TampleteStr += "<td class=\"dtr-control sorting_1\">";
                                switch (Obj.Groups[i].Rows[w].Cols[c].QuestionType) {
                                    case "text":
                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length == 0) {
                                            Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": 1, "value": "", "lastUpdate": "" });
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                        }
                                        TampleteStr += "<input type=\"text\"onchange=\"changeTableJsonData(event)\" class=\"form-control mb-3\"name=\"";
                                        TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                                            TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value + "\"";
                                        }
                                        TampleteStr += ">";
                                        break;
                                    case "number":
                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length == 0) {
                                            Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": 1, "value": "", "lastUpdate": "" });
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                        }
                                        TampleteStr += "<input type=\"number\" onchange=\"changeTableJsonData(event)\" class=\"form-control mb-3\"name=\"";
                                        TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                                            TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value + "\"";
                                        }
                                        TampleteStr += ">";
                                        break;
                                    //case "select":
                                    //    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].Answers[0].value;
                                    //    break;
                                    case "display":
                                        TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionText;
                                        break;
                                    case "date":
                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length == 0) {
                                            Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": 1, "value": 0, "lastUpdate": "" });
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                        }
                                        TampleteStr += "<input type=\"date\" onchange=\"changeTableJsonData(event)\" class=\"form-control mb-3\"name=\"";
                                        TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                                            let v = new Date(Obj.Groups[i].Rows[w].Cols[c].Answers[0].value);
                                            console.log("v" + v);
                                            if (v > 0) {
                                                v = v.Format("yyyy-MM-dd");
                                            }
                                            TampleteStr += "value=\"" + v + "\"";
                                        }
                                        TampleteStr += ">";

                                        break;
                                    case "radio":
                                        for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++) {
                                            if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers.length) {
                                                Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "" });
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                            }

                                            TampleteStr += "<div class=\"form-check\">"
                                            TampleteStr += "<input type=\"radio\" onchange=\"changeTableJsonData(event)\" class=\" mr-1\"name=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                            TampleteStr += "value=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                                            TampleteStr += "\"id=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index + w;
                                            TampleteStr += "\"";
                                            if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].value == true) {
                                                    TampleteStr += "checked";
                                                }
                                            }
                                            TampleteStr += ">";
                                            TampleteStr += "<label for=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index + w;
                                            TampleteStr += "\"class=\"\">" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText + "</label>";
                                            TampleteStr += "</div>";
                                        }
                                        break;
                                    case "checkbox":
                                        //case "CheckboxMixImage":
                                        for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++) {
                                            if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers.length) {
                                                Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "" });
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                            }
                                            TampleteStr += "<div class=\"form-check\">"
                                            TampleteStr += "<input type=\"checkbox\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                            TampleteStr += "value=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                                            TampleteStr += "\"id=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                                            TampleteStr += "\"";
                                            if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].value == true) {
                                                    TampleteStr += "checked";
                                                }
                                            }
                                            TampleteStr += ">";
                                            TampleteStr += "<label for=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                                            TampleteStr += "\"class=\"\">" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText + "</label>"
                                            TampleteStr += "</div>";
                                        }
                                        break;
                                    case "sign":
                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length == 0) {
                                            Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": 1, "value": "", "lastUpdate": "" });
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                        }
                                        let signImgID = document.getElementById("mainPlaceHolder_adminSign").value;
                                        let time = new Date();
                                        let today = time.Format("yyyy-MM-dd");

                                        if (Number(Obj.Groups[i].Rows[w].Cols[c].Answers[0].value) > 0) {
                                            TampleteStr += "<div class=\"col-12 pt-2 tableSign\">";
                                            TampleteStr += "<div data-Staut=\"Edit\" style=\"font-size:10px\" data-GidandRow=\"GID\" onchange=\"changeTableJsonData(event)\" onclick=\"SignByAdminId(event)\" class=\"btn btn-primary Signbtn ml-2 rowPart\" >";//
                                            TampleteStr += "取消簽核";
                                            TampleteStr += "</div>";
                                            TampleteStr += "<div class=\"ml-5 \">";//SignImageBox
                                            TampleteStr += "<img style=\"width:40%\" src=\"";//img
                                            TampleteStr += "ShowAdminImg?id=" + signImgID + "\"";
                                            TampleteStr += "id=\"sign" + signImgID + "\"";
                                            TampleteStr += "class=\"" + Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                                            TampleteStr += "\"name=\"" + Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                                            TampleteStr += "\">";//img
                                            TampleteStr += "<span  name=\"" + Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                                            TampleteStr += "\" class=\"d-flex justify-content-end signDate\">";
                                            TampleteStr += today;
                                            TampleteStr += "</span>";
                                            TampleteStr += "</div>";//SignImageBox
                                            TampleteStr += "</div>";
                                        } else {
                                            TampleteStr += "<div class=\"col-12 pt-2 tableSign\">";
                                            TampleteStr += "<div data-Staut=\"Edit\" style=\"font-size:10px\" data-GidandRow=\"GID\" onchange=\"changeTableJsonData(event)\" onclick=\"SignByAdminId(event)\" class=\"btn btn-primary Signbtn ml-2 rowPart\" >";//
                                            TampleteStr += "簽核";
                                            TampleteStr += "</div>";
                                            TampleteStr += "<div class=\"ml-5 d-none\">";//SignImageBox
                                            TampleteStr += "<img style=\"width:40%\" src=\"";//img
                                            TampleteStr += "ShowAdminImg.aspx?id=" + signImgID + "\"";
                                            TampleteStr += "id=\"sign" + signImgID + "\"";
                                            TampleteStr += "class=\"" + Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                                            TampleteStr += "\"name=\"" + Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                                            TampleteStr += "\">";//img
                                            TampleteStr += "<span  name=\"" + Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                                            TampleteStr += "\" class=\"d-flex justify-content-end signDate\">";
                                            TampleteStr += today;
                                            TampleteStr += "</span>";
                                            TampleteStr += "</div>";//SignImageBox
                                            TampleteStr += "</div>";
                                        }

                                        break;
                                    case "filling":
                                        let fillingStr = Obj.Groups[i].Rows[w].Cols[c].QuestionText;
                                        let StrArr = fillingStr.split("##");
                                        let n = 1;
                                        let N = 0;//第幾個填充答案
                                        for (var s = 0; s < StrArr.length; s++) {
                                            if (StrArr[s].includes("^")) {
                                                if (n > Obj.Groups[i].Rows[w].Cols[c].Answers.length) {
                                                    Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": n, "value": "", "lastUpdate": "" });
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                }
                                                TampleteStr += "<input type=\"text\" onchange=\"changeTableJsonData(event)\" style=\"width:20%\"  class=\"form-control d-inline mr-1 ml-1 mb-2\"name=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                TampleteStr += "data-filling=\"" + n + "\"";
                                                if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                                                    TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].Answers[N].value + "\"";
                                                }
                                                TampleteStr += ">";
                                                n++;
                                                N++;
                                                let txt = StrArr[s].substring(2);
                                                if (txt != null) {
                                                    TampleteStr += "<span>" + txt + "</span>";
                                                }
                                            } else {
                                                TampleteStr += "<span>" + StrArr[s] + "</span>";
                                            }
                                        }
                                        break;
                                    case "file"://要可以下載檔案
                                        TampleteStr += "<span class=\"mb-3 btn btn-default btn-file\"><i class=\"fas fa-paperclip\"></i>";
                                        TampleteStr += "<input  onchange=\"changeTableJsonData(event)\" type=\"file\" class=\"Upload form-control mb-3\"name=\"";
                                        TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\">";
                                        TampleteStr += "上傳檔案";
                                        TampleteStr += "</span>";
                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                                            TampleteStr += "</br>";
                                            TampleteStr += "<span class=\"ml-3\">" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value + "</span>"
                                            TampleteStr += "<a class=\"btn btn-default btn-sm ml-3\" href=\"Upload" + "/" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value + "\">";
                                            TampleteStr += "<i class=\"fas fa-cloud-download-alt\"></i>";
                                            TampleteStr += "</a>";
                                        }
                                        break;
                                    case "CheckboxMixFilling":
                                        for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++) {
                                            if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers.length) {
                                                Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "", "Answers": [] });
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                            }
                                            TampleteStr += "<div class=\"form-check\">"
                                            TampleteStr += "<input type=\"checkbox\"onchange=\"changeTableJsonData(event)\" onclick=\"DisabledTrue(event)\" class=\" mr-1\"name=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                            TampleteStr += "value=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                                            TampleteStr += "\"id=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                                            TampleteStr += "\"";
                                            if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].value == true) {
                                                    TampleteStr += "checked";
                                                }
                                            }
                                            TampleteStr += ">";
                                            let fillingStr = Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                                            let fSn = 1;
                                            let n = 0;
                                            let StrArr = fillingStr.split("##");
                                            for (var s = 0; s < StrArr.length; s++) {
                                                if (StrArr[s].includes("^")) {
                                                    if (fSn > Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.length) {
                                                        Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.push({ "index": fSn, "value": "", "lastUpdate": "" });
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                    }
                                                    TampleteStr += "<input type=\"text\" disabled style=\"width:20%\" onchange=\"changeTableJsonData(event)\"  class=\"form-control d-inline ml-1 mr-1 mb-2\"name=\"";
                                                    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                    TampleteStr += "data-checkboxIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index + "\"";
                                                    TampleteStr += "data-TextIndex=\"" + fSn + "\"";
                                                    if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.length > 0) {
                                                        TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers[n].value + "\"";
                                                    }
                                                    TampleteStr += ">";
                                                    fSn++;
                                                    n++;
                                                    let txt = StrArr[s].substring(2);
                                                    if (txt != null) {

                                                        TampleteStr += "<span>" + txt + "</span>";
                                                    }
                                                } else {

                                                    TampleteStr += "<span>" + StrArr[s] + "</span>";
                                                }
                                            }
                                            TampleteStr += "</div>";
                                            if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers == true) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length == 0) {
                                                    Obj.Groups[i].Rows[w].Cols[c].otherAnswer.push({ "index": 1, "value": "", "lastUpdate": "" });
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                }
                                                TampleteStr += "<span>其他</span>"
                                                TampleteStr += "<input type=\"text\"onchange=\"changeTableJsonData(event)\" class=\"other form-control mb-3\"name=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                                                    TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value + "\"";
                                                }
                                                TampleteStr += ">";
                                            }

                                        }
                                        break;
                                    case "RadioMixFilling":
                                        for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++) {
                                            if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers.length) {
                                                Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "", "Answers": [] });
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                            }
                                            TampleteStr += "<div class=\"form-check\">"
                                            TampleteStr += "<input type=\"radio\" onclick=\"CleanOthers(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                            TampleteStr += "value=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                                            TampleteStr += "\"id=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                                            TampleteStr += "\"";
                                            if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].value == true) {
                                                TampleteStr += "checked";
                                            }
                                            TampleteStr += ">";
                                            let fillingStr = Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                                            let StrArr = fillingStr.split("##");
                                            let fSn = 1;
                                            let n = 0;
                                            for (var s = 0; s < StrArr.length; s++) {
                                                if (StrArr[s].includes("^")) {
                                                    if (fSn > Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.length) {
                                                        Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.push({ "index": fSn, "value": "", "lastUpdate": "" });
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                    }
                                                    TampleteStr += "<input type=\"text\" onchange=\"changeTableJsonData(event)\"  disabled style=\"width:10%\" class=\"form-control ml-1 mr-1 d-inline mb-2\"name=\"";//data-gidandrow
                                                    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                    TampleteStr += "data-RadioIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index + "\"";
                                                    TampleteStr += "data-TextIndex=\"" + fSn + "\"";
                                                    if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.length > 0) {
                                                        TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers[n].value + "\"";
                                                    }
                                                    TampleteStr += ">";
                                                    fSn++;
                                                    n++;
                                                    let txt = StrArr[s].substring(2);
                                                    if (txt != null) {
                                                        TampleteStr += "<span>" + txt + "</span>";
                                                    }
                                                } else {
                                                    TampleteStr += "<span>" + StrArr[s] + "</span>";
                                                }
                                            }
                                            TampleteStr += "</div>";
                                        }
                                        if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers == true) {
                                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length == 0) {
                                                Obj.Groups[i].Rows[w].Cols[c].otherAnswer.push({ "index": 1, "value": "", "lastUpdate": "" });
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                            }
                                            TampleteStr += "<span>其他</span>"
                                            TampleteStr += "<input type=\"text\"onchange=\"changeTableJsonData(event)\" class=\"other form-control mb-3\"name=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                                                TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value + "\"";
                                            }
                                            TampleteStr += ">";
                                        }

                                        break;
                                    case "RadioMixCheckbox":
                                        for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++) {
                                            if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers.length) {
                                                Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "", "Answers": [] });
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                            }

                                            TampleteStr += "<div class=\"form-check\">"
                                            TampleteStr += "<input type=\"radio\" onchange=\"changeTableJsonData(event)\" onclick=\"CleanOptionforTable(event)\" class=\" mr-1\"name=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                            TampleteStr += "value=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                                            TampleteStr += "\"id=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                                            TampleteStr += "\"";
                                            if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].value == true) {
                                                    TampleteStr += "checked";
                                                }
                                            }
                                            TampleteStr += ">";
                                            TampleteStr += "<span class=\"mr-2\" style=\"font-weight:bold \">" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText + "</span>";
                                            for (var k = 0; k < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions.length; k++) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.length) {
                                                    Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.push({ "index": k + 1, "value": false, "lastUpdate": "" });
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                }

                                                TampleteStr += "<input onchange=\"changeTableJsonData(event)\" type=\"checkbox\" disabled class=\"mr-1\"name=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                TampleteStr += "value=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index;
                                                TampleteStr += "\"id=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].AnsText;
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index;
                                                TampleteStr += "\"";
                                                TampleteStr += "data-RadioIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index + "\"";
                                                TampleteStr += "data-CheckboxIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index + "\"";
                                                console.log("RadioMixCheckbox");
                                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.length > 0) {
                                                    if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers[k].value == true) {
                                                        TampleteStr += "checked";
                                                    }
                                                }
                                                TampleteStr += ">";
                                                TampleteStr += "<label for=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].AnsText;
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index;
                                                TampleteStr += "\"class=\"mr-2\">" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].AnsText + "</label>";
                                            }
                                            TampleteStr += "</div>";
                                        }
                                        if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers == true) {
                                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length == 0) {
                                                Obj.Groups[i].Rows[w].Cols[c].otherAnswer.push({ "index": 1, "value": "", "lastUpdate": "" });
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                            }
                                            TampleteStr += "<span>其他</span>"
                                            TampleteStr += "<input type=\"text\"onchange=\"changeTableJsonData(event)\" class=\"other form-control mb-3\"name=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                                                TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value + "\"";
                                            }
                                            TampleteStr += ">";
                                        }

                                        break;
                                    default:
                                }

                                TampleteStr += "</td>";
                            }
                            //    tampleteStr += "<td class=\"dtr-control sorting_1\">";
                            //    tampleteStr += "<button type=\"button\" class=\"btn btn-secondary\" data-toggle=\"modal\" data-isInsert=\"false\" data-target=\"#modal-update\"onclick =\"showModal(event)\"";
                            //    tampleteStr += "data-gid=\"" + Gsn + "\"" + "data-row=\"" + w + "\"";
                            //    tampleteStr += ">" + "編輯";
                            //    tampleteStr += "</button>"
                            //    tampleteStr += "</td>";
                            //    tampleteStr += "<td class=\"dtr-control sorting_1\">";
                            //    tampleteStr += "<button type=\"button\"onclick =\"DeleteRow(event)\" class=\"btn btn-danger\" data-toggle=\"modal\"  data-target=\"#modal-danger\"";
                            //    tampleteStr += "data-gid=\"" + Gsn + "\"" + "data-row=\"" + w + "\"";
                            //    tampleteStr += ">" + "刪除";
                            //    tampleteStr += "</button>"
                            //    tampleteStr += "</td>";
                            //    tampleteStr += "</tr>";
                        }
                        TampleteStr += "</tbody>";
                        TampleteStr += "</table>";
                        TampleteStr += "<div class=\"d-flex justify-content-center\"><div class=\" mb-3\">";
                        //tampleteStr += "<button type=\"button\" class=\"btn btn-app \" data-toggle=\"modal\" data-isInsert=\"true\" data-target=\"#modal-insert\"data-gid=\"";
                        //tampleteStr += Gsn + "\"";
                        //tampleteStr += "onclick =\"showModal(event)\">";
                        //tampleteStr += "<i class=\" fas fa-plus-circle\"><i>";
                        //tampleteStr += "</button>";
                        TampleteStr += "</div></div>";
                        TampleteStr += "</div>";//col-12
                        TampleteStr += "</div>";//row
                        TampleteStr += "</div>";//table-responsive
                        TampleteStr += "</div>";//rowPart
                        TampleteStr += "</div>";//rowContainer
                        TampleteStr += "</div>";//rowPart

                        ansEditFormT.innerHTML += TampleteStr;

                        break;
                    case "row":
                        let insertTitle = document.querySelector(".insertTitle");
                        insertTitle.innerText = Obj.Groups[i].GroupName;
                        let ansEditForm = document.querySelector(".ansEditForm ");
                        let tampleteStr = "";
                        tampleteStr += "<div class=\"rowPart\">";
                        tampleteStr += "<div class=\"rowPart\">";
                        tampleteStr += "<h3 class=\"rowPart\">" + Obj.Groups[i].GroupName;
                        tampleteStr += "</h3>";
                        tampleteStr += "<div class=\"rowContainer row card mb-4 rowPart\">";
                        tampleteStr += "<div class=\"rowPart\">";
                        tampleteStr += "<div class=\"table-responsive rowPart\" style=\"overflow-x:hidden\">";
                        tampleteStr += "<div class=\"row\">";
                        tampleteStr += "<div class=\"col-sm-12 col-12 rowPart\">";
                        tampleteStr += "<table class=\"table table-bordered dataTable rowPart\" style=\"width: 100%;\">";
                        tampleteStr += "<thead>";//thead
                        tampleteStr += "<tr role=\"row\">";
                        if (Obj.Groups[i].hasSN > 0) {
                            tampleteStr += "<th class=\"sorting sorting_asc rowPart\">" + "項次";
                            tampleteStr += "</th>";
                        }
                        for (var r = 0; r < Obj.Groups[i].Rows[0].Cols.length; r++) {//首列的標題

                            switch (Obj.Groups[i].Rows[0].Cols[r].QuestionType) {
                                case "display":
                                    tampleteStr += "<th class=\"sorting sorting_asc rowPart\">" + Obj.Groups[i].Rows[0].Cols[r].QuestionText;
                                    tampleteStr += "</th>";
                                    break;
                                case "text":
                                    tampleteStr += "<th class=\"sorting sorting_asc rowPart\">" + Obj.Groups[i].Rows[0].Cols[r].QuestionText;
                                    tampleteStr += "<input type=\"text\" value=\"" + Obj.Groups[i].Rows[0].Cols[r].Answers[0].value + "\">";
                                    tampleteStr += "</th>";
                                    break;
                                default:
                            }
                        }
                        tampleteStr += "<th class=\"sorting sorting_asc rowPart\">" + "編輯";
                        tampleteStr += "</th>";
                        tampleteStr += "<th class=\"sorting sorting_asc rowPart\">" + "刪除";
                        tampleteStr += "</th>";
                        tampleteStr += "</tr>";
                        tampleteStr += "</thead>";//thead
                        tampleteStr += "<tbody>";//
                        //有項次
                        let no = Obj.Groups[i].hasSN;
                        if (Obj.Groups[i].hasSN > 0) {

                            tampleteStr += "<tr class=\"odd\">";
                            tampleteStr += "<td class=\"dtr-control sorting_1\">";
                            tampleteStr += no;
                            tampleteStr += "</td>";
                            tampleteStr += "</tr>";
                            no++;
                        }
                        for (var w = 1; w < Obj.Groups[i].Rows.length; w++) {
                            tampleteStr += "<tr class=\"odd\">";
                            for (var c = 0; c < Obj.Groups[i].Rows[w].Cols.length; c++) {//答案的顯示 存JSON的答案
                                tampleteStr += "<td class=\"dtr-control sorting_1\">";
                                if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                                    switch (Obj.Groups[i].Rows[w].Cols[c].QuestionType) {
                                        case "file":
                                        case "image":
                                            tampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value+"</span>";
                                            tampleteStr += "<a  class=\"ml-1 btn btn-default btn-sm \" href=\"Upload/" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value +"\">";
                                            tampleteStr += "<i class=\"fas fa-cloud-download-alt\"></i>";
                                            tampleteStr += "</a>";
                                            break;
                                        case "text":
                                        case "number":
                                        case "select":
                                            tampleteStr += Obj.Groups[i].Rows[w].Cols[c].Answers[0].value;
                                            break;
                                        case "display":
                                            tampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionText;
                                            break;
                                        case "date":
                                            let dateValue = Obj.Groups[i].Rows[w].Cols[c].Answers[0].value;
                                            console.log("dateValue_" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value)
                                            let dateStr = new Date(dateValue);
                                            dateStr = dateStr.Format("yyyy-MM-dd");
                                            if (!dateStr.includes("Na") && dateValue != null) {//
                                                tampleteStr += dateStr;
                                            }
                                            break;
                                        case "radio":
                                        case "checkbox":
                                        case "CheckboxMixImage":
                                            for (var r = 0; r < Obj.Groups[i].Rows[1].Cols[c].Answers.length; r++) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[r].value == true) {
                                                    tampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[r].AnsText + "</br>";
                                                }
                                            }
                                            break;
                                        case "sign":
                                            if (Obj.Groups[i].Rows[w].Cols[c].Answers[0].value != 0) {
                                                let time = new Date(Obj.Groups[i].Rows[w].Cols[c].Answers[0].lastUpdate);
                                                let strTime = time.Format("yyyy-MM-dd");
                                                tampleteStr += "<img style=\"width:20%\" id=\"sign\" src=\"" + "ShowAdminImg.aspx?id=" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value + "\">";
                                                tampleteStr += "<span>" + strTime + "</span>";
                                            } 
                                            break;
                                        case "filling":
                                            let fillingStr = Obj.Groups[i].Rows[w].Cols[c].QuestionText;
                                            let StrArr = fillingStr.split("##");
                                            let n = 1;
                                            let N = 0;//第幾個填充答案
                                            if (Obj.Groups[i].Rows[w].Cols[c].Answers[N].value == "") {
                                                tampleteStr += "";
                                            } else {
                                                for (var s = 0; s < StrArr.length; s++) {
                                                    if (StrArr[s].includes("^")) {
                                                        let reStr = StrArr[s].substring(2);
                                                        tampleteStr += Obj.Groups[i].Rows[w].Cols[c].Answers[N].value + reStr;
                                                        n++;
                                                        N++;
                                                    } else {
                                                        tampleteStr += StrArr[s];
                                                    }
                                                }
                                            }
                                            break;
                                        
                                        case "CheckboxMixFilling":
                                        case "RadioMixFilling":
                                            for (var r = 0; r < Obj.Groups[i].Rows[w].Cols[c].Answers.length; r++) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[r].value == true) {
                                                    let fillingStr = Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[r].AnsText;
                                                    let StrArr = fillingStr.split("##");
                                                    let n = 1;
                                                    let N = 0;//第幾個填充答案
                                                    for (var s = 0; s < StrArr.length; s++) {
                                                        if (StrArr[s].includes("^")) {
                                                            let reStr = StrArr[s].substring(2);
                                                            tampleteStr += Obj.Groups[i].Rows[w].Cols[c].Answers[r].Answers[N].value + reStr;
                                                            n++;
                                                            N++;
                                                        } else {
                                                            tampleteStr += StrArr[s];
                                                        }
                                                    }
                                                }
                                                tampleteStr += "</br>";
                                            }
                                            if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers == true) {
                                                tampleteStr += "其他:" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value;
                                            }

                                            break;
                                        case "RadioMixCheckbox":
                                            for (var r = 0; r < Obj.Groups[i].Rows[w].Cols[c].Answers.length; r++) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[r].value == true) {
                                                    tampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[r].AnsText + ":";
                                                    for (var b = 0; b < Obj.Groups[i].Rows[w].Cols[c].Answers[r].Answers.length; b++) {
                                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers[r].Answers[b].value == true) {
                                                            tampleteStr += "</br>" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[r].AnswerOptions[b].AnsText;
                                                        }
                                                    }
                                                }
                                            }
                                            if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers == true) {
                                                tampleteStr += "其他:" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value;
                                            }

                                            break;
                                        default:
                                    }

                                }
                                tampleteStr += "</td>";
                            }
                            tampleteStr += "<td class=\"dtr-control sorting_1\">";
                            tampleteStr += "<button type=\"button\" class=\"btn btn-secondary\" data-toggle=\"modal\" data-isInsert=\"false\" data-target=\"#modal-update\"onclick =\"showModal(event)\"";
                            tampleteStr += "data-gid=\"" + Gsn + "\"" + "data-row=\"" + w + "\"";
                            tampleteStr += ">" + "編輯";
                            tampleteStr += "</button>"
                            tampleteStr += "</td>";
                            tampleteStr += "<td class=\"dtr-control sorting_1\">";
                            tampleteStr += "<button type=\"button\"onclick =\"DeleteRow(event)\" class=\"btn btn-danger\" data-toggle=\"modal\"  data-target=\"#modal-danger\"";
                            tampleteStr += "data-gid=\"" + Gsn + "\"" + "data-row=\"" + w + "\"";
                            tampleteStr += ">" + "刪除";
                            tampleteStr += "</button>"
                            tampleteStr += "</td>";
                            tampleteStr += "</tr>";
                        }
                        tampleteStr += "</tbody>";
                        tampleteStr += "</table>";
                        tampleteStr += "<div class=\"d-flex justify-content-center\"><div class=\" mb-3\">";
                        tampleteStr += "<button type=\"button\" class=\"btn btn-app \" data-toggle=\"modal\" data-isInsert=\"true\" data-target=\"#modal-insert\"data-gid=\"";
                        tampleteStr += Gsn + "\"";
                        tampleteStr += "onclick =\"showModal(event)\">";
                        tampleteStr += "<i class=\" fas fa-plus-circle\"><i>";
                        tampleteStr += "</button>";
                        tampleteStr += "</div></div>";
                        tampleteStr += "</div>";//col-12
                        tampleteStr += "</div>";//row
                        tampleteStr += "</div>";//table-responsive
                        tampleteStr += "</div>";//rowPart
                        tampleteStr += "</div>";//rowContainer
                        tampleteStr += "</div>";//rowPart

                        ansEditForm.innerHTML += tampleteStr;
                }
            }
        }
        function showModal(event) {
            let isInsert = event.currentTarget.dataset.isinsert;
            let Obj = GetJsonData();
            let i = event.currentTarget.dataset.gid;
            let w = event.currentTarget.dataset.row;
            console.log("isInsert:" + isInsert)
            //新增的modle
            if (isInsert == "true") {
                let insertBody = document.querySelector(".insertBody");
                let insertBodyStr = "";
                for (var r = 0; r < Obj.Groups[i].Rows[0].Cols.length; r++) {
                    let rowInsert = document.querySelector(".rowInsert");
                    rowInsert.setAttribute("id", Obj.Groups[i].GroupID);
                    switch (Obj.Groups[i].Rows[1].Cols[r].QuestionType) {
                        case "display":
                            insertBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            break;
                        case "sign":
                            let signImgID = document.getElementById("mainPlaceHolder_adminSign").value;
                            let time = new Date();
                            let today = time.getFullYear() + "-" + Number(time.getMonth() + 1);
                            today += "-" + time.getDate();
                            insertBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            insertBodyStr += "<div class=\"col-12 pt-2 SignBoxRow\">";
                            insertBodyStr += "<div data-Staut=\"Edit\" data-GidandRow=\"GID\" onchange=\"changeTableJsonData(event)\"  onclick=\"SignByAdminId(event)\" class=\"btn btn-primary Signbtn ml-2 rowPart\" >";//
                            insertBodyStr += "簽核";
                            insertBodyStr += "</div>";
                            insertBodyStr += "<div class=\"ml-5  SignImageBox d-none\">";//SignImageBox
                            insertBodyStr += "<img src=\"";//img
                            insertBodyStr += "ShowAdminImg.aspx?id=" + signImgID + "\"";
                            insertBodyStr += "id=\"sign" + signImgID + "\"";
                            insertBodyStr += "class=\"" + Obj.Groups[i].Rows[1].Cols[r].QuestionID;
                            insertBodyStr += "\"name=\"" + Obj.Groups[i].Rows[1].Cols[r].QuestionID;
                            insertBodyStr += "\">";//img
                            insertBodyStr += "<span  name=\"" + Obj.Groups[i].Rows[1].Cols[r].QuestionID;
                            insertBodyStr += "\" class=\"d-flex justify-content-center signDate\">";
                            insertBodyStr += today;
                            insertBodyStr += "</span>";
                            insertBodyStr += "</div>";//SignImageBox
                            insertBodyStr += "</div>";
                            break;
                        case "date":
                            insertBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            insertBodyStr += "<input type=\"date\" class=\"form-control mb-3\"name=\"";
                            insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\">";
                            break;
                        case "file":
                            insertBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            insertBodyStr += "<span class=\"mb-3 btn btn-default btn-file\"><i class=\"fas fa-paperclip\"></i>";
                            insertBodyStr += "<input onchange=\"appenUploadName(event)\" type=\"file\" class=\"Upload form-control mb-3\"name=\"";
                            insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\">";
                            insertBodyStr += "上傳檔案";
                            insertBodyStr += "<span id=\"UploadName" + Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"></span>";
                            insertBodyStr += "</span>";
                            break;
                        case "text":
                            insertBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            insertBodyStr += "<input type=\"text\" class=\"form-control mb-3\"name=\"";
                            insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\">";
                            break;
                        case "number":
                            insertBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            insertBodyStr += "<input type=\"number\" class=\"form-control mb-3\"name=\"";
                            insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\">";
                            break;
                        case "select":
                            insertBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            insertBodyStr += "<select class=\"mb-3 form-control \"";
                            insertBodyStr += "name=\"" + Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                            insertBodyStr += ">";
                            insertBodyStr += "<option value=\"" + "" + "\">" + "請選擇" + "</option>";
                            for (var o = 0; o < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions.length; o++) {
                                insertBodyStr += "<option value=\"" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText + "\">" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText + "</option>";
                            }
                            insertBodyStr += "</select>";
                            break;
                        case "checkbox":
                            insertBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            for (var o = 0; o < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions.length; o++) {
                                insertBodyStr += "<div class=\"form-check\">"
                                insertBodyStr += "<input type=\"checkbox\" class=\" mr-3\"name=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                insertBodyStr += "value=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                insertBodyStr += "\"id=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                insertBodyStr += "\">";
                                insertBodyStr += "<label for=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                insertBodyStr += "\"class=\"\">" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText + "</label>"
                                insertBodyStr += "</div>";
                            }
                            break;
                        case "radio":
                            insertBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            for (var o = 0; o < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions.length; o++) {
                                insertBodyStr += "<div class=\"form-check\">"
                                insertBodyStr += "<input type=\"radio\" class=\" mr-3\"name=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                insertBodyStr += "value=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                insertBodyStr += "\"id=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                insertBodyStr += "\">";
                                insertBodyStr += "<label for=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                insertBodyStr += "\"class=\"\">" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText + "</label>"
                                insertBodyStr += "</div>";
                            }
                            break;
                        case "filling":
                            let fillingStr = Obj.Groups[i].Rows[1].Cols[r].QuestionText;
                            let StrArr = fillingStr.split("##");
                            let n = 1;
                            let N = 0;//第幾個填充答案
                            for (var s = 0; s < StrArr.length; s++) {
                                if (StrArr[s].includes("^")) {
                                    insertBodyStr += "<input type=\"text\" style=\"width:20%\"  class=\"form-control d-inline mb-2\"name=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                    insertBodyStr += "data-filling=\"" + n + "\"";
                                    insertBodyStr += ">";
                                    n++;
                                    let txt = StrArr[s].substring(2);
                                    if (txt != null) {
                                        insertBodyStr += "<span>" + txt + "</span>";
                                    }
                                } else {
                                    insertBodyStr += "<span>" + StrArr[s] + "</span>";
                                }
                            }
                            break;
                        case "CheckboxMixImage":
                            insertBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            for (var o = 0; o < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions.length; o++) {
                                if (Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText.includes("##^")) {
                                    insertBodyStr += "<div class=\"form-check\">"
                                    insertBodyStr += "<input type=\"checkbox\" onclick=\"DisabledTrue(event)\" class=\" mr-3\"name=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                    insertBodyStr += "value=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                    insertBodyStr += "\"id=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                    insertBodyStr += "\">";
                                    let fillingStr = Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                    let StrArr = fillingStr.split("##");
                                    for (var s = 0; s < StrArr.length; s++) {
                                        if (StrArr[s].includes("^")) {
                                            insertBodyStr += "<input type=\"text\" disabled style=\"width:20%\" class=\"form-control d-inline mb-2\"name=\"";
                                            insertBodyStr += Obj.Groups[i].GroupID + "\">";
                                            let txt = StrArr[s].substring(2);
                                            if (txt != null) {
                                                insertBodyStr += "<span>" + txt + "</span>";
                                            }
                                        } else {
                                            insertBodyStr += "<span>" + StrArr[s] + "</span>";
                                        }
                                    }
                                } else {
                                    insertBodyStr += "<div class=\"form-check\">"
                                    insertBodyStr += "<input type=\"checkbox\" class=\" mr-3\"name=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                    insertBodyStr += "value=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                    insertBodyStr += "\"id=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                    insertBodyStr += "\">";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                    insertBodyStr += "<img class=\"col-12\" src=\"";
                                    insertBodyStr += "ShowAdminImg.aspx?id=" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].image + "\">";

                                }
                                insertBodyStr += "</div>";
                            }
                            break;
                        case "CheckboxMixFilling":
                            insertBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            for (var o = 0; o < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions.length; o++) {
                                insertBodyStr += "<div class=\"form-check\">"
                                insertBodyStr += "<input type=\"checkbox\" onclick=\"DisabledTrue(event)\" class=\" mr-3\"name=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                insertBodyStr += "value=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                insertBodyStr += "\"id=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                insertBodyStr += "\">";

                                let fillingStr = Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                let fSn = 1;
                                let StrArr = fillingStr.split("##");
                                //    insertBodyStr += "<label for=\"";
                                //    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                //    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                //    insertBodyStr += "\"class=\"\">";
                                for (var s = 0; s < StrArr.length; s++) {
                                    if (StrArr[s].includes("^")) {
                                        insertBodyStr += "<input type=\"text\" disabled style=\"width:20%\" class=\"form-control d-inline mb-2\"name=\"";
                                        insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                        insertBodyStr += "data-checkboxIndex=\"" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index + "\"";
                                        insertBodyStr += "data-TextIndex=\"" + fSn + "\"";
                                        fSn++;
                                        let txt = StrArr[s].substring(2);
                                        if (txt != null) {
                                            insertBodyStr += "<span>" + txt + "</span>";
                                        }
                                    } else {
                                        insertBodyStr += "<span>" + StrArr[s] + "</span>";
                                    }
                                }
                                //insertBodyStr += "</label>";
                                insertBodyStr += "</div>";
                            }
                            if (Obj.Groups[i].Rows[1].Cols[r].hasOtherAnswers == true) {
                                let time = new Date().getMilliseconds();
                                insertBodyStr += "<span>其他:</span>";
                                insertBodyStr += "<input type=\"text\" class=\"other form-control mb-3\"name=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + time + "\"";
                                insertBodyStr += "data-QID=\"" + Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                insertBodyStr += ">";

                            }
                            break;
                        case "RadioMixFilling":
                            insertBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            for (var o = 0; o < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions.length; o++) {
                                insertBodyStr += "<div class=\"form-check\">"
                                insertBodyStr += "<input type=\"radio\" onclick=\"CleanOthers(event)\" class=\" mr-3\"name=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                insertBodyStr += "value=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                insertBodyStr += "\"id=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                insertBodyStr += "\">";

                                let fillingStr = Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                let StrArr = fillingStr.split("##");
                                //    insertBodyStr += "<label for=\"";
                                //    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                //    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                //    insertBodyStr += "\"class=\"\">";
                                let fSn = 1;
                                for (var s = 0; s < StrArr.length; s++) {
                                    if (StrArr[s].includes("^")) {
                                        insertBodyStr += "<input type=\"text\" disabled style=\"width:20%\" class=\"form-control d-inline mb-2\"name=\"";//data-gidandrow
                                        insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                        insertBodyStr += "data-RadioIndex=\"" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index + "\"";
                                        insertBodyStr += "data-TextIndex=\"" + fSn + "\"";
                                        fSn++;
                                        let txt = StrArr[s].substring(2);
                                        if (txt != null) {
                                            insertBodyStr += "<span>" + txt + "</span>";
                                        }
                                    } else {
                                        insertBodyStr += "<span>" + StrArr[s] + "</span>";
                                        console.log(" StrArr[s]" + StrArr[s])
                                    }
                                }
                                //insertBodyStr += "</label>";
                                insertBodyStr += "</div>";
                            }
                            if (Obj.Groups[i].Rows[1].Cols[r].hasOtherAnswers == true) {
                                let time = new Date().getMilliseconds();
                                insertBodyStr += "<span>其他:</span>";
                                insertBodyStr += "<input type=\"text\" class=\"other form-control mb-3\"name=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + time + "\"";
                                insertBodyStr += "data-QID=\"" + Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                insertBodyStr += ">";

                            }

                            break;
                        case "RadioMixCheckbox":
                            insertBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            for (var o = 0; o < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions.length; o++) {
                                insertBodyStr += "<div class=\"form-check\">"
                                insertBodyStr += "<input type=\"radio\" onclick=\"CleanOptionforTable(event)\" class=\" mr-3\"name=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                insertBodyStr += "value=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                insertBodyStr += "\"id=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                insertBodyStr += "\">";
                                insertBodyStr += "<span>" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText + "</span>";
                                for (var k = 0; k < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnswerOptions.length; k++) {
                                    insertBodyStr += "<input type=\"checkbox\" disabled class=\"mr-1\"name=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                    insertBodyStr += "value=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnswerOptions[k].index;
                                    insertBodyStr += "\"id=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnswerOptions[k].AnsText;
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnswerOptions[k].index;
                                    insertBodyStr += "\"";
                                    insertBodyStr += "data-RadioIndex=\"" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index + "\"";
                                    insertBodyStr += "data-CheckboxIndex=\"" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnswerOptions[k].index + "\">";
                                    insertBodyStr += "<label for=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnswerOptions[k].AnsText;
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnswerOptions[k].index;
                                    insertBodyStr += "\"class=\"mr-2\">" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnswerOptions[k].AnsText + "</label>"
                                }
                                insertBodyStr += "</div>";
                            }
                            if (Obj.Groups[i].Rows[1].Cols[r].hasOtherAnswers == true) {
                                let time = new Date().getMilliseconds();
                                insertBodyStr += "<span>其他:</span>";
                                insertBodyStr += "<input type=\"text\" class=\"other form-control mb-3\"name=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + time + "\"";
                                insertBodyStr += "data-QID=\"" + Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                insertBodyStr += ">";
                                
                            }

                            break;
                        default:
                    }
                }
                insertBody.innerHTML = insertBodyStr;
            } else {
                console.log("編輯");
                let updateBody = document.querySelector(".updateBody");
                let updateBodyStr = "";
                for (var r = 0; r < Obj.Groups[i].Rows[w].Cols.length; r++) {
                    let rowUpdate = document.querySelector(".rowUpdate");
                    rowUpdate.setAttribute("id", Obj.Groups[i].GroupID);
                    switch (Obj.Groups[i].Rows[1].Cols[r].QuestionType) {
                        case "display":
                            updateBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            break;
                        case "sign":
                            let signImgID = document.getElementById("mainPlaceHolder_adminSign").value;
                            let time = new Date();
                            let today = time.getFullYear() + "/" + Number(time.getMonth() + 1);
                            today += "/" + time.getDate();
                            if (Obj.Groups[i].Rows[w].Cols[r].Answers.length > 0) {
                                updateBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                                updateBodyStr += "<div class=\"col-12 pt-2 SignBoxRow\">";
                                updateBodyStr += "<div data-Staut=\"Edit\" data-GidandRow=\"" + Obj.Groups[i].GroupID+"#"+w+"\" onchange=\"changeTableJsonData(event)\"  onclick=\"SignByAdminId(event)\" class=\"btn btn-primary Signbtn ml-2 rowPart\" >";//

                                updateBodyStr += "取消簽核";
                                updateBodyStr += "</div>";
                                updateBodyStr += "<div class=\"ml-5  SignImageBox \">";//SignImageBox
                                updateBodyStr += "<img src=\"";//img
                                updateBodyStr += "ShowAdminImg.aspx?id=" + Obj.Groups[i].Rows[w].Cols[r].Answers[0].value + "\"";
                                updateBodyStr += "id=\"sign" + signImgID + "\"";
                                updateBodyStr += "class=\"" + Obj.Groups[i].Rows[w].Cols[r].QuestionID;
                                updateBodyStr += "\"name=\"" + Obj.Groups[i].Rows[w].Cols[r].QuestionID;
                                updateBodyStr += "\">";//img
                                updateBodyStr += "<span  name=\"" + Obj.Groups[i].Rows[w].Cols[r].QuestionID;
                                updateBodyStr += "\" class=\"d-flex justify-content-center signDate\">";
                                updateBodyStr += today;
                                updateBodyStr += "</span>";
                                updateBodyStr += "</div>";//SignImageBox
                                updateBodyStr += "</div>";

                            } else {
                                updateBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                                updateBodyStr += "<div class=\"col-12 pt-2 SignBoxRow\">";
                                updateBodyStr += "<div data-Staut=\"Edit\" data-GidandRow=\"GID\" onchange=\"changeTableJsonData(event)\"  onclick=\"SignByAdminId(event)\" class=\"btn btn-primary Signbtn ml-2 rowPart\" >";//
                                updateBodyStr += "簽核";
                                updateBodyStr += "</div>";
                                updateBodyStr += "<div class=\"ml-5  SignImageBox d-none\">";//SignImageBox
                                updateBodyStr += "<img src=\"";//img
                                updateBodyStr += "ShowAdminImg.aspx?id=" + signImgID + "\"";
                                updateBodyStr += "id=\"sign" + signImgID + "\"";
                                updateBodyStr += "class=\"" + Obj.Groups[i].Rows[w].Cols[r].QuestionID;
                                updateBodyStr += "\"name=\"" + Obj.Groups[i].Rows[w].Cols[r].QuestionID;
                                updateBodyStr += "\">";//img
                                updateBodyStr += "<span  name=\"" + Obj.Groups[i].Rows[w].Cols[r].QuestionID;
                                updateBodyStr += "\" class=\"d-flex justify-content-center signDate\">";
                                updateBodyStr += today;
                                updateBodyStr += "</span>";
                                updateBodyStr += "</div>";//SignImageBox
                                updateBodyStr += "</div>";

                            }
                            break;
                        case "date":
                            updateBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            updateBodyStr += "<input type=\"date\"onchange=\"changeTableJsonData(event)\" class=\"Upload form-control mb-3\"name=\"";
                            updateBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\">";
                            break;
                        case "file":
                            updateBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            updateBodyStr += "<span class=\"mb-3 btn btn-default btn-file\"><i class=\"fas fa-paperclip\"></i>";
                            updateBodyStr += "<input type=\"file\" onchange=\"changeTableJsonData(event)\" class=\"form-control mb-3\"name=\"";
                            updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\">";
                            updateBodyStr += "上傳檔案";
                            updateBodyStr += "</span>";
                            break;
                        case "text":
                            updateBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            updateBodyStr += "<input type=\"text\"onchange=\"changeTableJsonData(event)\"  class=\"form-control mb-3\"name=\"";
                            updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                            if (Obj.Groups[i].Rows[w].Cols[r].Answers.length > 0) {
                                updateBodyStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[r].Answers[0].value + "\"";
                            }
                            updateBodyStr += ">";
                            break;
                        case "number":
                            updateBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            updateBodyStr += "<input type=\"number\"onchange=\"changeTableJsonData(event)\" class=\"form-control mb-3\"name=\"";
                            updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                            if (Obj.Groups[i].Rows[w].Cols[r].Answers.length > 0) {
                                updateBodyStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[r].Answers[0].value + "\"";
                            }
                            updateBodyStr += ">";
                            break;
                        case "select":
                            updateBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            updateBodyStr += "<select onchange=\"changeTableJsonData(event)\" class=\"mb-3 form-control \"";
                            updateBodyStr += "name=\"" + Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                            updateBodyStr += ">";
                            updateBodyStr += "<option value=\"" + "" + "\">" + "請選擇" + "</option>";
                            for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[r].AnswerOptions.length; o++) {
                                if (Obj.Groups[i].Rows[w].Cols[r].Answers.length > 0) {
                                    if (Obj.Groups[i].Rows[w].Cols[r].Answers[0].value == Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText) {
                                        updateBodyStr += "<option value=\"" + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText + "\"selected>" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText + "</option>";
                                    } else {
                                        updateBodyStr += "<option value=\"" + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText + "\">" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText + "</option>";
                                    }
                                } else {
                                    updateBodyStr += "<option value=\"" + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText + "\">" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText + "</option>";
                                }
                            }
                            updateBodyStr += "</select>";
                            break;
                        case "checkbox":
                            updateBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[r].AnswerOptions.length; o++) {
                                updateBodyStr += "<div class=\"form-check\">"
                                updateBodyStr += "<input onchange=\"changeTableJsonData(event)\"  type=\"checkbox\" class=\" mr-3\"name=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                updateBodyStr += "value=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                updateBodyStr += "\"id=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText;
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                updateBodyStr += "\"";
                                if (Obj.Groups[i].Rows[w].Cols[r].Answers.length > 0) {
                                    if (Obj.Groups[i].Rows[w].Cols[r].Answers[o].value == true) {
                                        updateBodyStr += "checked";
                                    }
                                }
                                updateBodyStr += ">";
                                updateBodyStr += "<label for=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText;
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                updateBodyStr += "\"class=\"\">" + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText + "</label>"
                                updateBodyStr += "</div>";
                            }
                            break;
                        case "radio":
                            updateBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[r].AnswerOptions.length; o++) {
                                updateBodyStr += "<div class=\"form-check\">"
                                updateBodyStr += "<input onchange=\"changeTableJsonData(event)\" type=\"radio\" class=\" mr-3\"name=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                updateBodyStr += "value=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                updateBodyStr += "\"id=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText;
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                updateBodyStr += "\"";
                                if (Obj.Groups[i].Rows[w].Cols[r].Answers.length > 0) {
                                    if (Obj.Groups[i].Rows[w].Cols[r].Answers[o].value == true) {
                                        updateBodyStr += "checked";
                                    }
                                }

                                updateBodyStr += ">";
                                updateBodyStr += "<label for=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText;
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                updateBodyStr += "\"class=\"\">" + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText + "</label>"
                                updateBodyStr += "</div>";
                            }
                            break;
                        case "filling":
                            let fillingStr = Obj.Groups[i].Rows[w].Cols[r].QuestionText;
                            let StrArr = fillingStr.split("##");
                            let n = 1;
                            let N = 0;//第幾個填充答案
                            if (Obj.Groups[i].Rows[w].Cols[r].Answers.length > 0) {
                                if (Obj.Groups[i].Rows[w].Cols[r].Answers[N].value == "") {
                                    updateBodyStr += "";
                                } else {
                                    for (var s = 0; s < StrArr.length; s++) {
                                        if (StrArr[s].includes("^")) {
                                            let reStr = StrArr[s].substring(2);
                                            updateBodyStr += "<input type=\"text\"onchange=\"changeTableJsonData(event)\" style=\"width:20%\"  class=\"form-control d-inline mb-3\"name=\"";
                                            updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                            updateBodyStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[r].Answers[N].value;
                                            updateBodyStr += "\"";
                                            updateBodyStr += "data-filling=\"" + n + "\"";
                                            updateBodyStr += ">";
                                            updateBodyStr += "<span>" + reStr + "</span>";
                                            n++;
                                            N++;
                                        } else {
                                            updateBodyStr += "<span>" + StrArr[s] + "</span>";
                                        }
                                    }
                                }
                            }
                            break;
                        case "CheckboxMixImage":
                            updateBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[r].AnswerOptions.length; o++) {
                                if (Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText.includes("##^")) {
                                    updateBodyStr += "<div class=\"form-check\">"
                                    updateBodyStr += "<input type=\"checkbox\" onchange=\"changeTableJsonData(event)\" onclick=\"DisabledTrue(event)\" class=\" mr-3\"name=\"";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                    updateBodyStr += "value=\"";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                    updateBodyStr += "\"id=\"";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText;
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                    updateBodyStr += "\">";
                                    let fillingStr = Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText;
                                    let StrArr = fillingStr.split("##");
                                    for (var s = 0; s < StrArr.length; s++) {
                                        if (StrArr[s].includes("^")) {
                                            updateBodyStr += "<input type=\"text\" onchange=\"changeTableJsonData(event)\" disabled style=\"width:20%\" class=\"form-control d-inline mb-2\"name=\"";
                                            updateBodyStr += Obj.Groups[i].GroupID + "\">";
                                            let txt = StrArr[s].substring(2);
                                            if (txt != null) {
                                                updateBodyStr += "<span>" + txt + "</span>";
                                            }
                                        } else {
                                            updateBodyStr += "<span>" + StrArr[s] + "</span>";
                                        }
                                    }
                                } else {
                                    updateBodyStr += "<div class=\"form-check\">"
                                    updateBodyStr += "<input onchange=\"changeTableJsonData(event)\" type=\"checkbox\" class=\" mr-3\"name=\"";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                    updateBodyStr += "value=\"";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                    updateBodyStr += "\"id=\"";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText;
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                    updateBodyStr += "\"";
                                    if (Obj.Groups[i].Rows[w].Cols[r].Answers.length > 0) {
                                        if (Obj.Groups[i].Rows[w].Cols[r].Answers[o].value == true) {
                                            updateBodyStr += "checked";
                                        }
                                    }
                                    updateBodyStr += ">";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText;
                                    updateBodyStr += "<img class=\"col-12\" src=\"";
                                    updateBodyStr += "ShowAdminImg.aspx?id=" + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].image + "\">";

                                }
                                updateBodyStr += "</div>";
                            }
                            break;
                        case "CheckboxMixFilling":
                            updateBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[r].AnswerOptions.length; o++) {
                                updateBodyStr += "<div class=\"form-check\">"
                                updateBodyStr += "<input onchange=\"changeTableJsonData(event)\" type=\"checkbox\" onclick=\"DisabledTrue(event)\" class=\" mr-3\"name=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                updateBodyStr += "value=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                updateBodyStr += "\"id=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText;
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index + "\"";
                                if (Obj.Groups[i].Rows[w].Cols[r].Answers.length > 0) {
                                    if (Obj.Groups[i].Rows[w].Cols[r].Answers[o].value == true) {
                                        updateBodyStr += "checked";
                                    }
                                }
                                updateBodyStr += ">";
                                let fillingStr = Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText;
                                let fSn = 1;
                                let n = 0;
                                let StrArr = fillingStr.split("##");
                                //    insertBodyStr += "<label for=\"";
                                //    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                //    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                //    insertBodyStr += "\"class=\"\">";
                                for (var s = 0; s < StrArr.length; s++) {
                                    if (StrArr[s].includes("^")) {
                                        updateBodyStr += "<input  onchange=\"changeTableJsonData(event)\" type=\"text\" disabled style=\"width:20%\" class=\"form-control d-inline mb-2\"name=\"";
                                        updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                        updateBodyStr += "data-checkboxIndex=\"" + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index + "\"";
                                        if (Obj.Groups[i].Rows[w].Cols[r].Answers[o].value == true) {
                                            if (Obj.Groups[i].Rows[w].Cols[r].Answers[o].Answers.length > 0) {
                                                updateBodyStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[r].Answers[o].Answers[n].value + "\"";
                                                n++;
                                            }
                                        }

                                        updateBodyStr += "data-TextIndex=\"" + fSn + "\">";
                                        fSn++;
                                        let txt = StrArr[s].substring(2);
                                        if (txt != null) {
                                            updateBodyStr += "<span>" + txt + "</span>";
                                        }
                                    } else {
                                        updateBodyStr += "<span>" + StrArr[s] + "</span>";
                                    }
                                }
                                //insertBodyStr += "</label>";
                                updateBodyStr += "</div>";
                            }
                            if (Obj.Groups[i].Rows[w].Cols[r].hasOtherAnswers== true) {
                                updateBodyStr += "<span>其他:</span>";
                                updateBodyStr += "<input onchange=\"changeTableJsonData(event)\" type=\"text\" class=\"other form-control mb-3\"name=\"";
                                updateBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                updateBodyStr += "value=\"" + Obj.Groups[i].Rows[1].Cols[r].otherAnswer[0].value+"\"";
                                updateBodyStr += ">";
                            }

                            break;
                        case "RadioMixFilling":
                            updateBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[r].AnswerOptions.length; o++) {
                                updateBodyStr += "<div class=\"form-check\">"
                                updateBodyStr += "<input type=\"radio\"onchange=\"changeTableJsonData(event)\" onclick=\"CleanOthers(event)\" class=\" mr-3\"name=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                updateBodyStr += "value=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                updateBodyStr += "\"id=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText;
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                updateBodyStr += "\"";
                                if (Obj.Groups[i].Rows[w].Cols[r].Answers.length > 0) {
                                    if (Obj.Groups[i].Rows[w].Cols[r].Answers[o].value == true) {
                                        updateBodyStr += "checked";
                                    }
                                }
                                updateBodyStr += ">";
                                let fillingStr = Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText;
                                let StrArr = fillingStr.split("##");
                                //    insertBodyStr += "<label for=\"";
                                //    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                //    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                //    insertBodyStr += "\"class=\"\">";
                                let fSn = 1;
                                let n = 0;
                                let N = 0;
                                for (var s = 0; s < StrArr.length; s++) {
                                    if (StrArr[s].includes("^")) {
                                        updateBodyStr += "<input type=\"text\" onchange=\"changeTableJsonData(event)\" disabled style=\"width:20%\" class=\"form-control d-inline mb-2\"name=\"";//data-gidandrow
                                        updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                        updateBodyStr += "data-RadioIndex=\"" + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index + "\"";
                                        updateBodyStr += "data-TextIndex=\"" + fSn + "\"";
                                        if (Obj.Groups[i].Rows[w].Cols[r].Answers[o].value == true) {
                                            updateBodyStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[r].Answers[o].Answers[N].value + "\"";
                                            console.log(Obj.Groups[i].Rows[w].Cols[r].Answers[o].Answers[N].value);
                                            N++;
                                        }
                                        updateBodyStr += ">";
                                        fSn++;
                                        n++;
                                        let txt = StrArr[s].substring(2);
                                        if (txt != null) {
                                            updateBodyStr += "<span>" + txt + "</span>";
                                        }
                                    } else {
                                        updateBodyStr += "<span>" + StrArr[s] + "</span>";

                                    }
                                }
                                //insertBodyStr += "</label>";
                                updateBodyStr += "</div>";
                            }
                            if (Obj.Groups[i].Rows[w].Cols[r].hasOtherAnswers == true) {
                                updateBodyStr += "<span>其他:</span>";
                                updateBodyStr += "<input onchange=\"changeTableJsonData(event)\" type=\"text\" class=\"other form-control mb-3\"name=\"";
                                updateBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                updateBodyStr += "value=\"" + Obj.Groups[i].Rows[1].Cols[r].otherAnswer[0].value + "\"";
                                updateBodyStr += ">";
                            }
                            break;
                        case "RadioMixCheckbox":
                            updateBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[r].AnswerOptions.length; o++) {
                                let oldStr = updateBodyStr;
                                updateBodyStr += "<div class=\"form-check\">";
                                updateBodyStr += "<input type=\"radio\" onchange=\"changeTableJsonData(event)\" onclick=\"CleanOptionforTable(event)\" class=\" mr-3\"name=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                updateBodyStr += "value=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                updateBodyStr += "\"id=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText;
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                updateBodyStr += "\"";
                                if (Obj.Groups[i].Rows[w].Cols[r].Answers[o].value == true) {
                                    updateBodyStr = oldStr;
                                    updateBodyStr += "<div class=\"form-check\">";
                                    updateBodyStr += "<input checked type=\"radio\"  onchange=\"changeTableJsonData(event)\" onclick=\"CleanOptionforTable(event)\" class=\" mr-3\"name=\"";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                    updateBodyStr += "value=\"";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                    updateBodyStr += "\"id=\"";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText;
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                    updateBodyStr += "\"";
                                }
                                updateBodyStr += ">";
                                updateBodyStr += "<span>" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText + "</span>";
                                for (var k = 0; k < Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnswerOptions.length; k++) {
                                    updateBodyStr += "<input onchange=\"changeTableJsonData(event)\" type=\"checkbox\" disabled class=\"mr-1\"name=\"";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                    updateBodyStr += "value=\"";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnswerOptions[k].index;
                                    updateBodyStr += "\"id=\"";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnswerOptions[k].AnsText;
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnswerOptions[k].index;
                                    updateBodyStr += "\"";
                                    updateBodyStr += "data-RadioIndex=\"" + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index + "\"";
                                    updateBodyStr += "data-CheckboxIndex=\"" + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnswerOptions[k].index + "\"";

                                    if (Obj.Groups[i].Rows[w].Cols[r].Answers[o].Answers[k].value == true) {
                                        updateBodyStr += "checked";
                                    }
                                    updateBodyStr += ">";
                                    updateBodyStr += "<label for=\"";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnswerOptions[k].AnsText;
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnswerOptions[k].index;
                                    updateBodyStr += "\"class=\"mr-2\">" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnswerOptions[k].AnsText + "</label>"
                                }
                                updateBodyStr += "</div>";
                            }
                            if (Obj.Groups[i].Rows[w].Cols[r].hasOtherAnswers == true) {
                                updateBodyStr += "<span>其他:</span>";
                                updateBodyStr += "<input onchange=\"changeTableJsonData(event)\" type=\"text\" class=\"other form-control mb-3\"name=\"";
                                updateBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                updateBodyStr += "value=\"" + Obj.Groups[i].Rows[1].Cols[r].otherAnswer[0].value + "\"";
                                updateBodyStr += ">";
                            }
                            break;
                        default:
                    }
                }
                updateBody.innerHTML = updateBodyStr;
            }

        }
        //row 編輯
        function Update(event) {
            const dataObj = GetJsonData();
            //img

            let GroupId = event.currentTarget.id;
            let imgs = event.currentTarget.parentNode.parentNode.getElementsByTagName("img");
            let SignImageBox = event.currentTarget.parentNode.parentNode.querySelectorAll(".SignImageBox");
            for (var m = 0; m < imgs.length; m++) {
                for (var i = 0; i < dataObj.Groups.length; i++) {
                    if (dataObj.Groups[i].GroupID == GroupId) {
                        let sn = dataObj.Groups[i].Rows.length - 1;
                        for (let c = 0; c < dataObj.Groups[i].Rows[sn].Cols.length; c++) {
                            if (dataObj.Groups[i].Rows[sn].Cols[c].QuestionID == imgs[m].name && SignImageBox[m].classList.contains("d-inline")) {
                                dataObj.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                let sid = imgs[m].id;
                                sid = sid.substring(4);
                                console.log("img" + sid);

                                dataObj.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": 1, "value": sid, "lastUpdate": today });
                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

                            } else {
                                dataObj.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                dataObj.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": 1, "value": 0, "lastUpdate": null });
                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));


                            }
                        }
                    }
                }
                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
            }

            //let fade = document.querySelector(".modal-backdrop");
            //fade.classList.remove("modal-open");
            document.body.classList.remove("modal-open");

            let allModal = document.querySelectorAll(".modalcontainer");
            for (var i = 0; i < allModal.length; i++) {
                allModal[i].innerHTML = "";
            }
            let allFade = document.querySelectorAll(".modal-backdrop");
            for (var i = 0; i < allFade.length; i++) {
                allFade[i].classList.remove("modal-open", "show", "fade", "modal-backdrop");
            }
            let allRow = document.querySelectorAll(".rowPart");
            for (var i = 0; i < allRow.length; i++) {
                allRow[i].innerHTML = "";
            }


            let ansEditForm = document.querySelector(".ansEditForm");
            ansEditForm.innerHTML = "";
            GroupsTemplate(dataObj);
            let updateBody = document.querySelector(".updateBody");
            let updateBodyStr = "";
            updateBody.innerHTML = updateBodyStr;
            $("#modal-update").modal('hide');

        }
        //row 上傳檔案顯示換檔案名稱
        function appenUploadName(event) {
            let thisName = event.currentTarget;
            let parentBox = event.currentTarget.parentNode;
            let id = "UploadName" + event.currentTarget.name
            let Uploadname = document.getElementById(id);
            console.log("UploadName" + Uploadname);
            Uploadname.innerText = thisName.value;
        }
        //row 新增
        function Insert(event) {
            let date = new Date();
            let today = date.getTime();
            let inputs = event.currentTarget.parentNode.parentNode.getElementsByTagName("input");
            let select = event.currentTarget.parentNode.parentNode.getElementsByTagName("select");
            let GroupId = event.currentTarget.id;
            let DataObj = new Object();

            const dataObj = GetJsonData();
            let remove = false;
            let isfile = false
            for (var i = 0; i < dataObj.Groups.length; i++) {
                if (dataObj.Groups[i].GroupID == GroupId) {
                    DataObj = dataObj.Groups[i].Rows[1];//複製的Rows
                }
            }
            let All = 0;
            for (let i = 0; i < DataObj.Cols.length; i++) {
                if (DataObj.Cols[i].Answers.length == 0) {
                    All++;
                } else {
                    if (DataObj.Cols[i].QuestionType == "file") {
                        DataObj.Cols[i].Answers.length = 0
                    }
                }
            }
            if (All == DataObj.Cols.length) {
                remove = true;
            }
            for (var i = 0; i < dataObj.Groups.length; i++) {
                if (dataObj.Groups[i].GroupID == GroupId) {
                    if (remove) {
                        DataObj.index = dataObj.Groups[i].Rows.length;
                        dataObj.Groups[i].Rows.push(DataObj);
                        dataObj.Groups[i].Rows = dataObj.Groups[i].Rows.slice(0, 2);
                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                    } else {
                        dataObj.Groups[i].Rows.push(DataObj);
                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

                    }
                }
            }
            let dataObj2 = GetJsonData();
            for (var s = 0; s < select.length; s++) {
                for (var i = 0; i < dataObj2.Groups.length; i++) {
                    if (dataObj2.Groups[i].GroupID == GroupId) {
                        let sn = dataObj2.Groups[i].Rows.length - 1;
                        let Name = select[s].name;
                        for (let c = 0; c < dataObj2.Groups[i].Rows[sn].Cols.length; c++) {
                            let Qid = dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID;
                            console.log("sQid:" + Qid);
                            if (Qid == Name) {
                                let sindex = c + 1;
                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": sindex, "value": select[s].value, "lastUpdate": today });

                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID = dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID + today;
                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                            }
                        }
                    }
                }
            }
            //img
            let imgs = event.currentTarget.parentNode.parentNode.getElementsByTagName("img");
            let SignImageBox = event.currentTarget.parentNode.parentNode.querySelectorAll(".SignImageBox");
            for (var m = 0; m < imgs.length; m++) {
                for (var i = 0; i < dataObj2.Groups.length; i++) {
                    if (dataObj2.Groups[i].GroupID == GroupId) {
                        let sn = dataObj2.Groups[i].Rows.length - 1;
                        for (let c = 0; c < dataObj2.Groups[i].Rows[sn].Cols.length; c++) {
                            if (dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID == imgs[m].name && SignImageBox[m].classList.contains("d-inline")) {
                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                let sid = imgs[m].id;
                                sid = sid.substring(4);
                                console.log("img" + sid);
                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": 1, "value": sid, "lastUpdate": today });
                            }
                        }
                    }
                }
                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
            }
            for (var d = 0; d < inputs.length; d++) {
                console.log(inputs.length)
                for (var i = 0; i < dataObj2.Groups.length; i++) {
                    if (dataObj2.Groups[i].GroupID == GroupId) {
                        let sn = dataObj2.Groups[i].Rows.length - 1;
                        for (let c = 0; c < dataObj2.Groups[i].Rows[sn].Cols.length; c++) {
                            let ColsSn = dataObj2.Groups[i].Rows[sn].Cols.length - 1;
                            if (dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID == inputs[d].name || dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID == inputs[d].name.substring(1) && inputs[d].type != "button") {
                                let Qtype = dataObj2.Groups[i].Rows[sn].Cols[c].QuestionType;//題目的
                                console.log("Qtype" + Qtype);
                                switch (Qtype) {
                                    case "file":
                                        index = c + 1;
                                        let fileName = inputs[d].value;
                                        var re = /\.(jpg|png|doc|pdf|docx)$/i;
                                        if (!re.test(fileName)) {
                                            alert("檔案格式錯誤!!請檢查!!")
                                            break;
                                        } else {
                                            let now = date.getFullYear("yyyy") + String(date.getMonth() + 1).padStart(2, '0') + String(date.getDate()).padStart(2, '0') + String(date.getHours()).padStart(2, '0') + String(date.getMinutes()).padStart(2, '0') + String(date.getSeconds()).padStart(2, '0') + String(date.getMilliseconds()).padStart(3, '0');
                                            fileName = fileName.substring("12");
                                            fileName = now + "_" + fileName;
                                            Upload(fileName);
                                            dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                            dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": index, "value": fileName, "lastUpdate": today });
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                        }
                                        break;
                                    case "text":
                                        index = c + 1;
                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": index, "value": inputs[d].value, "lastUpdate": today });
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                        //給新QuestionID
                                        //let newQid = dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID + today;
                                        //dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID = newQid;
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));

                                        break;
                                    case "number":
                                        index = c + 1;
                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": index, "value": inputs[d].value, "lastUpdate": today });
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));

                                        ////給新QuestionID
                                        //dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID = dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID + today;
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));

                                        break;
                                    case "date":
                                        index = c + 1;
                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                        let dateV = Date.parse(inputs[d].value);
                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": index, "value": dateV, "lastUpdate": today });
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));

                                        //給新QuestionID
                                        //dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID = dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID + today;
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));

                                        break;
                                    case "checkbox":
                                    case "CheckboxMixImage":
                                        let sameCheckboxes = document.getElementsByName(inputs[d].name);
                                        if (dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length > dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length) {
                                            for (var o = 0; o < dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length; o++) {
                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions[o].index, "value": false, "lastUpdate": today });
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                            }
                                        }
                                        for (var k = 0; k < sameCheckboxes.length; k++) {
                                            if (sameCheckboxes[k].checked) {
                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers[k].value = true;
                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers[k].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                            } else {
                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers[k].value = false;
                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers[k].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                            }
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                        }
                                        //給新QuestionID
                                        //dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID = dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID + today;
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));


                                        break;
                                    case "radio":
                                        let smaeRadios = document.getElementsByName(inputs[d].name);
                                        if (dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length > dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length) {
                                            for (var o = 0; o < dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length; o++) {
                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions[o].index, "value": false, "lastUpdate": today });
                                            }
                                        }
                                        for (var s = 0; s < smaeRadios.length; s++) {
                                            if (smaeRadios[s].checked) {
                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers[s].value = true;
                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers[s].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                            } else {
                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers[s].value = false;
                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers[s].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                            }
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                        }
                                        //給新QuestionID
                                        //dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID = dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID + today;
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));


                                        break;
                                    case "filling":
                                        let fillingboxes = document.getElementsByName(inputs[d].name);
                                        console.log("fillingboxes:" + fillingboxes);
                                        let fillingStr = dataObj2.Groups[i].Rows[sn].Cols[c].QuestionText;
                                        let StrArr = fillingStr.split("##");
                                        let n = 1;
                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                        if (fillingboxes.length > dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length) {
                                            for (var f = 0; f < fillingboxes.length; f++) {
                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": n, "value": fillingboxes[f].value, "lastUpdate": today });
                                                n++;
                                            }
                                        }
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                        //給新QuestionID
                                        //dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID = dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID + today;
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));


                                        break;
                                    case "sign":
                                        let items = document.getElementsByName(inputs[d].name);
                                        let img = [];
                                        items.forEach(function (item) {
                                            if (item.type == "img") {
                                                img.push(item);
                                            }
                                        });
                                        for (var m = 0; m < img.length; m++) {
                                            let signId = img[m].id.substring(4);
                                            dataObj2.Groups[i].Rows[sn].Cols[c].Answers[0].push({ "index": 1, "value": null, "image": signId, "lastUpdate": today });
                                        }
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                        //給新QuestionID
                                        //dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID = dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID + today;
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));


                                        break;
                                    case "RadioMixFilling":
                                        if (inputs[d].type == "radio") {
                                            let SmaeRadios = document.getElementsByName(inputs[d].name);
                                            let Radios = [];
                                            let Txts = [];
                                            let others = document.querySelectorAll(".other");
                                            let other;
                                            if (!remove) {
                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                            }
                                            SmaeRadios.forEach(function (item) {
                                                if (item.type == "radio") {
                                                    Radios.push(item);
                                                }
                                            });
                                            SmaeRadios.forEach(function (item) {
                                                if (item.type == "text" && !item.classList.contains("other")) {
                                                    Txts.push(item);
                                                } else if (item.type == "text" && item.classList.contains("other")) {
                                                    other = item;
                                                }
                                            });
                                            others.forEach(function (item) {
                                                if (item.dataset.qid == inputs[d].name) {
                                                    other = item;
                                                }
                                            })
                                            if (dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length > dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length) {
                                                for (var o = 0; o < dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length; o++) {
                                                    dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions[o].index, "value": false, "lastUpdate": today, "Answers": [] });
                                                }
                                            }
                                            for (var r = 0; r < Radios.length; r++) {
                                                if (dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length>r) {
                                                    if (Radios[r].checked) {
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].value = true;
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].lastUpdate = today;
                                                        for (var t = 0; t < Txts.length; t++) {
                                                            if (Txts[t].dataset.radioindex == Radios[r].value && Txts.length > dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers.length) {
                                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers.push({ "index": Number(Txts[t].dataset.textindex), "value": Txts[t].value, "lastUpdate": today });
                                                            }
                                                        }
                                                    } else {
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].value = false;
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].lastUpdate = today;
                                                        //
                                                        for (var t = 0; t < Txts.length; t++) {
                                                            if (Txts[t].dataset.radioindex == Radios[r].value && Txts.length > dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers.length) {
                                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers.push({ "index": Number(Txts[t].dataset.textindex), "value": "", "lastUpdate": today });
                                                            }

                                                        }
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                                    }

                                                }
                                            }
                                            if (dataObj2.Groups[i].Rows[sn].Cols[c].hasOtherAnswers == true) {
                                                dataObj2.Groups[i].Rows[sn].Cols[c].otherAnswer.push({ "index": 1, "value": other.value, "lastUpdate": today });
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));

                                            }
                                            //給新QuestionID
                                            //dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID = dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID + today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));

                                        }
                                        break;
                                    case "RadioMixCheckbox":
                                        if (inputs[d].type == "radio") {
                                            console.log("RadioMixCheckBox")
                                            let Smaeradios = document.getElementsByName(inputs[d].name);
                                            let Radios = [];
                                            let Ckbs = [];
                                            let others = document.querySelectorAll(".other");
                                            let other;
                                            if (!remove) {
                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                            }
                                            others.forEach(function (item) {
                                                if (item.dataset.qid == inputs[d].name) {
                                                    other = item;
                                                }
                                            })


                                            Smaeradios.forEach(function (item) {
                                                if (item.type == "radio") {
                                                    Radios.push(item);
                                                }
                                            });
                                            Smaeradios.forEach(function (item) {
                                                if (item.type == "checkbox") {
                                                    Ckbs.push(item);
                                                }
                                            });
                                            Smaeradios.forEach(function (item) {
                                                if (item.type == "text") {
                                                    other = item;
                                                }
                                            });
                                            if (dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length > dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length) {
                                                for (var o = 0; o < dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length; o++) {
                                                    dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions[o].index, "value": false, "lastUpdate": "", "Answers": [] });
                                                }
                                            }
                                            for (var r = 0; r < Radios.length; r++) {
                                                if (dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length >r) {
                                                    if (Radios[r].checked) {
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].value = true;
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].lastUpdate = today;
                                                        for (var b = 0; b < Ckbs.length; b++) {
                                                            if (Ckbs[b].dataset.radioindex == Radios[r].value && dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions[r].AnswerOptions.length > dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers.length) {
                                                                if (Ckbs[b].checked) {
                                                                    dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers.push({ "index": Number(Ckbs[b].dataset.checkboxindex), "value": true, "lastUpdate": today });
                                                                } else {
                                                                    dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers.push({ "index": Number(Ckbs[b].dataset.checkboxindex), "value": false, "lastUpdate": today });
                                                                }
                                                            }
                                                        }
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));

                                                    } else {
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].value = false;
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[0].lastUpdate = today;
                                                        for (var b = 0; b < Ckbs.length; b++) {
                                                            if (Ckbs[b].dataset.radioindex == Radios[r].value && dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions[r].AnswerOptions.length > dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers.length) {
                                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers.push({ "index": Number(Ckbs[b].dataset.checkboxindex), "value": false, "lastUpdate": today });
                                                            }
                                                        }
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                                    }

                                                }
                                                if (dataObj2.Groups[i].Rows[sn].Cols[c].hasOtherAnswers == true) {
                                                    dataObj2.Groups[i].Rows[sn].Cols[c].otherAnswer.push({ "index": 1, "value": other.value, "lastUpdate": today });
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                                }

                                                //給新QuestionID
                                                //dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID = dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID + today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                            }
                                        }
                                        break;
                                    //case "CheckboxMixImage":
                                    //    if (dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length > dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length) {
                                    //        for (var o = 0; o < dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length; o++) {
                                    //            dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions[o].index, "value": false, "lastUpdate": today });
                                    //        }
                                    //    }
                                    //    break;

                                    case "CheckboxMixFilling":
                                        if (inputs[d].type == "checkbox") {
                                            let Smaecheckboxs = document.getElementsByName(inputs[d].name);
                                            let Checkboxs = [];
                                            let Txts = [];
                                            let other;
                                            let others = document.querySelectorAll(".other");
                                            if (!remove) {
                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                            }
                                            others.forEach(function (item) {
                                                if (item.dataset.qid == inputs[d].name) {
                                                    other = item;
                                                }
                                            })


                                            Smaecheckboxs.forEach(function (item) {
                                                if (item.type == "checkbox") {
                                                    Checkboxs.push(item);
                                                }
                                            });
                                            console.log("Checkboxs" + Checkboxs.length)
                                            Smaecheckboxs.forEach(function (item) {
                                                if (item.type == "text" && !item.classList.contains("other")) {
                                                    Txts.push(item);
                                                } else if (item.type == "text" && item.classList.contains("other")) {
                                                    other = item;
                                                }
                                            });
                                            if (dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length > dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length) {
                                                for (var o = 0; o < dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length; o++) {
                                                    dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions[o].index, "value": false, "lastUpdate": today, "Answers": [] });
                                                }
                                            }
                                            for (var b = 0; b < Checkboxs.length; b++) {
                                                if (Checkboxs[b].checked) {
                                                    if (dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length>b) {
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].value = true;
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].lastUpdate = today;
                                                        for (var t = 0; t < Txts.length; t++) {
                                                            if (Txts[t].dataset.checkboxindex == Checkboxs[b].value && Txts.length > dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].Answers.length) {
                                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].Answers.push({ "index": Number(Txts[t].dataset.textindex), "value": Txts[t].value, "lastUpdate": today });
                                                            }
                                                        }
                                                    }
                                                } else {
                                                    if (dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length > b) {
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].value = false;
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].lastUpdate = today;
                                                        for (var t = 0; t < Txts.length; t++) {
                                                            if (Txts[t].dataset.checkboxindex == Checkboxs[b].value && Txts.length > dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].Answers.length) {
                                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].Answers.push({ "index": Number(Txts[t].dataset.textindex), "value": "", "lastUpdate": today });
                                                            }
                                                        }
                                                        //if (Txts[t].dataset.checkboxindex == Checkboxs[b].value && Txts.length > dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].Answers.length) {
                                                        //    dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].Answers.push({ "index": Number(Txts[t].dataset.textindex), "value":"", "lastUpdate": today });
                                                        //}
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                                    }
                                                }
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                            }
                                            if (dataObj2.Groups[i].Rows[sn].Cols[c].hasOtherAnswers == true) {
                                                dataObj2.Groups[i].Rows[sn].Cols[c].otherAnswer.push({ "index": 1, "value": other.value, "lastUpdate": today });
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                            }

                                            //給新QuestionID
                                            //dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID = dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID + today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));

                                        }
                                        break;
                                    default:
                                }

                            }
                        }

                    }
                }
            }


            let fade = document.querySelector(".modal-backdrop");
            fade.classList.remove("modal-open");
            document.body.classList.remove("modal-open");

            //let allModal = document.querySelectorAll(".modalcontainer");
            //for (var i = 0; i < allModal.length; i++) {
            //    allModal[i].innerHTML = "";
            //}
            let allFade = document.querySelectorAll(".modal-backdrop");
            for (var i = 0; i < allFade.length; i++) {
                allFade[i].classList.remove("modal-open", "show", "fade", "modal-backdrop");
            }
            let allRow = document.querySelectorAll(".rowPart");
            for (var i = 0; i < allRow.length; i++) {
                allRow[i].innerHTML = "";
            }
            let ansEditForm = document.querySelector(".ansEditForm");
            ansEditForm.innerHTML = "";
            //取最後一個 row 重新給QID
            for (var i = 0; i < dataObj2.Groups.length; i++) {
                if (dataObj2.Groups[i].GroupID == GroupId) {
                    for (var r = 0; r < dataObj2.Groups[i].Rows.length; r++) {
                        dataObj2.Groups[i].Rows[r].index = Number(r + 1);
                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                    }
                }
            }
            for (var i = 0; i < dataObj2.Groups.length; i++) {
                if (dataObj2.Groups[i].GroupID == GroupId) {
                    let lastRow = Number(dataObj2.Groups[i].Rows.length - 1);
                    for (var c = 0; c < dataObj2.Groups[i].Rows[lastRow].Cols.length; c++) {
                        console.log("dataObj2.Groups[i].Rows[lastRow].Cols[c].QuestionID" + dataObj2.Groups[i].Rows[lastRow].Cols[c].QuestionID)
                        let row = lastRow + 1;
                        let col = c + 1;
                        dataObj2.Groups[i].Rows[lastRow].Cols[c].QuestionID = dataObj2.Groups[i].Rows[lastRow].Cols[c].QuestionID + row + col;
                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                    }
                }
            }
            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));

            GroupsTemplate(dataObj2);
            let insertBody = document.querySelector(".insertBody");
            let insertBodyStr = "";
            insertBody.innerHTML = insertBodyStr;
            $("#modal-insert").modal('hide');
        }
        function changeRowJsonData(event) {
            var dataObj = GetJsonData();
            let thischangeRow = event.currentTarget;

        }
        //row 刪除 
        function DeleteRow(event) {
            var dataObj = GetJsonData();
            let gid = event.currentTarget.dataset.gid;
            let row = Number(event.currentTarget.dataset.row);

            dataObj.Groups[gid].Rows.splice(row, 1);
            for (var i = 0; i < dataObj.Groups[gid].Rows.length; i++) {
                dataObj.Groups[gid].Rows[i], index = i + 1;
            }
            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

            let allRow = document.querySelectorAll(".rowPart");
            for (var i = 0; i < allRow.length; i++) {
                allRow[i].innerHTML = "";
            }

            GroupsTemplate(dataObj);
        }

        //Table跟Row的 資料變動時改變Json內容
        function changeTableJsonData(event) {
            var dataObj = GetJsonData();
            let thischange = event.currentTarget;
            let thischangeType = thischange.type;
            let thischangeQ = thischange.name;
            //let gsn = thischange.dataset.
            console.log("thischange_" + thischange.type);
            let date = new Date();
            let today = date.getTime();
            switch (thischangeType) {
                case "file":
                case "image":
                    for (var i = 0; i < dataObj.Groups.length; i++) {
                        if (dataObj.Groups[i].GroupType != "normal") {
                            for (var j = 0; j < dataObj.Groups[i].Rows.length; j++) {
                                for (var q = 0; q < dataObj.Groups[i].Rows[j].Cols.length; q++) {
                                    //檢查檔名
                                    let fileName = thischange.value;
                                    var re = /\.(jpg|png|doc|pdf|docx)$/i;  //允許的副檔名
                                    console.log("file");
                                    //let AppendFileName = document.querySelector("#MainContent_AppendFile");
                                    if (!re.test(fileName)) {
                                        alert("檔案格式錯誤!!請檢查!!")
                                        break;
                                    } else {
                                        if (dataObj.Groups[i].Rows[j].Cols[q].QuestionID == event.currentTarget.name) {
                                            let now = date.getFullYear("yyyy") + String(date.getMonth() + 1).padStart(2, '0') + String(date.getDate()).padStart(2, '0') + String(date.getHours()).padStart(2, '0') + String(date.getMinutes()).padStart(2, '0') + String(date.getSeconds()).padStart(2, '0') + String(date.getMilliseconds()).padStart(3, '0');
                                            fileName = fileName.substring("12");
                                            fileName = now + "_" + fileName;
                                            Upload(fileName);
                                            if (dataObj.Groups[i].Rows[j].Cols[q].Answers.length > 0) {
                                                dataObj.Groups[i].Rows[j].Cols[q].QuestionID = dataObj.Groups[i].Rows[j].Cols[q].QuestionID + j + today;
                                                dataObj.Groups[i].Rows[j].Cols[q].Answers[0].value = fileName;
                                                dataObj.Groups[i].Rows[j].Cols[q].Answers[0].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            } else {
                                            //    let obj = dataObj.Groups[i].Rows[j];
                                            //    obj.Cols[q].QuestionID = dataObj.Groups[i].Rows[1].Cols[q].QuestionID + j + today;
                                            //    obj.Cols[q].Answers.push({ "index": 1, "value": fileName, "lastUpdate": today });
                                            //    //dataObj.Groups[i].Rows[1].Cols[q].QuestionID = dataObj.Groups[i].Rows[1].Cols[q].QuestionID + j + today;
                                            //    //dataObj.Groups[i].Rows[1].Cols[q].Answers.push({ "index": 1, "value": fileName, "lastUpdate": today });
                                            //    dataObj.Groups[i].Rows.push(obj);
                                            //    //dataObj.Groups[i].Rows.splice(1, 1);
                                            //    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            }
                                        }
                                    }

                                }

                            }
                        }
                    }
                    break;

                case "text":
                case "number":
                case "date":
                case "select-one":
                    for (let t = 0; t < dataObj.Groups.length; t++) {
                        if (dataObj.Groups[t].GroupType != "normal") {
                            for (let i = 0; i < dataObj.Groups[t].Rows.length; i++) {
                                for (let c = 0; c < dataObj.Groups[t].Rows[i].Cols.length; c++) {
                                    if (dataObj.Groups[t].Rows[i].Cols[c].QuestionID == thischangeQ && dataObj.Groups[t].Rows[i].Cols[c].QuestionType == "text") {

                                        dataObj.Groups[t].Rows[i].Cols[c].Answers[0].value = thischange.value;
                                        dataObj.Groups[t].Rows[i].Cols[c].Answers[0].lastUpdate = today;
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                    }
                                    else if (dataObj.Groups[t].Rows[i].Cols[c].QuestionID == thischangeQ && dataObj.Groups[t].Rows[i].Cols[c].QuestionType == "number") {

                                        dataObj.Groups[t].Rows[i].Cols[c].Answers[0].value = thischange.value;
                                        dataObj.Groups[t].Rows[i].Cols[c].Answers[0].lastUpdate = today;
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

                                    }
                                    else if (dataObj.Groups[t].Rows[i].Cols[c].QuestionID == thischangeQ && dataObj.Groups[t].Rows[i].Cols[c].QuestionType == "date") {
                                        dataObj.Groups[t].Rows[i].Cols[c].Answers[0].value = Date.parse(thischange.value);
                                        dataObj.Groups[t].Rows[i].Cols[c].Answers[0].lastUpdate = today;
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

                                    }
                                    else if (dataObj.Groups[t].Rows[i].Cols[c].QuestionID == thischangeQ && dataObj.Groups[t].Rows[i].Cols[c].QuestionType == "select-one") {
                                        dataObj.Groups[t].Rows[i].Cols[c].Answers[0].value = thischange.value;
                                        dataObj.Groups[t].Rows[i].Cols[c].Answers[0].lastUpdate = today;
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

                                    }
                                    else if (dataObj.Groups[t].Rows[i].Cols[c].QuestionID == thischangeQ && dataObj.Groups[t].Rows[i].Cols[c].QuestionType == "filling") {

                                        let fsn = Number(thischange.dataset.filling);
                                        let indexfsn = Number(thischange.dataset.filling);
                                        fsn = fsn - 1;
                                        dataObj.Groups[t].Rows[i].Cols[c].Answers[fsn].index = indexfsn;
                                        dataObj.Groups[t].Rows[i].Cols[c].Answers[fsn].value = thischange.value;
                                        dataObj.Groups[t].Rows[i].Cols[c].Answers[fsn].lastUpdate = today;
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                    }
                                    else if (dataObj.Groups[t].Rows[i].Cols[c].QuestionType == "RadioMixFilling" && dataObj.Groups[t].Rows[i].Cols[c].QuestionID == thischangeQ) {
                                        if (thischange.classList.contains("other")) {
                                            dataObj.Groups[t].Rows[i].Cols[c].otherAnswer[0].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].otherAnswer[0].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        }
                                        let radioindex = thischange.dataset.radioindex;
                                        let textindex = thischange.dataset.textindex;
                                        for (let o = 0; o < dataObj.Groups[t].Rows[i].Cols[c].Answers.length; o++) {
                                            if (dataObj.Groups[t].Rows[i].Cols[c].Answers[o].index == radioindex) {
                                                for (var a = 0; a < dataObj.Groups[t].Rows[i].Cols[c].Answers[o].Answers.length; a++) {
                                                    if (dataObj.Groups[t].Rows[i].Cols[c].Answers[o].Answers[a].index == textindex) {
                                                        if (dataObj.Groups[t].Rows[i].Cols[c].Answers[o].value == true) {
                                                            dataObj.Groups[t].Rows[i].Cols[c].Answers[o].Answers[a].value = thischange.value;
                                                            dataObj.Groups[t].Rows[i].Cols[c].Answers[o].Answers[a].lastUpdate = today;
                                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                        }
                                                    }
                                                }
                                            } else {
                                                for (var a = 0; a < dataObj.Groups[t].Rows[i].Cols[c].Answers[o].Answers.length; a++) {
                                                    console.log("RadioMixFilling");
                                                    dataObj.Groups[t].Rows[i].Cols[c].Answers[o].Answers[a].value = "";
                                                    dataObj.Groups[t].Rows[i].Cols[c].Answers[o].Answers[a].lastUpdate = today;
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

                                                }

                                            }
                                        }
                                    }
                                    else if (dataObj.Groups[t].Rows[i].Cols[c].QuestionType == "CheckboxMixFilling" && dataObj.Groups[t].Rows[i].Cols[c].QuestionID == thischange.name) {//Checkbox下面的filling
                                        if (thischange.classList.contains("other")) {
                                            dataObj.Groups[t].Rows[i].Cols[c].otherAnswer[0].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].otherAnswer[0].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        }

                                        let checkboxindex = thischange.dataset.checkboxindex;
                                        let textindex = thischange.dataset.textindex;
                                        for (let o = 0; o < dataObj.Groups[t].Rows[i].Cols[c].Answers.length; o++) {
                                            if (dataObj.Groups[t].Rows[i].Cols[c].Answers[o].index == checkboxindex) {
                                                for (var a = 0; a < dataObj.Groups[t].Rows[i].Cols[c].Answers[o].Answers.length; a++) {
                                                    if (dataObj.Groups[t].Rows[i].Cols[c].Answers[o].Answers[a].index == textindex) {
                                                        if (dataObj.Groups[t].Rows[i].Cols[c].Answers[o].value == true) {

                                                            dataObj.Groups[t].Rows[i].Cols[c].Answers[o].Answers[a].value = thischange.value;
                                                            dataObj.Groups[t].Rows[i].Cols[c].Answers[o].Answers[a].lastUpdate = today;
                                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                        } else {
                                                            dataObj.Groups[t].Rows[i].Cols[c].Answers[o].Answers[a].value = "";
                                                            dataObj.Groups[t].Rows[i].Cols[c].Answers[o].Answers[a].lastUpdate = today;
                                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    else if (thischange.classList.contains("other")) {
                                        console.log("other");
                                        for (let c = 0; c < dataObj.Groups[t].Rows[i].Cols.length; c++) {
                                            if (dataObj.Groups[t].Rows[i].Cols[c].hasOtherAnswers && dataObj.Groups[t].Rows[i].Cols[c].QuestionID == thischange.name) {
                                                dataObj.Groups[t].Rows[i].Cols[c].otherAnswer[0].value = thischange.value;
                                                dataObj.Groups[t].Rows[i].Cols[c].otherAnswer[0].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

                                            }
                                        }
                                    }
                                }
                            }

                        }
                    }
                    break;
                case "radio":
                case "RadioMixFilling":
                    for (let i = 0; i < dataObj.Groups.length; i++) {
                        if (dataObj.Groups[i].GroupType != "normal") {
                            for (let r = 0; r < dataObj.Groups[i].Rows.length; r++) {
                                for (let c = 0; c < dataObj.Groups[i].Rows[r].Cols.length; c++) {
                                    if (dataObj.Groups[i].Rows[r].Cols[c].QuestionID == thischange.name) {
                                        for (var a = 0; a < dataObj.Groups[i].Rows[r].Cols[c].Answers.length; a++) {
                                            dataObj.Groups[i].Rows[r].Cols[c].Answers[a].value = false;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        }
                                        if (thischange.checked) {
                                            for (var a = 0; a < dataObj.Groups[i].Rows[r].Cols[c].Answers.length; a++) {
                                                if (thischange.value == dataObj.Groups[i].Rows[r].Cols[c].Answers[a].index) {
                                                    dataObj.Groups[i].Rows[r].Cols[c].Answers[a].value = true;
                                                    dataObj.Groups[i].Rows[r].Cols[c].Answers[a].lastUpdate = today;
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                }
                                            }
                                        } else {
                                            for (var a = 0; a < dataObj.Groups[i].Rows[r].Cols[c].Answers.length; a++) {
                                                if (thischange.value == dataObj.Groups[i].Rows[r].Cols[c].Answers[a].index) {
                                                    if (dataObj.Groups[i].Rows[r].Cols[c].Answers[a].Answers.length > 0 && dataObj.Groups[i].Rows[r].Cols[c].QuestionType == "RadioMixCheckbox") {
                                                        for (var aa = 0; aa < dataObj.Groups[i].Rows[r].Cols[c].Answers[a].Answers.length; aa++) {
                                                            dataObj.Groups[i].Rows[r].Cols[c].Answers[a].Answers[aa].value == false;
                                                            dataObj.Groups[i].Rows[r].Cols[c].Answers[a].Answers[aa].lastUpdate = today;
                                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

                                                        }
                                                    } else if (dataObj.Groups[i].Rows[r].Cols[c].Answers[a].Answers.length > 0 && dataObj.Groups[i].Rows[r].Cols[c].QuestionType == "RadioMixFilling") {

                                                        for (var aa = 0; aa < dataObj.Groups[i].Rows[r].Cols[c].Answers[a].Answers.length; aa++) {
                                                            dataObj.Groups[i].Rows[r].Cols[c].Answers[a].Answers[aa].value == "";
                                                            dataObj.Groups[i].Rows[r].Cols[c].Answers[a].Answers[aa].lastUpdate = today;
                                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

                                                        }

                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                        }
                    }
                    break;
                case "checkbox":
                    for (let i = 0; i < dataObj.Groups.length; i++) {
                        if (dataObj.Groups[i].GroupType != "normal") {
                            for (let r = 0; r < dataObj.Groups[i].Rows.length; r++) {
                                for (let c = 0; c < dataObj.Groups[i].Rows[r].Cols.length; c++) {
                                    if (dataObj.Groups[i].Rows[r].Cols[c].QuestionID == thischange.name) {
                                        if (dataObj.Groups[i].Rows[r].Cols[c].QuestionType == "RadioMixCheckbox" && dataObj.Groups[i].Rows[r].Cols[c].QuestionID == thischange.name) {
                                            if (thischange.classList.contains("other")) {
                                                console.log("other");
                                                dataObj.Groups[t].Rows[i].Cols[c].otherAnswer[0].value = thischange.value;
                                                dataObj.Groups[t].Rows[i].Cols[c].otherAnswer[0].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            }

                                            if (thischange.checked) {
                                                let checkboxindex = thischange.dataset.checkboxindex;
                                                let radioindex = thischange.dataset.radioindex;
                                                for (var a = 0; a < dataObj.Groups[i].Rows[r].Cols[c].Answers.length; a++) {
                                                    if (dataObj.Groups[i].Rows[r].Cols[c].Answers[a].index == radioindex) {
                                                        dataObj.Groups[i].Rows[r].Cols[c].Answers[a].value = true;
                                                        for (var aa = 0; aa < dataObj.Groups[i].Rows[r].Cols[c].Answers[a].Answers.length; aa++) {
                                                            if (dataObj.Groups[i].Rows[r].Cols[c].Answers[a].Answers[aa].index == checkboxindex) {
                                                                dataObj.Groups[i].Rows[r].Cols[c].Answers[a].Answers[aa].value = true;
                                                                dataObj.Groups[i].Rows[r].Cols[c].Answers[a].Answers[aa].lastUpdate = today;
                                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                            }
                                                        }
                                                    } else {
                                                        dataObj.Groups[i].Rows[r].Cols[c].Answers[a].value = false;
                                                        for (var aa = 0; aa < dataObj.Groups[i].Rows[r].Cols[c].Answers[a].Answers.length; aa++) {
                                                            dataObj.Groups[i].Rows[r].Cols[c].Answers[a].Answers[aa].value = false;
                                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    for (let i = 0; i < dataObj.Groups.length; i++) {
                        if (dataObj.Groups[i].GroupType != "normal") {
                            for (let r = 0; r < dataObj.Groups[i].Rows.length; r++) {
                                for (let c = 0; c < dataObj.Groups[i].Rows[r].Cols.length; c++) {
                                    if (dataObj.Groups[i].Rows[r].Cols[c].QuestionID == thischange.name.substring(1) || dataObj.Groups[i].Rows[r].Cols[c].QuestionID == thischange.name) {

                                        if (dataObj.Groups[i].Rows[r].Cols[c].QuestionType == "checkbox" || dataObj.Groups[i].Rows[r].Cols[c].QuestionType == "CheckboxMixImage" || dataObj.Groups[i].Rows[r].Cols[c].QuestionType == "CheckboxMixFilling") {
                                            if (thischange.checked) {
                                                for (var a = 0; a < dataObj.Groups[i].Rows[r].Cols[c].Answers.length; a++) {
                                                    if (dataObj.Groups[i].Rows[r].Cols[c].Answers[a].index == thischange.value) {
                                                        dataObj.Groups[i].Rows[r].Cols[c].Answers[a].value = true;
                                                        dataObj.Groups[i].Rows[r].Cols[c].Answers[a].lastUpdate = today;
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                    }
                                                }
                                            } else {
                                                for (var a = 0; a < dataObj.Groups[i].Rows[r].Cols[c].Answers.length; a++) {
                                                    console.log("yy")
                                                    if (dataObj.Groups[i].Rows[r].Cols[c].Answers[a].index == thischange.value) {
                                                        dataObj.Groups[i].Rows[r].Cols[c].Answers[a].value = false;
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                        if (dataObj.Groups[i].Rows[r].Cols[c].QuestionType =="CheckboxMixFilling") {
                                                            let Ansans = dataObj.Groups[i].Rows[r].Cols[c].Answers[a].Answers.length;
                                                            for (var aa = 0; aa < Ansans; aa++) {
                                                                console.log("Ansans" + Ansans);
                                                                dataObj.Groups[i].Rows[r].Cols[c].Answers[a].Answers[aa].value = "";
                                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                            }

                                                        }
                                                        dataObj.Groups[i].Rows[r].Cols[c].Answers[a].lastUpdate = today;
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                        }
                    }
                    break;

                default:
            }
        }
        //normal 資料變動時改變Json內容
        function changeJsonData(event) {
            var dataObj = GetJsonData();
            let thischange = event.currentTarget;
            console.log("thischange_" + thischange.type)
            let date = new Date();
            let today = date.getTime();
            switch (thischange.type) {
                case "file":
                case "image":
                    for (var i = 0; i < dataObj.Groups.length; i++)  {
                        if (dataObj.Groups[i].GroupType == "normal") {
                            for (var j = 0; j < dataObj.Groups[i].Questions.length; j++) {
                                //檢查檔名
                                let fileName = thischange.value;
                                var re = /\.(jpg|png|doc|pdf|docx)$/i;  //允許的副檔名
                                console.log("file");
                                //let AppendFileName = document.querySelector("#MainContent_AppendFile");
                                if (!re.test(fileName)) {
                                    alert("檔案格式錯誤!!請檢查!!")
                                    break;
                                } else {
                                    if (dataObj.Groups[i].Questions[j].QuestionText == event.currentTarget.name) {
                                        let now = date.getFullYear("yyyy") + String(date.getMonth() + 1).padStart(2, '0') + String(date.getDate()).padStart(2, '0') + String(date.getHours()).padStart(2, '0') + String(date.getMinutes()).padStart(2, '0') + String(date.getSeconds()).padStart(2, '0') + String(date.getMilliseconds()).padStart(3, '0');
                                        fileName = fileName.substring("12");
                                        fileName = now + "_" + fileName;
                                        
                                        Upload(fileName);
                                        if (dataObj.Groups[i].Questions[j].Answers.length > 0) {
                                            dataObj.Groups[i].Questions[j].Answers[0].value = fileName;
                                            dataObj.Groups[i].Questions[j].Answers[0].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            alert("檔案上傳成功!")
                                        } else {
                                            dataObj.Groups[i].Questions[j].Answers.push({ "index": 1, "value": fileName, "lastUpdate": today });
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            alert("檔案上傳成功!")
                                        }
                                    }
                                }

                            }
                        }
                    }
                    break;
                case "text":
                case "number":
                case "date":
                case "select-one":
                    let ThisName = event.currentTarget.name;
                    let thisNameQ = ThisName.split("_");
                    for (var i = 0; i < dataObj.Groups.length; i++) {
                        if (dataObj.Groups[i].GroupType == "normal") {
                            for (var j = 0; j < dataObj.Groups[i].Questions.length; j++) {
                                if (dataObj.Groups[i].Questions[j].QuestionText == event.currentTarget.name) {
                                    dataObj.Groups[i].Questions[j].Answers.length = 0;
                                    dataObj.Groups[i].Questions[j].Answers.push({ "index": 1, "value": event.currentTarget.value, "lastUpdate": today });
                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                }
                                else if (dataObj.Groups[i].Questions[j].QuestionType == "filling") {////Filling
                                    if (dataObj.Groups[i].Questions[j].QuestionText == thisNameQ[0]) {
                                        let sn = thisNameQ[1] - 1;
                                        if (dataObj.Groups[i].Questions[j].Answers.length == 0) {
                                            dataObj.Groups[i].Questions[j].Answers.push({ "index": thisNameQ[1], "value": event.currentTarget.value, "lastUpdate": today });
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        } else if (dataObj.Groups[i].Questions[j].Answers.length < thisNameQ[1]) {
                                            dataObj.Groups[i].Questions[j].Answers.push({ "index": thisNameQ[1], "value": event.currentTarget.value, "lastUpdate": today });
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        } else {
                                            dataObj.Groups[i].Questions[j].Answers[sn].value = event.currentTarget.value;
                                            dataObj.Groups[i].Questions[j].Answers[sn].lastUpdate = today;
                                            dataObj.Groups[i].Questions[j].Answers[sn].index = sn + 1;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        }
                                    }
                                } else if (dataObj.Groups[i].Questions[j].QuestionType == "CheckboxMixFilling") {
                                    let thisValue = event.currentTarget.name;
                                    let ansValue = thisValue.split("_");
                                    console.log("CheckboxMixFilling Filling")
                                    for (var ansO = 0; ansO < dataObj.Groups[i].Questions[j].AnswerOptions.length; ansO++) {
                                        if (dataObj.Groups[i].Questions[j].AnswerOptions[ansO].AnsText == ansValue[0]) {
                                            for (var f = 0; f < dataObj.Groups[i].Questions[j].Answers[ansO].Answers.length; f++) {
                                                if (dataObj.Groups[i].Questions[j].Answers[ansO].Answers[f].index == ansValue[1]) {
                                                    console.log("CheckboxMixFilling Filling2")
                                                    dataObj.Groups[i].Questions[j].Answers[ansO].Answers[f].value = event.currentTarget.value;
                                                    dataObj.Groups[i].Questions[j].Answers[ansO].Answers[f].lastUpdate = today;
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                }
                                            }
                                        }
                                    }
                                }
                                else if (dataObj.Groups[i].Questions[j].QuestionType == "RadioMixFilling") {
                                    let thisValue = event.currentTarget.name;
                                    let ansValue = thisValue.split("_");
                                    console.log("RadioMixFilling Filling")
                                    for (var ansO = 0; ansO < dataObj.Groups[i].Questions[j].AnswerOptions.length; ansO++) {
                                        if (dataObj.Groups[i].Questions[j].AnswerOptions[ansO].AnsText == ansValue[0]) {

                                            for (var f = 0; f < dataObj.Groups[i].Questions[j].Answers[ansO].Answers.length; f++) {
                                                if (dataObj.Groups[i].Questions[j].Answers[ansO].Answers[f].index == ansValue[1]) {
                                                    console.log("RadioMixFilling Filling2")
                                                    dataObj.Groups[i].Questions[j].Answers[ansO].Answers[f].value = event.currentTarget.value;
                                                    dataObj.Groups[i].Questions[j].Answers[ansO].Answers[f].lastUpdate = today;
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    break;
                case "checkbox":
                    for (var i = 0; i < dataObj.Groups.length; i++) {
                        for (var j = 0; j < dataObj.Groups[i].Questions.length; j++) {
                            if (dataObj.Groups[i].Questions[j].QuestionText == event.currentTarget.name && dataObj.Groups[i].Questions[j].QuestionType == "checkbox") {
                                if (event.currentTarget.checked) {
                                    for (var ic = 0; ic < dataObj.Groups[i].Questions[j].AnswerOptions.length; ic++) {
                                        if (dataObj.Groups[i].Questions[j].AnswerOptions[ic].AnsText == event.currentTarget.value) {
                                            dataObj.Groups[i].Questions[j].Answers[ic].value = true;
                                            dataObj.Groups[i].Questions[j].Answers[ic].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        }
                                    }
                                } else {
                                    for (let cc = 0; cc < dataObj.Groups[i].Questions[j].AnswerOptions.length; cc++) {
                                        if (dataObj.Groups[i].Questions[j].AnswerOptions[cc].AnsText == event.currentTarget.value) {
                                            dataObj.Groups[i].Questions[j].Answers[cc].value = false;
                                            dataObj.Groups[i].Questions[j].Answers[cc].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            console.log("沒勾:" + dataObj.Groups[i].Questions[j].Answers);
                                        }
                                    }
                                }
                            }
                            else if (dataObj.Groups[i].Questions[j].QuestionType == "CheckboxMixFilling") {
                                console.log("CheckboxMixFilling Checkbox")
                                if (event.currentTarget.checked) {
                                    for (var y = 0; y < dataObj.Groups[i].Questions[j].AnswerOptions.length; y++) {
                                        if (dataObj.Groups[i].Questions[j].AnswerOptions[y].AnsText == event.currentTarget.value) {
                                            let Opt = y;
                                            for (var m = 0; m < dataObj.Groups[i].Questions[j].Answers.length; m++) {
                                                if (dataObj.Groups[i].Questions[j].Answers[m].index == dataObj.Groups[i].Questions[j].AnswerOptions[Opt].index) {

                                                    dataObj.Groups[i].Questions[j].Answers[m].value = true;
                                                    dataObj.Groups[i].Questions[j].Answers[m].lastUpdate = today;
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                }
                                            }
                                        }
                                    }
                                } else {
                                    for (var y = 0; y < dataObj.Groups[i].Questions[j].AnswerOptions.length; y++) {
                                        if (dataObj.Groups[i].Questions[j].AnswerOptions[y].AnsText == event.currentTarget.value) {
                                            for (var m = 0; m < dataObj.Groups[i].Questions[j].Answers.length; m++) {
                                                if (dataObj.Groups[i].Questions[j].Answers[m].index == dataObj.Groups[i].Questions[j].AnswerOptions[y].index) {
                                                    dataObj.Groups[i].Questions[j].Answers[m].value = false;
                                                    dataObj.Groups[i].Questions[j].Answers[m].lastUpdate = today;
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                }
                                            }
                                        }
                                    }
                                }
                            } else if (dataObj.Groups[i].Questions[j].QuestionType == "RadioMixCheckbox") {
                                if (event.currentTarget.checked) {
                                    for (var y = 0; y < dataObj.Groups[i].Questions[j].AnswerOptions.length; y++) {
                                        if (dataObj.Groups[i].Questions[j].AnswerOptions[y].AnsText == event.currentTarget.name) {
                                            for (var x = 0; x < dataObj.Groups[i].Questions[j].AnswerOptions[y].AnswerOptions.length; x++) {
                                                if (dataObj.Groups[i].Questions[j].AnswerOptions[y].AnswerOptions[x].AnsText == event.currentTarget.value) {
                                                    dataObj.Groups[i].Questions[j].Answers[y].Answers[x].value = true;
                                                    console.log("dataObj.Groups[i].Questions[j].Answers[y].Answers[x].index:" + dataObj.Groups[i].Questions[j].Answers[y].Answers[x].index);
                                                    dataObj.Groups[i].Questions[j].Answers[y].Answers[x].lastUpdate = today;
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                }
                                            }
                                        }
                                    }
                                }
                                else {
                                    for (var y = 0; y < dataObj.Groups[i].Questions[j].AnswerOptions.length; y++) {
                                        if (dataObj.Groups[i].Questions[j].AnswerOptions[y].AnsText == event.currentTarget.name) {
                                            for (var x = 0; x < dataObj.Groups[i].Questions[j].AnswerOptions[y].AnswerOptions.length; x++) {
                                                if (dataObj.Groups[i].Questions[j].AnswerOptions[y].AnswerOptions[x].AnsText == event.currentTarget.value) {
                                                    dataObj.Groups[i].Questions[j].Answers[y].Answers[x].value = false;
                                                    dataObj.Groups[i].Questions[j].Answers[y].Answers[x].lastUpdate = today;
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            else if (dataObj.Groups[i].Questions[j].QuestionType == "CheckboxMixImage") {
                                if (event.currentTarget.checked) {
                                    for (var ic = 0; ic < dataObj.Groups[i].Questions[j].AnswerOptions.length; ic++) {
                                        if (dataObj.Groups[i].Questions[j].AnswerOptions[ic].AnsText == event.currentTarget.value) {
                                            dataObj.Groups[i].Questions[j].Answers[ic].value = true;
                                            dataObj.Groups[i].Questions[j].Answers[ic].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        }
                                    }
                                } else {
                                    for (let cc = 0; cc < dataObj.Groups[i].Questions[j].AnswerOptions.length; cc++) {
                                        if (dataObj.Groups[i].Questions[j].AnswerOptions[cc].AnsText == event.currentTarget.value) {
                                            dataObj.Groups[i].Questions[j].Answers[cc].value = false;
                                            dataObj.Groups[i].Questions[j].Answers[cc].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            console.log("沒勾:" + dataObj.Groups[i].Questions[j].Answers);
                                        }
                                    }
                                }

                            }
                        }
                    }
                    break;
                case "radio":
                    for (var i = 0; i < dataObj.Groups.length; i++) {
                        for (var j = 0; j < dataObj.Groups[i].Questions.length; j++) {
                            if (dataObj.Groups[i].Questions[j].QuestionText == event.currentTarget.name && dataObj.Groups[i].Questions[j].QuestionType == "radio") {
                                if (event.currentTarget.checked) {
                                    for (var r = 0; r < dataObj.Groups[i].Questions[j].AnswerOptions.length; r++) {
                                        if (dataObj.Groups[i].Questions[j].AnswerOptions[r].AnsText == event.currentTarget.value) {
                                            dataObj.Groups[i].Questions[j].Answers[r].value = true;
                                            dataObj.Groups[i].Questions[j].Answers[r].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        } else {
                                            dataObj.Groups[i].Questions[j].Answers[r].value = false;
                                            dataObj.Groups[i].Questions[j].Answers[r].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        }
                                    }
                                }
                            } else if (dataObj.Groups[i].Questions[j].QuestionText == event.currentTarget.name && dataObj.Groups[i].Questions[j].QuestionType == "RadioMixCheckbox") {
                                if (event.currentTarget.checked) {
                                    for (var rc = 0; rc < dataObj.Groups[i].Questions[j].AnswerOptions.length; rc++) {
                                        if (dataObj.Groups[i].Questions[j].AnswerOptions[rc].AnsText == event.currentTarget.value) {
                                            dataObj.Groups[i].Questions[j].Answers[rc].value = true;
                                            dataObj.Groups[i].Questions[j].Answers[rc].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        } else {
                                            dataObj.Groups[i].Questions[j].Answers[rc].value = false;
                                            dataObj.Groups[i].Questions[j].Answers[rc].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        }
                                    }
                                }
                            } else if (dataObj.Groups[i].Questions[j].QuestionText == event.currentTarget.name && dataObj.Groups[i].Questions[j].QuestionType == "RadioMixFilling") {
                                if (event.currentTarget.checked) {
                                    for (var c = 0; c < dataObj.Groups[i].Questions[j].AnswerOptions.length; c++) {
                                        if (dataObj.Groups[i].Questions[j].AnswerOptions[c].AnsText == event.currentTarget.value) {
                                            dataObj.Groups[i].Questions[j].Answers[c].value = true;
                                            dataObj.Groups[i].Questions[j].Answers[c].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        } else {
                                            dataObj.Groups[i].Questions[j].Answers[c].value = false;
                                            dataObj.Groups[i].Questions[j].Answers[c].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        }
                                    }
                                }
                            }
                        }
                    }
                    break;
                default:
            }
        }
        function SignByAdminId(event) {
            let date = new Date();
            let time = date.getTime();
            let This = event.currentTarget;
            let today = date.getFullYear("yyyy") + "-" + String(date.getMonth() + 1).padStart(2, '0') + "-" + String(date.getDate()).padStart(2, '0');
            var ChangejsonStr = document.querySelector("#mainPlaceHolder_jsonData").value;
            var JsonObj = JSON.parse(ChangejsonStr);
            let signImgID = document.querySelector("#mainPlaceHolder_adminSign").value;
            let SignBoxFather = event.currentTarget.parentNode;
            let SignBox = event.currentTarget.nextSibling;
            let SignImage = SignBox.childNodes[0];
            let isTable = false;
            let isRow = false;
            let dataStaut;
            let GidandRowsIndex;
            let Str;
            let Gid;
            let Row;
            var singDate = document.querySelectorAll(".signDate");
            for (var i = 0; i < singDate.length; i++) {
                singDate[i].innerText = today;
            }


            if (SignBoxFather.classList.contains("SignBoxinsertRow") || SignBoxFather.classList.contains("SignBoxRow")) {
                GidandRowsIndex = SignBoxFather.querySelector(".Signbtn").dataset.gidandrow;
                dataStaut = SignBoxFather.querySelector(".Signbtn").dataset.staut;
                Str = GidandRowsIndex.split("#");
                Gid = Str[0];
                Row = Str[1]-1;
            }


            SignImage.src = "ShowAdminImg?id=" + signImgID;

            if (SignBoxFather.classList.contains("SignBoxRow")) {//row 修改

                if (SignBox.classList.contains("d-none")) {
                    event.currentTarget.innerText = "取消簽核"
                    SignBox.classList.remove("d-none");
                    SignBox.classList.add("d-inline");
                    var singDate = document.querySelector(".signDate");
                    singDate.innerText = today;
                    for (var g = 0; g < JsonObj.Groups.length; g++) {
                        console.log(JsonObj.Groups[g].GroupID);
                        
                        if (JsonObj.Groups[g].GroupID == Gid) {
                            for (var c = 0; c < JsonObj.Groups[g].Rows[Row].Cols.length; c++) {
                                if (SignImage.classList.contains(JsonObj.Groups[g].Rows[Row].Cols[c].QuestionID)) {
                                    console.log(c);
                                    if (JsonObj.Groups[g].Rows[Row].Cols[c].Answers.length == 2) {
                                        JsonObj.Groups[g].Rows[Row].Cols[c].Answers.push({ "index": 1, "value": 0, "lastUpdate": time });
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(JsonObj));

                                    } else {
                                        JsonObj.Groups[g].Rows[Row].Cols[c].Answers[0].value = 0;
                                        JsonObj.Groups[g].Rows[Row].Cols[c].Answers[0].lastUpdate = time;
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(JsonObj));
                                    }
                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(JsonObj));
                                }
                            }
                        }
                    }
                } else {
                    SignBox.classList.remove("d-inline");
                    SignBox.classList.add("d-none");
                    event.currentTarget.innerText = "簽核";
                    for (var g = 0; g < JsonObj.Groups.length; g++) {
                        console.log("if" + Gid)
                        if (JsonObj.Groups[g].GroupID == Gid) {
                            for (var c = 0; c < JsonObj.Groups[g].Rows[Row].Cols.length; c++) {
                                console.log(JsonObj.Groups[g].Rows[Row].Cols[c].QuestionID);
                                if (SignImage.classList.contains(JsonObj.Groups[g].Rows[Row].Cols[c].QuestionID)) {
                                    JsonObj.Groups[g].Rows[Row].Cols[c].Answers.push({ "index": 1, "value": 0, "lastUpdate": null });
                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(JsonObj));
                                } /*else {*/
                                //    console.log("if" + Gid)
                                //    JsonObj.Groups[g].Rows[Row].Cols[c].Answers[0].value ="";
                                //    JsonObj.Groups[g].Rows[Row].Cols[c].Answers[0].lastUpdate = null;
                                //    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(JsonObj));
                                //}
                            }
                        }
                    }
                }
            }
            else if (SignBox.classList.contains("d-none")) {//table
                if (SignBoxFather.classList.contains("tableSign")) {
                    SignBoxFather.classList.remove("d-flex", "justify-content-end");
                    event.currentTarget.classList.add("mr-1");
                    isTable = true;
                    console.log("table2513");
                }

                SignBox.classList.remove("d-none");
                SignImage.id = "sign" + signImgID;
                SignBox.classList.add("d-inline");
                event.currentTarget.innerText = "取消簽核";
               
                if (isTable) {
                    for (var i = 0; i < JsonObj.Groups.length; i++) {
                        if (JsonObj.Groups[i].GroupType != "normal") {
                            for (var k = 0; k < JsonObj.Groups[i].Rows.length; k++) {
                                for (var c = 0; c < JsonObj.Groups[i].Rows[k].Cols.length; c++) {
                                    if (SignImage.classList.contains(JsonObj.Groups[i].Rows[k].Cols[c].QuestionID)) {
                                        JsonObj.Groups[i].Rows[k].Cols[c].Answers[0].value = signImgID;
                                        JsonObj.Groups[i].Rows[k].Cols[c].Answers[0].lastUpdate = time;
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(JsonObj));
                                    }
                                }
                            }

                        }
                    }
                } else {
                    
                    for (var i = 0; i < JsonObj.Groups.length; i++) {
                        if (JsonObj.Groups[i].GroupType == "normal") {
                            for (var k = 0; k < JsonObj.Groups[i].Questions.length; k++) {
                                if (SignImage.classList.contains(JsonObj.Groups[i].Questions[k].QuestionID)) {
                                    if (JsonObj.Groups[i].Questions[k].Answers.length == 0) {
                                        JsonObj.Groups[i].Questions[k].Answers.push({ "index": 1, "value": signImgID, "lastUpdate": time });
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(JsonObj));
                                    } else {
                                        JsonObj.Groups[i].Questions[k].Answers[0].value = signImgID;
                                        JsonObj.Groups[i].Questions[k].Answers[0].lastUpdate = time;
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(JsonObj));
                                    }
                                }
                            }

                        }
                    }
                }

            }
            else {
                console.log("簽名")
                if (SignBoxFather.classList.contains("tableSign")) {//table
                    SignBoxFather.classList.add("d-flex", "justify-content-end");
                    event.currentTarget.classList.remove("mr-1");
                    isTable = true;
                }
                SignBox.classList.remove("d-inline");
                SignBox.classList.add("d-none");
                event.currentTarget.innerText = "簽核";
                if (isTable) {
                    for (var i = 0; i < JsonObj.Groups.length; i++) {
                        for (var k = 0; k < JsonObj.Groups[i].Rows.length; k++) {
                            for (var c = 0; c < JsonObj.Groups[i].Rows[k].Cols.length; c++) {
                                if (SignImage.classList.contains(JsonObj.Groups[i].Rows[k].Cols[c].QuestionID)) {
                                    JsonObj.Groups[i].Rows[k].Cols[c].Answers[0].value = null;
                                    JsonObj.Groups[i].Rows[k].Cols[c].Answers[0].lastUpdate = null;
                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(JsonObj));
                                }
                            }
                        }
                    }
                } else {
                    console.log("normal")
                    for (var i = 0; i < JsonObj.Groups.length; i++) {
                        if (JsonObj.Groups[i].GroupType == "normal") {
                            for (var k = 0; k < JsonObj.Groups[i].Questions.length; k++) {
                                if (SignImage.classList.contains(JsonObj.Groups[i].Questions[k].QuestionID)) {
                                    if (JsonObj.Groups[i].Questions[k].Answers.length < 0) {
                                        JsonObj.Groups[i].Questions[k].Answers.push({ "index": 1, "value": null, "lastUpdate": null });
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(JsonObj));
                                    } else {
                                        JsonObj.Groups[i].Questions[k].Answers.length = 0;
                                        JsonObj.Groups[i].Questions[k].Answers.push({ "index": 1, "value": null, "lastUpdate": null });
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(JsonObj));
                                    }
                                }
                            }

                        }
                    }
                }
            }
        }
        //Disabled切換
        function DisabledTrue(event) {
            let input = event.currentTarget;
            let inputBrothers = event.currentTarget.parentNode.childNodes;
            if (input.checked == true) {
                for (var b = 0; b < inputBrothers.length; b++) {
                    inputBrothers[b].disabled = false;
                }
            } else {
                for (var d = 0; d < inputBrothers.length; d++) {
                    inputBrothers[d].disabled = true;
                    if (inputBrothers[d].type == "text") {
                        inputBrothers[d].value = "";
                    }
                }
            }
            input.disabled = false;

        }
        //清空 checkbox勾選 一般
        function CleanOption(event) {//不刪radio的checked
            let gfather = event.currentTarget.parentNode.parentNode;
            let selfradio = gfather.childNodes;//radio box
            for (var i = 0; i < selfradio.length; i++) {
                let selfckbs = selfradio[i].childNodes;
                for (var cki = 0; cki < selfckbs.length; cki++) {
                    selfckbs[cki].checked = false;
                    selfckbs[cki].disabled = true;
                }
            }
            event.currentTarget.checked = true;

            let selfchbox = event.currentTarget.parentNode.childNodes;
            for (var c = 0; c < selfchbox.length; c++) {
                selfchbox[c].disabled = false;
            }

            for (var b = 0; b < selfradio.length; b++) {
                selfradio[b].childNodes[0].disabled = false;
            }
            event.currentTarget.disabled = false;
        }
        //清空 checkbox勾選 Table跟row
        function CleanOptionforTable(event) {//不刪radio的checked
            let gfather = event.currentTarget.parentNode;
            let selfradio = gfather.childNodes;//radio box
            for (var i = 0; i < selfradio.length; i++) {
                let selfckbs = selfradio[i].childNodes;
                for (var cki = 0; cki < selfckbs.length; cki++) {
                    selfckbs[cki].checked = false;
                    selfckbs[cki].disabled = true;
                }
            }
            event.currentTarget.checked = true;

            let selfchbox = event.currentTarget.parentNode.childNodes;
            for (var c = 0; c < selfchbox.length; c++) {
                selfchbox[c].disabled = false;
            }

            for (var b = 0; b < selfradio.length; b++) {
                selfradio[b].disabled = false;
            }
            event.currentTarget.disabled = false;
        }
        //清空 填充跟切換Disabled
        function CleanOthers(event) {
            let gfather = event.currentTarget.parentNode.parentNode;
            let Allinputs = gfather.childNodes;
            for (var i = 0; i < Allinputs.length; i++) {
                let fillings = Allinputs[i].childNodes;
                for (var f = 0; f < fillings.length; f++) {
                    if (fillings[f].type == "text") {
                        fillings[f].value = "";
                    }
                    fillings[f].disabled = true;
                    fillings[0].disabled = false;
                }
            }
            let myFilling = event.currentTarget.parentNode.childNodes;
            for (var m = 0; m < myFilling.length; m++) {
                myFilling[m].disabled = false;
            }
            event.currentTarget.disabled = false;
        }
        //產生Table問題有固定的欄位 跟變動欄位
        //會變動的部分 
        //QuestionType 問題類型 方法會依問題類型產出對應的樣式 GroupsSn第幾個群組 RowsSn第幾列問體組 Obj來源的Json
        function ColsMapQuestionTypeTemplate(QuestionType, GroupsSn, RowsSn, Obj) {//直的放在 卡片標頭
            switch (QuestionType) {
                case "text":
                    break;
                case "number":
                    break;
                case "radio":
                    let headerRadioContainer = CreateTableTypeCardHeaderPartRadio(Obj, GroupsSn, RowsSn);
                    return headerRadioContainer;
                    break;
                case "RadioMixCheckbox":
                    break;
                case "checkbox":
                    let headercheckboxContainer = CreateTableTypeCardHeaderPartCheckbox(Obj, GroupsSn, RowsSn);
                    return headercheckboxContainer;
                    break;
                case "select":
                    break;
                case "image":
                    break;
                case "display":
                    let txt = CreateTableTypeCardHeaderPartDisplay(Obj, GroupsSn, RowsSn);
                    return txt;
                case "filling":
                    let fillingbox = CreateTableTypeCardHeaderPartFilling(Obj, GroupsSn, RowsSn);
                    return fillingbox;
                    break;
                default:
            }
        }
        //固定的部分 卡片中會重複出現的問題
        function RowsMapQuestionTypeTemplate(QuestionType, GroupsSn, RowsSn, ColsSn, Obj) {//行的 放在card-body
            switch (QuestionType) {
                case "text":
                    let container = CreateTableTypeCardBodyPartText(Obj, GroupsSn, RowsSn, ColsSn);
                    return container;
                    break;
                case "number":
                    break;
                case "radio":
                    let radioContainer = CreateTableTypeCardBodyPartRadio(Obj, GroupsSn, RowsSn, ColsSn);
                    return radioContainer;
                    break;
                case "RadioMixCheckbox":
                    let RadioMixCheckboxcontainer = CreateTableTypeCardBodyPartRadioMixCheckbox(Obj, GroupsSn, RowsSn, ColsSn);
                    return RadioMixCheckboxcontainer;
                    break;
                case "checkbox":
                    let checkboxContainer = CreateTableTypeCardBodyPartCheckbox(Obj, GroupsSn, RowsSn, ColsSn);
                    return checkboxContainer;
                    break;
                case "CheckboxMixFilling":
                    let CheckboxMixFillingContainer = CreateTableTypeCardBodyPartCheckboxMixFilling(Obj, GroupsSn, RowsSn, ColsSn);
                    return CheckboxMixFillingContainer;
                    break;
                case "select":
                    break;
                case "image":
                    let imgBox = CreateTableTypeCardBodyPartImage(Obj, GroupsSn, RowsSn, ColsSn);
                    return imgBox;
                    break;
                case "date":
                    let Datecontainer = CreateTableTypeCardBodyPartDate(Obj, GroupsSn, RowsSn, ColsSn);
                    return Datecontainer;
                    break;
                case "display":
                    let rowtxtBox = CreateTableTypeCardBodyPartDisplay(Obj, GroupsSn, RowsSn, ColsSn);
                    return rowtxtBox;
                    break;
                case "sign":
                    let Signcontainer = CreateTableTypeCardBodyPartSign(Obj, GroupsSn, RowsSn, ColsSn);
                    return Signcontainer;
                    break;
                case "filling":
                    let fillingBox = CreateTableTypeCardBodyPartFilling(Obj, GroupsSn, RowsSn, ColsSn);
                    return fillingBox;
                    break;
                case "RadioMixFilling":
                    let RadioMixFillingBox = CreateTableTypeCardBodyPartRadioMixFilling(Obj, GroupsSn, RowsSn, ColsSn);
                    return RadioMixFillingBox;
                    break;
                default:
            }
        }
        //產群組類型是Normal的Text(問答)
        //DataObj是要產出會面的資料來源(資料庫中的OutputJson轉Object)
        //GroupSn 迴圈到第幾個的群組
        //QusetionSn迴圈到第幾個的問題
        //Parent 要將Text append到哪個載體下面
        function CreateNormalTypeText(DataObj, GroupSn, QusetionSn, Parent) {
            let inputBox = document.createElement("div");
            inputBox.classList.add("col-6", "pt-2");
            Parent.append(inputBox);
            let colbox = document.createElement('div');
            colbox.classList.add("col-3");
            Parent.append(colbox);
            let TextInput = document.createElement("input");
            TextInput.setAttribute("type", "text");
            TextInput.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText);
            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length > 0) {
                TextInput.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[0].value);
            }
            TextInput.setAttribute("onchange", "changeJsonData(event)");
            TextInput.classList.add("form-control", "form-control-user", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
            inputBox.append(TextInput);
        }
        function CreateNormalTypeNumber(DataObj, GroupSn, QusetionSn, Parent) {
            let inputNumsBox = document.createElement("div");
            inputNumsBox.classList.add("col-6", "pt-2");
            Parent.append(inputNumsBox);
            let colNumsbox = document.createElement('div');
            colNumsbox.classList.add("col-3");
            Parent.append(colNumsbox);
            let NumsInput = document.createElement("input");
            NumsInput.setAttribute("type", "number");
            NumsInput.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText);
            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length > 0) {
                NumsInput.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[0].value);
            }
            NumsInput.setAttribute("onchange", "changeJsonData(event)");
            NumsInput.classList.add("form-control", "form-control-user", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
            inputNumsBox.append(NumsInput);
        };
        function CreateNormalTypeRadio(DataObj, GroupSn, QusetionSn, Parent) {
            for (var ar = 0; ar < DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length; ar++) {
                //空白表單 要先把所有選項給Answers
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length > DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length) {
                    let today = new Date().getTime();
                    DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.push({ "index": DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[ar].index, "value": false, "lastUpdate": today });
                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                }

                let inputRadioBox = document.createElement("div");
                inputRadioBox.classList.add("col-1", "pt-2");
                Parent.append(inputRadioBox);
                let RadioLabel = document.createElement("label");
                RadioLabel.classList.add("form-check-label", "pl-1");
                RadioLabel.innerText = DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[ar].AnsText;
                let RadioInput = document.createElement("input");
                RadioInput.classList.add("myRadio", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                RadioInput.setAttribute("type", "radio");
                RadioInput.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText)
                RadioInput.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[ar].AnsText);
                RadioInput.setAttribute("onchange", "changeJsonData(event)");
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length > 0) {
                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[ar].value == true) {
                        RadioInput.setAttribute("checked", "true");
                    }
                }
                inputRadioBox.append(RadioInput);
                inputRadioBox.append(RadioLabel);
            }
            let newline = document.createElement('div');
            newline.classList.add("col-12")
            Parent.append(newline);
        }
        function CreateNormalTypeCheckbox(DataObj, GroupSn, QusetionSn, Parent) {
            for (var ac = 0; ac < DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length; ac++) {
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length > DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length) {
                    let today = new Date().getTime();
                    DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.push({ "index": DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[ac].index, "value": false, "lastUpdate": today });
                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                }

                let inputCheckbox = document.createElement('div');
                inputCheckbox.classList.add("col-2", "pt-2", "position-relative");
                Parent.append(inputCheckbox);
                let CheckLabel = document.createElement("label");
                CheckLabel.classList.add("form-check-label", "pl-1");
                CheckLabel.innerText = DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[ac].AnsText;

                let CheckboxInput = document.createElement("input");
                CheckboxInput.setAttribute("type", "checkbox");
                CheckboxInput.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[ac].AnsText);
                CheckboxInput.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText);
                CheckboxInput.setAttribute("onchange", "changeJsonData(event)");
                CheckboxInput.classList.add("mycheckbox", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID)
                for (var asnc = 0; asnc < DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length; asnc++) {
                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[asnc].value == true) {
                        CheckboxInput.setAttribute("checked", "true");
                    }
                }
                inputCheckbox.append(CheckboxInput);
                inputCheckbox.append(CheckLabel);
            }
            let newLine = document.createElement('div');
            newLine.classList.add("col-12");
            Parent.append(newLine);
        }
        function CreateNormalTypeSelect(DataObj, GroupSn, QusetionSn, Parent) {
            let Selectbox = document.createElement('div');
            Selectbox.classList.add("col-6", "pt-2");
            Parent.append(Selectbox);
            let Select = document.createElement("select");
            Select.setAttribute("onchange", "changeJsonData(event)");
            Select.classList.add("form-control", "form-control-user", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
            Selectbox.append(Select);
            let firstOption = document.createElement("option");
            firstOption.text = "請選擇";
            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length > 0) {
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[0].value == null) {
                    firstOption.setAttribute("selected", "true");
                }
            }
            Select.appendChild(firstOption);
            Select.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText);
            for (var as = 0; as < DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length; as++) {
                let option = document.createElement("option");
                option.text = DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[as].AnsText;
                option.value = DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[as].AnsText;
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length > 0) {
                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[0].value == DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[as].AnsText) {
                        option.setAttribute("selected", "true");
                    }
                }
                Select.appendChild(option);
            }

            let NewLine = document.createElement('div');
            NewLine.classList.add("col-12");
            Parent.append(NewLine);
        }
        function CreateNormalTypeImage(DataObj, GroupSn, QusetionSn, Parent) {
            let ImageBox = document.createElement("div");
            ImageBox.classList.add("col-8", "pt-2");
            Parent.append(ImageBox);
            let ImageInput = document.createElement("input");
            ImageInput.setAttribute("type", "file");
            ImageInput.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText);
            ImageInput.setAttribute("id", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
            ImageInput.setAttribute("onchange", "changeJsonData(event)");
            ImageInput.classList.add("Upload");
            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[0] != null) {
                let filename = document.createElement("span");
                filename.innerText = DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[0].value;
                filename.classList.add("mr-1");
                let download = document.createElement("a");
                download.href = "Upload/" + DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[0].value;
                download.classList.add("btn", "btn-default", "btn-sm", "mr-3");
                let icon = document.createElement("i");
                icon.classList.add("fas", "fa-cloud-download-alt");
                ImageBox.append(filename);
                download.append(icon);
                ImageBox.append(download);
            }
            ImageBox.append(ImageInput);
            let Newline = document.createElement('div');
            Newline.classList.add("col-12");
            Parent.append(Newline);
        }
        function CreateNormalTypeDate(DataObj, GroupSn, QusetionSn, Parent) {
            let DateBox = document.createElement("div");
            DateBox.classList.add("col-6", "pt-2");
            Parent.append(DateBox);
            let DateInput = document.createElement("input");
            DateInput.setAttribute("type", "date");
            DateInput.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText);
            DateInput.setAttribute("onchange", "changeJsonData(event)");
            DateInput.classList.add("form-control", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[0] != null) {//顯示答案
                let date = DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[0].value;
                DateInput.setAttribute("value", date);
                DateInput.innerText = date;
            }
            DateBox.append(DateInput);
            let NEWline = document.createElement('div');
            NEWline.classList.add("col-12");
            Parent.append(NEWline);
        }
        function CreateNormalTypeSign(DataObj, GroupSn, QusetionSn, Parent) {
            let SignBox = document.createElement("div");
            SignBox.classList.add("col-6", "pt-2", "SignBox");
            Parent.append(SignBox);
            let SignBtn = document.createElement("div");
            SignBtn.classList.add("btn", "btn-primary", "Signbtn")
            SignBtn.setAttribute("onclick", "SignByAdminId(event)");
            SignBtn.setAttribute("onchange", "changeJsonData(event)");
            SignBtn.innerText = "簽核";
            SignBox.append(SignBtn);
            let SignImageBox = document.createElement("div");
            SignImageBox.classList.add("ml-5", "SignImageBox", "d-none");
            SignBox.append(SignImageBox);
            let signImgID = document.getElementById("mainPlaceHolder_adminSign").value;
            let signImage = document.createElement("img");

            let signdate = document.createElement('span');
            signdate.classList.add("d-flex", "justify-content-center", "signDate");
            signImage.setAttribute("id", "sign" + signImgID);
            signImage.classList.add(DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length > 0) {
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[0].value != null) {
                    signImage.src = "ShowAdminImg.aspx?id=" + DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[0].value;
                    let last = new Date(DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[0].lastUpdate);

                    signdate.innerText = last.Format("yyyy-MM-dd");
                    SignImageBox.classList.remove("d-none");
                    SignImageBox.classList.add("d-inline");
                } else {
                    signImage.src = "ShowAdminImg.aspx?id=" + signImgID;
                    let today = new Date();
                    signdate.innerText = today.getFullYear();
                    signdate.innerText += "/";
                    signdate.innerText += today.getMonth() + 1;
                    signdate.innerText += "/";
                    signdate.innerText += today.getDate();
                    SignImageBox.classList.add("d-none", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                }
            }
            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length > 0) {
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[0].value != signImgID) {//如果已經有人簽 不是登入者簽的不能覆蓋
                    SignBtn.classList.add("d-none");
                } else {
                    SignBtn.innerText = "取消簽核";
                }

            }
            signImage.style.width = "30%";

            SignImageBox.append(signImage);
            SignImageBox.append(signdate);

        }
        function CreateNormalTypeFilling(DataObj, GroupSn, QusetionSn, Parent) {
            let today = new Date().getTime();
            let FillingBox = document.createElement("div");
            FillingBox.classList.add("col-12", "pt-2", "FillingBox", "d-flex", "ml-4");
            Parent.append(FillingBox);
            let Qtext = DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText;//把填充題目取出
            let strOfFilling = Qtext.split("##");
            let AnsSn = 0;
            let index = AnsSn + 1;
            for (var sf = 0; sf < strOfFilling.length; sf++) {
                if (strOfFilling[sf].includes("^")) {//有^就是要填的位置
                    DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.push({ "index": index, "value": "", "lastUpdate": today });
                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));


                    let fillinfPlace = document.createElement("input");//有要填的地方放Input
                    fillinfPlace.setAttribute("type", "text");
                    fillinfPlace.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText + "_" + index);
                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length > 0) {
                        fillinfPlace.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[AnsSn].value);
                    }
                    fillinfPlace.setAttribute("onchange", "changeJsonData(event)");//todo 檢查 有順序問題
                    fillinfPlace.classList.add("form-control", "form-control-user", "col-1", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                    FillingBox.append(fillinfPlace);
                    let words = strOfFilling[sf].substring(2);
                    if (words != null) {
                        let wds = document.createElement('div');
                        wds.classList.add("ml-1", "mr-1", "pt-1", "myTextColor");
                        wds.innerText = words;
                        FillingBox.append(wds);
                    }
                    AnsSn++;
                    index++;
                } else {
                    let Words = document.createElement('div');
                    Words.classList.add("ml-1", "mr-1", "pt-1", "myTextColor");
                    Words.innerText = strOfFilling[sf];
                    FillingBox.append(Words);
                }

            }

        }
        function CreateNormalTypeCheckboxMixFilling(DataObj, GroupSn, QusetionSn, Parent) {
            let today = new Date().getTime();
            let newLINEfs = document.createElement('div');
            newLINEfs.classList.add("col-12");
            Parent.append(newLINEfs);
            let fillingAns = 0;//ANS的項次
            let optionAns = 0;
            let index = 1;
            let father = document.createElement("div");//父層
            father.classList.add("row");
            Parent.append(father);
            for (var acf = 0; acf < DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length; acf++) {//checkbox部分
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length > DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length) {
                    DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.push({ "index": DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[acf].index, "value": false, "lastUpdate": today, "Answers": [] });
                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                }
                let checkboxFillngBox = document.createElement("div");
                checkboxFillngBox.classList.add("col-4", "pt-2", "d-flex", "ml-5", "checkboxFillngBox", "justify-content-start", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                father.append(checkboxFillngBox);
                let ckboxInput = document.createElement("input");
                ckboxInput.setAttribute("type", "checkbox");
                ckboxInput.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText);
                ckboxInput.setAttribute("onchange", "changeJsonData(event)");
                ckboxInput.setAttribute("onclick", "DisabledTrue(event)");
                ckboxInput.classList.add("CheckboxMixFilling", "mycheckbox", "mt-2", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                checkboxFillngBox.append(ckboxInput);
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[acf].value == true) {
                    ckboxInput.checked = true;
                }
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[acf].AnsText.includes("##^")) {//有填空 填空部分
                    let AnsText = DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[acf].AnsText;//答案選項
                    let AnsAStr = AnsText.split("##");//切等分要放input text
                    for (var ocf = 0; ocf < AnsAStr.length; ocf++) {//把切好的陣列
                        if (AnsAStr[ocf].includes("^")) {//要填空的位置
                            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[acf].Answers.length == 0) {
                                DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[acf].Answers.push({ "index": index, "value": "", "lastUpdate": today });
                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                            }

                            let place = document.createElement("input");
                            place.setAttribute("type", "text");
                            place.setAttribute("onchange", "changeJsonData(event)");
                            place.disabled = true;
                            place.classList.add("form-control", "form-control-user", "mr-2", "ml-1", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                            place.style.width = "25%";
                            checkboxFillngBox.append(place);
                            let Txts = AnsAStr[ocf].substring("2");//填空後面的字
                            //place.classList.add(Txts);
                            place.setAttribute("name", AnsText + "_" + index);
                            for (var x = 0; x < DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[acf].Answers.length; x++) {
                                place.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[acf].Answers[x].value);
                            }


                            if (Txts != null) {
                                let txts = document.createElement('div');
                                txts.classList.add("pt-2");//, Txts
                                txts.innerText = Txts;
                                ckboxInput.setAttribute("value", AnsText);//20220822 改
                                checkboxFillngBox.append(txts);//沒有填空的文字
                            }
                        }

                    }
                } else {
                    let TXTS = document.createElement("div");//一開始的文字
                    TXTS.innerText = AnsAStr[ocf];
                    checkboxFillngBox.append(TXTS);
                }
                fillingAns++;
                optionAns = 0;
            }
            let newLINEf = document.createElement('div');
            newLINEf.classList.add("col-12");
            Parent.append(newLINEf);

        }
        function CreateNormalTypeRadioMixCheckbox(DataObj, GroupSn, QusetionSn, Parent) {
            let today = new Date().getTime();
            let RadioMixCheckboxBox = document.createElement("div");
            RadioMixCheckboxBox.classList.add("row");
            Parent.append(RadioMixCheckboxBox);
            for (var arc = 0; arc < DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length; arc++) {//radio
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length > DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length) {
                    DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.push({ "index": DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].index, "value": false, "lastUpdate": today, "Answers": [] });
                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                }
                let RCinputBox = document.createElement("div");
                RCinputBox.classList.add("col-12", "pt-2", "position-relative", "ml-5");
                Parent.append(RCinputBox);
                let radioLabel = document.createElement("label");
                radioLabel.classList.add("form-check-label", "myLabelrc");
                radioLabel.innerText = DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnsText;

                let rcRadio = document.createElement("input");
                rcRadio.setAttribute("type", "radio");
                rcRadio.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnsText);
                rcRadio.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText);
                rcRadio.setAttribute("onchange", "changeJsonData(event)");//todo 檢查 父子值問題
                rcRadio.setAttribute("onclick", "CleanOption(event)");
                //跟答案比對 有的被選起來
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].value == true) {
                    console.log("北病" + DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].value);
                    rcRadio.setAttribute("checked", "true");
                }

                rcRadio.classList.add("pl-1", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                RCinputBox.append(rcRadio);
                RadioMixCheckboxBox.append(RCinputBox);
                RCinputBox.append(radioLabel);
                for (var arco = 0; arco < DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnswerOptions.length; arco++) {
                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnswerOptions.length > DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].Answers.length) {
                        DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].Answers.push({ "index": DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnswerOptions[arco].index, "value": false, "lastUpdate": today });
                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                    }
                    let ckBoxOption = document.createElement('input');
                    ckBoxOption.setAttribute("type", "checkbox");
                    ckBoxOption.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnsText);
                    ckBoxOption.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnswerOptions[arco].AnsText);
                    ckBoxOption.setAttribute("onchange", "changeJsonData(event)");
                    ckBoxOption.classList.add("myCheckboxRc", "ml-5", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                    ckBoxOption.disabled = true;
                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].Answers[arco].value == true) {
                        console.log("打勾勾");
                        ckBoxOption.setAttribute("checked", "true");
                        ckBoxOption.disabled = false;
                    }
                    RCinputBox.append(ckBoxOption);
                    let ckOptionSpan = document.createElement("span");
                    ckOptionSpan.innerText = DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnswerOptions[arco].AnsText;
                    ckOptionSpan.classList.add("pt-1", "ml-1")
                    RCinputBox.append(ckOptionSpan);
                }
            }
        }
        function CreateNormalTypeRadioMixFilling(DataObj, GroupSn, QusetionSn, Parent) {
            let today = new Date().getTime();
            let rfRadfillBoxFather = document.createElement("div");
            rfRadfillBoxFather.classList.add("row");
            Parent.append(rfRadfillBoxFather)
            for (var arf = 0; arf < DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length; arf++) {//radio
                let rfRadfillBox = document.createElement("div");
                rfRadfillBox.classList.add("rfRadfillBox", "col-12", "ml-5", "position-relative");
                rfRadfillBoxFather.append(rfRadfillBox);
                let rfRadio = document.createElement("input");
                rfRadio.setAttribute("type", "radio");
                rfRadio.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText);
                rfRadio.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arf].AnsText);
                rfRadio.setAttribute("onchange", "changeJsonData(event)");
                rfRadio.setAttribute("onclick", "CleanOthers(event)");
                rfRadio.classList.add("myRadio", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length > DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length) {
                    DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.push({ "index": DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arf].index, "value": false, "lastUpdate": today, "Answers": [] });
                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                }

                if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length > 0) {

                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arf].value == true) {
                        rfRadio.checked = true;
                    }
                }
                rfRadfillBox.append(rfRadio);
                let rfLabel = document.createElement("label");
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arf].AnsText.includes("##^")) {
                    let rfAnstext = DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arf].AnsText.split("##");
                    let fillingAns = 0;
                    let fillingAnsSn = fillingAns + 1;
                    for (var rfo = 0; rfo < rfAnstext.length; rfo++) {
                        if (rfAnstext[rfo].includes("^")) {
                            let placeRf = document.createElement("input");
                            placeRf.setAttribute("type", "text");//ttxx
                            placeRf.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arf].AnsText + "_" + fillingAnsSn);
                            placeRf.setAttribute("onchange", "changeJsonData(event)");
                            placeRf.classList.add("form-control", "form-control-user", "mb-3", "d-inline", "mr-2", "ml-1", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                            placeRf.disabled = true;
                            //placeRf.classList.add(rfAnstext[rfo].substring("2"))
                            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arf].Answers.length < rfAnstext.length) {
                                DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arf].Answers.push({ "index": fillingAnsSn, "value": "", "lastUpdate": today });
                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                            }
                            placeRf.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arf].Answers[fillingAns].value);

                            placeRf.style.width = "10%";
                            rfRadfillBox.append(placeRf);
                            if (rfAnstext[rfo].substring("2") != null) {
                                let AnsTXT = document.createElement("span");
                                AnsTXT.innerText = rfAnstext[rfo].substring("2");
                                rfRadfillBox.append(AnsTXT)
                            }
                            fillingAns++;
                            fillingAnsSn++;
                        } else {
                            let AnsTXT = document.createElement("span");
                            AnsTXT.innerText = rfAnstext[rfo];
                            rfRadfillBox.append(AnsTXT)
                        }
                    }
                } else {
                    rfLabel.innerText = DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arf].AnsText;
                    rfRadfillBox.append(rfLabel)
                }
            }

        }
        function CreateNormalTypeCheckboxMixImage(DataObj, GroupSn, QusetionSn, Parent) {
            let today = new Date().getTime();
            let newlineCbI = document.createElement("div");
            newlineCbI.classList.add("col-12");
            Parent.append(newlineCbI);
            for (var cbi = 0; cbi < DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length; cbi++) {
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length > DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length) {
                    DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.push({ "index": DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[cbi].index, "value": false, "lastUpdate": today });
                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                }
                let CBimagebox = document.createElement("div");
                CBimagebox.classList.add("col-12", "position-relative", "ml-4");
                Parent.append(CBimagebox);
                let checkbox = document.createElement("input");
                checkbox.setAttribute("type", "checkbox");
                checkbox.setAttribute("onchange", "changeJsonData(event)");//todo 檢查 抓子節點圖片ID
                checkbox.classList.add("mycheckbox", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                checkbox.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[cbi].AnsText);
                checkbox.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText);
                //顯示答案
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[cbi].value == true) {
                    checkbox.setAttribute("checked", "true");
                }

                CBimagebox.append(checkbox);
                let ckblabel = document.createElement("label");
                ckblabel.classList.add("form-check-label", "mb-1", "pl-1", "mt-2");
                ckblabel.innerText = DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[cbi].AnsText;
                CBimagebox.append(ckblabel);
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[cbi].image != 0) {
                    let img = document.createElement("img");
                    img.src = "ShowAdminImg.aspx?id=" + DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[cbi].image;
                    img.classList.add("col-10", "ml-5");
                    Parent.append(img)
                }
            }
        }

        //Table ColsMapQuestionTypeTemplate中會呼叫這個方法產出問題樣式
        //Table 有分放在標頭(Card-header-固定欄位)跟放在下面的部分(Card-body會重複的部分)
        function CreateTableTypeCardHeaderPartRadio(DataObj, GroupsSn, RowsSn) {
            let headerRadioContainer = document.createElement("div");
            headerRadioContainer.classList.add("headerRadioContainer", "d-inline", "ml-1");
            for (var hRAnsOp = 0; hRAnsOp < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[0].AnswerOptions.length; hRAnsOp++) {
                let headerRadio = document.createElement("input");
                headerRadio.setAttribute("type", "radio");
                headerRadio.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[0].AnswerOptions[hRAnsOp].AnsText);
                headerRadio.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[0].QuestionID);
                for (let v = 0; v < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[0].Answers.length; v++) {
                    if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[0].AnswerOptions[hRAnsOp].AnsText == DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[0].Answers[v].value) {
                        headerRadio.checked = true;
                    }
                }
                headerRadio.setAttribute("onchange", "changeTableJsonData(event)");
                headerRadio.classList.add("myRadio", "ml-2");
                headerRadio.style.left = 0;
                headerRadioContainer.append(headerRadio);

                let headerLabelRadio = document.createElement("label");
                headerLabelRadio.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[0].AnswerOptions[hRAnsOp].AnsText;
                headerRadioContainer.append(headerLabelRadio);
            }
            return headerRadioContainer;

        }
        function CreateTableTypeCardHeaderPartCheckbox(DataObj, GroupsSn, RowsSn) {
            let headercheckboxContainer = document.createElement("div");
            headercheckboxContainer.classList.add("headercheckboxContainer", "d-inline", "ml-1");
            for (var hrc = 0; hrc < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[0].AnswerOptions.length; hrc++) {
                let hckbox = document.createElement("input");
                hckbox.setAttribute("type", "checkbox");
                hckbox.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[0].AnswerOptions[hrc].AnsText);
                hckbox.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[0].QuestionID);
                for (let w = 0; w < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[0].Answers.length; w++) {
                    if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[0].Answers[w].value == DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[0].AnswerOptions[hrc].AnsText) {
                        hckbox.checked = true;
                    }
                }
                hckbox.setAttribute("onchange", "changeTableJsonData(event)");
                hckbox.classList.add("d-inline", "myCheckboxRc", "ml-3", "mr-2");
                hckbox.style.top = 0;
                headercheckboxContainer.append(hckbox);
                let hcklabel = document.createElement("label");
                hcklabel.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[0].AnswerOptions[hrc].AnsText;
                hcklabel.classList.add("d-inline");
                headercheckboxContainer.append(hcklabel);

            }
            return headercheckboxContainer;
        }
        function CreateTableTypeCardHeaderPartDisplay(DataObj, GroupsSn, RowsSn) {
            let txt = document.createElement("span");
            txt.classList.add("pl-2");
            txt.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[0].AnswerOptions[0].AnsText;
            return txt;
        }
        function CreateTableTypeCardHeaderPartFilling(DataObj, GroupsSn, RowsSn) {
            let fillingbox = document.createElement("div");
            fillingbox.classList.add("fillingbox", "d-flex", "justify-content-space");
            let fillingtxts = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[0].AnswerOptions[0].AnsText;
            let fillingStr = fillingtxts.split("##");
            let AnsSn = 0;
            let index = AnsSn + 1;
            for (var fs = 0; fs < fillingStr.length; fs++) {
                if (fillingStr[fs].includes("^")) {
                    let fillinfPlace = document.createElement("input");//有要填的地方放Input
                    fillinfPlace.setAttribute("type", "text");
                    fillinfPlace.setAttribute("onchange", "changeTableJsonData(event)");
                    fillinfPlace.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[0].AnswerOptions[0].AnsText + "_" + index);
                    fillinfPlace.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[0].Answers[0].value);
                    if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[0].Answers[0].value == null) {
                        fillinfPlace.setAttribute("value", "");
                    }
                    fillinfPlace.classList.add("form-control", "form-control-user");
                    AnsSn++;
                    index++;
                    fillingbox.append(fillinfPlace);
                    let words = fillingStr[fs].substring(2);
                    if (words != null) {
                        let wds = document.createElement('div');
                        wds.classList.add("ml-1", "mr-1", "pt-2");
                        wds.innerText = words;
                        fillingbox.append(wds);
                    }
                } else {
                    let Words = document.createElement('div');
                    Words.classList.add("ml-1", "mr-1", "pt-2");
                    Words.innerText = fillingStr[fs];
                    fillingbox.append(Words);
                }
            }
            return fillingbox;

        }
        //Table 放在會重複的部分(Card-body)
        function CreateTableTypeCardBodyPartText(DataObj, GroupsSn, RowsSn, ColsSn) {
            let container = document.createElement("div");
            container.classList.add("col-6");
            let label = document.createElement("label");
            label.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            container.append(label);
            let inputTxt = document.createElement("input");
            inputTxt.setAttribute("type", "text");
            inputTxt.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
            inputTxt.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value);
            if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value == null) {
                inputTxt.setAttribute("value", "");
            }
            inputTxt.setAttribute("onchange", "changeTableJsonData(event)");
            inputTxt.classList.add("form-control", "form-control-user")
            container.append(inputTxt);
            return container;
        }
        function CreateTableTypeCardBodyPartRadio(DataObj, GroupsSn, RowsSn, ColsSn) {
            let radioContainer = document.createElement("div");
            radioContainer.classList.add("col-12");
            let radioh5 = document.createElement("h5");
            radioh5.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            radioh5.classList.add("myTextColor");
            let inputBox = document.createElement("div");
            inputBox.classList.add("inputBox", "d-flex");
            for (var rAnsOp = 0; rAnsOp < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions.length; rAnsOp++) {
                let RadioInput = document.createElement("input");
                RadioInput.setAttribute("type", "radio");
                RadioInput.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rAnsOp].AnsText);
                if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value == DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rAnsOp].AnsText) {
                    RadioInput.checked = true;
                }
                RadioInput.setAttribute("onchange", "changeTableJsonData(event)");
                RadioInput.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                RadioInput.classList.add("myRadio");
                RadioInput.style.left = 0;

                inputBox.append(RadioInput);
                let labelRadio = document.createElement("label");
                labelRadio.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rAnsOp].AnsText;
                labelRadio.classList.add("pt-1", "pr-2");
                inputBox.append(labelRadio);
            }
            radioContainer.append(radioh5);
            radioContainer.append(inputBox);
            return radioContainer;
        }
        function CreateTableTypeCardBodyPartRadioMixCheckbox(DataObj, GroupsSn, RowsSn, ColsSn) {
            let RadioMixCheckboxcontainer = document.createElement("div");
            RadioMixCheckboxcontainer.classList.add("RadioMixCheckboxcontainer", "col-12");
            let RadioMixCheckboxH5 = document.createElement("h5");
            RadioMixCheckboxH5.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            RadioMixCheckboxH5.classList.add("myTextColor");
            RadioMixCheckboxcontainer.append(RadioMixCheckboxH5);//QuestionText 
            let inputsContainer = document.createElement("div");
            inputsContainer.classList.add("inputsContainer");
            for (var rmci = 0; rmci < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions.length; rmci++) {//答案選項 radio
                let ckboxCheck = false;
                let inputGroup = document.createElement("div");
                inputGroup.classList.add("inputGroup", "col-12");
                let rmcRadio = document.createElement("input");
                rmcRadio.setAttribute("type", "radio");
                rmcRadio.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                rmcRadio.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmci].AnsText);
                if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmci].AnsText == DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value) {
                    rmcRadio.checked = true;
                    ckboxCheck = true;
                }
                rmcRadio.setAttribute("onchange", "changeTableJsonData(event)");
                rmcRadio.setAttribute("onclick", "CleanOptionforTable(event)");
                rmcRadio.classList.add("myRadio");
                rmcRadio.style.left = 0;
                inputGroup.append(rmcRadio);
                let labelrmc = document.createElement("label");
                labelrmc.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmci].AnsText;
                inputGroup.append(labelrmc);
                for (var ii = 0; ii < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmci].AnswerOptions.length; ii++) {
                    let ckbox = document.createElement("input");
                    ckbox.setAttribute("type", "checkbox");
                    ckbox.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmci].AnswerOptions[ii].AnsText);
                    if (ckboxCheck) {
                        for (let ans = 0; ans < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].Answers.length; ans++) {
                            if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmci].AnswerOptions[ii].AnsText == DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].Answers[ans].value) {
                                ckbox.checked = true;
                                ckbox.disabled = false;
                            }
                        }
                    } else {
                        ckbox.disabled = true;
                    }
                    ckbox.setAttribute("onchange", "changeTableJsonData(event)");
                    ckbox.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                    ckbox.classList.add("myCheckboxRc", "ml-2", "mr-1");

                    inputGroup.append(ckbox);
                    let labelck = document.createElement("label");
                    labelck.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmci].AnswerOptions[ii].AnsText;
                    inputGroup.append(labelck);
                }
                inputsContainer.append(inputGroup);
            }
            RadioMixCheckboxcontainer.append(inputsContainer);
            return RadioMixCheckboxcontainer;

        }
        function CreateTableTypeCardBodyPartCheckbox(DataObj, GroupsSn, RowsSn, ColsSn) {
            let checkboxContainer = document.createElement("div");
            checkboxContainer.classList.add("checkboxContainer", "col-12");
            let h5Checkbox = document.createElement("h5");
            h5Checkbox.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            h5Checkbox.classList.add("myTextColor");
            checkboxContainer.append(h5Checkbox);
            let checkboxsgroup = document.createElement("div");
            checkboxsgroup.classList.add("d-flex", "col-12");
            checkboxContainer.append(checkboxsgroup);
            for (var cc = 0; cc < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions.length; cc++) {
                let ckb = document.createElement("input");
                ckb.setAttribute("type", "checkbox");
                ckb.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                ckb.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[cc].AnsText);
                for (let i = 0; i < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers.length; i++) {
                    if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[cc].AnsText == DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[i].value) {
                        ckb.checked = true;
                    }
                }

                ckb.setAttribute("onchange", "changeTableJsonData(event)");
                ckb.classList.add("mycheckbox", "ml-1", "mr-2");
                checkboxsgroup.append(ckb);
                let ckbLabel = document.createElement("label");
                ckbLabel.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[cc].AnsText;
                checkboxsgroup.append(ckbLabel);
            }
            return checkboxContainer;

        }
        function CreateTableTypeCardBodyPartCheckboxMixFilling(DataObj, GroupsSn, RowsSn, ColsSn) {
            let CheckboxMixFillingContainer = document.createElement("div");
            CheckboxMixFillingContainer.classList.add("CheckboxMixFillingContainer", "col-12");
            let h5CheckboxMixFilling = document.createElement("h5");
            h5CheckboxMixFilling.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            h5CheckboxMixFilling.classList.add("myTextColor");
            CheckboxMixFillingContainer.append(h5CheckboxMixFilling);
            let ckbmfGroups = document.createElement("div");
            ckbmfGroups.classList.add("ckbmfGroup");
            let fillingDisable = true;
            let Ans1;//哪一個Checkbox有勾;
            for (var ccc = 0; ccc < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions.length; ccc++) {//checkbox的選項
                let ckbInput = document.createElement("input");
                ckbInput.setAttribute("type", "checkbox");
                ckbInput.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[ccc].AnsText);
                for (let u = 0; u < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers.length; u++) {
                    if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[u].value == DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[ccc].AnsText) {
                        ckbInput.checked = true;
                        fillingDisable = false;
                        Ans1 = u;
                        break;
                    } else {
                        fillingDisable = true;
                        Ans1 = null;
                    }
                }
                ckbInput.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                ckbInput.setAttribute("onchange", "changeTableJsonData(event)");
                ckbInput.setAttribute("onclick", "DisabledTrue(event)");
                ckbInput.classList.add("mycheckbox", "ml-1", "mr-2");
                let ckbmfInputGroup = document.createElement("div");
                ckbmfInputGroup.classList.add("col-12", "ckbmfInputGroup");
                ckbmfInputGroup.append(ckbInput);
                ckbmfGroups.append(ckbmfInputGroup);

                //filling 的部分
                let fills = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[ccc].AnsText;

                if (fills.includes("##^")) {
                    let fillsStrs = fills.split("##");
                    let index = 1;
                    let ansSn = 0;
                    for (var fi = 0; fi < fillsStrs.length; fi++) {
                        if (fillsStrs[fi].includes("^")) {
                            let finput = document.createElement("input");
                            finput.setAttribute("type", "text");
                            finput.disabled = fillingDisable;
                            finput.setAttribute("onchange", "changeTableJsonData(event)");
                            finput.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[ccc].AnsText + "_" + index);
                            if (Ans1 != null) {
                                finput.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[Ans1].Answers[ansSn].value);
                                if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[Ans1].Answers[ansSn].valu == null) {
                                    finput.setAttribute("value", "");
                                }
                            }
                            finput.style.width = "20%";
                            finput.classList.add("form-control", "form-control-user", "mb-3", "d-inline", "mr-2", "ml-1", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                            ckbmfInputGroup.append(finput);
                            if (fillsStrs[fi].substring("2") != null) {
                                let ckmfLabel = document.createElement("label");
                                ckmfLabel.innerText = fillsStrs[fi].substring("2");
                                ckbmfInputGroup.append(ckmfLabel);
                            }
                            index++;
                            ansSn++;
                        } else {
                            let ckmfLabel = document.createElement("label");
                            ckmfLabel.innerText = fillsStrs[fi];
                            ckbmfInputGroup.append(ckmfLabel);
                        }
                    }
                } else {
                    let ckmfLabel = document.createElement("label");
                    ckmfLabel.innerText = fillsStrs[fi];
                    ckbmfInputGroup.append(ckmfLabel);
                }
            }
            CheckboxMixFillingContainer.append(ckbmfGroups);
            return CheckboxMixFillingContainer;
        }
        function CreateTableTypeCardBodyPartImage(DataObj, GroupsSn, RowsSn, ColsSn) {
            let imgBox = document.createElement("div");
            imgBox.classList.add("col-12");
            let h5img = document.createElement("h5");
            h5img.classList.add("myTextColor");
            h5img.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            imgBox.append(h5img);
            let imgQ = document.createElement("img");
            imgQ.src = "ShowAdminImg?id=" + DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[0].image;
            imgBox.append(imgQ);
            return imgBox;
        }
        function CreateTableTypeCardBodyPartDate(DataObj, GroupsSn, RowsSn, ColsSn) {
            let Datecontainer = document.createElement("div");
            Datecontainer.classList.add("col-6");
            let Datelabel = document.createElement("label");
            Datelabel.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText

            Datecontainer.append(Datelabel);
            let inputDate = document.createElement("input");
            inputDate.setAttribute("type", "date");
            inputDate.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value);
            inputDate.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
            console.log("Datelabel_" + DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText + "QuestionID_" + DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[0].QuestionID);
            inputDate.setAttribute("onchange", "changeTableJsonData(event)");
            inputDate.classList.add("form-control", "form-control-user");
            Datecontainer.append(inputDate);
            return Datecontainer;
        }
        function CreateTableTypeCardBodyPartDisplay(DataObj, GroupsSn, RowsSn, ColsSn) {
            let rowtxtBox = document.createElement("div");
            rowtxtBox.classList.add("col-12", "rowtxtBox");
            let rowQ = document.createElement("h5");
            rowQ.classList.add("myTextColor");
            rowQ.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            rowtxtBox.append(rowQ);
            let rowtxt = document.createElement("p");
            rowtxt.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[0].AnsText;
            rowtxtBox.append(rowtxt);
            return rowtxtBox;
        }
        function CreateTableTypeCardBodyPartSign(DataObj, GroupsSn, RowsSn, ColsSn) {
            let Signcontainer = document.createElement("div");
            Signcontainer.classList.add("col-6");
            let SignCard = document.createElement("div");
            SignCard.classList.add("card", "mb-4");
            Signcontainer.append(SignCard);
            let Signlabel = document.createElement("label");
            Signlabel.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            let SignCardheader = document.createElement("div");
            SignCardheader.classList.add("card-header");
            SignCardheader.append(Signlabel);
            SignCard.append(SignCardheader);
            let SignCardbody = document.createElement("div");
            SignCardbody.classList.add("card-body", "d-flex", "justify-content-center");
            SignCard.append(SignCardbody);
            let Signspan = document.createElement("span");
            Signspan.classList.add("pt-2");
            Signspan.innerText = "人員簽章:";

            SignCardbody.append(Signspan);
            let btnSign = document.createElement("buttom");
            btnSign.classList.add("btn", "btn-primary", "ml-1");

            btnSign.innerText = "簽章";
            let SignImageContainer = document.createElement("div");
            SignImageContainer.style.width = "80%";
            SignImageContainer.classList.add("d-none", "SignImageContainer");
            let SignImage = document.createElement("img");
            SignImage.style.width = "60%";
            SignImage.classList.add(DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
            let dateSpan = document.createElement("span");
            dateSpan.classList.add("d-flex", "justify-content-end");
            if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value != null) {
                //簽名檔 有人簽了直接秀
                SignImage.src = "ShowAdminImg?id=" + DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value;
                dateSpan.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].lastUpdate;

                SignImageContainer.classList.remove("d-none");
            } else {
                btnSign.setAttribute("onclick", "SignByAdminId(event)");
                btnSign.setAttribute("onchange", "changeTableJsonData(event)")
                let today = new Date();
                dateSpan.innerText = today.getFullYear();
                dateSpan.innerText += "/";
                dateSpan.innerText += today.getMonth() + 1;
                dateSpan.innerText += "/";
                dateSpan.innerText += today.getDate();
                SignCardbody.append(btnSign);
            }
            SignImageContainer.append(SignImage);
            SignImageContainer.append(dateSpan);
            SignCardbody.append(SignImageContainer);
            return Signcontainer;
        }
        function CreateTableTypeCardBodyPartFilling(DataObj, GroupsSn, RowsSn, ColsSn) {
            let fillingBox = document.createElement("div");
            fillingBox.classList.add("col-12", "mb-3");
            let fillingH5 = document.createElement("h5");
            fillingH5.classList.add("myTextColor");
            fillingH5.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            fillingBox.append(fillingH5);
            let fillingTxts = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[0].AnsText;
            let fillingStrs = fillingTxts.split("##");
            let ansSn = 0;
            let ansIndex = 1;
            for (var Str = 0; Str < fillingStrs.length; Str++) {
                if (fillingStrs[Str].includes("^")) {
                    let fillingfPlace = document.createElement("input");//有要填的地方放Input
                    fillingfPlace.setAttribute("type", "text");
                    fillingfPlace.setAttribute("onchange", "changeTableJsonData(event)");
                    fillingfPlace.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[0].AnsText + "_" + ansIndex);
                    fillingfPlace.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[ansSn].value);
                    if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[ansSn].value == null) {
                        fillingfPlace.setAttribute("value", "");
                    }

                    fillingfPlace.style.width = "20%";
                    fillingfPlace.classList.add("form-control", "form-control-user", "d-inline", "mb-2");
                    ansSn++;
                    ansIndex++;
                    fillingBox.append(fillingfPlace);
                    let character = fillingStrs[Str].substring(2);
                    if (character != null) {
                        let chars = document.createElement('div');
                        chars.classList.add("ml-1", "mr-1", "pt-2", "d-inline");
                        chars.innerText = character;
                        fillingBox.append(chars);
                    }
                } else {
                    let Character = document.createElement('div');
                    Character.classList.add("ml-1", "mr-1", "pt-2", "d-inline");
                    Character.innerText = fillingStrs[Str];
                    fillingBox.append(Character);
                }
            }
            return fillingBox;
        }
        function CreateTableTypeCardBodyPartRadioMixFilling(DataObj, GroupsSn, RowsSn, ColsSn) {
            let RadioMixFillingBox = document.createElement("div");
            RadioMixFillingBox.classList.add("col-12", "mb-3", "RadioMixFillingBox");
            let QradioMixFilling = document.createElement("h5");
            QradioMixFilling.classList.add("myTextColor");
            QradioMixFilling.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            RadioMixFillingBox.append(QradioMixFilling);
            let radioMixFillingInputBox = document.createElement("div");
            radioMixFillingInputBox.classList.add("radioMixFillingInputBox");
            //radio 的選項
            for (var rmfAns = 0; rmfAns < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions.length; rmfAns++) {
                let fillingValue = false;
                let radioInput = document.createElement("input");
                radioInput.setAttribute("type", "radio");
                radioInput.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                radioInput.setAttribute("onclick", "CleanOthers(event)");
                radioInput.setAttribute("onchange", "changeTableJsonData(event)");
                radioInput.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmfAns].AnsText);
                if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmfAns].AnsText == DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value) {
                    radioInput.checked = true;
                    fillingValue = true;
                }
                radioInput.classList.add("myRadio");
                radioInput.style.left = 0;
                let optionGroup = document.createElement("div");
                optionGroup.classList.add("optionGroup", "col-12");
                optionGroup.append(radioInput);
                radioMixFillingInputBox.append(optionGroup);
                //filling 的部分
                let rfindex = 1;
                let sn = 0;
                let fillings = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmfAns].AnsText;//todo
                if (fillings.includes("##^")) {
                    let fillingsStrs = fillings.split("##");
                    for (var rfsi = 0; rfsi < fillingsStrs.length; rfsi++) {
                        if (fillingsStrs[rfsi].includes("^")) {
                            let placeInput = document.createElement("input");
                            placeInput.setAttribute("type", "text");
                            placeInput.setAttribute("onchange", "changeTableJsonData(event)");
                            placeInput.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmfAns].AnsText + "_" + rfindex);
                            if (fillingValue) {
                                placeInput.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].Answers[sn].value);
                                if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].Answers[sn].value == null) {
                                    placeInput.setAttribute("value", "");
                                }
                            } else {
                                placeInput.disabled = true;
                            }
                            placeInput.style.width = "20%";
                            placeInput.classList.add("form-control", "form-control-user", "mb-3", "d-inline", "mr-2", "ml-1", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                            optionGroup.append(placeInput);
                            if (fillingsStrs[rfsi].substring("2") != null) {
                                let StrLabel = document.createElement("label");
                                StrLabel.innerText = fillingsStrs[rfsi].substring("2");
                                optionGroup.append(StrLabel);
                            }
                            rfindex++;
                            sn++;
                        } else {
                            let StrLabel = document.createElement("label");
                            StrLabel.innerText = fillingsStrs[rfsi];
                            optionGroup.append(StrLabel);
                        }
                    }
                } else {
                    let StrLabel = document.createElement("label");
                    StrLabel.innerText = fillings;
                    optionGroup.append(StrLabel);
                }
            }
            RadioMixFillingBox.append(radioMixFillingInputBox);

            return RadioMixFillingBox;

        }

        //row 會分放在編輯的Modal跟放在新增的Modal
        //DataObj是要產出會面的資料來源(資料庫中的OutputJson轉Object)
        //GroupSn 迴圈到第幾個的群組
        //RowsSn迴圈到第幾個的Row
        //ColsSn迴圈到第幾個的Col
        //EditModal放在哪一個編輯Modal裡
        //InsertModal 放在哪一個新增Modal裡
        //Td 顯示答案要放在哪一個Table的Td裡
        //Text
        function CreateRowTypeText(DataObj, GroupsSn, RowsSn, ColsSn, EditModal, InsertModal, Td) {
            //for (var bbbb = 0; bbbb < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers.length; bbbb++) {
            let colbox = document.createElement('div');
            let label = document.createElement("label");
            label.classList.add("myTextColor")
            label.innerText = DataObj.Groups[GroupsSn].Rows[0].Cols[ColsSn].QuestionText;
            console.log("label:" + label.innerText);
            colbox.append(label);
            colbox.classList.add("col-12", "rowPart");
            EditModal.append(colbox);
            let inputBox = document.createElement("div");
            inputBox.classList.add("col-12", "mb-4", "rowPart");
            EditModal.append(inputBox);

            let colboxInster = document.createElement('div');
            let labelInster = document.createElement("label");
            labelInster.classList.add("myTextColor", "rowPart")
            labelInster.innerText = DataObj.Groups[GroupsSn].Rows[0].Cols[ColsSn].QuestionText;
            console.log("labelInster:" + labelInster.innerText);
            colboxInster.append(labelInster);
            colboxInster.classList.add("col-12", "rowPart");
            InsertModal.append(colboxInster);
            let inputBoxInster = document.createElement("div");
            inputBoxInster.classList.add("col-12", "mb-4", "rowPart");
            InsertModal.append(inputBoxInster);
            let TextInput = document.createElement("input");
            let EmptyInput = document.createElement("input");
            TextInput.setAttribute("type", "text");
            EmptyInput.setAttribute("type", "text");
            TextInput.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
            EmptyInput.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
            TextInput.setAttribute("onchange", "changeTableJsonData(event)");
            TextInput.classList.add("form-control", "form-control-user", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
            EmptyInput.classList.add("form-control", "form-control-user", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
            inputBoxInster.append(EmptyInput);
            if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers.length == 0) {
                TextInput.setAttribute("value", "");
            } else {
                TextInput.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value);
            }
            Td.innerText = TextInput.value;
            inputBox.append(TextInput);
            //    }
        }
        //Date
        function CreateRowTypeDate(DataObj, GroupsSn, RowsSn, ColsSn, EditModal, InsertModal, Td) {
            let dateQ = document.createElement("label");
            dateQ.classList.add("myTextColor", "col-12", "mt-2", "rowPart");
            dateQ.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            EditModal.append(dateQ);
            let DateBox = document.createElement("div");
            DateBox.classList.add("col-12", "rowPart");
            EditModal.append(DateBox);
            let DateInput = document.createElement("input");
            DateInput.setAttribute("type", "date");
            DateInput.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
            DateInput.setAttribute("onchange", "changeTableJsonData(event)");
            DateInput.classList.add("col-12", "form-control", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID, "mb-3", "rowPart");
            if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0] != null) {//顯示答案
                let date = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value;
                DateInput.setAttribute("value", date);
                DateInput.innerText = date;
                Td.innerText = date;
            }
            DateBox.append(DateInput);
            //長insertModal
            let dateQinsert = document.createElement("label");
            dateQinsert.classList.add("myTextColor", "col-12", "mt-2", "rowPart");
            dateQinsert.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            InsertModal.append(dateQinsert);
            let dateBoxinsert = document.createElement("div");
            dateBoxinsert.classList.add("col-12", "rowPart");
            InsertModal.append(dateBoxinsert);
            let dateInputinsert = document.createElement("input");
            dateInputinsert.setAttribute("type", "date");
            dateInputinsert.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
            dateInputinsert.classList.add("col-12", "form-control", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID, "mb-3", "rowPart");
            dateBoxinsert.append(dateInputinsert);
            //長insertModal

        }
        //Radio
        function CreateRowTypeRadio(DataObj, GroupsSn, RowsSn, ColsSn, EditModal, InsertModal, Td) {
            let Quetion = document.createElement("label");
            Quetion.classList.add("col-12", "mt-3", "myTextColor", "rowPart");
            Quetion.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            EditModal.append(Quetion);
            for (var ar = 0; ar < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions.length; ar++) {
                let inputRadioBox = document.createElement("div");
                inputRadioBox.classList.add("col-12");
                EditModal.append(inputRadioBox);
                let RadioLabel = document.createElement("label");
                RadioLabel.classList.add("form-check-label");
                RadioLabel.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[ar].AnsText;
                let RadioInput = document.createElement("input");
                RadioInput.classList.add(DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID, "myRadio");
                RadioInput.style.left = "0px";
                RadioInput.setAttribute("type", "radio");
                RadioInput.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                RadioInput.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[ar].AnsText);
                RadioInput.setAttribute("onchange", "changeTableJsonData(event)");
                if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers.length > 0) {
                    if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value == RadioInput.value) {
                        RadioInput.setAttribute("checked", "true");
                        Td.innerText = RadioInput.value;
                    }
                }
                inputRadioBox.append(RadioInput);
                inputRadioBox.append(RadioLabel);
            }
            //長insertModal
            let questionInsert = document.createElement("label");
            questionInsert.classList.add("col-12", "mt-3", "myTextColor", "rowPart");
            questionInsert.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            InsertModal.append(questionInsert);
            for (var ar = 0; ar < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions.length; ar++) {
                let inputRadioBoxInster = document.createElement("div");
                inputRadioBoxInster.classList.add("col-12");
                InsertModal.append(inputRadioBoxInster);
                let RadioLabelInster = document.createElement("label");
                RadioLabelInster.classList.add("form-check-label");
                RadioLabelInster.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[ar].AnsText;
                let RadioInputInster = document.createElement("input");
                RadioInputInster.classList.add(DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID, "myRadio");
                RadioInputInster.style.left = "0px";
                RadioInputInster.setAttribute("type", "radio");
                RadioInputInster.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                RadioInputInster.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[ar].AnsText);
                inputRadioBoxInster.append(RadioInputInster);
                inputRadioBoxInster.append(RadioLabelInster);
            }
            //長insertModal

        }
        //RadioMixFilling
        function CreateRowTypeRadioMixFilling(DataObj, GroupsSn, RowsSn, ColsSn, EditModal, InsertModal, Td) {
            let question = document.createElement("label");
            question.classList.add("col-12", "mt-3", "myTextColor");
            question.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            EditModal.append(question);
            let rfRadfillBoxFather = document.createElement("div");
            rfRadfillBoxFather.classList.add("col-12");
            EditModal.append(rfRadfillBoxFather);
            let showValue = false;
            for (var arf = 0; arf < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions.length; arf++) {//radio
                let rfRadfillBox = document.createElement("div");
                rfRadfillBox.classList.add("rfRadfillBox");
                rfRadfillBoxFather.append(rfRadfillBox);
                let rfRadio = document.createElement("input");
                rfRadio.setAttribute("type", "radio");
                rfRadio.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                rfRadio.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[arf].AnsText);
                rfRadio.setAttribute("onchange", "changeTableJsonData(event)");
                rfRadio.setAttribute("onclick", "CleanOthers(event)");
                rfRadio.classList.add("myRadio", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                rfRadio.style.left = "0px";
                if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[arf].AnsText == DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value) {
                    rfRadio.checked = true;
                    showValue = true;
                } else {
                    showValue = false;
                }
                rfRadfillBox.append(rfRadio);
                let rfLabel = document.createElement("label");
                if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[arf].AnsText.includes("##^")) {

                    let rfAnstext = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[arf].AnsText.split("##");
                    let fillingAns = 0;
                    let fillingAnsSn = fillingAns + 1;
                    for (var rfo = 0; rfo < rfAnstext.length; rfo++) {
                        if (rfAnstext[rfo].includes("^")) {
                            let placeRf = document.createElement("input");
                            placeRf.setAttribute("type", "text");//ttxx
                            placeRf.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[arf].AnsText + "_" + fillingAnsSn);
                            placeRf.setAttribute("onchange", "changeTableJsonData(event)");//todo 檢查
                            placeRf.classList.add("form-control", "form-control-user", "mb-2", "d-inline", "mr-2", "ml-1", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                            placeRf.disabled = true;
                            //placeRf.classList.add(rfAnstext[rfo].substring("2"))
                            if (showValue) {
                                if (fillingAns < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].Answers.length) {
                                    placeRf.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].Answers[fillingAns].value);
                                    placeRf.disabled = false;
                                    Td.innerText += DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].Answers[fillingAns].value;
                                }
                            }

                            placeRf.style.width = "20%";
                            rfRadfillBox.append(placeRf);
                            if (fillingAns < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].Answers.length) {
                                fillingAns++;
                                fillingAnsSn++;
                            }
                            if (rfAnstext[rfo].substring("2") != null) {
                                let AnsTXT = document.createElement("span");
                                AnsTXT.innerText = rfAnstext[rfo].substring("2");
                                if (showValue) {
                                    Td.innerText += rfAnstext[rfo].substring("2");
                                }
                                rfRadfillBox.append(AnsTXT);
                            }
                        } else {
                            let AnsTXT = document.createElement("span");
                            AnsTXT.innerText = rfAnstext[rfo];
                            if (showValue) {
                                Td.innerText += rfAnstext[rfo];
                            }
                            rfRadfillBox.append(AnsTXT)
                        }

                    }
                } else {
                    //Td.innerText += DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[arf].AnsText;
                    rfLabel.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[arf].AnsText;
                    rfRadfillBox.append(rfLabel);
                }
            }
            //長insertModal
            let Qinsert = document.createElement("label");
            Qinsert.classList.add("col-12", "mt-3", "myTextColor");
            Qinsert.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            InsertModal.append(Qinsert);
            let rfRadfillBoxFatherinsert = document.createElement("div");
            rfRadfillBoxFatherinsert.classList.add("col-12");
            InsertModal.append(rfRadfillBoxFatherinsert);
            for (var arf = 0; arf < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions.length; arf++) {//radio
                let rfRadfillInsterBox = document.createElement("div");
                rfRadfillInsterBox.classList.add("rfRadfillBox");
                rfRadfillBoxFatherinsert.append(rfRadfillInsterBox);
                let radioInsert = document.createElement("input");
                radioInsert.setAttribute("type", "radio");
                radioInsert.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                radioInsert.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[arf].AnsText);
                radioInsert.setAttribute("onclick", "CleanOthers(event)");
                radioInsert.classList.add("myRadio", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                radioInsert.style.left = "0px";
                rfRadfillInsterBox.append(radioInsert);
                let rfLabelInsert = document.createElement("label");
                if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[arf].AnsText.includes("##^")) {
                    let rfAnstextInsert = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[arf].AnsText.split("##");
                    let fillingAnsInsert = 0;
                    for (var rfo = 0; rfo < rfAnstextInsert.length; rfo++) {
                        let fillingAnsInsertSn = fillingAnsInsert + 1;
                        if (rfAnstextInsert[rfo].includes("^")) {
                            let placeRfInsert = document.createElement("input");
                            placeRfInsert.setAttribute("type", "text");//ttxx
                            placeRfInsert.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[arf].AnsText + "_" + fillingAnsInsertSn);
                            placeRfInsert.classList.add("form-control", "form-control-user", "mb-2", "d-inline", "mr-2", "ml-1", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                            placeRfInsert.disabled = true;
                            if (fillingAnsInsert < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].Answers.length) {
                                fillingAnsInsert++;
                                fillingAnsInsertSn++;
                            }
                            placeRfInsert.style.width = "20%";
                            rfRadfillInsterBox.append(placeRfInsert);
                            if (rfAnstextInsert[rfo].substring("2") != null) {
                                let ansTXT = document.createElement("span");
                                ansTXT.innerText = rfAnstextInsert[rfo].substring("2");
                                rfRadfillInsterBox.append(ansTXT);
                            }
                        } else {
                            let ansTXT = document.createElement("span");
                            ansTXT.innerText = rfAnstextInsert[rfo];
                            rfRadfillInsterBox.append(ansTXT);
                        }
                    }
                } else {
                    ansTXT.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[arf].AnsText;
                    rfLabelInsert.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[arf].AnsText;
                    rfRadfillInsterBox.append(rfLabelInsert);
                }
            }
            //長insertModal
        }
        //CheckboxMixFilling
        function CreateRowTypeCheckboxMixFilling(DataObj, GroupsSn, RowsSn, ColsSn, EditModal, InsertModal, Td) {
            let CkbMfQ = document.createElement("label");
            CkbMfQ.classList.add("col-12", "mt-3", "myTextColor", "rowPart");
            CkbMfQ.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            let fillingAns = 0;//ANS的項次
            let optionAns = 1;
            let father = document.createElement("div");
            father.classList.add("col-12", "rowPart");
            EditModal.append(CkbMfQ);
            EditModal.append(father);
            let Ans1;//哪一個Checkbox有勾;
            let fillingDisable = true;
            for (var acf = 0; acf < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions.length; acf++) {
                let checkboxFillngBox = document.createElement("div");
                checkboxFillngBox.classList.add("pt-1", "d-flex", "checkboxFillngBox", "justify-content-start", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                father.append(checkboxFillngBox);
                let ckboxInput = document.createElement("input");
                ckboxInput.setAttribute("type", "checkbox");
                ckboxInput.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                ckboxInput.setAttribute("onchange", "changeTableJsonData(event)");//todo 檢查 有父子的值的問題
                ckboxInput.setAttribute("onclick", "DisabledTrue(event)");
                ckboxInput.classList.add("mr-1", "CheckboxMixFilling", "mycheckbox", "mt-2", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                for (let s = 0; s < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers.length; s++) {
                    if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[s].value == DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[acf].AnsText) {
                        ckboxInput.setAttribute("checked", "true");
                        Ans1 = s;
                        fillingDisable = false;
                        break;
                    } else {
                        fillingDisable = true;
                        Ans1 = null;
                    }
                }

                ckboxInput.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[acf].AnsText);
                checkboxFillngBox.append(ckboxInput);
                if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[acf].AnsText.includes("##^")) {//有填空
                    let AnsText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[acf].AnsText;
                    let AnsAStr = AnsText.split("##");
                    let index = 1;
                    let ansSn = 0;
                    for (var ocf = 0; ocf < AnsAStr.length; ocf++) {
                        if (AnsAStr[ocf].includes("^")) {
                            let place = document.createElement("input");
                            place.setAttribute("type", "text");
                            place.setAttribute("onchange", "changeTableJsonData(event)");//todo 檢查 有順序問題
                            place.setAttribute("name", AnsText + "_" + index);
                            place.disabled = true;
                            if (Ans1 != null) {
                                let ckbValue = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[Ans1].value.split("##^1");
                                Td.innerText += ckbValue[0];
                                Td.innerText += DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[Ans1].Answers[ansSn].value;
                                place.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[Ans1].Answers[ansSn].value);
                                place.disabled = fillingDisable;
                            }
                            place.classList.add("form-control", "form-control-user", "mr-2", "ml-1", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                            place.style.width = "50%";
                            checkboxFillngBox.append(place);
                            if (AnsAStr[ocf].substring("2") != null) {
                                let ckmfLabel = document.createElement("label");
                                ckmfLabel.innerText = AnsAStr[ocf].substring("2");
                                //Td.innerText += AnsAStr[ocf].substring("2");
                                checkboxFillngBox.append(ckmfLabel)
                            }
                            index++;
                            ansSn++;
                        }
                        else {
                            let TXTS = document.createElement("label");
                            TXTS.innerText = AnsAStr[ocf];
                            /*Td.innerText += AnsAStr[ocf];*/
                            TXTS.classList.add("mt-1");
                            checkboxFillngBox.append(TXTS);
                        }
                    }
                }
                else {
                    let TXTS = document.createElement("label");
                    TXTS.innerText = AnsAStr[ocf];
                    //Td.innerText += AnsAStr[ocf];
                    checkboxFillngBox.append(TXTS);
                }
            }
            //長insertModal
            let CkbMfQInsert = document.createElement("label");
            CkbMfQInsert.classList.add("col-12", "mt-3", "myTextColor", "rowPart");
            CkbMfQInsert.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            let fillingAnsInsert = 0;//ANS的項次
            let optionAnsInsert = 1;//
            let fatherInsert = document.createElement("div");
            fatherInsert.classList.add("col-12");
            InsertModal.append(CkbMfQInsert);
            InsertModal.append(fatherInsert);
            let Ans1Insert;//哪一個Checkbox有勾;
            let fillingDisableInsert = true;
            for (var acf = 0; acf < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions.length; acf++) {
                let checkboxFillngInsertBox = document.createElement("div");
                checkboxFillngInsertBox.classList.add("pt-1", "d-flex", "checkboxFillngBox", "justify-content-start", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                fatherInsert.append(checkboxFillngInsertBox);
                let ckboxInputInsert = document.createElement("input");
                ckboxInputInsert.setAttribute("type", "checkbox");
                ckboxInputInsert.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                ckboxInputInsert.setAttribute("onclick", "DisabledTrue(event)");
                ckboxInputInsert.classList.add("mr-1", "CheckboxMixFilling", "mycheckbox", "mt-2", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID, "insert");
                //for (let s = 0; s < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers.length; s++) {
                //    if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[s].value == DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[acf].AnsText) {
                //        ckboxInputInsert.setAttribute("checked", "true");
                //        Ans1Insert = s;
                //        fillingDisableInsert = false;
                //    }
                //    else {
                //        fillingDisableInsert = true;
                //        Ans1Insert = null;
                //    }
                //}
                ckboxInputInsert.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[acf].AnsText);
                checkboxFillngInsertBox.append(ckboxInputInsert);
                if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[acf].AnsText.includes("##^")) {//有填空
                    let AnsTextInsert = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[acf].AnsText;
                    let AnsAStrInsert = AnsTextInsert.split("##");
                    let indexInsert = 1;
                    let ansSnInsert = 0;
                    for (var ocf = 0; ocf < AnsAStrInsert.length; ocf++) {
                        if (AnsAStrInsert[ocf].includes("^")) {
                            let placeInsert = document.createElement("input");
                            placeInsert.setAttribute("type", "text");
                            placeInsert.setAttribute("name", AnsTextInsert + "_" + indexInsert);
                            placeInsert.disabled = true;
                            if (Ans1Insert != null) {
                                //placeInsert.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[Ans1Insert].Answers[ansSnInsert].value);
                                placeInsert.disabled = fillingDisableInsert;
                            }
                            placeInsert.classList.add("form-control", "form-control-user", "mr-2", "ml-1", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                            placeInsert.style.width = "50%";
                            checkboxFillngInsertBox.append(placeInsert);
                            if (AnsAStrInsert[ocf].substring("2") != null) {
                                let ckmfInsertLabel = document.createElement("label");
                                ckmfInsertLabel.innerText = AnsAStrInsert[ocf].substring("2");
                                checkboxFillngInsertBox.append(ckmfInsertLabel);
                            }
                            indexInsert++;
                            ansSnInsert++;
                        }
                        else {
                            let TXTSInsert = document.createElement("label");
                            TXTSInsert.innerText = AnsAStrInsert[ocf];
                            TXTSInsert.classList.add("mt-1");
                            checkboxFillngInsertBox.append(TXTSInsert);
                        }
                    }
                }
                else {
                    let TXTSInsert = document.createElement("label");
                    TXTSInsert.innerText = AnsAStrInsert[ocf];
                    checkboxFillngInsertBox.append(TXTSInsert);
                }

            }

            //長insertModal

        }
        //RadioMixCheckBox
        function CreateRowTypeRadioMixCheckBox(DataObj, GroupsSn, RowsSn, ColsSn, EditModal, InsertModal, Td) {
            let rmcQ = document.createElement("label");
            rmcQ.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            rmcQ.classList.add("mt-3", "myTextColor");
            let rmcBox = document.createElement("div");
            rmcBox.classList.add("col-12", "pt-2");
            rmcBox.append(rmcQ);
            EditModal.append(rmcBox);
            for (var rmci = 0; rmci < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions.length; rmci++) {//答案選項 radio
                let ckboxCheck = false;
                let inputGroup = document.createElement("div");
                inputGroup.classList.add("col-12", "inputGroup");
                let rmcRadio = document.createElement("input");
                rmcRadio.setAttribute("type", "radio");
                rmcRadio.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                rmcRadio.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmci].AnsText);
                if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmci].AnsText == DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value) {
                    rmcRadio.setAttribute("checked", "true");
                    ckboxCheck = true;
                    Td.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value + "-";
                }
                rmcRadio.setAttribute("onchange", "changeTableJsonData(event)");
                rmcRadio.setAttribute("onclick", "CleanOptionforTable(event)");
                rmcRadio.classList.add("myRadio");
                rmcRadio.style.left = 0;
                inputGroup.append(rmcRadio);
                let labelrmc = document.createElement("label");
                labelrmc.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmci].AnsText;
                inputGroup.append(labelrmc);
                for (var ii = 0; ii < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmci].AnswerOptions.length; ii++) {
                    let ckbox = document.createElement("input");
                    ckbox.setAttribute("type", "checkbox");
                    ckbox.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmci].AnswerOptions[ii].AnsText);
                    if (ckboxCheck) {
                        for (let ans = 0; ans < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].Answers.length; ans++) {
                            if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmci].AnswerOptions[ii].AnsText == DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].Answers[ans].value) {
                                ckbox.checked = true;
                                ckbox.disabled = false;
                                Td.innerText += DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].Answers[ans].value;
                            }
                        }
                    } else {
                        ckbox.disabled = true;
                    }
                    ckbox.setAttribute("onchange", "changeTableJsonData(event)");
                    ckbox.setAttribute("name", "1" + DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                    ckbox.classList.add("myCheckboxRc", "ml-2", "mr-1");
                    inputGroup.append(ckbox);
                    let labelck = document.createElement("label");
                    labelck.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmci].AnswerOptions[ii].AnsText;
                    inputGroup.append(labelck);
                    EditModal.append(inputGroup);
                }
            }
            //
            let rmcQInsert = document.createElement("label");
            rmcQInsert.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            rmcQInsert.classList.add("mt-3", "myTextColor");
            let rmcBoxInsert = document.createElement("div");
            rmcBoxInsert.classList.add("col-12", "pt-2");
            rmcBoxInsert.append(rmcQInsert);
            InsertModal.append(rmcBoxInsert);
            for (var rmci = 0; rmci < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions.length; rmci++) {//答案選項 radio
                let ckboxCheckInster = false;
                let inputGroupInster = document.createElement("div");
                inputGroupInster.classList.add("col-12", "inputGroupInster");
                let rmcRadioInster = document.createElement("input");
                rmcRadioInster.setAttribute("type", "radio");
                rmcRadioInster.setAttribute("name", "2" + DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                rmcRadioInster.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmci].AnsText);
                //if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmci].AnsText == DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value) {
                //    rmcRadioInster.checked = true;
                //    ckboxCheckInster = true;
                //    Td.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value + "-";
                //}
                rmcRadioInster.setAttribute("onchange", "changeTableJsonData(event)");
                rmcRadioInster.setAttribute("onclick", "CleanOptionforTable(event)");
                rmcRadioInster.classList.add("myRadio");
                rmcRadioInster.style.left = 0;
                inputGroupInster.append(rmcRadioInster);
                let labelrmcInster = document.createElement("label");
                labelrmcInster.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmci].AnsText;
                inputGroupInster.append(labelrmcInster);
                for (var ii = 0; ii < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmci].AnswerOptions.length; ii++) {
                    let ckboxInster = document.createElement("input");
                    ckboxInster.setAttribute("type", "checkbox");
                    ckboxInster.setAttribute("value", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmci].AnswerOptions[ii].AnsText);
                    if (ckboxCheckInster) {
                        for (let ans = 0; ans < DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].Answers.length; ans++) {
                            if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmci].AnswerOptions[ii].AnsText == DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].Answers[ans].value) {
                                //ckboxInster.checked = true;
                                ckboxInster.disabled = false;
                                Td.innerText += DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].Answers[ans].value;
                            }
                        }
                    } else {
                        ckboxInster.disabled = true;
                    }
                    ckboxInster.setAttribute("name", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmci].AnsText);
                    ckboxInster.classList.add("myCheckboxRc", "ml-2", "mr-1", "insert");
                    inputGroupInster.append(ckboxInster);
                    let labelckInster = document.createElement("label");
                    labelckInster.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].AnswerOptions[rmci].AnswerOptions[ii].AnsText;
                    inputGroupInster.append(labelckInster);
                    InsertModal.append(inputGroupInster);
                }
            }


        }
        //Sign
        function CreateRowTypeSign(DataObj, GroupsSn, RowsSn, ColsSn, EditModal, InsertModal, Td, modalID) {
            let signQ = document.createElement("label");
            signQ.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            signQ.classList.add("mt-3", "myTextColor");
            let SignBox = document.createElement("div");
            SignBox.classList.add("col-12", "pt-2", "SignBoxRow");
            let SignBtn = document.createElement("buttom");
            SignBtn.classList.add("btn", "btn-primary", "Signbtn", "ml-2", "rowPart");
            SignBtn.setAttribute("onclick", "SignByAdminId(event)");
            SignBtn.setAttribute("data-Staut", "Edit");
            SignBtn.setAttribute("data-GidandRow", modalID);

            SignBtn.setAttribute("onchange", "changeTableJsonData(event)");//todo
            SignBtn.innerText = "簽核";
            SignBox.append(signQ);
            SignBox.append(SignBtn);

            let SignImageBox = document.createElement("div");
            SignImageBox.classList.add("ml-5", "SignImageBox");
            SignBox.append(SignImageBox);
            let signImgID = document.getElementById("mainPlaceHolder_adminSign").value;
            let signImage = document.createElement("img");

            let signdate = document.createElement('span');
            signdate.classList.add("d-flex", "justify-content-center", "signDate");
            signImage.setAttribute("id", "sign" + signImgID);
            signImage.classList.add(DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
            Td.innerHTML = '<img class="d-none" src="ShowAdminImg?id=' + signImgID + '"style="width: 10%;"' + '>';

            if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value != null) {
                signImage.src = "ShowAdminImg.aspx?id=" + DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value;
                Td.innerHTML = '<img src="ShowAdminImg?id=' + DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value + '"style="width: 10%;"' + '>';
                signdate.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].lastUpdate;
                SignImageBox.classList.add("d-inline");
            } else {
                signImage.src = "ShowAdminImg.aspx?id=" + signImgID;
                let today = new Date();
                signdate.innerText = today.getFullYear();
                signdate.innerText += "/";
                signdate.innerText += today.getMonth() + 1;
                signdate.innerText += "/";
                signdate.innerText += today.getDate();
                SignImageBox.classList.add("d-none", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
                Td.innerHTML = '<img class="d-none" src="ShowAdminImg?id=' + signImgID + '"style="width: 10%;"' + '>';
            }

            if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value != signImgID && DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value != null) {//如果已經有人簽 不是登入者簽的不能覆蓋
                SignBtn.setAttribute("disabled", "true");
            } else if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value == null) {
                SignBtn.innerText = "簽核";
            }
            else {
                SignBtn.innerText = "取消簽核";
            }
            signImage.style.width = "30%";
            SignImageBox.append(signImage);
            SignImageBox.append(signdate);
            EditModal.append(SignBox);
            //長insertModal
            let signQinsert = document.createElement("label");
            signQinsert.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            signQinsert.classList.add("mt-3", "myTextColor");
            let SignBoxinsert = document.createElement("div");
            SignBoxinsert.classList.add("col-12", "pt-2", "SignBoxinsertRow");
            let SignBtninsert = document.createElement("buttom");
            SignBtninsert.classList.add("btn", "btn-primary", "Signbtn", "ml-2", "insert_sign", modalID)
            SignBtninsert.setAttribute("onclick", "SignByAdminId(event)");
            SignBtninsert.setAttribute("data-Staut", "insert");
            SignBtninsert.setAttribute("data-gidandrow", modalID);

            SignBtninsert.setAttribute("onchange", "changeTableJsonData(event)");//todo
            SignBtninsert.innerText = "簽核";
            SignBoxinsert.append(signQinsert);
            SignBoxinsert.append(SignBtninsert);
            let SignImageBoxinsert = document.createElement("div");
            SignImageBoxinsert.classList.add("ml-5", "SignImageBoxinsert");
            SignBoxinsert.append(SignImageBoxinsert);
            let signImginsertID = document.getElementById("mainPlaceHolder_adminSign").value;
            let signImageinsert = document.createElement("img");
            let signdateinsert = document.createElement('span');
            signdateinsert.classList.add("d-flex", "justify-content-center", "signDate");
            signImageinsert.setAttribute("id", "sign" + signImginsertID);
            signImageinsert.classList.add(DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
            //Td.innerHTML = '<img class="d-none" src="ShowAdminImg?id=' + signImginsertID + '"style="width: 10%;"' + '>';
            //if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value != null) {
            //    signImageinsert.src = "ShowAdminImg.aspx?id=" + DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value;
            //    Td.innerHTML = '<img src="ShowAdminImg?id=' + DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value + '"style="width: 10%;"' + '>';
            //    signdateinsert.innerText = DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].lastUpdate;
            //    SignImageBoxinsert.classList.add("d-inline");
            //} else {
            signImageinsert.src = "ShowAdminImg.aspx?id=" + signImginsertID;
            let Today = new Date();
            signdateinsert.innerText = Today.getFullYear();
            signdateinsert.innerText += "/";
            signdateinsert.innerText += Today.getMonth() + 1;
            signdateinsert.innerText += "/";
            signdateinsert.innerText += Today.getDate();
            SignImageBoxinsert.classList.add("d-none", DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID);
            SignBtninsert.innerText = "簽核";
            //    Td.innerHTML = '<img class="d-none" src="ShowAdminImg?id=' + signImginsertID + '"style="width: 10%;"' + '>';
            /*}*/
            //if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value != signImginsertID && DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value != null) {//如果已經有人簽 不是登入者簽的不能覆蓋
            //    SignBtninsert.setAttribute("disabled", "true");
            //} else if (DataObj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].Answers[0].value == null) {
            //    SignBtninsert.innerText = "簽核";
            //}
            //else {
            //    SignBtninsert.innerText = "取消簽核";
            //}
            signImageinsert.style.width = "30%";
            SignImageBoxinsert.append(signImageinsert);
            SignImageBoxinsert.append(signdateinsert);
            InsertModal.append(SignBoxinsert);
            //長insertModal
        }

    </script>
</asp:Content>
