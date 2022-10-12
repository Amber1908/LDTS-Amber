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
                        <li class="breadcrumb-item"><asp:HyperLink ID="ProUrl" runat="server" Text="程序書"></asp:HyperLink></li>
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
                                <input type="text" runat="server" MaxLength="50" id="ExtendName" class="form-control form-control-border" />
                            </div>
                            <div class="ansKeyword form-group">
                                <label for="keyword" style="font-size: 12px; color: #00000080">關鍵字設定</label>
                                <input type="text" runat="server" MaxLength="200" id="keyword" class="form-control form-control-border" />
                            </div>
                            <div class="ansStatus form-group">
                                <label for="Stauts" style="font-size: 12px; color: #00000080">表單狀態</label>
                                <select id="Stauts" class="form-control select2 select2-hidden-accessible" style="width: 100%;" runat="server">
                                    <option value="0">作廢</option>
                                    <option value="1">正常</option>
                                    <option value="2">待簽核</option>
                                    <option value="3">已簽核</option>
                                    <option value="4">結案</option>
                                </select>
                            </div>
                            <div class="ansDesc form-group">
                                <label for="desc" style="font-size: 12px; color: #00000080">表單描述</label>
                                <asp:TextBox TextMode="MultiLine" MaxLength="3000"  ID="desc" runat="server" Rows="5" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="ansSave form-group float-right">
                                <asp:Button runat="server" ID="Printbtn" CssClass="btn btn-danger" Text="列印" OnClick="Printbtn_Click" />
                                <asp:Button runat="server" ID="SaveButton" CssClass="btn btn-primary" Text="儲存" OnClick="SaveButton_Click" />
                                <asp:Button runat="server" ID="Deletebtn" CssClass="btn btn-default" Text="刪除" OnClick="Deletebtn_Click" />
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
            
            var ao = document.getElementById("mainPlaceHolder_Ao");
            var savebtn = document.getElementById("mainPlaceHolder_SaveButton");
            var Printbtn = document.getElementById("mainPlaceHolder_Printbtn");
            switch (ao.value) {
                case "2":
                    break;
                case "1":
                    var allsign = document.getElementsByClassName("Signbtn");
                    for (var i = 0; i < allsign.length; i++) {
                        console.log(allsign.length);
                    //        allsign[i].removeAttribute("onclick");
                        allsign[i].classList.add("d-none");
                    }
                    break;
                case "0":
                    var allbtn = document.getElementsByTagName("button");
                    console.log("allbtn" + allbtn.length);
                    var allinputs = document.getElementsByTagName("input");
                    var allsign = document.getElementsByClassName("Signbtn");
                    var downloads = document.getElementsByClassName("download");
                    var selects = document.getElementsByTagName("select");
                    var txtbox = document.getElementsByTagName("textarea");
                    console.log(allsign.length);
                    for (var i = 0; i < txtbox.length; i++) {
                        txtbox[i].disabled = true;
                    }
                    for (var i = 0; i < selects.length; i++) {
                        selects[i].disabled = true;
                    }
                    for (var i = 0; i < downloads.length; i++) {
                        downloads[i].classList.add("d-none");
                    }
                    for (var i = 0; i < allsign.length; i++) {
                        allsign[i].classList.add("d-none");
                    }
                    for (var i = 0; i < allinputs.length; i++) {
                        console.log(allinputs[i].type);
                        //inputBrothers[d].disabled = true;
                        allinputs[i].disabled = true;
                    }
                    for (var i = 0; i < allbtn.length; i++) {
                        console.log(allinputs[i].type);
                        //inputBrothers[d].disabled = true;
                        allbtn[i].disabled = true;
                    }
                   
                    savebtn.classList.add("d-none");
                    Printbtn.classList.add("d-none");
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
                        QcardBody.classList.add("card-body", "row");

                        for (var q = 0; q < Obj.Groups[i].Questions.length; q++) {
                            normalDiv.append(QcardBody);
                            let Qlabel = document.createElement("div");
                            let img = document.createElement("img");
                            if (Obj.Groups[i].Questions[q].QuestionType == "checkbox") {
                                Qlabel.classList.add("col-12", "pt-2", "d-flex", "justify-content-start");
                            }

                            if (Obj.Groups[i].Questions[q].QuestionType == "radio") {
                                Qlabel.classList.add("col-12", "pt-2", "d-flex", "justify-content-start");
                            }
                            if (Obj.Groups[i].Questions[q].QuestionType == "display") {
                                //Qlabel.classList.add("col-12","d-flex","justify-content-start");
                                if (Obj.Groups[i].Questions[q].AnswerOptions.length > 0) {
                                    img.src = "ShowAdminImg?id=" + Obj.Groups[i].Questions[q].AnswerOptions[0].image;
                                    img.style.width = "80%";
                                    QcardBody.append(img);
                                }
                            } else {
                                Qlabel.classList.add("col-12","d-flex", "justify-content-start");
                            }
                            QcardBody.append(Qlabel);
                            let nQuestion = document.createElement("p");//問題的Style 
                            nQuestion.classList.add("nQuestion", "myTextColor");
                            nQuestion.style.fontSize = "20px";
                            if (hasSn > 0) {//有項次
                                nQuestion.innerText = hasSn;
                                hasSn++;
                            }
                            if (Obj.Groups[i].Questions[q].QuestionType == "RadioMixCheckbox" || Obj.Groups[i].Questions[q].QuestionType == "CheckboxMixFilling" || Obj.Groups[i].Questions[q].QuestionType == "RadioMixFilling") {
                                nQuestion.classList.add("mt-5");
                            }
                            //題目有填充
                            if (Obj.Groups[i].Questions[q].QuestionText.includes("##^") && Obj.Groups[i].Questions[q].QuestionType!="display") {
                                let Qtext = Obj.Groups[i].Questions[q].QuestionText;//把填充題目取出
                                let strOfFilling = Qtext.split("##");
                                let AnsSn = 0;
                                let index = AnsSn + 1;
                                for (var sf = 0; sf < strOfFilling.length; sf++) {
                                    if (strOfFilling[sf].includes("^")) {//有^就是要填的位置
                                        let fillinfPlace = document.createElement("input");//有要填的地方放Input
                                        fillinfPlace.setAttribute("type", "text");
                                        fillinfPlace.setAttribute("name", Obj.Groups[i].Questions[q].QuestionID);
                                        fillinfPlace.setAttribute("data-textindex", index);
                                        fillinfPlace.setAttribute("data-isQuentionfilling", true);
                                        if (Obj.Groups[i].Questions[q].fillings != undefined) {
                                            fillinfPlace.setAttribute("value", Obj.Groups[i].Questions[q].fillings[AnsSn].value);
                                        }
                                        fillinfPlace.setAttribute("onchange", "changeJsonData(event)");//todo 檢查 有順序問題
                                        fillinfPlace.classList.add("form-control", "form-control-user", "col-1", "form-control-sm", "form-control-border", Obj.Groups[i].Questions[q].QuestionID);
                                        Qlabel.append(fillinfPlace);
                                        let words = strOfFilling[sf].substring(2);
                                        if (words != null) {
                                            let wds = document.createElement('div');
                                            wds.classList.add("ml-1", "mr-1", "pt-1","mb-2","myTextColor");
                                            wds.innerText = words;
                                            wds.style.fontSize = "20px";
                                            Qlabel.append(wds);
                                        }
                                        AnsSn++;
                                        index++;
                                    } else {
                                        let Words = document.createElement('div');
                                        Words.classList.add("ml-1", "mr-1", "pt-1","mb-2","myTextColor");
                                        Words.innerText = strOfFilling[sf];
                                        Words.style.fontSize = "20px";
                                        Qlabel.append(Words);
                                    }

                                }

                            } else {
                                nQuestion.innerText += Obj.Groups[i].Questions[q].QuestionText;//QuestionText
                            }
                            if (Obj.Groups[i].Questions[q].QuestionType == "display" && hasSn > 0) {
                                nQuestion.innerText = hasSn - 1;//再填答區顯示
                                Qlabel.append(nQuestion);

                            } else if (Obj.Groups[i].Questions[q].QuestionType == "display" && hasSn < 0) {
                                nQuestion.innerText = "";
                                nQuestion.style.fontSize = "0px";
                            }
                            if (Obj.Groups[i].Questions[q].QuestionType != "display" ) {
                                Qlabel.append(nQuestion);
                            }
                            switch (Obj.Groups[i].Questions[q].QuestionType) {//產出對應的問題
                                case "CheckboxMixRadio":
                                    CreateNormalTypeCheckboxMixRadio(Obj, i, q, QcardBody);
                                    break;
                                case "text":
                                    CreateNormalTypeText(Obj, i, q, QcardBody);//Obj Json來源 i第幾個Group q第幾個問題 QcardBody要放在哪個載體中
                                    break;
                                case "memo":
                                    CreateNormalTypeMemo(Obj, i, q, QcardBody);//Obj Json來源 i第幾個Group q第幾個問題 QcardBody要放在哪個載體中
                                    break;
                                case "number":
                                    CreateNormalTypeNumber(Obj, i, q, QcardBody);
                                    break;
                                case "checkbox":
                                case "CheckboxMixFilling":
                                    CreateNormalTypeCheckboxMixFilling(Obj, i, q, QcardBody);
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
                                case"display":
                                case "filling":
                                    CreateNormalTypeFilling(Obj, i, q, QcardBody);
                                    break;
                                case "RadioMixCheckbox":
                                    CreateNormalTypeRadioMixCheckbox(Obj, i, q, QcardBody);
                                    break;
                                case "radio":
                                case "RadioMixFilling":
                                    CreateNormalTypeRadioMixFilling(Obj, i, q, QcardBody);
                                    break;
                                case "CheckboxMixImage":
                                    CreateNormalTypeCheckboxMixImage(Obj, i, q, QcardBody);
                                    break;
                                default:
                            }
                            
                           
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
                        TampleteStr += "<table class=\"table table-bordered dataTable rowPart\" style=\"width:100%;margin-bottom: 0px;\">";
                        TampleteStr += "<thead>";//thead
                        TampleteStr += "<tr role=\"row\">";
                        if (Obj.Groups[i].hasSN > 0) {
                            TampleteStr += "<th style=\"width:5%\" class=\"sorting sorting_asc rowPart\">" + "項次";
                            TampleteStr += "</th>";
                        }
                        for (var r = 0; r < Obj.Groups[i].Rows[0].Cols.length; r++) {//首列的標題
                            let rowSn = 0;
                            switch (Obj.Groups[i].Rows[0].Cols[r].QuestionType) {
                                case "display":
                                    if (Obj.Groups[i].Rows[0].Cols[r].QuestionText.includes("##^")) {
                                        TampleteStr += "<th class=\"sorting sorting_asc rowPart\">";
                                        let fillingStr = Obj.Groups[i].Rows[0].Cols[r].QuestionText;
                                        let StrArr = fillingStr.split("##");
                                        let n = 1;
                                        let inft = 1;
                                        let fsn = 1;
                                        let N = 0;//第幾個填充答案
                                        if (Obj.Groups[i].Rows[0].Cols[r].fillings == undefined) {
                                            Obj.Groups[i].Rows[0].Cols[r].fillings = [];
                                        }
                                        for (var s = 0; s < StrArr.length; s++) {
                                            if (StrArr[s].includes("^")) {
                                                if (n+1 > Obj.Groups[i].Rows[0].Cols[r].fillings.length) {
                                                    Obj.Groups[i].Rows[0].Cols[r].fillings.push({ "index": fsn, "value": "", "lastUpdate": "" });
                                                    fsn++;
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                }
                                                TampleteStr += "<input type=\"text\" onchange=\"changeTableJsonData(event)\" style=\"max-width:100px\"  class=\"form-control-sm form-control-border form-control d-inline mr-1 ml-1 mb-2\"name=\"";
                                                TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionID + "\"";
                                                TampleteStr += "data-filling=\"" + n + "\"";
                                                if (Obj.Groups[i].Rows[0].Cols[r].fillings.length > 0) {
                                                    TampleteStr += "value=\"" + Obj.Groups[i].Rows[0].Cols[r].fillings[N].value + "\"";
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
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
                                        TampleteStr += "</th>";
                                    } else {
                                        TampleteStr += "<th class=\"sorting sorting_asc rowPart\">" + Obj.Groups[i].Rows[0].Cols[r].QuestionText;
                                        TampleteStr += "</th>";
                                    }
                                    break;
                                case "number":
                                    TampleteStr += "<th class=\"sorting sorting_asc rowPart\">"
                                    if (Obj.Groups[i].Rows[0].Cols[r].QuestionText != "") {
                                        if (Obj.Groups[i].Rows[0].Cols[r].QuestionText.includes("##^")) {
                                            TampleteStr += checkTableIsFilling(Obj, i, rowSn, r);
                                        } else {
                                            TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionText;
                                        }
                                    }
                                    if (Obj.Groups[i].Rows[0].Cols[r].Answers.length == 0) {
                                        Obj.Groups[i].Rows[0].Cols[r].Answers.push({ "index": 1, "value": "", "lastUpdate": "" });
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                    }
                                    TampleteStr += "<input type=\"number\" onchange=\"changeTableJsonData(event)\" class=\"form-control mb-3\"name=\"";
                                    TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionID + "\"";
                                    if (Obj.Groups[i].Rows[0].Cols[r].Answers.length > 0) {
                                        TampleteStr += "value=\"" + Obj.Groups[i].Rows[0].Cols[r].Answers[0].value + "\"";
                                    }
                                    TampleteStr += ">";
                                    TampleteStr += "</th>";
                                    break;

                                case "text":
                                    Obj.Groups[i].Rows[0].Cols[r].Answers.push({ "index": 1, "value": "", "lastUpdate": ""});
                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                    var valueTemp = Obj.Groups[i].Rows[0].Cols[r].Answers.length > 0 ? Obj.Groups[i].Rows[0].Cols[r].Answers[0].value : "";

                                    TampleteStr += "<th class=\"sorting sorting_asc rowPart\">"
                                    if (Obj.Groups[i].Rows[0].Cols[r].QuestionText != "") {
                                        if (Obj.Groups[i].Rows[0].Cols[r].QuestionText.includes("##^")) {
                                            TampleteStr += checkTableIsFilling(Obj, i, rowSn, r);
                                        } else {
                                            TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionText;
                                        }
                                    }
                                    TampleteStr += "<input type=\"text\" class=\"form-control\" onchange=\"changeTableJsonData(event)\" value=\"" + valueTemp + "\"";
                                    TampleteStr += "name=\"" + Obj.Groups[i].Rows[0].Cols[r].QuestionID+"\"";
                                    TampleteStr += "/>";
                                    TampleteStr += "</th>";
                                    break;
                                case "sign":
                                    if (Obj.Groups[i].Rows[0].Cols[r].QuestionText != "") {
                                        TampleteStr += "<th class=\"sorting sorting_asc rowPart\">";
                                        if (Obj.Groups[i].Rows[0].Cols[r].QuestionText != "") {
                                            if (Obj.Groups[i].Rows[0].Cols[r].QuestionText.includes("##^")) {
                                                TampleteStr += checkTableIsFilling(Obj, i, rowSn, r);
                                            } else {
                                                TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionText;
                                            }
                                        }

                                        if (Obj.Groups[i].Rows[0].Cols[r].Answers.length == 0) {
                                            Obj.Groups[i].Rows[0].Cols[r].Answers.push({ "index": 1, "value": 0, "lastUpdate": "" });
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                        }
                                        let signImgID = document.getElementById("mainPlaceHolder_adminSign").value;
                                        let time = new Date();
                                        let today = time.Format("yyyy-MM-dd");

                                        if (Number(Obj.Groups[i].Rows[0].Cols[r].Answers[0].value) > 0) {
                                            TampleteStr += "<div class=\"col-12 pt-2 tableSign\">";
                                            if (signImgID == Obj.Groups[i].Rows[0].Cols[r].Answers[0].value) {
                                                TampleteStr += "<div data-Staut=\"Edit\" style=\"font-size:10px\" data-GidandRow=\"GID\" onchange=\"changeTableJsonData(event)\" onclick=\"SignByAdminId(event)\" class=\"btn btn-primary Signbtn ml-2 rowPart\" >";//
                                                TampleteStr += "取消簽核";
                                                TampleteStr += "</div>";
                                            }
                                            TampleteStr += "<div class=\"mt-5 d-inline\">";//SignImageBox
                                            TampleteStr += "<img style=\"width:100px;\" src=\"";//img
                                            TampleteStr += "ShowAdminImg?id=" + Obj.Groups[i].Rows[0].Cols[r].Answers[0].value + "\"";
                                            TampleteStr += "id=\"sign" + Obj.Groups[i].Rows[0].Cols[r].Answers[0].value + "\"";
                                            TampleteStr += "class=\"" + Obj.Groups[i].Rows[0].Cols[r].QuestionID;
                                            if (Obj.Groups[i].Rows[0].Cols[r].rotate == true) {
                                                TampleteStr += " " + "signRotated mt-5 mb-3 ml_1";
                                            }
                                            TampleteStr += "\"name=\"" + Obj.Groups[i].Rows[0].Cols[r].QuestionID;
                                            TampleteStr += "\">";//img
                                            TampleteStr += "<span style=\"font-weight:lighter;\" name=\"" + Obj.Groups[i].Rows[0].Cols[r].QuestionID;//
                                            if (Obj.Groups[i].Rows[0].Cols[r].rotate == true) {
                                                TampleteStr += "\" class=\" signDate mt-3\">";//d-flex justify-content-start
                                            } else {
                                                TampleteStr += "\" class=\"signDate mt-3\">";//d-flex  justify-content-end
                                            }
                                            time = new Date(Obj.Groups[i].Rows[0].Cols[r].Answers[0].lastUpdate);
                                            TampleteStr += time.Format("yyyy-MM-dd");
                                            TampleteStr += "</span>";
                                            TampleteStr += "</div>";//SignImageBox
                                            TampleteStr += "</div>";
                                        } else {
                                            TampleteStr += "<div class=\"col-12 pt-2 tableSign\">";
                                            TampleteStr += "<div data-Staut=\"Edit\" style=\"font-size:10px\" data-GidandRow=\"GID\" onchange=\"changeTableJsonData(event)\" onclick=\"SignByAdminId(event)\" class=\"btn btn-primary Signbtn ml-2 rowPart\" >";//
                                            TampleteStr += "簽核";
                                            TampleteStr += "</div>";
                                            TampleteStr += "<div class=\"mt-5 d-none\">";//SignImageBox
                                            TampleteStr += "<img style=\"width:100px\" src=\"";//img
                                            TampleteStr += "ShowAdminImg.aspx?id=" + signImgID + "\"";
                                            TampleteStr += "id=\"sign" + signImgID + "\"";
                                            TampleteStr += "class=\"" + Obj.Groups[i].Rows[0].Cols[r].QuestionID;
                                            TampleteStr += "\"name=\"" + Obj.Groups[i].Rows[0].Cols[r].QuestionID;
                                            TampleteStr += "\">";//img
                                            TampleteStr += "<span style=\"font-weight:lighter;\" name=\"" + Obj.Groups[i].Rows[0].Cols[r].QuestionID;
                                            TampleteStr += "\" class=\" signDate mt-3\">";//d-flex justify-content-end
                                            TampleteStr += today;
                                            TampleteStr += "</span>";
                                            TampleteStr += "</div>";//SignImageBox
                                            TampleteStr += "</div>";
                                        }

                                        TampleteStr += "</th>";
                                    }
                                    break;
                                case "date":
                                    TampleteStr += "<th class=\"sorting sorting_asc rowPart\">"

                                    if (Obj.Groups[i].Rows[0].Cols[r].QuestionText != "") {
                                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionText;
                                    }
                                    if (Obj.Groups[i].Rows[0].Cols[r].Answers.length == 0) {
                                        Obj.Groups[i].Rows[0].Cols[r].Answers.push({ "index": 1, "value": 0, "lastUpdate": "" });
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                    }
                                    TampleteStr += "<input type=\"date\" onchange=\"changeTableJsonData(event)\" class=\"form-control mb-3\"name=\"";
                                    TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionID + "\"";
                                    if (Obj.Groups[i].Rows[0].Cols[r].Answers[0].value != 0) {
                                        let v = new Date(Obj.Groups[i].Rows[0].Cols[r].Answers[0].value);
                                        console.log("v" + v);
                                        if (v > 0) {
                                            v = v.Format("yyyy-MM-dd");
                                        }
                                        TampleteStr += "value=\"" + v + "\"";
                                    }
                                    TampleteStr += ">";
                                    TampleteStr += "</th>";

                                    break;
                                case "radio":
                                    TampleteStr += "<th class=\"sorting sorting_asc rowPart\">"
                                    if (Obj.Groups[i].Rows[0].Cols[r].QuestionText != "") {
                                        if (Obj.Groups[i].Rows[0].Cols[r].QuestionText.includes("##^")) {
                                            TampleteStr += checkTableIsFilling(Obj, i, rowSn, r);
                                        } else {
                                            TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionText;
                                        }
                                    }
                                    for (var o = 0; o < Obj.Groups[i].Rows[0].Cols[r].AnswerOptions.length; o++) {
                                        if (Obj.Groups[i].Rows[0].Cols[r].AnswerOptions.length > Obj.Groups[i].Rows[0].Cols[r].Answers.length) {
                                            Obj.Groups[i].Rows[0].Cols[r].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "" });
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                        }
                                        TampleteStr += "<div class=\"form-check\">"
                                        TampleteStr += "<input type=\"radio\" onclick=\"CleanOthers(event)\" onchange=\"changeTableJsonData(event)\" class=\" mr-1\"name=\"";
                                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionID + "\"";
                                        TampleteStr += "value=\"";
                                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].index;
                                        TampleteStr += "\"id=\"";
                                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].AnsText;
                                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].index + w;
                                        TampleteStr += "\"";
                                       
                                        if (Obj.Groups[i].Rows[0].Cols[r].Answers.length > 0) {
                                            if (Obj.Groups[i].Rows[0].Cols[r].Answers[o].value == true) {
                                                TampleteStr += "checked";
                                            }
                                        }
                                        TampleteStr += ">";
                                        TampleteStr += "<label for=\"";
                                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].AnsText;
                                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].index + w;
                                        TampleteStr += "\"class=\"\">" + Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].AnsText + "</label>";
                                        TampleteStr += "</div>";
                                    }
                                    if (Obj.Groups[i].Rows[0].Cols[r].hasOtherAnswers) {
                                        if (Obj.Groups[i].Rows[0].Cols[r].otherAnswer.length == 0) {
                                            Obj.Groups[i].Rows[0].Cols[r].otherAnswer.push({ "index": 1, "value": null, "lastUpdate": "" });
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                        }
                                        TampleteStr += "<div class=\"form-check\">"
                                        TampleteStr += "<input class=\"otherAns\" type=\"radio\" onclick=\"CleanOthers(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionID;
                                        TampleteStr += "\"";
                                        if (Obj.Groups[i].Rows[0].Cols[r].otherAnswer.length > 0) {
                                            if (Obj.Groups[i].Rows[0].Cols[r].otherAnswer[0].value != null) {
                                                TampleteStr += "checked";
                                            }
                                        }
                                        TampleteStr += ">";
                                        TampleteStr += "<label >其他</label>";
                                        TampleteStr += "<input type=\"text\"onchange=\"changeTableJsonData(event)\" disabled class=\"other form-control-border form-control form-control-sm mb-3\"name=\"";
                                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionID + "\"";
                                        if (Obj.Groups[i].Rows[0].Cols[r].otherAnswer.length > 0) {
                                            if (Obj.Groups[i].Rows[0].Cols[r].otherAnswer[0].value != null) {
                                                TampleteStr += "value=\"" + Obj.Groups[i].Rows[0].Cols[r].otherAnswer[0].value + "\"";
                                            }
                                        }
                                        TampleteStr += ">";

                                        TampleteStr += "</div>";

                                    }
                                    TampleteStr += "</th>";
                                    break;
                                case "checkbox":
                                    TampleteStr += "<th class=\"sorting sorting_asc rowPart\">";
                                    if (Obj.Groups[i].Rows[0].Cols[r].QuestionText != "") {
                                        if (Obj.Groups[i].Rows[0].Cols[r].QuestionText.includes("##^")) {
                                            TampleteStr += checkTableIsFilling(Obj, i, rowSn, r);
                                        } else {
                                            TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionText;
                                        }
                                    }
                                    for (var o = 0; o < Obj.Groups[i].Rows[0].Cols[r].AnswerOptions.length; o++) {
                                        if (Obj.Groups[i].Rows[0].Cols[r].AnswerOptions.length > Obj.Groups[i].Rows[0].Cols[r].Answers.length) {
                                            Obj.Groups[i].Rows[0].Cols[r].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "" });
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                        }
                                        TampleteStr += "<div class=\"form-check\">"
                                        TampleteStr += "<input type=\"checkbox\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionID + "\"";
                                        TampleteStr += "value=\"";
                                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].index;
                                        TampleteStr += "\"id=\"";
                                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].AnsText;
                                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].index;
                                        TampleteStr += "\"";
                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                                            if (Obj.Groups[i].Rows[0].Cols[r].Answers[o].value == true) {
                                                TampleteStr += "checked";
                                            }
                                        }
                                        TampleteStr += ">";
                                        TampleteStr += "<label for=\"";
                                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].AnsText;
                                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].index;
                                        TampleteStr += "\"class=\"\">" + Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].AnsText + "</label>"
                                        TampleteStr += "</div>";
                                    }
                                    TampleteStr += "</th>";
                                    break;
                                case "CheckboxMixImage":
                                    let hasFillings = false;
                                    for (var o = 0; o < Obj.Groups[i].Rows[0].Cols[r].AnswerOptions.length; o++) {
                                        if (Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].AnsText.includes("##^")) {
                                            hasFillings = true;
                                            break;
                                        }
                                    }
                                    TampleteStr += "<th class=\"sorting sorting_asc rowPart\">";
                                    if (Obj.Groups[i].Rows[0].Cols[r].QuestionText != "") {
                                        if (Obj.Groups[i].Rows[0].Cols[r].QuestionText.includes("##^")) {
                                            TampleteStr += checkTableIsFilling(Obj, i, rowSn, r);
                                        } else {
                                            TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionText;
                                        }
                                    }
                                    for (var o = 0; o < Obj.Groups[i].Rows[0].Cols[r].AnswerOptions.length; o++) {//checkbox
                                        if (Obj.Groups[i].Rows[0].Cols[r].AnswerOptions.length > Obj.Groups[i].Rows[0].Cols[r].Answers.length) {
                                            Obj.Groups[i].Rows[0].Cols[r].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "","fillings":[]});
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                        }
                                        TampleteStr += "<div class=\"form-check\">";
                                        TampleteStr += "<input type=\"checkbox\" onchange=\"changeTableJsonData(event)\" onclick=\"DisabledTrue(event)\" class=\" mr-1\"name=\"";
                                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionID + "\"";
                                        TampleteStr += "value=\"";
                                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].index;
                                        TampleteStr += "\"id=\"";
                                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].AnsText;
                                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].index;
                                        TampleteStr += "\"";
                                        let IsDisabled = "disabled";
                                        if (Obj.Groups[i].Rows[0].Cols[r].Answers.length > 0) {
                                            if (Obj.Groups[i].Rows[0].Cols[r].Answers[o].value == true) {
                                                TampleteStr += "checked";
                                                IsDisabled = " ";
                                            }
                                        }
                                        TampleteStr += ">";
                                        if (hasFillings) {//has filllings
                                            let fillingStr = Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].AnsText;
                                            let fSn = 1;
                                            let n = 0;
                                            let StrArr = fillingStr.split("##");
                                            for (var s = 0; s < StrArr.length; s++) {
                                                if (StrArr[s].includes("^")) {
                                                    if (fSn > Obj.Groups[i].Rows[0].Cols[r].Answers[o].fillings.length) {
                                                        Obj.Groups[i].Rows[0].Cols[r].Answers[o].fillings.push({ "index": fSn, "value": "", "lastUpdate": "" });
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                    }
                                                    TampleteStr += "<input type=\"text\"  style=\"max-width:100px\" onchange=\"changeTableJsonData(event)\"  class=\"form-control form-control-border form-control-sm d-inline ml-1 mr-1 mb-2\"name=\"";
                                                    TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionID + "\"";
                                                    TampleteStr += "data-checkboxIndex=\"" + Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].index + "\"";
                                                    TampleteStr += "data-TextIndex=\"" + fSn + "\"";
                                                    if (Obj.Groups[i].Rows[0].Cols[r].Answers[o].fillings.length > 0) {
                                                        TampleteStr += "value=\"" + Obj.Groups[i].Rows[0].Cols[r].Answers[o].fillings[n].value + "\"";
                                                    }
                                                    TampleteStr += ">";
                                                    TampleteStr += IsDisabled;
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

                                            //img
                                            TampleteStr += "<img style =\"height:50px\"src=\"ShowAdminImg?id=" + Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].image + "\"" + "/>";
                                        } else {//dose hasn't filllings
                                            TampleteStr += "<label for=\"";
                                            TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].AnsText;
                                            TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].index;
                                            TampleteStr += "\"class=\"mb-5\">" + Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].AnsText + "</label>";
                                            TampleteStr += "<img style =\"height:50px\"src=\"ShowAdminImg?id=" + Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].image + "\"" + "/>";
                                        }

                                        TampleteStr += "</div>";
                                    }

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
                                        if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                                            if (Obj.Groups[i].Rows[w].Cols[c].QuestionText.includes("##^")) {
                                                TampleteStr += checkTableIsFilling(Obj, i, w, c);
                                            } else {
                                                TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                                            }
                                        }
                                        TampleteStr += "<input type=\"text\"onchange=\"changeTableJsonData(event)\" class=\"form-control mb-3\"name=\"";
                                        TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                       
                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                                            TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value + "\"";
                                        }
                                        TampleteStr += ">";
                                        break;
                                    case "memo":
                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length == 0) {
                                            Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": 1, "value": "", "lastUpdate": "" });
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                        }
                                        if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                                            if (Obj.Groups[i].Rows[w].Cols[c].QuestionText.includes("##^")) {
                                                TampleteStr += checkTableIsFilling(Obj, i, w, c);
                                            } else {
                                                TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                                            }
                                        }
                                        TampleteStr += "<textarea onchange=\"changeTableJsonData(event)\" class=\"form-control mb-3\"name=\"";
                                        TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                        TampleteStr += ">";
                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].Answers[0].value ;
                                        }
                                        TampleteStr += "</textarea>";
                                        break;
                                    case "number":
                                        if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                                            if (Obj.Groups[i].Rows[w].Cols[c].QuestionText.includes("##^")) {
                                                TampleteStr += checkTableIsFilling(Obj, i, w, c);
                                            } else {
                                                TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                                            }
                                        }
                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length == 0) {
                                            Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": 1, "value": "", "lastUpdate": "","fillings":[]});
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
                                    case "date":
                                        if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                                            if (Obj.Groups[i].Rows[w].Cols[c].QuestionText.includes("##^")) {
                                                TampleteStr += checkTableIsFilling(Obj, i, w, c);
                                            } else {
                                                TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                                            }
                                        }
                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length == 0) {
                                            Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": 1, "value": 0, "lastUpdate": "","fillings": [] });
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                        }
                                        TampleteStr += "<input type=\"date\" onchange=\"changeTableJsonData(event)\" class=\"form-control mb-3\"name=\"";
                                        TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers[0].value != 0) {
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
                                        let isRadioMixFilling = false;
                                        for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++) {
                                            if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText.includes("##^")) {
                                                isRadioMixFilling = true;
                                                break;
                                            }
                                        }
                                        if (isRadioMixFilling) {
                                            //RadioMixFilling
                                            if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                                                if (Obj.Groups[i].Rows[w].Cols[c].QuestionText.includes("##^")) {
                                                    TampleteStr += checkTableIsFilling(Obj,i,w,c);
                                                } else {
                                                    TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                                                }
                                            }
                                            for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers.length) {
                                                    Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "", "fillings": []});
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                }
                                                TampleteStr += "<div class=\"form-check mt-2\">"
                                                TampleteStr += "<input type=\"radio\" onclick=\"CleanOthers(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                TampleteStr += "value=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                                                TampleteStr += "\"id=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                                                TampleteStr += "\"";
                                                let isdisabled = "  disabled ";
                                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].value == true) {
                                                    TampleteStr += "checked";
                                                    isdisabled = " ";
                                                }
                                                TampleteStr += ">";
                                                let fillingStr = Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                                                let StrArr = fillingStr.split("##");
                                                let fSn = 1;
                                                let n = 0;
                                                for (var s = 0; s < StrArr.length; s++) {
                                                    if (StrArr[s].includes("^")) {
                                                        if (fSn > Obj.Groups[i].Rows[w].Cols[c].Answers[o].fillings.length) {
                                                            Obj.Groups[i].Rows[w].Cols[c].Answers[o].fillings.push({ "index": fSn, "value": "", "lastUpdate": "" });
                                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                        }
                                                        TampleteStr += "<input type=\"text\" onchange=\"changeTableJsonData(event)\"  style=\"max-width:100px\" class=\"form-control-border form-control form-control-sm ml-1 mr-1 d-inline mb-2\"name=\"";//data-gidandrow
                                                        TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                        TampleteStr += isdisabled;
                                                        TampleteStr += "data-RadioIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index + "\"";
                                                        TampleteStr += "data-TextIndex=\"" + fSn + "\"";
                                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].fillings.length > 0) {
                                                            TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].Answers[o].fillings[n].value + "\"";
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
                                            if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length == 0) {
                                                    Obj.Groups[i].Rows[w].Cols[c].otherAnswer.push({ "index": 1, "value": false, "lastUpdate": "", "fillings": [{ "index": 1, "value": false, "lastUpdate": ""}] });
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                }
                                                TampleteStr += "<div class=\"form-check d-flex mt-2\">"
                                                TampleteStr += "<input class=\"otherAns\" type=\"radio\" onclick=\"CleanOthers(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                                                TampleteStr += "\"";
                                                let otherDisabled = "disabled";
                                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                                                    if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value) {
                                                        TampleteStr += "checked";
                                                        otherDisabled = " ";
                                                    }
                                                }
                                                TampleteStr += ">";
                                                TampleteStr += "<label class=\"pt-2 pl-1 pr-1\">其他</label>";
                                                TampleteStr += "<input style=\"max-width:100px\" type=\"text\"onchange=\"changeTableJsonData(event)\" class=\"other form-control-border d-inline form-control form-control-sm mb-3\"name=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                                                    if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value) {
                                                        TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].fillings[0].value + "\"";
                                                    }
                                                }
                                                TampleteStr += otherDisabled;
                                                TampleteStr += ">";
                                                TampleteStr += "</div>";
                                            }

                                        } else {
                                            if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                                                if (Obj.Groups[i].Rows[w].Cols[c].QuestionText.includes("##^")) {
                                                    TampleteStr += checkTableIsFilling(Obj, i, w, c);
                                                } else {
                                                    TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                                                }
                                            }
                                            for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers.length) {
                                                    Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "", "fillings": [{ "index": 1, "value": false, "lastUpdate": "" }] });
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                }
                                                TampleteStr += "<div class=\"form-check\">"
                                                TampleteStr += "<input type=\"radio\" onclick=\"CleanOthers(event)\" onchange=\"changeTableJsonData(event)\" class=\" mr-1\"name=\"";
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
                                            if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length == 0) {
                                                    Obj.Groups[i].Rows[w].Cols[c].otherAnswer.push({ "index": 1, "value": false, "lastUpdate": "", "fillings": [{ "index": 1, "value": false, "lastUpdate": "" }]});
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                }
                                                TampleteStr += "<div class=\"form-check d-flex mt-1\">"
                                                TampleteStr += "<input class=\"otherAns\" type=\"radio\" onclick=\"CleanOthers(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                                                TampleteStr += "\"";
                                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                                                    if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value) {
                                                        TampleteStr += "checked";
                                                    }
                                                }
                                                TampleteStr += ">";
                                                TampleteStr += "<label class=\"pt-2 pl-1 mr-1\">其他</label>";
                                                TampleteStr += "<input style=\"max-width:100px\" type=\"text\"onchange=\"changeTableJsonData(event)\" disabled class=\"other form-control-border d-inline form-control form-control-sm mb-3\"name=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                                                    if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value) {
                                                        TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].fillings[0].value + "\"";
                                                    }
                                                }
                                                TampleteStr += ">";

                                                TampleteStr += "</div>";
                                            }

                                        }

                                        break;
                                    case "checkbox":
                                        let isCheckboxMixFillings = false;
                                        for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++) {
                                            if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText.includes("##^")) {
                                                isCheckboxMixFillings = true;
                                                break;
                                            }
                                        }
                                        if (isCheckboxMixFillings) {
                                            //CheckboxMixFilling
                                            if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                                                if (Obj.Groups[i].Rows[w].Cols[c].QuestionText.includes("##^")) {
                                                    TampleteStr += checkTableIsFilling(Obj, i, w, c);
                                                } else {
                                                    TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                                                }
                                            }
                                            for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers.length) {
                                                    Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "", "fillings": [] });
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                }
                                                TampleteStr += "<div class=\"form-check mt-2\">"
                                                TampleteStr += "<input type=\"checkbox\"onchange=\"changeTableJsonData(event)\" onclick=\"DisabledTrue(event)\" class=\" mr-1\"name=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                TampleteStr += "value=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                                                TampleteStr += "\"id=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                                                TampleteStr += "\"";
                                                let isDisabled = " disabled";
                                                if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                                                    if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].value) {
                                                        TampleteStr += "checked";
                                                        isDisabled = " ";
                                                    }
                                                }
                                                TampleteStr += ">";
                                                let fillingStr = Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                                                let fSn = 1;
                                                let n = 0;
                                                let StrArr = fillingStr.split("##");
                                                for (var s = 0; s < StrArr.length; s++) {
                                                    if (StrArr[s].includes("^")) {
                                                        if (fSn > Obj.Groups[i].Rows[w].Cols[c].Answers[o].fillings.length) {
                                                            Obj.Groups[i].Rows[w].Cols[c].Answers[o].fillings.push({ "index": fSn, "value": "", "lastUpdate": "" });
                                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                        }
                                                        TampleteStr += "<input type=\"text\" style=\"max-width:100px\" onchange=\"changeTableJsonData(event)\"  class=\"form-control form-control-border form-control-sm d-inline ml-1 mr-1 mb-2\"name=\"";
                                                        TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                        TampleteStr += "data-checkboxIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index + "\"";
                                                        TampleteStr += "data-TextIndex=\"" + fSn + "\"";
                                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].fillings.length > 0) {
                                                            TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].Answers[o].fillings[n].value + "\"";
                                                        }
                                                        TampleteStr += isDisabled;
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
                                            if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length == 0) {
                                                    Obj.Groups[i].Rows[w].Cols[c].otherAnswer.push({ "index": 1, "value": false, "lastUpdate": "", "fillings": [{ "index": 1, "value": "", "lastUpdate": "" }] });
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                }
                                                TampleteStr += "<div class=\"form-check d-flex  mt-2\">"
                                                TampleteStr += "<input class=\"otherAns\" type=\"checkbox\" onclick=\"DisabledTrue(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                                                TampleteStr += "\"";
                                                let isDisabled = "disabled";
                                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                                                    if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value) {
                                                        TampleteStr += "checked";
                                                        isDisabled = " ";
                                                    }
                                                }
                                                TampleteStr += ">";
                                                TampleteStr += "<label class=\"pt-2 pl-1 pr-1\">其他</label>";
                                                TampleteStr += "<input style=\"max-width:100px\" type=\"text\"onchange=\"changeTableJsonData(event)\"  class=\"other form-control-border d-inline form-control form-control-sm mb-3\"name=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                                                    if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != null) {
                                                        TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].fillings[0].value + "\"";
                                                        TampleteStr += isDisabled;
                                                    }
                                                }
                                                TampleteStr += ">";

                                                TampleteStr += "</div>";
                                            }

                                        } else {
                                            if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                                                if (Obj.Groups[i].Rows[w].Cols[c].QuestionText.includes("##^")) {
                                                    TampleteStr += checkTableIsFilling(Obj, i, w, c);
                                                } else {
                                                    TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                                                }
                                            }
                                            for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers.length) {
                                                    Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "" });
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                }
                                                TampleteStr += "<div class=\"form-check\">"
                                                TampleteStr += "<input type=\"checkbox\" onchange=\"changeTableJsonData(event)\" onclick=\"DisabledTrue(event)\" class=\" mr-1\"name=\"";
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

                                            if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers == true) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length == 0) {
                                                    Obj.Groups[i].Rows[w].Cols[c].otherAnswer.push({ "index": 1, "value": null, "lastUpdate": "" });
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                }
                                                TampleteStr += "<div class=\"form-check d-flex mt-1\">"
                                                TampleteStr += "<input class=\"otherAns\" type=\"checkbox\" onclick=\"DisabledTrue(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                                                TampleteStr += "\"";
                                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                                                    if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value) {
                                                        TampleteStr += "checked";
                                                    }
                                                }
                                                TampleteStr += ">";
                                                TampleteStr += "<label class=\"pt-2 pl-1 pr-1\">其他</label>";
                                                TampleteStr += "<input style=\"max-width:100px\" type=\"text\"onchange=\"changeTableJsonData(event)\" disabled class=\"other form-control-border d-inline form-control form-control-sm mb-3\"name=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                                                    if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value) {
                                                        TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].fillings[0].value + "\"";
                                                    }
                                                }
                                                TampleteStr += ">";

                                                TampleteStr += "</div>";
                                            }

                                        }
                                        break;
                                    case "CheckboxMixImage":
                                        let hasTxt = false;
                                        for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++)  {
                                            if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText.includes("##^")) {
                                                hasTxt = true;
                                                break;
                                            }
                                        }
                                        if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                                            if (Obj.Groups[i].Rows[w].Cols[c].QuestionText.includes("##^")) {
                                                TampleteStr += checkTableIsFilling(Obj, i, w, c);
                                            } else {
                                                TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                                            }
                                        }
                                        for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++) {//checkbox
                                            if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers.length) {
                                                Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "" ,"fillings":[]});
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                            }
                                            TampleteStr += "<div class=\"form-check\">";
                                            TampleteStr += "<input type=\"checkbox\" onchange=\"changeTableJsonData(event)\" onclick=\"DisabledTrue(event)\" class=\" mr-1\"name=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                            TampleteStr += "value=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                                            TampleteStr += "\"id=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                                            TampleteStr += "\"";
                                            let isdisabled = "disabled";
                                            if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].value == true) {
                                                    TampleteStr += "checked";
                                                    isdisabled = " ";
                                                }
                                            }
                                            TampleteStr += ">";
                                            if (hasTxt) {
                                                let fillingStr = Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                                                let fSn = 1;
                                                let n = 0;
                                                let StrArr = fillingStr.split("##");
                                                for (var s = 0; s < StrArr.length; s++) {
                                                    if (StrArr[s].includes("^")) {
                                                        if (fSn > Obj.Groups[i].Rows[w].Cols[c].Answers[o].fillings.length) {
                                                            Obj.Groups[i].Rows[w].Cols[c].Answers[o].fillings.push({ "index": fSn, "value": "", "lastUpdate": "" });
                                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                        }
                                                        TampleteStr += "<input type=\"text\" style=\"max-width:100px\" onchange=\"changeTableJsonData(event)\"  class=\"form-control form-control-border form-control-sm d-inline ml-1 mr-1 mb-2\"name=\"";
                                                        TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                        TampleteStr += "data-checkboxIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index + "\"";
                                                        TampleteStr += "data-TextIndex=\"" + fSn + "\"";
                                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].fillings.length > 0) {
                                                            TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].Answers[o].fillings[n].value + "\"";
                                                        }
                                                        TampleteStr += isdisabled;
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

                                                //img
                                                TampleteStr += "<img style =\"height:50px\"src=\"ShowAdminImg?id=" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].image + "\"" + "/>";
                                            } else {
                                                TampleteStr += "<label for=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                                                TampleteStr += "\"class=\"mb-5\">" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText + "</label>";
                                                //img
                                                TampleteStr += "<img style =\"height:50px\"src=\"ShowAdminImg?id=" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].image + "\"" + "/>";
                                            }
                                            TampleteStr += "</div>";
                                        }
                                        if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers ) {
                                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length == 0) {
                                                Obj.Groups[i].Rows[w].Cols[c].otherAnswer.push({ "index": 1, "value": false, "lastUpdate": "", "fillings": [{ "index": 1, "value": "", "lastUpdate": "" }] });
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                            }
                                            TampleteStr += "<div class=\"form-check d-flex mt-1\">"
                                            TampleteStr += "<input class=\"otherAns\" type=\"checkbox\" onclick=\"DisabledTrue(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                                            TampleteStr += "\"";
                                            let isdisabled = "disabled";
                                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value ) {
                                                    TampleteStr += "checked";
                                                    isdisabled = " ";
                                                }
                                            }
                                            TampleteStr += ">";
                                            TampleteStr += "<label class=\"pt-2 pl-1 mr-1\">其他</label>";
                                            TampleteStr += "<input style=\"max-width:100px\" type=\"text\"onchange=\"changeTableJsonData(event)\" class=\"other form-control-border d-inline form-control form-control-sm mb-3\"name=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value) {
                                                    TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].fillings[0].value + "\"";
                                                }
                                            }
                                            TampleteStr += isdisabled;
                                            TampleteStr += ">";

                                            TampleteStr += "</div>";
                                        }
                                        break;
                                    case "sign":
                                        if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                                            if (Obj.Groups[i].Rows[w].Cols[c].QuestionText.includes("##^")) {
                                                TampleteStr += checkTableIsFilling(Obj, i, w, c);
                                            } else {
                                                TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                                            }
                                        }
                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length == 0) {
                                            Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": 1, "value":0, "lastUpdate": "" });
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                        }
                                        let signImgID = document.getElementById("mainPlaceHolder_adminSign").value;
                                        let time = new Date();
                                        let today = time.Format("yyyy-MM-dd");

                                        if (Number(Obj.Groups[i].Rows[w].Cols[c].Answers[0].value) > 0) {
                                            TampleteStr += "<div class=\"col-12 pt-2 tableSign\">";
                                            if (signImgID == Obj.Groups[i].Rows[w].Cols[c].Answers[0].value) {
                                                TampleteStr += "<div data-Staut=\"Edit\" style=\"font-size:10px\" data-GidandRow=\"GID\" onchange=\"changeTableJsonData(event)\" onclick=\"SignByAdminId(event)\" class=\"btn btn-primary Signbtn ml-2 rowPart\" >";//
                                                TampleteStr += "取消簽核";
                                                TampleteStr += "</div>";
                                            }
                                            TampleteStr += "<div class=\"mt-5 d-inline\">";//SignImageBox
                                            TampleteStr += "<img style=\"width:100px \" src=\"";//img
                                            TampleteStr += "ShowAdminImg?id=" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value + "\"";
                                            TampleteStr += "id=\"sign" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value + "\"";
                                            TampleteStr += "class=\"" + Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                                            if (Obj.Groups[i].Rows[w].Cols[c].rotate == true) {
                                                TampleteStr +=" "+"signRotated mt-5 mb-3 ml_1";
                                            }
                                            TampleteStr += "\"name=\"" + Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                                            TampleteStr += "\">";//img
                                            TampleteStr += "<span  name=\"" + Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                                            if (Obj.Groups[i].Rows[w].Cols[c].rotate == true) {
                                                TampleteStr += "\" class=\"d-flex justify-content-start signDate mt-3\">";
                                            } else {
                                                TampleteStr += "\" class=\"signDate mt-3\">";//d-flex justify-content-end 
                                            }
                                            time = new Date(Obj.Groups[i].Rows[w].Cols[c].Answers[0].lastUpdate);
                                            TampleteStr += time.Format("yyyy-MM-dd");
                                            TampleteStr += "</span>";
                                            TampleteStr += "</div>";//SignImageBox
                                            TampleteStr += "</div>";
                                        } else {
                                            TampleteStr += "<div class=\"col-12 pt-2 tableSign\">";
                                            TampleteStr += "<div data-Staut=\"Edit\" style=\"font-size:10px\" data-GidandRow=\"GID\" onchange=\"changeTableJsonData(event)\" onclick=\"SignByAdminId(event)\" class=\"btn btn-primary Signbtn ml-2 rowPart\" >";//
                                            TampleteStr += "簽核";
                                            TampleteStr += "</div>";
                                            TampleteStr += "<div class=\"mt-5 d-none\">";//SignImageBox
                                            TampleteStr += "<img style=\"width:100px \" src=\"";//img
                                            TampleteStr += "ShowAdminImg.aspx?id=" + signImgID + "\"";
                                            TampleteStr += "id=\"sign" + signImgID + "\"";
                                            TampleteStr += "class=\"" + Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                                            TampleteStr += "\"name=\"" + Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                                            TampleteStr += "\">";//img
                                            TampleteStr += "<span  name=\"" + Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                                            TampleteStr += "\" class=\" signDate mt-3\">";//d-flex justify-content-end
                                            TampleteStr += today;
                                            TampleteStr += "</span>";
                                            TampleteStr += "</div>";//SignImageBox
                                            TampleteStr += "</div>";
                                        }

                                        break;
                                    case "display":
                                        if (Obj.Groups[i].Rows[w].Cols[c].QuestionText.includes("##^")) {
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

                                        } else {
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionText;
                                        }
                                        break;
                                    case "file"://要可以下載檔案
                                        if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                                            if (Obj.Groups[i].Rows[w].Cols[c].QuestionText.includes("##^")) {
                                                TampleteStr += checkTableIsFilling(Obj, i, w, c);
                                            } else {
                                                TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                                            }
                                        }
                                        TampleteStr += "<span class=\"mb-3 btn btn-default btn-file\"><i class=\"fas fa-paperclip\"></i>";
                                        TampleteStr += "<input  onchange=\"changeTableJsonData(event)\" type=\"file\" class=\"Upload form-control mb-3\"name=\"";
                                        TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\">";
                                        TampleteStr += "上傳檔案";
                                        TampleteStr += "</span>";
                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                                            TampleteStr += "</br>";
                                            TampleteStr += "<span class=\"ml-3\">" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value + "</span>"
                                            TampleteStr += "<a class=\"download btn btn-default btn-sm ml-3\" href=\"Upload" + "/" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value + "\">";
                                            TampleteStr += "<i class=\"fas fa-cloud-download-alt\"></i>";
                                            TampleteStr += "</a>";
                                        }
                                        break;
                                    case "RadioMixCheckbox":
                                        //radio part
                                        if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                                            if (Obj.Groups[i].Rows[w].Cols[c].QuestionText.includes("##^")) {
                                                TampleteStr += checkTableIsFilling(Obj, i, w, c);
                                            } else {
                                                TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                                            }
                                        }
                                        let isRadioMixFillings = false;
                                        let isCheckboxMixfillings = false;
                                        let radioCkbDisabled = "disabled";
                                        
                                        for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++) {
                                            if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText.includes("##^")) {
                                                isRadioMixFillings = true;
                                                break;
                                            }
                                        }
                                        for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++) {
                                            TampleteStr += "<div class=\"form-check\">";//包一組選項radio and checkbox 
                                            if (isRadioMixFillings) {// radio has fillings
                                                if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers.length) {
                                                    Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "", "fillings": [], "Answers": [] });
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                }
                                                //radio part
                                                /*TampleteStr += "<div class=\"form-check mt-2\">"*/
                                                TampleteStr += "<input type=\"radio\" onclick=\"swich(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                TampleteStr += "value=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                                                TampleteStr += "\"id=\"";
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                                                TampleteStr += "\"";
                                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].value == true) {
                                                    TampleteStr += "checked";
                                                    radioCkbDisabled = " ";
                                                } else {
                                                    radioCkbDisabled = "disabled";
                                                }
                                                TampleteStr += ">";

                                                //fillings part
                                                let fillingStr = Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                                                let StrArr = fillingStr.split("##");
                                                let fSn = 1;
                                                let n = 0;
                                                for (var s = 0; s < StrArr.length; s++) {
                                                    if (StrArr[s].includes("^")) {
                                                        if (fSn > Obj.Groups[i].Rows[w].Cols[c].Answers[o].fillings.length) {
                                                            Obj.Groups[i].Rows[w].Cols[c].Answers[o].fillings.push({ "index": fSn, "value": "", "lastUpdate": "" });
                                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                        }
                                                        TampleteStr += "<input type=\"text\" onchange=\"changeTableJsonData(event)\" style=\"max-width:100px\" class=\"form-control-border form-control form-control-sm ml-1 mr-1 d-inline mb-2\"name=\"";//data-gidandrow
                                                        TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                        TampleteStr += "data-RadioIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index + "\"";
                                                        TampleteStr += "data-TextIndex=\"" + fSn + "\"";
                                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].fillings.length > 0) {
                                                            TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].Answers[o].fillings[n].value + "\"";
                                                        }
                                                        TampleteStr += radioCkbDisabled;
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
                                                //fillings part
                                                //radio part
                                            } else {//radio hasn't fillings
                                                if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers.length) {
                                                    Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "","fillings":[],"Answers": [] });
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                }
                                                TampleteStr += "<div class=\"form-check\">"
                                                TampleteStr += "<input type=\"radio\" onchange=\"changeTableJsonData(event)\" onclick=\"CleanOption(event)\" class=\" mr-1\"name=\"";
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
                                                        radioCkbDisabled = " ";
                                                    }
                                                }

                                                TampleteStr += ">";
                                                TampleteStr += "<span class=\"mr-2\" style=\"font-weight:bold \">" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText + "</span>";

                                            }
                                            for (var k = 0; k < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions.length; k++) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].AnsText.includes("##^")) {
                                                    isCheckboxMixfillings = true;
                                                    break;
                                                }
                                            }
                                            if (isCheckboxMixfillings) {//checkbox has fillings
                                                for (var k = 0; k < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions.length; k++) {
                                                    if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.length) {
                                                        Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.push({ "index": k + 1, "value": false, "lastUpdate": "","fillings":[]});
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                    }
                                                    //checkbox part
                                                    TampleteStr += "</br><input onchange=\"changeTableJsonData(event)\"onclick=\"swichDisabledTrue(event)\" type=\"checkbox\" class=\"ml-2 mr-1\"name=\"";
                                                    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                    TampleteStr += "value=\"";
                                                    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index;
                                                    TampleteStr += "\"id=\"";
                                                    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].AnsText;
                                                    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index;
                                                    TampleteStr += "\"";
                                                    TampleteStr += "data-RadioIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index + "\"";
                                                    TampleteStr += "data-CheckboxIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index + "\"";
                                                    TampleteStr += radioCkbDisabled;//checkbox
                                                    let ckbFillDisabled = "disabled";
                                                    if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.length > 0) {
                                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers[k].value) {
                                                            TampleteStr += "checked";
                                                            ckbFillDisabled = " ";
                                                        }
                                                    }
                                                    TampleteStr += radioCkbDisabled;
                                                    TampleteStr += ">";
                                                    //fillings part
                                                   
                                                    let fillingStr = Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].AnsText;
                                                    let fSn = 1;
                                                    let n = 0;
                                                    let StrArr = fillingStr.split("##");
                                                    for (var s = 0; s < StrArr.length; s++) {
                                                        if (StrArr[s].includes("^")) {
                                                            
                                                            if (fSn > Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers[k].fillings.length) {
                                                                Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers[k].fillings.push({ "index": fSn, "value": "", "lastUpdate": "" });
                                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                            }
                                                            TampleteStr += "<input type=\"text\"  style=\"max-width:100px\" onchange=\"changeTableJsonData(event)\"  class=\"form-control form-control-border form-control-sm d-inline ml-1 mr-1 mb-2\"name=\"";
                                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                            TampleteStr += "data-checkboxIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index + "\"";
                                                            TampleteStr += "data-radioindex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index+ "\"";
                                                            TampleteStr += "data-TextIndex=\"" + fSn + "\"";
                                                            if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers[k].fillings.length > 0) {
                                                                TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers[k].fillings[n].value + "\"";
                                                            }
                                                            TampleteStr += ckbFillDisabled;
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
                                                   /* TampleteStr += "</div>";*/

                                                    //
                                                //    TampleteStr += "<label for=\"";
                                                //    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].AnsText;
                                                //    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index;
                                                //    TampleteStr += "\"class=\"mr-2\">" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].AnsText + "</label>";
                                                }

                                            } else {
                                                //checkbox part
                                                for (var k = 0; k < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions.length; k++) {
                                                    if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.length) {
                                                        Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.push({ "index": k + 1, "value": false, "lastUpdate": "" });
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                    }
                                                    TampleteStr += "</br><input onchange=\"changeTableJsonData(event)\" type=\"checkbox\" class=\"mr-1\"name=\"";
                                                    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                    TampleteStr += "value=\"";
                                                    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index;
                                                    TampleteStr += "\"id=\"";
                                                    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].AnsText;
                                                    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index;
                                                    TampleteStr += "\"";
                                                    TampleteStr += "data-RadioIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index + "\"";
                                                    TampleteStr += "data-CheckboxIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index + "\"";

                                                    if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.length > 0) {
                                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers[k].value == true) {
                                                            TampleteStr += "checked";
                                                            TampleteStr += radioCkbDisabled;
                                                        }
                                                    }
                                                    TampleteStr += ">";
                                                    TampleteStr += "<label for=\"";
                                                    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].AnsText;
                                                    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index;
                                                    TampleteStr += "\"class=\"mr-2\">" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].AnsText + "</label>";
                                                }

                                            }
                                            TampleteStr += "</div>";//包一組選項radio and checkbox 
                                        }
                                        if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers) {
                                            
                                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length == 0) {
                                                Obj.Groups[i].Rows[w].Cols[c].otherAnswer.push({ "index": 1, "value": false, "lastUpdate": "", "fillings": [{ "index": 1, "value": "", "lastUpdate": "" }] });
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                            }
                                            TampleteStr += "<div class=\"form-check d-flex mt-1\">"
                                            TampleteStr += "<input class=\"otherAns\" type=\"radio\" onclick=\"CleanOthers(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                                            TampleteStr += "\"";
                                            let isDisabled = "disabled";
                                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value) {
                                                    TampleteStr += "checked";
                                                    isDisabled = "";
                                                }
                                            }
                                            TampleteStr += ">";
                                            TampleteStr += "<label class=\"pt-2 pl-1 pr-1\">其他</label>";
                                            TampleteStr += "<input style=\"max-width:100px\" type=\"text\"onchange=\"changeTableJsonData(event)\"  class=\"other form-control-border d-inline form-control form-control-sm mb-3\"name=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value) {
                                                    TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].fillings[0].value + "\"";
                                                    
                                                }
                                            }
                                            TampleteStr += isDisabled;
                                            TampleteStr += ">";

                                            TampleteStr += "</div>";
                                        }

                                        break;
                                    case "CheckboxMixRadio":
                                        //radio part
                                        if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                                            if (Obj.Groups[i].Rows[w].Cols[c].QuestionText.includes("##^")) {
                                                TampleteStr += checkTableIsFilling(Obj, i, w, c);
                                            } else {
                                                TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                                            }
                                        }
                                        let IsRadioMixFillings = false;
                                        let IsCheckboxMixfillings = false;
                                        for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++) {
                                            if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText.includes("##^")) {
                                                IsCheckboxMixfillings = true;
                                                break;
                                            }
                                        }
                                        for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++) {
                                            TampleteStr += "<div class=\"form-check\">";//包一組選項radio and checkbox 
                                            if (IsCheckboxMixfillings) {// checkbox has fillings
                                                if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers.length) {
                                                    Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "", "fillings": [], "Answers": [] });
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                }
                                                //radio part
                                                /*TampleteStr += "<div class=\"form-check mt-2\">"*/
                                                TampleteStr += "<input type=\"checkbox\" onclick=\"swich(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
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

                                                //fillings part
                                                let fillingStr = Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                                                let StrArr = fillingStr.split("##");
                                                let fSn = 1;
                                                let n = 0;
                                                for (var s = 0; s < StrArr.length; s++) {
                                                    if (StrArr[s].includes("^")) {
                                                        if (fSn > Obj.Groups[i].Rows[w].Cols[c].Answers[o].fillings.length) {
                                                            Obj.Groups[i].Rows[w].Cols[c].Answers[o].fillings.push({ "index": fSn, "value": "", "lastUpdate": "" });
                                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                        }
                                                        TampleteStr += "<input type=\"text\" onchange=\"changeTableJsonData(event)\"  disabled style=\"max-width:100px\" class=\"form-control-border form-control form-control-sm ml-1 mr-1 d-inline mb-2\"name=\"";//data-gidandrow
                                                        TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                        TampleteStr += "data-CheckboxIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index + "\"";
                                                        TampleteStr += "data-TextIndex=\"" + fSn + "\"";
                                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].fillings.length > 0) {
                                                            TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].Answers[o].fillings[n].value + "\"";
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
                                                //fillings part
                                                //radio part
                                            } else {//radio hasn't fillings
                                                if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers.length) {
                                                    Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "", "fillings": [], "Answers": [] });
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                }
                                                TampleteStr += "<div class=\"form-check\">"
                                                TampleteStr += "<input type=\"checkbox\" onchange=\"changeTableJsonData(event)\" onclick=\"CleanOption(event)\" class=\" mr-1\"name=\"";
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

                                            }
                                            for (var k = 0; k < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions.length; k++) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].AnsText.includes("##^")) {
                                                    IsRadioMixFillings = true;
                                                    break;
                                                }
                                            }
                                            if (IsRadioMixFillings) {//radio has fillings
                                                for (var k = 0; k < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions.length; k++) {
                                                    if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.length) {
                                                        Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.push({ "index": k + 1, "value": false, "lastUpdate": "", "fillings": [] });
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                    }
                                                    //radio part
                                                    TampleteStr += "<input onchange=\"changeTableJsonData(event)\"onclick=\"swichDisabledTrue(event)\" type=\"radio\" disabled class=\"ml-2 mr-1\"name=\"";
                                                    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                    TampleteStr += "value=\"";
                                                    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index;
                                                    TampleteStr += "\"id=\"";
                                                    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].AnsText;
                                                    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index;
                                                    TampleteStr += "\"";
                                                    TampleteStr += "data-RadioIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index + "\"";
                                                    TampleteStr += "data-CheckboxIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index + "\"";
                                                   
                                                    if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.length > 0) {
                                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers[k].value) {
                                                            TampleteStr += "checked";
                                                        }
                                                    }
                                                    TampleteStr += ">";
                                                    //fillings part

                                                    let fillingStr = Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].AnsText;
                                                    let fSn = 1;
                                                    let n = 0;
                                                    let StrArr = fillingStr.split("##");
                                                    for (var s = 0; s < StrArr.length; s++) {
                                                        if (StrArr[s].includes("^")) {
                                                            console.log("chkboxFillings");
                                                            if (fSn > Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers[k].fillings.length) {
                                                                Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers[k].fillings.push({ "index": fSn, "value": "", "lastUpdate": "" });
                                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                            }
                                                            TampleteStr += "<input type=\"text\" disabled style=\"max-width:100px\" onchange=\"changeTableJsonData(event)\"  class=\"form-control form-control-border form-control-sm d-inline ml-1 mr-1 mb-2\"name=\"";
                                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                            TampleteStr += "data-checkboxIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index + "\"";
                                                            TampleteStr += "data-radioindex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index + "\"";
                                                            TampleteStr += "data-TextIndex=\"" + fSn + "\"";
                                                            if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers[k].fillings.length > 0) {
                                                                TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers[k].fillings[n].value + "\"";
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
                                                    /* TampleteStr += "</div>";*/

                                                    //
                                                    //    TampleteStr += "<label for=\"";
                                                    //    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].AnsText;
                                                    //    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index;
                                                    //    TampleteStr += "\"class=\"mr-2\">" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].AnsText + "</label>";
                                                }

                                            } else {
                                                //radio part
                                                for (var k = 0; k < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions.length; k++) {
                                                    if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.length) {
                                                        Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.push({ "index": k + 1, "value": false, "lastUpdate": "" });
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                                    }

                                                    TampleteStr += "<input onchange=\"changeTableJsonData(event)\" type=\"radio\" disabled class=\"mr-1\"name=\"";
                                                    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                                    TampleteStr += "value=\"";
                                                    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index;
                                                    TampleteStr += "\"id=\"";
                                                    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].AnsText;
                                                    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index;
                                                    TampleteStr += "\"";
                                                    TampleteStr += "data-RadioIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index + "\"";
                                                    TampleteStr += "data-CheckboxIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index + "\"";
                                                   
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

                                            }
                                            TampleteStr += "</div>";//包一組選項radio and checkbox 
                                        }
                                        console.log("hasOtherAnswers" + Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers);
                                        if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers) {

                                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length == 0) {
                                                Obj.Groups[i].Rows[w].Cols[c].otherAnswer.push({ "index": 1, "value": false, "lastUpdate": "", "fillings": [{ "index": 1, "value": "", "lastUpdate": "" }] });
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                                            }
                                            TampleteStr += "<div class=\"form-check d-flex mt-1\">"
                                            TampleteStr += "<input class=\"otherAns\" type=\"radio\" onclick=\"CleanOthers(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                                            TampleteStr += "\"";
                                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value) {
                                                    TampleteStr += "checked";
                                                }
                                            }
                                            TampleteStr += ">";
                                            TampleteStr += "<label class=\"pt-2 pl-1 pr-1\">其他</label>";
                                            TampleteStr += "<input style=\"max-width:100px\" type=\"text\"onchange=\"changeTableJsonData(event)\" disabled class=\"other form-control-border d-inline form-control form-control-sm mb-3\"name=\"";
                                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value) {
                                                    TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].fillings[0].value + "\"";
                                                }
                                            }
                                            TampleteStr += ">";

                                            TampleteStr += "</div>";
                                        }

                                        break;

                                    default:
                                }

                                TampleteStr += "</td>";
                            }
                        }
                        TampleteStr += "</tbody>";
                        TampleteStr += "</table>";
                        //TampleteStr += "<div class=\"d-flex justify-content-center\"><div class=\" mb-3\">";
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
                        let no = Obj.Groups[i].hasSN;
                        for (var w = 2; w < Obj.Groups[i].Rows.length; w++) {
                            //有項次
                            
                            tampleteStr += "<tr class=\"odd\">";
                            if (Obj.Groups[i].hasSN > 0) {
                                tampleteStr += "<td class=\"dtr-control sorting_1\">";
                                tampleteStr += no;
                                tampleteStr += "</td>";
                                no++;
                            }
                            for (var c = 0; c < Obj.Groups[i].Rows[w].Cols.length; c++) {//答案的顯示 存JSON的答案

                                tampleteStr += "<td class=\"dtr-control sorting_1\">";

                                if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0 || Obj.Groups[i].Rows[w].Cols[c].fillings != undefined) {
                                    switch (Obj.Groups[i].Rows[w].Cols[c].QuestionType) {
                                        case "file":
                                        case "image":
                                            if (Obj.Groups[i].Rows[w].Cols[c].QuestionText!=null) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].QuestionText.includes("##^")) {
                                                    tampleteStr += checkRowShowAnsFilling(Obj, i, w, c);
                                                } else {
                                                    tampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span></br>";
                                                }
                                            }
                                            tampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value + "</span>";
                                            if (Obj.Groups[i].Rows[w].Cols[c].Answers[0].value!="") {
                                                tampleteStr += "<a  class=\"ml-1 btn btn-default btn-sm download\" href=\"Upload/" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value + "\">";
                                                tampleteStr += "<i class=\"fas fa-cloud-download-alt\"></i>";
                                                tampleteStr += "</a>";
                                            }
                                            break;
                                        case "memo":
                                        case "text":
                                        case "number":
                                        case "select":
                                            if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != null) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].QuestionText.includes("##^")) {
                                                    tampleteStr += checkRowShowAnsFilling(Obj, i, w, c);
                                                } else {
                                                    tampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span></br>";
                                                }
                                            }
                                            tampleteStr += Obj.Groups[i].Rows[w].Cols[c].Answers[0].value;
                                            break;
                                        case "date":
                                            if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != null) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].QuestionText.includes("##^")) {
                                                    tampleteStr += checkRowShowAnsFilling(Obj, i, w, c);
                                                } else {
                                                    tampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span></br>";
                                                }
                                            }
                                            let dateValue = Obj.Groups[i].Rows[w].Cols[c].Answers[0].value;
                                            console.log("dateValue_" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value)
                                            let dateStr = new Date(dateValue);
                                            dateStr = dateStr.Format("yyyy-MM-dd");
                                            if (!dateStr.includes("Na") && dateValue != null) {//
                                                tampleteStr += dateStr;
                                            }
                                            break;
                                        case "CheckboxMixImage":
                                            if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != null) {
                                                tampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span></br>";
                                            }
                                            for (var r = 0; r < Obj.Groups[i].Rows[1].Cols[c].Answers.length; r++) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[r].value == true) {
                                                    tampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[r].AnsText + "</br>";
                                                    tampleteStr += "<img style=\"height:50px\"src=\"ShowAdminImg?id=" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[r].image + "\"" + "/>" + "</br>";
                                                }
                                            }
                                            if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers && Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != null && Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != "") {
                                                tampleteStr += "其他:" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value + "</br>";
                                            }
                                            break;
                                        case "sign":
                                            if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != null) {
                                                tampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span></br>";
                                            }
                                            if (Obj.Groups[i].Rows[w].Cols[c].Answers[0].value != null && Obj.Groups[i].Rows[w].Cols[c].Answers[0].value !=0) {
                                                let time = new Date(Obj.Groups[i].Rows[w].Cols[c].Answers[0].lastUpdate);
                                                let strTime = time.Format("yyyy-MM-dd");
                                                tampleteStr += "<img style=\"width:20%\" id=\"sign\" src=\"" + "ShowAdminImg.aspx?id=" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value + "\">";
                                                tampleteStr += "<span>" + strTime + "</span>";
                                            } 
                                            break;
                                        case "display":
                                            let fillingStr = Obj.Groups[i].Rows[w].Cols[c].QuestionText;
                                            let StrArr = fillingStr.split("##");
                                            let n = 1;
                                            let N = 0;//第幾個填充答案
                                            for (var s = 0; s < StrArr.length; s++) {
                                                if (StrArr[s].includes("^")) {
                                                    let reStr = StrArr[s].substring(2);
                                                    tampleteStr += "<input type=\"text\"style=\"max-width: 50px\" class=\"form-control-border form-control-sm form-control d-inline mb-2\"value=\"" + Obj.Groups[i].Rows[w].Cols[c].fillings[N].value + "\">";
                                                    tampleteStr +=reStr;
                                                    n++;
                                                    N++;
                                                } else {
                                                    tampleteStr += StrArr[s];
                                                }
                                            }
                                            break;
                                        case "checkbox":
                                            if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != null) {
                                                tampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span></br>";
                                            }

                                            for (var r = 0; r < Obj.Groups[i].Rows[w].Cols[c].Answers.length; r++) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[r].value == true) {
                                                    tampleteStr += "<input type=\"checkbox\" class=\"mr-1\" checked>";
                                                    let fillingStr = Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[r].AnsText;
                                                    let StrArr = fillingStr.split("##");
                                                    let SN = 0;//第幾個填充答案
                                                    let n = 1;
                                                    for (var s = 0; s < StrArr.length; s++) {
                                                        if (StrArr[s].includes("^")) {
                                                            let reStr = StrArr[s].substring(2);
                                                            tampleteStr += "<input type=\"text\"style=\"max-width: 50px\" class=\"form-control-border form-control-sm form-control d-inline mb-2\"value=\""+ Obj.Groups[i].Rows[w].Cols[c].Answers[r].fillings[SN].value+"\">";
                                                            tampleteStr += reStr;
                                                            n++;
                                                            SN++;
                                                        } else {
                                                            tampleteStr += StrArr[s];
                                                        }
                                                    }
                                                    tampleteStr += "</br>";
                                                }
                                            }
                                            if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers && Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value ) {
                                                tampleteStr += "<input type=\"checkbox\" class=\"mr-1\" checked>";
                                                tampleteStr += "其他:" + "<input type=\"text\"style=\"max-width: 50px\" class=\"form-control-border form-control-sm form-control d-inline mb-2\"value=\"" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].fillings[0].value + "\">";

                                            }
                                            break;
                                        case "radio":
                                            if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != null) {
                                                tampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span></br>";
                                            }

                                            for (var r = 0; r < Obj.Groups[i].Rows[w].Cols[c].Answers.length; r++) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[r].value) {
                                                    tampleteStr += "<input type=\"radio\" class=\"mr-1\" checked>";
                                                    let fillingStr = Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[r].AnsText;
                                                    let StrArr = fillingStr.split("##");
                                                    let SN = 0;//第幾個填充答案
                                                    let n = 1;
                                                    for (var s = 0; s < StrArr.length; s++) {
                                                        if (StrArr[s].includes("^")) {
                                                            let reStr = StrArr[s].substring(2);
                                                            tampleteStr += "<input type=\"text\"style=\"max-width: 50px\" class=\"form-control-border form-control-sm form-control d-inline mb-2\"value=\"" + Obj.Groups[i].Rows[w].Cols[c].Answers[r].fillings[SN].value +"\">";
                                                            tampleteStr += reStr;
                                                            n++;
                                                            SN++;
                                                        } else {
                                                            tampleteStr += StrArr[s];
                                                        }
                                                    }
                                                }
                                            }
                                            if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers && Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != null && Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != "") {
                                                tampleteStr += "<input type=\"radio\" class=\"mr-1\" checked>";
                                                tampleteStr += "其他:" + "<input type=\"text\"style=\"max-width: 50px\" class=\"form-control-border form-control-sm form-control d-inline mb-2\"value=\"" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].fillings[0].value + "\">";
                                            }

                                            break;
                                        case "RadioMixCheckbox":
                                            if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != null) {
                                                tampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span></br>";
                                            }

                                            for (var r = 0; r < Obj.Groups[i].Rows[w].Cols[c].Answers.length; r++) {
                                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[r].value) {//radio 有fillings
                                                    tampleteStr += "<input type=\"radio\" class=\"mr-1\" checked>";
                                                    if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[r].AnsText.includes("##^")) {
                                                        let fillingStr = Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[r].AnsText;
                                                        let StrArr = fillingStr.split("##");
                                                        let SN = 0;//第幾個填充答案
                                                        let n = 1;
                                                        for (var s = 0; s < StrArr.length; s++) {
                                                            if (StrArr[s].includes("^")) {
                                                                let reStr = StrArr[s].substring(2);
                                                                tampleteStr += "<input type=\"text\"style=\"max-width: 50px\" class=\"form-control-border form-control-sm form-control d-inline mb-2\"value=\"" + Obj.Groups[i].Rows[w].Cols[c].Answers[r].fillings[SN].value + "\">" +"</br>";
                                                                tampleteStr += reStr;
                                                                n++;
                                                                SN++;
                                                            } else {
                                                                tampleteStr += StrArr[s];
                                                            }
                                                        }
                                                        for (var a = 0; a < Obj.Groups[i].Rows[w].Cols[c].Answers[r].Answers.length; a++) {
                                                            if (Obj.Groups[i].Rows[w].Cols[c].Answers[r].Answers[a].value) {
                                                                tampleteStr += "<input type=\"checkbox\" class=\"ml-3 mr-1\" checked>";
                                                                if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[r].AnswerOptions[a].AnsText.includes("##^")) {//checkbox有fillings
                                                                    let fillingStr = Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[r].AnswerOptions[a].AnsText;
                                                                    let StrArr = fillingStr.split("##");
                                                                    let SN = 0;//第幾個填充答案
                                                                    let n = 1;
                                                                    for (var s = 0; s < StrArr.length; s++) {
                                                                        if (StrArr[s].includes("^")) {
                                                                            let reStr = StrArr[s].substring(2);
                                                                            tampleteStr += "<input type=\"text\"style=\"max-width: 50px\" class=\"form-control-border form-control-sm form-control d-inline mb-2\"value=\"" + Obj.Groups[i].Rows[w].Cols[c].Answers[r].Answers[a].fillings[SN].value + "\">";
                                                                            tampleteStr += reStr;
                                                                            n++;
                                                                            SN++;
                                                                        } else {
                                                                            tampleteStr += StrArr[s];
                                                                        }
                                                                    }
                                                                    tampleteStr += "</br>";
                                                                }
                                                                else {//checkbox沒有fillings
                                                                    tampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[r].AnswerOptions[a].AnsText;
                                                                }
                                                            }
                                                        }
                                                    } else {//radio 沒有fillings
                                                        tampleteStr += "<input type=\"radio\" class=\"mr-1\" checked>"+ Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[r].AnsText;
                                                        for (var b = 0; b < Obj.Groups[i].Rows[w].Cols[c].Answers[r].Answers.length; b++) {
                                                            if (Obj.Groups[i].Rows[w].Cols[c].Answers[r].Answers[b].value) {
                                                                if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[r].AnswerOptions[b].AnsText.includes("##^")) {//checkbox有fillings
                                                                    let fillingStr = Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[r].AnswerOptions[b].AnsText;
                                                                    let StrArr = fillingStr.split("##");
                                                                    let SN = 0;//第幾個填充答案
                                                                    let n = 1;
                                                                    for (var s = 0; s < StrArr.length; s++) {
                                                                        if (StrArr[s].includes("^")) {
                                                                            let reStr = StrArr[s].substring(2);
                                                                            tampleteStr += "<input type=\"text\"style=\"max-width: 50px\" class=\"form-control-border form-control-sm form-control d-inline mb-2\"value=\"" + Obj.Groups[i].Rows[w].Cols[c].Answers[r].Answers[b].fillings[SN].value + "\">";
                                                                            tampleteStr += reStr;
                                                                            n++;
                                                                            SN++;
                                                                        } else {
                                                                            tampleteStr += StrArr[s];
                                                                        }
                                                                    }
                                                                    tampleteStr += "</br>";

                                                                } else {
                                                                    tampleteStr += "</br> <input type=\"checkbox\" class=\"mr-1\" checked>" + Obj.Groups[i].Rows[w].Cols[c].Answers[r].Answers[b].AnsText;
                                                                }
                                                            }
                                                        }
                                                   }
                                                }
                                            }
                                            if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers && Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != null && Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != "") {
                                                tampleteStr += "其他:" + "<input type=\"text\"style=\"max-width: 50px\" class=\"form-control-border form-control-sm form-control d-inline mb-2\"value=\"" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].fillings[0].value + "\">";
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
            let w = Number(event.currentTarget.dataset.row);
            var ao = document.getElementById("mainPlaceHolder_Ao");

            console.log("isInsert:" + isInsert)
            //新增的modle
            if (isInsert == "true") {
                let insertBody = document.querySelector(".insertBody");
                let insertBodyStr = "";
                for (var r = 0; r < Obj.Groups[i].Rows[0].Cols.length; r++) {
                    let rowInsert = document.querySelector(".rowInsert");
                    rowInsert.setAttribute("id", Obj.Groups[i].GroupID);
                    let firstRow = 1;
                    switch (Obj.Groups[i].Rows[1].Cols[r].QuestionType) {
                        case "display":
                            if (Obj.Groups[i].Rows[0].Cols[r].QuestionText!=0) {
                                insertBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            }
                            CheckRowFilling(Obj, i, firstRow, r);
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                let fillingStr = Obj.Groups[i].Rows[1].Cols[r].QuestionText;
                                let StrArr = fillingStr.split("##");
                                let n = 1;
                                let N = 0;//第幾個填充答案
                                for (var s = 0; s < StrArr.length; s++) {
                                    if (StrArr[s].includes("^")) {
                                        insertBodyStr += "<input type=\"text\" style=\"max-width:100px\"  class=\"form-control-border form-control-sm form-control d-inline mb-2\"name=\"";
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
                            } 
                            break;
                        case "sign":
                            let signImgID = document.getElementById("mainPlaceHolder_adminSign").value;
                            let time = new Date();
                            let today = time.getFullYear() + "-" + Number(time.getMonth() + 1);
                            today += "-" + time.getDate();
                            insertBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText != null) {
                                if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                    insertBodyStr += CheckRowFilling(Obj, i,firstRow,r,w);
                                } else {
                                    insertBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                                }
                               
                            }
                            if (ao.value == 2) {
                                insertBodyStr += "<div class=\"col-12 pt-2 SignBoxRow\">";
                                insertBodyStr += "<div data-Staut=\"Edit\" data-GidandRow=\"GID\" onchange=\"changeTableJsonData(event)\"  onclick=\"SignByAdminId(event)\" class=\"btn btn-primary Signbtn ml-2 rowPart\" >";//
                                insertBodyStr += "簽核";
                                insertBodyStr += "</div>";
                                insertBodyStr += "<div class=\"ml-5  SignImageBox d-none\">";//SignImageBox
                                insertBodyStr += "<img style=\"height:80px\" src=\"";//img
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
                            }
                            break;
                        case "date":
                            insertBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                insertBodyStr += CheckRowFilling(Obj, i, firstRow, r);
                            } else {
                                insertBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                            }
                            insertBodyStr += "<input type=\"date\" class=\"form-control mb-3\"name=\"";
                            insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\">";
                            break;
                        case "file":
                            insertBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                insertBodyStr += CheckRowFilling(Obj, i, firstRow, r);
                            } else {
                                insertBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                            }
                            insertBodyStr += "<span class=\"mb-3 btn btn-default btn-file\"><i class=\"fas fa-paperclip\"></i>";
                            insertBodyStr += "<input onchange=\"appenUploadName(event)\" type=\"file\" class=\"Upload form-control mb-3\"name=\"";
                            insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\">";
                            insertBodyStr += "上傳檔案";
                            insertBodyStr += "<span id=\"UploadName" + Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"></span>";
                            insertBodyStr += "</span>";
                            break;
                        case "memo":
                            insertBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                insertBodyStr += CheckRowFilling(Obj, i, firstRow, r);
                            } else {
                                insertBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                            }
                            insertBodyStr += "<textarea class=\"form-control mb-3\"name=\"";
                            insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\">";
                            insertBodyStr += "</textarea>";
                            break;
                        case "text":
                            insertBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                insertBodyStr += CheckRowFilling(Obj, i, firstRow, r);
                            } else {
                                insertBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                            }
                            insertBodyStr += "<input type=\"text\" class=\"form-control mb-3\"name=\"";
                            insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\">";
                            break;
                        case "number":
                            insertBodyStr += "<h6>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h6>";
                            insertBodyStr += "<input type=\"number\" class=\"form-control mb-3\"name=\"";
                            insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\">";
                            break;
                        case "select":
                            insertBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                insertBodyStr += CheckRowFilling(Obj, i, firstRow, r);
                            } else {
                                insertBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                            }
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
                            insertBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                insertBodyStr += CheckRowFilling(Obj, i, firstRow, r);
                            } else {
                                insertBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                            }
                            let hasFillings = false;
                            for (var o = 0; o < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions.length; o++) {
                                if (Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText.includes("##^")) {
                                    hasFillings = true;
                                    break;
                                }
                            }
                            if (hasFillings) {
                                //有填充
                                for (var o = 0; o < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions.length; o++) {
                                    insertBodyStr += "<div class=\"form-check mt-3\">"
                                    insertBodyStr += "<input type=\"checkbox\" onclick=\"CleanOthersForRow(event)\" class=\" mr-3\"name=\"";
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
                                            insertBodyStr += "<input type=\"text\" disabled style=\"max-width:100px\" class=\"form-control-border form-control-sm ml-2 mr-2 form-control d-inline mb-2\"name=\"";
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

                            } else {
                                //沒有填充
                                for (var o = 0; o < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions.length; o++) {
                                    insertBodyStr += "<div class=\"form-check\">"
                                    insertBodyStr += "<input type=\"checkbox\" class=\" mr-3\"name=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                    insertBodyStr += "value=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                    insertBodyStr += "\"id=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID;
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                    insertBodyStr += "\">";
                                    insertBodyStr += "<label for=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID;
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                    insertBodyStr += "\"class=\"\">" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText + "</label>"
                                    insertBodyStr += "</div>";
                                }
                            }
                            if (Obj.Groups[i].Rows[1].Cols[r].hasOtherAnswers) {
                                let time = new Date().getMilliseconds();
                                insertBodyStr += "<div class=\"form-check\">"
                                insertBodyStr += "<input class=\"otherAns  mr-3\" type=\"checkbox\" onclick=\"DisabledTrue(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + time;
                                insertBodyStr += "\"";
                                insertBodyStr += ">";
                                insertBodyStr += "<label>其他</label>";
                                insertBodyStr += "<input type=\"text\"onchange=\"changeTableJsonData(event)\" disabled class=\"form-control-border other d-inline col-3 ml-2 form-control mb-3\"name=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + time + "\"";
                                insertBodyStr += "data-QID=\"" + Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                insertBodyStr += ">";
                                insertBodyStr += "</div>";
                            }
                            break;
                        case "radio":
                            insertBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                insertBodyStr += CheckRowFilling(Obj, i, firstRow, r);
                            } else {
                                insertBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                            }

                            let Hasfillings = false;
                            for (var o = 0; o < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions.length; o++) {
                                if (Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText.includes("##^")) {
                                    Hasfillings = true;
                                    break;
                                }
                            }
                            if (Hasfillings) {
                                for (var o = 0; o < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions.length; o++) {
                                    insertBodyStr += "<div class=\"form-check mt-3\">"
                                    insertBodyStr += "<input type=\"radio\" onclick=\"CleanOthersForRow(event)\" class=\"mr-3\"name=\"";
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
                                            insertBodyStr += "<input type=\"text\" disabled style=\"max-width:100px\" class=\"form-control-border form-control-sm form-control d-inline mb-2\"name=\"";//data-gidandrow
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

                            } else {
                                for (var o = 0; o < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions.length; o++) {
                                    insertBodyStr += "<div class=\"form-check\">"
                                    insertBodyStr += "<input type=\"radio\" class=\" mr-3\"name=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                    insertBodyStr += "value=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                    insertBodyStr += "\"id=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID;
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                    insertBodyStr += "\">";
                                    insertBodyStr += "<label for=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID;
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                    insertBodyStr += "\"class=\"\">" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText + "</label>"
                                    insertBodyStr += "</div>";
                                }
                            }
                            if (Obj.Groups[i].Rows[1].Cols[r].hasOtherAnswers) {
                                let time = new Date().getMilliseconds();
                                insertBodyStr += "<div class=\"form-check\">"
                                insertBodyStr += "<input class=\"otherAns  mr-3\" type=\"radio\" onclick=\"CleanOptionforTable(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID ;
                                insertBodyStr += "\"";
                                insertBodyStr += ">";
                                insertBodyStr += "<label >其他</label>";
                                insertBodyStr += "<input type=\"text\"onchange=\"changeTableJsonData(event)\"disabled class=\"form-control-border form-control-sm  form-control other d-inline col-3 ml-2 form-control mb-3\"name=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + time + "\"";
                                insertBodyStr += "data-QID=\"" + Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                insertBodyStr += ">";
                                insertBodyStr += "</div>";
                            }

                            break;
                        case "CheckboxMixImage":
                            insertBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                insertBodyStr += CheckRowFilling(Obj, i, firstRow, r);
                            } else {
                                insertBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                            }

                            let hasFill = false;
                            for (var o = 0; o < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions.length; o++) {
                                if (Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText.includes("##^")) {
                                    hasFill = true;
                                    break;
                                }
                            }
                            for (var o = 0; o < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions.length; o++) {
                                if (hasFill) {
                                    console.log("hasFill");
                                    insertBodyStr += "<div class=\"form-check mt-3\">"
                                    insertBodyStr += "<input type=\"checkbox\"onclick=\"DisabledTrue(event)\" class=\" mr-3\"name=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                    insertBodyStr += "value=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                    insertBodyStr += "\"id=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                    insertBodyStr += "\">";
                                    let fillingStr = Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                    let StrArr = fillingStr.split("##");
                                    let TxtSn = 1;
                                    for (var s = 0; s < StrArr.length; s++) {
                                        if (StrArr[s].includes("^")) {
                                            insertBodyStr += "<input type=\"text\" disabled style=\"width:20%\" class=\"form-control-border form-control-sm form-control d-inline mb-2\"name=\"";
                                            insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                            insertBodyStr += "data-checkboxindex=\"" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index + "\"";
                                            insertBodyStr += "data-textindex=\"" + TxtSn + "\"";
                                            insertBodyStr += ">";
                                            let txt = StrArr[s].substring(2);
                                            if (txt != null) {
                                                insertBodyStr += "<span>" + txt + "</span>";
                                            }
                                            TxtSn++;
                                        } else {
                                            insertBodyStr += "<span>" + StrArr[s] + "</span>";
                                        }
                                    }
                                    insertBodyStr += "<img class=\"col-12\" src=\"";
                                    insertBodyStr += "ShowAdminImg.aspx?id=" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].image + "\">";

                                } else {
                                    insertBodyStr += "<div class=\"form-check mt-3\">"
                                    insertBodyStr += "<input type=\"checkbox\" onclick=\"DisabledTrue(event)\" class=\" mr-3\"name=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                    insertBodyStr += "value=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                    insertBodyStr += "\"id=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                    insertBodyStr += "\">";

                                    insertBodyStr += "<div class=\"form-check mt-3\">"
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
                            if (Obj.Groups[i].Rows[1].Cols[r].hasOtherAnswers) {
                                let time = new Date().getMilliseconds();
                                insertBodyStr += "<div class=\"form-check mt-3\">"
                                insertBodyStr += "<input class=\"otherAns  mr-3\" type=\"checkbox\" onclick=\"DisabledTrue(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + time;
                                insertBodyStr += "\"";
                                insertBodyStr += ">";
                                insertBodyStr += "<label>其他</label>";
                                insertBodyStr += "<input type=\"text\"onchange=\"changeTableJsonData(event)\" disabled class=\"other form-control-border form-control-sm d-inline col-3 ml-2 form-control mb-3\"name=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + time + "\"";
                                insertBodyStr += "data-QID=\"" + Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                insertBodyStr += ">";
                                insertBodyStr += "</div>";
                            }

                            break;
                        case "CheckboxMixFilling":
                            insertBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                insertBodyStr += CheckRowFilling(Obj, i, firstRow, r);
                            } else {
                                insertBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                            }
                            for (var o = 0; o < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions.length; o++) {
                                insertBodyStr += "<div class=\"form-check mt-3\">"
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
                                for (var s = 0; s < StrArr.length; s++) {
                                    if (StrArr[s].includes("^")) {
                                        insertBodyStr += "<input type=\"text\" disabled style=\"max-width:100px\" class=\"form-control-border form-control-sm ml-2 mr-2 form-control d-inline mb-2\"name=\"";
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
                            if (Obj.Groups[i].Rows[1].Cols[r].hasOtherAnswers) {
                                let time = new Date().getMilliseconds();
                                insertBodyStr += "<div class=\"form-check mt-3\">"
                                insertBodyStr += "<input class=\"otherAns  mr-3\" type=\"checkbox\" onclick=\"DisabledTrue(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + time;
                                insertBodyStr += "\"";
                                insertBodyStr += ">";
                                insertBodyStr += "<label>其他</label>";
                                insertBodyStr += "<input type=\"text\"onchange=\"CleanOthers(event)\"style=\"max-width:100px\" disabled class=\"form-control-border form-control-sm other d-inline col-3 ml-2 form-control mb-3\"name=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + time + "\"";
                                insertBodyStr += "data-QID=\"" + Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                insertBodyStr += ">";
                                insertBodyStr += "</div>";
                            }
                            break;
                        case "RadioMixFilling":
                            insertBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                insertBodyStr += CheckRowFilling(Obj, i, firstRow, r);
                            } else {
                                insertBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                            }

                            for (var o = 0; o < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions.length; o++) {
                                insertBodyStr += "<div class=\"form-check mt-3\">"
                                insertBodyStr += "<input type=\"radio\" onclick=\"CleanOthers(event)\" class=\"mr-3\"name=\"";
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
                                        insertBodyStr += "<input type=\"text\" disabled style=\"max-width:100px\" class=\"form-control-border form-control-sm form-control d-inline mb-2\"name=\"";//data-gidandrow
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
                            if (Obj.Groups[i].Rows[1].Cols[r].hasOtherAnswers) {
                                let time = new Date().getMilliseconds();
                                insertBodyStr += "<div class=\"form-check mt-3\">"
                                insertBodyStr += "<input class=\"otherAns  mr-3\" type=\"radio\" onclick=\"CleanOthers(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID;
                                insertBodyStr += "\"";
                                insertBodyStr += ">";
                                insertBodyStr += "<label >其他</label>";
                                insertBodyStr += "<input type=\"text\"onchange=\"changeTableJsonData(event)\" style=\"max-width:100px\" disabled class=\"form-control-border form-control-sm other d-inline col-3 ml-2 form-control mb-3\"name=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + time + "\"";
                                insertBodyStr += "data-QID=\"" + Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                insertBodyStr += ">";
                                insertBodyStr += "</div>";
                            }

                            break;
                        case "RadioMixCheckbox":
                            insertBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                insertBodyStr += CheckRowFilling(Obj, i, firstRow, r);
                            } else {
                                insertBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                            }
                            let radioHasFillings = false;
                            let checkboxHasFillings = false;
                            //radio有填充 radioHasFillings true
                            for (var o = 0; o < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions.length; o++) {
                                if (Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText.includes("##^")) {
                                    radioHasFillings = true;
                                    break;
                                }
                            }
                            //checkbox 有填充 checkboxHasFillings true
                            for (var o = 0; o < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions.length; o++) {
                                for (var c = 0; c < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnswerOptions.length; c++) {
                                    if (Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnswerOptions[c].AnsText.includes("##^")) {
                                        checkboxHasFillings = true;
                                        break;
                                    }
                                }
                            }
                            for (var o = 0; o < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions.length; o++) {
                                //radio part
                                insertBodyStr += "<div class=\"form-check\">"
                                insertBodyStr += "<input type=\"radio\" onclick=\"CleanOptionforRow(event)\" class=\" mr-3\"name=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                insertBodyStr += "value=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                insertBodyStr += "\"id=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                insertBodyStr += "\">";
                                //radio filling part
                                if (radioHasFillings) {
                                    let fillingStr = Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                    let StrArr = fillingStr.split("##");
                                    let fSn = 1;
                                    for (var s = 0; s < StrArr.length; s++) {
                                        if (StrArr[s].includes("^")) {
                                            insertBodyStr += "<input type=\"text\" disabled style=\"max-width:100px\" class=\"form-control-border form-control-sm form-control d-inline mb-2\"name=\"";//data-gidandrow
                                            insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                            insertBodyStr += "data-RadioIndex=\"" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index + "\"";
                                            insertBodyStr += "data-TextIndex=\"" + fSn + "\">";
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
                                    
                                } else {//沒有填充
                                    insertBodyStr += "<span>" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText + "</span>";
                                }
                                //checkbox part
                                for (var k = 0; k < Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnswerOptions.length; k++) {
                                    if (checkboxHasFillings) {
                                        insertBodyStr += "<br/>";
                                    }
                                    insertBodyStr += "<input type=\"checkbox\" onclick=\"swichDisabledTrue(event)\" disabled class=\"ml-3 mr-1\"name=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                    insertBodyStr += "value=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnswerOptions[k].index;
                                    insertBodyStr += "\"id=\"";
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnswerOptions[k].index;
                                    insertBodyStr += "\"";
                                    insertBodyStr += "data-RadioIndex=\"" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index + "\"";
                                    insertBodyStr += "data-CheckboxIndex=\"" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnswerOptions[k].index + "\">";
                                    if (checkboxHasFillings) {
                                       
                                        let fillingStr = Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnswerOptions[k].AnsText;
                                        let fSn = 1;
                                        let StrArr = fillingStr.split("##");
                                        //    insertBodyStr += "<label for=\"";
                                        //    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnsText;
                                        //    insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                        //    insertBodyStr += "\"class=\"\">";
                                        for (var s = 0; s < StrArr.length; s++) {
                                            if (StrArr[s].includes("^")) {
                                                insertBodyStr += "<input type=\"text\" disabled style=\"max-width:100px\" class=\"form-control-border form-control-sm ml-2 mr-2 form-control d-inline mb-2\"name=\"";
                                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                                insertBodyStr += "data-RadioIndex=\"" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index + "\"";
                                                insertBodyStr += "data-checkboxIndex=\"" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnswerOptions[k].index + "\"";
                                                insertBodyStr += "data-TextIndex=\"" + fSn + "\">";
                                                fSn++;
                                                let txt = StrArr[s].substring(2);
                                                if (txt != null) {
                                                    insertBodyStr += "<span>" + txt + "</span>";
                                                }
                                            } else {
                                                insertBodyStr += "<span>" + StrArr[s] + "</span>";
                                            }
                                        }
                                       
                                    } else {
                                        //選項
                                        insertBodyStr += "<label for=\"";
                                        insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].index;
                                        insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnswerOptions[k].index;
                                        insertBodyStr += "\"class=\"mr-2\">" + Obj.Groups[i].Rows[1].Cols[r].AnswerOptions[o].AnswerOptions[k].AnsText + "</label>"
                                        //選項
                                    }
                                }
                                insertBodyStr += "</div>";//form-check
                            }
                            if (Obj.Groups[i].Rows[1].Cols[r].hasOtherAnswers) {
                                let time = new Date().getMilliseconds();
                                insertBodyStr += "<div class=\"form-check mt-3\">"
                                insertBodyStr += "<input class=\"otherAns  mr-3\" type=\"radio\" onclick=\"DisabledTrue(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID;
                                insertBodyStr += "\"";
                                insertBodyStr += ">";
                                insertBodyStr += "<label >其他</label>";
                                insertBodyStr += "<input type=\"text\"onchange=\"changeTableJsonData(event)\" style=\"max-width:100px\" disabled class=\"form-control-border form-control-sm other d-inline col-3 ml-2 form-control mb-3\"name=\"";
                                insertBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + time + "\"";
                                insertBodyStr += "data-QID=\"" + Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                insertBodyStr += ">";
                                insertBodyStr += "</div>";
                            }
                            break;
                        default:
                    }
                }
                insertBody.innerHTML = insertBodyStr;
            } else {
                let firstRow = 1;
                console.log("編輯");
                let updateBody = document.querySelector(".updateBody");
                let updateBodyStr = "";
                for (var r = 0; r < Obj.Groups[i].Rows[w].Cols.length; r++) {
                    let rowUpdate = document.querySelector(".rowUpdate");
                    rowUpdate.setAttribute("id", Obj.Groups[i].GroupID);
                    switch (Obj.Groups[i].Rows[1].Cols[r].QuestionType) {
                        case "display":
                            if (Obj.Groups[i].Rows[0].Cols[r].QuestionText != 0) {
                                updateBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            }

                            if (Obj.Groups[i].Rows[w].Cols[r].QuestionText.includes("##^")) {
                                let fillingStr = Obj.Groups[i].Rows[w].Cols[r].QuestionText;
                                let StrArr = fillingStr.split("##");
                                let n = 1;
                                let N = 0;//第幾個填充答案
                                for (var s = 0; s < StrArr.length; s++) {
                                    if (StrArr[s].includes("^")) {
                                        updateBodyStr += "<input type=\"text\" style=\"max-width:100px\" onchange=\"changeTableJsonData(event)\" class=\"form-control-border form-control-sm form-control d-inline mb-2\"name=\"";
                                        updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                        updateBodyStr += "data-filling=\"" + n + "\"";
                                        updateBodyStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[r].fillings[N].value + "\"";
                                        updateBodyStr += ">";
                                        n++;
                                        let txt = StrArr[s].substring(2);
                                        if (txt != null) {
                                            updateBodyStr += "<span>" + txt + "</span>";
                                        }
                                        N++;
                                    } else {
                                        updateBodyStr += "<span>" + StrArr[s] + "</span>";
                                    }
                                }
                            } 

                            break;
                        case "sign":
                            let signImgID = document.getElementById("mainPlaceHolder_adminSign").value;
                            let time = new Date();
                            let today = time.getFullYear() + "/" + Number(time.getMonth() + 1);
                            today += "/" + time.getDate();
                            if (Obj.Groups[i].Rows[w].Cols[r].Answers.length > 0) {
                                if (Obj.Groups[i].Rows[w].Cols[r].Answers[0].value != null && Obj.Groups[i].Rows[w].Cols[r].Answers[0].value != 0) {
                                    updateBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                                    if (Obj.Groups[i].Rows[1].Cols[r].QuestionText != null) {
                                        if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                            updateBodyStr += CheckRowFilling(Obj, i, firstRow, r,w);
                                        } else {
                                            updateBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                                        }
                                    }

                                    if (ao.value == 2) {
                                        updateBodyStr += "<div class=\"col-12 pt-2 SignBoxRow\">";
                                        if (signImgID == Obj.Groups[i].Rows[w].Cols[r].Answers[0].value) {
                                            updateBodyStr += "<div data-Staut=\"Edit\" data-GidandRow=\"" + Obj.Groups[i].GroupID + "#" + w + "\" onchange=\"changeTableJsonData(event)\"  onclick=\"SignByAdminId(event)\" class=\"btn btn-primary Signbtn ml-2 rowPart\" >";//
                                            updateBodyStr += "取消簽核";
                                            updateBodyStr += "</div>";
                                        }
                                        updateBodyStr += "<div class=\"ml-5  SignImageBox \">";//SignImageBox
                                        updateBodyStr += "<img style=\"height: 80px\" src=\"";//img
                                        updateBodyStr += "ShowAdminImg.aspx?id=" + Obj.Groups[i].Rows[w].Cols[r].Answers[0].value + "\"";
                                        updateBodyStr += "id=\"sign" + Obj.Groups[i].Rows[w].Cols[r].Answers[0].value + "\"";
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
                                        updateBodyStr += "<div class=\"ml-5  SignImageBox \">";//SignImageBox
                                        updateBodyStr += "<img style=\"height: 80px\" src=\"";//img
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

                                    }
                                } else {
                                    updateBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                                    if (Obj.Groups[i].Rows[1].Cols[r].QuestionText != null) {
                                        if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                            updateBodyStr += CheckRowFilling(Obj, i, firstRow, r);
                                        } else {
                                            updateBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                                        }
                                    }

                                    if (ao.value == 2) {
                                        updateBodyStr += "<div class=\"col-12 pt-2 SignBoxRow\">";
                                        updateBodyStr += "<div data-Staut=\"Edit\" data-GidandRow=\"" + Obj.Groups[i].GroupID + "#" + w + "\" onchange=\"changeTableJsonData(event)\" onclick=\"SignByAdminId(event)\" class=\"btn btn-primary Signbtn ml-2 rowPart\" >";//
                                        updateBodyStr += "簽核";
                                        updateBodyStr += "</div>";
                                        updateBodyStr += "<div class=\"ml-5  SignImageBox d-none\">";//SignImageBox
                                        updateBodyStr += "<img style=\"height: 80px\" src=\"";//img
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
                                }
                            } else {
                                updateBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                                if (Obj.Groups[i].Rows[1].Cols[r].QuestionText != null) {
                                    if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                        updateBodyStr += CheckRowFilling(Obj, i, firstRow, r);
                                    } else {
                                        updateBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                                    }
                                }

                                if (ao.value == 2) {
                                    updateBodyStr += "<div class=\"col-12 pt-2 SignBoxRow\">";
                                    updateBodyStr += "<div data-Staut=\"Edit\" data-GidandRow=\"" + Obj.Groups[i].GroupID + "#" + w + "\" onchange=\"changeTableJsonData(event)\" onclick=\"SignByAdminId(event)\" class=\"btn btn-primary Signbtn ml-2 rowPart\" >";//
                                    updateBodyStr += "簽核";
                                    updateBodyStr += "</div>";
                                    updateBodyStr += "<div class=\"ml-5  SignImageBox d-none\">";//SignImageBox
                                    updateBodyStr += "<img style=\"height: 80px\" src=\"";//img
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
                            }
                            break;
                        case "date":
                            updateBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText != null) {
                                if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                    updateBodyStr += CheckRowFilling(Obj, i, firstRow, r,w);
                                } else {
                                    updateBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                                }
                            }

                            updateBodyStr += "<input type=\"date\"onchange=\"changeTableJsonData(event)\" class=\"Upload form-control mb-3\"name=\"";
                            updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                            if (Obj.Groups[i].Rows[w].Cols[r].Answers.length > 0) {
                                if (Obj.Groups[i].Rows[w].Cols[r].Answers[0].value!=null) {
                                    let time = new Date(Obj.Groups[i].Rows[w].Cols[r].Answers[0].value);
                                    time = time.Format("yyyy-MM-dd");
                                    updateBodyStr += "value=\"" + time + "\"";
                                }
                            }
                            updateBodyStr += ">";
                            break;
                        case "file":
                            updateBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText != null) {
                                if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                    updateBodyStr += CheckRowFilling(Obj, i, firstRow, r,w);
                                } else {
                                    updateBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                                }
                            }
                            updateBodyStr += "<span class=\"mb-3 btn btn-default btn-file\"><i class=\"fas fa-paperclip\"></i>";
                            updateBodyStr += "<input type=\"file\" onchange=\"appenUploadName(event)\" class=\"form-control Upload mb-3\"name=\"";
                            updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\">";
                            if (Obj.Groups[i].Rows[w].Cols[r].Answers.length > 0) {
                                updateBodyStr += "<span id=\"UploadName" + Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\">";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].Answers[0].value;
                                updateBodyStr += "</span>";
                            } else {
                                updateBodyStr += "上傳檔案";
                            }
                           
                            updateBodyStr += "</span>";

                            break;
                        case "text":
                            updateBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText != null) {
                                if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                    updateBodyStr += CheckRowFilling(Obj, i, firstRow, r,w);
                                } else {
                                    updateBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                                }
                            }
                            updateBodyStr += "<input type=\"text\"onchange=\"changeTableJsonData(event)\" class=\"form-control mb-3\"name=\"";
                            updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                            if (Obj.Groups[i].Rows[w].Cols[r].Answers.length > 0) {
                                updateBodyStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[r].Answers[0].value + "\"";
                            }
                            updateBodyStr += ">";
                            break;
                        case "memo":
                            updateBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText != null) {
                                if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                    updateBodyStr += CheckRowFilling(Obj, i, firstRow, r, w);
                                } else {
                                    updateBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                                }
                            }
                            updateBodyStr += "<textarea onchange=\"changeTableJsonData(event)\" class=\"form-control mb-3\"name=\"";
                            updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                            updateBodyStr += ">";
                            if (Obj.Groups[i].Rows[w].Cols[r].Answers.length > 0) {
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].Answers[0].value;
                            }
                            updateBodyStr += "</textarea>";
                            break;
                        case "number":
                            updateBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText != null) {
                                if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                    updateBodyStr += CheckRowFilling(Obj, i, firstRow, r,w);
                                } else {
                                    updateBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                                }
                            }
                            updateBodyStr += "<input type=\"number\"onchange=\"changeTableJsonData(event)\" class=\"form-control mb-3\"name=\"";
                            updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                            if (Obj.Groups[i].Rows[w].Cols[r].Answers.length > 0) {
                                updateBodyStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[r].Answers[0].value + "\"";
                            }
                            updateBodyStr += ">";
                            break;
                        case "select":
                            updateBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText != null) {
                                if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                    updateBodyStr += CheckRowFilling(Obj, i, firstRow, r,w);
                                } else {
                                    updateBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                                }
                            }
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
                            updateBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText != null) {
                                if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                    updateBodyStr += CheckRowFilling(Obj, i, firstRow, r,w);
                                } else {
                                    updateBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                                }
                            }
                            for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[r].AnswerOptions.length; o++) {
                                updateBodyStr += "<div class=\"form-check mt-3\">"
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
                                        let isdisabled = Obj.Groups[i].Rows[w].Cols[r].Answers[o].value == true ? "" : "disabled";
                                        updateBodyStr += "<input onchange=\"changeTableJsonData(event)\" type=\"text\" style=\"max-width:100px\" class=\"form-control-border form-control-sm ml-2 mr-1 form-control d-inline mb-2\"name=\"";
                                        updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                        updateBodyStr += isdisabled+" ";
                                        updateBodyStr += "data-checkboxIndex=\"" + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index + "\"";
                                        if (Obj.Groups[i].Rows[w].Cols[r].Answers[o].value == true) {
                                            if (Obj.Groups[i].Rows[w].Cols[r].Answers[o].fillings.length > 0) {
                                                updateBodyStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[r].Answers[o].fillings[n].value + "\"";
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
                            if (Obj.Groups[i].Rows[w].Cols[r].hasOtherAnswers) {
                                updateBodyStr += "<div class=\"form-check mt-3\">"
                                updateBodyStr += "<input class=\"otherAns mr-3\" type=\"checkbox\" onclick=\"DisabledTrue(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                updateBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID;
                                updateBodyStr += "\"";
                                if (Obj.Groups[i].Rows[w].Cols[r].otherAnswer[0].value != null && Obj.Groups[i].Rows[w].Cols[r].otherAnswer[0].value != "") {
                                    updateBodyStr += "checked";
                                }
                                updateBodyStr += ">";
                                updateBodyStr += "<label>其他</label>";
                                updateBodyStr += "<input type=\"text\"onchange=\"changeTableJsonData(event)\"disabled style=\"max-width:100px\" class=\"form-control-border form-control-sm other d-inline col-3 ml-2 form-control mb-3\"name=\"";
                                updateBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                if (Obj.Groups[i].Rows[w].Cols[r].otherAnswer[0].value != null && Obj.Groups[i].Rows[w].Cols[r].otherAnswer[0].value != "") {
                                    updateBodyStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[r].otherAnswer[0].value + "\"";
                                }
                                updateBodyStr += "data-QID=\"" + Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                updateBodyStr += ">";
                                updateBodyStr += "</div>";
                            }
                            break;
                        case "radio":
                            updateBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText != null) {
                                if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                    updateBodyStr += CheckRowFilling(Obj, i, firstRow, r,w);
                                } else {
                                    updateBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                                }
                            }
                            for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[r].AnswerOptions.length; o++) {
                                updateBodyStr += "<div class=\"form-check mt-3\">"
                                updateBodyStr += "<input type=\"radio\"onchange=\"changeTableJsonData(event)\" onclick=\"CleanOthersForRow(event)\" class=\" mr-3\"name=\"";
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
                                let fSn = 1;
                                let n = 0;
                                let N = 0;
                                for (var s = 0; s < StrArr.length; s++) {
                                    if (StrArr[s].includes("^")) {
                                        let isdisabled = Obj.Groups[i].Rows[w].Cols[r].Answers[o].value == true ? "" : "disabled";
                                        updateBodyStr += "<input type=\"text\" onchange=\"changeTableJsonData(event)\" style=\"max-width:100px\" class=\"form-control-border form-control-sm form-control d-inline mb-2\"name=\"";//data-gidandrow
                                        updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                        updateBodyStr += "data-RadioIndex=\"" + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index + "\"";
                                        updateBodyStr += "data-TextIndex=\"" + fSn + "\"";
                                        updateBodyStr += isdisabled+" ";
                                        if (Obj.Groups[i].Rows[w].Cols[r].Answers[o].value) {
                                            updateBodyStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[r].Answers[o].fillings[N].value + "\"";
                                            console.log(Obj.Groups[i].Rows[w].Cols[r].Answers[o].fillings[N].value);
                                        }
                                        updateBodyStr += ">";
                                        fSn++;
                                        n++;
                                        let txt = StrArr[s].substring(2);
                                        if (txt != null) {
                                            updateBodyStr += "<span>" + txt + "</span>";
                                        }
                                        N++;
                                    } else {
                                        updateBodyStr += "<span>" + StrArr[s] + "</span>";

                                    }

                                }
                                //insertBodyStr += "</label>";
                                updateBodyStr += "</div>";
                            }
                            if (Obj.Groups[i].Rows[1].Cols[r].hasOtherAnswers) {
                                let time = new Date().getMilliseconds();
                                updateBodyStr += "<div class=\"form-check mt-3\">"
                                updateBodyStr += "<input class=\"otherAns  mr-3\" type=\"radio\" onclick=\"CleanOthers(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID;
                                updateBodyStr += "\"";
                                if (Obj.Groups[i].Rows[w].Cols[r].otherAnswer[0].value != null && Obj.Groups[i].Rows[w].Cols[r].otherAnswer[0].value != "") {
                                    updateBodyStr += "checked";
                                }
                                updateBodyStr += ">";
                                updateBodyStr += "<label >其他</label>";
                                updateBodyStr += "<input type=\"text\"onchange=\"changeTableJsonData(event)\"style=\"max-width:100px\" disabled class=\"form-control-border form-control-sm other d-inline col-3 ml-2 form-control mb-3\"name=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                if (Obj.Groups[i].Rows[w].Cols[r].otherAnswer[0].value != null && Obj.Groups[i].Rows[w].Cols[r].otherAnswer[0].value != "") {
                                    updateBodyStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[r].otherAnswer[0].value + "\"";
                                }
                                updateBodyStr += "data-QID=\"" + Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                updateBodyStr += ">";
                                updateBodyStr += "</div>";
                            }

                            break;
                        case "CheckboxMixImage":
                            updateBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText != null) {
                                if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                    updateBodyStr += CheckRowFilling(Obj, i, firstRow, r,w);
                                } else {
                                    updateBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                                }
                            }
                            let hasFill = false;
                            for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[r].AnswerOptions.length; o++) {
                                if (Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText.includes("##^")) {
                                    hasFill = true;
                                    break;
                                }
                            }
                            for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[r].AnswerOptions.length; o++) {
                                if (hasFill) {
                                    updateBodyStr += "<div class=\"form-check mt-3\">"
                                    updateBodyStr += "<input type=\"checkbox\" onchange=\"changeTableJsonData(event)\" onclick=\"DisabledTrue(event)\" class=\" mr-3\"name=\"";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                    updateBodyStr += "value=\"";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                    updateBodyStr += "\"id=\"";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText;
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index+"\"";
                                    if (Obj.Groups[i].Rows[w].Cols[r].Answers.length > 0) {
                                        if (Obj.Groups[i].Rows[w].Cols[r].Answers[o].value == true) {
                                            updateBodyStr += "checked";
                                        }
                                    }
                                    updateBodyStr += "\>";
                                    let fillingStr = Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText;
                                    let StrArr = fillingStr.split("##");
                                    let txtSn = 0;//填充
                                    for (var s = 0; s < StrArr.length; s++) {
                                        if (StrArr[s].includes("^")) {
                                            let isdisabled = Obj.Groups[i].Rows[w].Cols[r].Answers[o].value == true ? "" : "disabled";
                                            updateBodyStr += "<input type=\"text\" onchange=\"changeTableJsonData(event)\" style=\"width:20%\" class=\"form-control-border form-control-sm form-control d-inline mb-2\"name=\"";
                                            updateBodyStr += Obj.Groups[i].GroupID + "\"";
                                            updateBodyStr += isdisabled;
                                            updateBodyStr += " value=\"" + Obj.Groups[i].Rows[w].Cols[r].Answers[o].fillings[txtSn].value + "\"";
                                            updateBodyStr += ">";
                                            txtSn++;
                                            let txt = StrArr[s].substring(2);
                                            if (txt != null) {
                                                updateBodyStr += "<span>" + txt + "</span>";
                                            }
                                        } else {
                                            updateBodyStr += "<span>" + StrArr[s] + "</span>";
                                        }
                                    }
                                    updateBodyStr += "<img class=\"col-12\" src=\"";
                                    updateBodyStr += "ShowAdminImg.aspx?id=" + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].image + "\">";

                                } else {

                                    updateBodyStr += "<div class=\"form-check mt-3\">"
                                    updateBodyStr += "<input type=\"checkbox\" onchange=\"changeTableJsonData(event)\" class=\" mr-3\"name=\"";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                    updateBodyStr += "value=\"";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                    updateBodyStr += "\"id=\"";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText;
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                    updateBodyStr += "\">";

                                    if (Obj.Groups[i].Rows[w].Cols[r].Answers.length > 0) {
                                        if (Obj.Groups[i].Rows[w].Cols[r].Answers[o].value == true) {
                                            updateBodyStr += "checked";
                                        }
                                    }
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText;
                                    updateBodyStr += "<img class=\"col-12\" src=\"";
                                    updateBodyStr += "ShowAdminImg.aspx?id=" + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].image + "\">";

                                }
                                updateBodyStr += "</div>";
                            }
                            if (Obj.Groups[i].Rows[w].Cols[r].hasOtherAnswers) {
                                let time = new Date().getMilliseconds();
                                updateBodyStr += "<div class=\"form-check mt-3\">"
                                updateBodyStr += "<input class=\"otherAns  mr-3\" type=\"checkbox\" onclick=\"DisabledTrue(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + time;
                                updateBodyStr += "\"";
                                updateBodyStr += ">";
                                updateBodyStr += "<label>其他</label>";
                                updateBodyStr += "<input type=\"text\"onchange=\"changeTableJsonData(event)\" disabled class=\"other form-control-border form-control-sm d-inline col-3 ml-2 form-control mb-3\"name=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + time + "\"";
                                updateBodyStr += "data-QID=\"" + Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                updateBodyStr += ">";
                                updateBodyStr += "</div>";
                            }
                            break;
                        case "RadioMixCheckbox":
                            updateBodyStr += "<h5>" + Obj.Groups[i].Rows[0].Cols[r].QuestionText + "</h5>";
                            if (Obj.Groups[i].Rows[1].Cols[r].QuestionText != null) {
                                if (Obj.Groups[i].Rows[1].Cols[r].QuestionText.includes("##^")) {
                                    updateBodyStr += CheckRowFilling(Obj, i, firstRow, r,w);
                                } else {
                                    updateBodyStr += "<h6>" + Obj.Groups[i].Rows[1].Cols[r].QuestionText + "</h6>";
                                }
                            }

                            let radioHasFillings = false;
                            let checkboxHasFillings = false;
                            //radio有填充 radioHasFillings true
                            for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[r].AnswerOptions.length; o++) {
                                if (Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText.includes("##^")) {
                                    radioHasFillings = true;
                                    break;
                                }
                            }
                            //checkbox 有填充 checkboxHasFillings true
                            for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[r].AnswerOptions.length; o++) {
                                for (var c = 0; c < Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnswerOptions.length; c++) {
                                    if (Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnswerOptions[c].AnsText.includes("##^")) {
                                        checkboxHasFillings = true;
                                        break;
                                    }
                                }
                            }
                            for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[r].AnswerOptions.length; o++) {
                                //radio part
                                updateBodyStr += "<div class=\"form-check\">"
                                updateBodyStr += "<input type=\"radio\" onclick=\"CleanOptionforRow(event)\" onchange=\"changeTableJsonData(event)\" class=\" mr-3\"name=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                let isChecked = Obj.Groups[i].Rows[w].Cols[r].Answers[o].value == true?"checked ":"";
                                console.log("Obj.Groups[i].Rows[w].Cols[r].Answers[o].value:" + Obj.Groups[i].Rows[w].Cols[r].Answers[o].value);
                                updateBodyStr += isChecked;
                                updateBodyStr += "value=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                updateBodyStr += "\"id=\"";
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText;
                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                updateBodyStr += "\">";
                                //radio filling part
                                if (radioHasFillings) {
                                    let fillingStr = Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText;
                                    let StrArr = fillingStr.split("##");
                                    let fSn = 1;
                                    let ValueSn = 0;
                                    for (var s = 0; s < StrArr.length; s++) {
                                        if (StrArr[s].includes("^")) {
                                            let isdisabled = Obj.Groups[i].Rows[w].Cols[r].Answers[o].value == true ? "" : "disabled";
                                            updateBodyStr += "<input type=\"text\"  onchange=\"changeTableJsonData(event)\" style=\"max-width:100px\" class=\"form-control-border form-control-sm form-control d-inline mb-2\"name=\"";//data-gidandrow
                                            updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                            updateBodyStr += "data-RadioIndex=\"" + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index + "\"";
                                            updateBodyStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[r].Answers[o].fillings[ValueSn].value + "\"";
                                            updateBodyStr += "data-TextIndex=\"" + fSn + "\"";
                                            updateBodyStr += isdisabled;
                                            updateBodyStr += ">";
                                            fSn++;
                                            ValueSn++;
                                            let txt = StrArr[s].substring(2);
                                            if (txt != null) {
                                                updateBodyStr += "<span>" + txt + "</span>";
                                            }
                                        } else {
                                            updateBodyStr += "<span>" + StrArr[s] + "</span>";
                                        }
                                    }
                                    //insertBodyStr += "</label>";

                                } else {//沒有填充
                                    updateBodyStr += "<span>" + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnsText + "</span>";
                                }
                                //checkbox part
                                for (var k = 0; k < Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnswerOptions.length; k++) {
                                    if (checkboxHasFillings) {
                                        updateBodyStr += "<br/>";
                                    }
                                    let isChecked = Obj.Groups[i].Rows[w].Cols[r].Answers[o].Answers[k].value == true ? "checked " : "";
                                    updateBodyStr += "<input type=\"checkbox\"  onchange=\"changeTableJsonData(event)\" onclick=\"swichDisabledTrue(event)\"  class=\"ml-3 mr-1\"name=\"";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                    updateBodyStr += "value=\"";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnswerOptions[k].index;
                                    updateBodyStr += "\"id=\"";
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                    updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnswerOptions[k].index;
                                    updateBodyStr += "\"";
                                    updateBodyStr += isChecked;
                                    updateBodyStr += "data-RadioIndex=\"" + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index + "\"";
                                    updateBodyStr += "data-CheckboxIndex=\"" + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnswerOptions[k].index + "\">";
                                    if (checkboxHasFillings) {

                                        let fillingStr = Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnswerOptions[k].AnsText;
                                        let fSn = 1;
                                        let Fsn = 0;//ckheckbox 的填充答案
                                        let StrArr = fillingStr.split("##");
                                        for (var s = 0; s < StrArr.length; s++) {
                                            if (StrArr[s].includes("^")) {
                                                let isDisabled = Obj.Groups[i].Rows[w].Cols[r].Answers[o].Answers[k].value == true ? "" : "disabled";
                                                updateBodyStr += "<input type=\"text\" onchange=\"changeTableJsonData(event)\"  style=\"max-width:100px\" class=\"form-control-border form-control-sm ml-2 mr-2 form-control d-inline mb-2\"name=\"";
                                                updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                                updateBodyStr += isDisabled+" ";
                                                updateBodyStr += "data-RadioIndex=\"" + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index + "\"";
                                                updateBodyStr += "data-checkboxIndex=\"" + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnswerOptions[k].index + "\"";
                                                updateBodyStr += "data-TextIndex=\"" + fSn + "\"";
                                                updateBodyStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[r].Answers[o].Answers[k].fillings[Fsn].value+"\">";
                                                fSn++;
                                                Fsn++;
                                                let txt = StrArr[s].substring(2);
                                                if (txt != null) {
                                                    updateBodyStr += "<span>" + txt + "</span>";
                                                }
                                            } else {
                                                updateBodyStr += "<span>" + StrArr[s] + "</span>";
                                            }
                                        }

                                    } else {
                                        //選項
                                        updateBodyStr += "<label for=\"";
                                        updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].QuestionID + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].index;
                                        updateBodyStr += Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnswerOptions[k].index;
                                        updateBodyStr += "\"class=\"mr-2\">" + Obj.Groups[i].Rows[w].Cols[r].AnswerOptions[o].AnswerOptions[k].AnsText + "</label>"
                                        //選項
                                    }
                                }
                                updateBodyStr += "</div>";//form-check
                            }
                            if (Obj.Groups[i].Rows[1].Cols[r].hasOtherAnswers) {
                                let time = new Date().getMilliseconds();
                                updateBodyStr += "<div class=\"form-check mt-3\">"
                                updateBodyStr += "<input class=\"otherAns  mr-3\" type=\"radio\" onclick=\"DisabledTrue(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                                updateBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID;
                                updateBodyStr += "\"";
                                if (Obj.Groups[i].Rows[w].Cols[r].otherAnswer[0].value != null && Obj.Groups[i].Rows[w].Cols[r].otherAnswer[0].value != "") {
                                    updateBodyStr += "checked";
                                }
                                updateBodyStr += ">";
                                updateBodyStr += "<label >其他</label>";
                                updateBodyStr += "<input type=\"text\"onchange=\"changeTableJsonData(event)\" style=\"max-width:100px\" disabled class=\"form-control-border form-control-sm other d-inline col-3 ml-2 form-control mb-3\"name=\"";
                                updateBodyStr += Obj.Groups[i].Rows[1].Cols[r].QuestionID + "\"";
                                if (Obj.Groups[i].Rows[w].Cols[r].otherAnswer[0].value != null && Obj.Groups[i].Rows[w].Cols[r].otherAnswer[0].value != "") {
                                    updateBodyStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[r].otherAnswer[0].value + "\"";
                                }
                                updateBodyStr += "data-QID=\"" + Obj.Groups[i].Rows[w].Cols[r].QuestionID + "\"";
                                updateBodyStr += ">";
                                updateBodyStr += "</div>";
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
            let date = new Date();
            let today = new Date().getTime();
            let GroupId = event.currentTarget.id;
            let imgs = event.currentTarget.parentNode.parentNode.getElementsByTagName("img");
            let inputs = event.currentTarget.parentNode.parentNode.getElementsByTagName("input");
            let files = [];
            for (var i = 0; i < inputs.length; i++) {
                if (inputs[i].type == "file") {
                    files.push(inputs[i]);
                }
            }
            let SignImageBox = event.currentTarget.parentNode.parentNode.querySelectorAll(".SignImageBox");
            for (var m = 0; m < imgs.length; m++) {
                for (var i = 0; i < dataObj.Groups.length; i++) {
                    if (dataObj.Groups[i].GroupID == GroupId) {
                        let sn = dataObj.Groups[i].Rows.length - 1;
                        for (let c = 0; c < dataObj.Groups[i].Rows[sn].Cols.length; c++) {
                            if (dataObj.Groups[i].Rows[sn].Cols[c].QuestionID == imgs[m].name ) {
                                for (var s = 0; s <  SignImageBox.length; s++) {
                                    if (SignImageBox[s].classList.contains("d-inline")) {
                                        dataObj.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                        let sid = imgs[m].id;
                                        sid = sid.substring(4);
                                        console.log("img" + sid);
                                        dataObj.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": 1, "value": sid, "lastUpdate": today });
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

                                    } else if (SignImageBox[s].classList.contains("d-none")) {
                                        dataObj.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                        dataObj.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": 1, "value": 0, "lastUpdate": null });
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                    }
                                }
                            }
                        }
                    }
                }
                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
            }
            //file

            for (var f = 0; f < files.length; f++) {
                for (var i = 0; i < dataObj.Groups.length; i++) {
                    if (dataObj.Groups[i].GroupID == GroupId) {
                        for (var r = 0; r < dataObj.Groups[i].Rows.length; r++) {
                            for (var c = 0; c < dataObj.Groups[i].Rows[r].Cols.length; c++) {
                                if (dataObj.Groups[i].Rows[r].Cols[c].QuestionID == files[f].name) {
                                    if (dataObj.Groups[i].Rows[r].Cols[c].Answers[0].value != files[f].value) {
                                        //要更換
                                        if (files[f].value!="") {
                                            let now = date.getFullYear("yyyy") + String(date.getMonth() + 1).padStart(2, '0') + String(date.getDate()).padStart(2, '0') + String(date.getHours()).padStart(2, '0') + String(date.getMinutes()).padStart(2, '0') + String(date.getSeconds()).padStart(2, '0') + String(date.getMilliseconds()).padStart(3, '0');
                                            let fileName = files[f].value;
                                            fileName = fileName.substring("12");
                                            fileName = now + "_" + fileName;
                                            dataObj.Groups[i].Rows[r].Cols[c].Answers[0].value = fileName;
                                            dataObj.Groups[i].Rows[r].Cols[c].Answers[0].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            Upload(fileName);

                                        }
                                    }
                                }
                            }
                        }
                    }
                }
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
            Uploadname.innerText = "";
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
                } 
            }
            if (All == DataObj.Cols.length) {
                remove = true;
            }
            for (var i = 0; i < dataObj.Groups.length; i++) {
                if (dataObj.Groups[i].GroupID == GroupId) {
                    if (remove) {
                    //    DataObj.index = dataObj.Groups[i].Rows.length;
                    //    dataObj.Groups[i].Rows.push(DataObj);
                    //    dataObj.Groups[i].Rows = dataObj.Groups[i].Rows.slice(0, 2);
                    //    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                        dataObj.Groups[i].Rows.push(DataObj);
                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

                    } else if (isfile) {
                        dataObj.Groups[i].Rows.push(DataObj);
                        dataObj.Groups[i].Rows = dataObj.Groups[i].Rows.slice(0,2);
                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                    }
                    else {
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
            //memo
            let memos = event.currentTarget.parentNode.parentNode.getElementsByTagName("textarea");
            for (var m = 0; m < memos.length; m++) {
                for (var i = 0; i < dataObj2.Groups.length; i++) {
                    if (dataObj2.Groups[i].GroupID == GroupId) {
                        let sn = dataObj2.Groups[i].Rows.length - 1;
                        for (let c = 0; c < dataObj2.Groups[i].Rows[sn].Cols.length; c++)  {
                            if (dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID == memos[m].name) {
                                let index = c + 1;
                                let memoFillings = document.getElementsByName(memos[m].name);//題目的填充
                                let newMemofillings = [];
                                memoFillings.forEach(function (fill) {
                                    if (fill.dataset.isqfilling) {
                                        newMemofillings.push(fill);
                                    }
                                });
                                
                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                dataObj2.Groups[i].Rows[sn].Cols[c].fillings = [];
                                console.log("memos[m].value" + memos[m].value);
                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": index, "value": memos[m].value, "lastUpdate": today });
                                for (var f = 0; f < newMemofillings.length; f++) {
                                    dataObj2.Groups[i].Rows[sn].Cols[c].fillings.push({ "index": newMemofillings[f].dataset.filling, "value": newMemofillings[f].value, "lastUpdate": today })
                                }
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
                            if (dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID == imgs[m].name) {
                                for (var s = 0; s < SignImageBox.length; s++) {
                                    if (SignImageBox[s].classList.contains("d-inline")) {
                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                        let sid = imgs[m].id;
                                        sid = sid.substring(4);
                                        console.log("img" + sid);
                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": 1, "value": sid, "lastUpdate": today });
                                    } else if (SignImageBox[s].classList.contains("d-none")) {
                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": 1, "value": null, "lastUpdate": today });
                                    }

                                }
                            }
                        }
                    }
                }
                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
            }
            for (var d = 0; d < inputs.length; d++) {
                for (var i = 0; i < dataObj2.Groups.length; i++) {
                    if (dataObj2.Groups[i].GroupID == GroupId) {
                        let sn = dataObj2.Groups[i].Rows.length - 1;
                        for (let c = 0; c < dataObj2.Groups[i].Rows[sn].Cols.length; c++) {
                            let ColsSn = dataObj2.Groups[i].Rows[sn].Cols.length - 1;
                            if (dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID == inputs[d].name || dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID == inputs[d].name.substring(1) && inputs[d].type != "button") {
                                let Qtype = dataObj2.Groups[i].Rows[sn].Cols[c].QuestionType;//題目的
                                switch (Qtype) {
                                    case "file":
                                        dataObj2.Groups[i].Rows[sn].Cols[c].fillings = [];
                                        let allFillngs = document.getElementsByName(inputs[d].name);//題目的填充
                                        let fileFillngs = [];//題目的填充
                                        allFillngs.forEach(function (fill) {
                                            if (fill.dataset.isqfilling) {
                                                fileFillngs.push(fill);
                                            }
                                        });
                                        index = c + 1;
                                        let fileName = inputs[d].value;
                                        console.log("fileName" + fileName);
                                        if (fileName != "") {
                                            /*var re = /\.(jpg|png|doc|pdf|docx)$/i;*/
                                            //if (!re.test(fileName)) {
                                            //    alert("檔案格式錯誤!!請檢查!!")
                                            //    break;
                                            //} else {
                                            //}
                                            let now = date.getFullYear("yyyy") + String(date.getMonth() + 1).padStart(2, '0') + String(date.getDate()).padStart(2, '0') + String(date.getHours()).padStart(2, '0') + String(date.getMinutes()).padStart(2, '0') + String(date.getSeconds()).padStart(2, '0') + String(date.getMilliseconds()).padStart(3, '0');
                                            let oldfileName = fileName.substring("12");
                                            fileName = fileName.substring("12");
                                            fileName = now + "_" + fileName;
                                            Upload(fileName);
                                            dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                            dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": index, "value": fileName, "lastUpdate": today });

                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                            alert("檔案上傳成功!!")
                                        } else {
                                            dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                            dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": 1, "value": "", "lastUpdate": today });
                                        }
                                        for (var f = 0; f < fileFillngs.length; f++) {
                                            dataObj2.Groups[i].Rows[sn].Cols[c].fillings.push({ "index": fileFillngs[f].dataset.filling, "value": fileFillngs[f].value, "lastUpdate": today });
                                        }

                                        break;
                                    case "text":
                                        index = c + 1;
                                        let fillings = document.getElementsByName(inputs[d].name);//題目的填充
                                        let newfillings = [];
                                        fillings.forEach(function (fill) {
                                            if (fill.dataset.isqfilling) {
                                                newfillings.push(fill);
                                            }
                                        });
                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                        dataObj2.Groups[i].Rows[sn].Cols[c].fillings = [];
                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": index, "value": inputs[d].value, "lastUpdate": today });
                                        for (var f = 0; f < newfillings.length; f++) {
                                            dataObj2.Groups[i].Rows[sn].Cols[c].fillings.push({ "index": newfillings[f].dataset.filling, "value": newfillings[f].value, "lastUpdate": today })
                                        }
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                        break;
                                    
                                    case "number":
                                        index = c + 1;
                                        let dateAllfillings = document.getElementsByName(inputs[d].name);
                                        let datefillings = [];
                                        dateAllfillings.forEach(function (fill) {
                                            if (fill.dataset.isqfilling) {
                                                datefillings.push(fill);
                                            }
                                        });
                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": index, "value": inputs[d].value, "lastUpdate": today });
                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers.fillings = [];
                                        for (var f = 0; f < datefillings.length; f++) {
                                            ataObj2.Groups[i].Rows[sn].Cols[c].Answers.fillings.push({ "index": datefillings[f].dataset.filling, "value": datefillings[f].value, "lastUpdate": today });
                                        }
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                        break;
                                    case "date":
                                        index = c + 1;
                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                        let fillingsboxes = document.getElementsByName(inputs[d].name);//題目的填充

                                        let dateV = Date.parse(inputs[d].value);
                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": index, "value": dateV, "lastUpdate": today });
                                        dataObj2.Groups[i].Rows[sn].Cols[c].fillings = [];
                                        for (var f = 0; f < fillingsboxes.length; f++) {
                                            dataObj2.Groups[i].Rows[sn].Cols[c].fillings.push({ "index": f + 1, "value": fillingsboxes[f].value, "lastUpdate": today });
                                        }
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));

                                        break;
                                    case "checkbox":
                                        if (inputs[d].type == "checkbox") {
                                            let Smaecheckboxs = document.getElementsByName(inputs[d].name);
                                            let Checkboxs = [];
                                            let Txts = [];
                                            let fillings = [];
                                            let other;
                                            let others = document.querySelectorAll(".other");
                                            others.forEach(function (item) {
                                                if (item.dataset.qid == inputs[d].name) {
                                                    other = item;
                                                }
                                            })
                                            Smaecheckboxs.forEach(function (item) {
                                                if (item.dataset.isqfilling) {
                                                    fillings.push(item);
                                                }
                                            });
                                            Smaecheckboxs.forEach(function (item) {
                                                if (item.type == "checkbox") {
                                                    Checkboxs.push(item);
                                                }
                                            });
                                            Smaecheckboxs.forEach(function (item) {
                                                if (item.type == "text" && !item.classList.contains("other")) {
                                                    Txts.push(item);
                                                } else if (item.type == "text" && item.classList.contains("other")) {
                                                    other = item;
                                                }
                                            });
                                            dataObj2.Groups[i].Rows[sn].Cols[c].fillings = [];
                                            for (var f = 0; f < fillings.length; f++) {
                                                dataObj2.Groups[i].Rows[sn].Cols[c].fillings.push({ "index": fillings[f].dataset.filling, "value": fillings[f].value, "lastUpdate": today });
                                            }
                                            if (dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length > dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length) {
                                                for (var o = 0; o < dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length; o++) {
                                                    dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions[o].index, "value": false, "lastUpdate": today, "fillings": [] });
                                                }
                                            }
                                            let optCount = Txts.length / dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length;

                                            for (var b = 0; b < Checkboxs.length; b++) {
                                                if (Checkboxs[b].checked) {
                                                    if (dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length > b) {
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].value = true;
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].lastUpdate = today;
                                                        for (var t = 0; t < Txts.length; t++) {
                                                            if (Txts[t].dataset.checkboxindex == Checkboxs[b].value && optCount > dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].fillings.length) {
                                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].fillings.push({ "index": Number(Txts[t].dataset.textindex), "value": Txts[t].value, "lastUpdate": today });
                                                            }
                                                        }
                                                    }
                                                } else {
                                                    if (dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length > b) {
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].value = false;
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].lastUpdate = today;
                                                        for (var t = 0; t < Txts.length; t++) {
                                                            if (Txts[t].dataset.checkboxindex == Checkboxs[b].value && optCount > dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].fillings.length) {
                                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].fillings.push({ "index": Number(Txts[t].dataset.textindex), "value": "", "lastUpdate": today });
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
                                            if (dataObj2.Groups[i].Rows[sn].Cols[c].hasOtherAnswers) {
                                                dataObj2.Groups[i].Rows[sn].Cols[c].otherAnswer.length = 0;
                                                dataObj2.Groups[i].Rows[sn].Cols[c].otherAnswer.push({ "index": 1, "value": false, "lastUpdate": today, "fillings": [{ "index": 1, "value": other.value, "lastUpdate": today }] });
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                            }

                                            //給新QuestionID
                                            //dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID = dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID + today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));

                                        }

                                        break;
                                    case "CheckboxMixImage":
                                        let SameNames = document.getElementsByName(inputs[d].name);
                                        let sameCheckboxes = [];
                                        let SameTxt = [];
                                        let qfillings = [];
                                        SameNames.forEach(function (item) {
                                            if (item.dataset.isqfilling) {
                                                qfillings.push(item);
                                            }
                                        });

                                        SameNames.forEach(function (item) {
                                            if (item.type == "checkbox" && !item.classList.contains("otherAns")) {
                                                sameCheckboxes.push(item);
                                            }
                                        });
                                        SameNames.forEach(function (item) {
                                            if (item.type == "text" && !item.classList.contains("otherAns")) {
                                                SameTxt.push(item);
                                            }
                                        });
                                        let otherCkb;
                                        let otherCkbs = document.querySelectorAll(".other");
                                        otherCkbs.forEach(function (item) {
                                            if (item.dataset.qid == inputs[d].name) {
                                                otherCkb = item;
                                            }
                                        })
                                        dataObj2.Groups[i].Rows[sn].Cols[c].fillings = [];
                                        for (var f = 0; f < qfillings.length; f++) {
                                            dataObj2.Groups[i].Rows[sn].Cols[c].fillings.push({ "index": qfillings[f].dataset.filling, "value": qfillings[f].value, "lastUpdate": today });
                                        }
                                        if (dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length > dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length) {
                                            for (var o = 0; o < dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length; o++) {
                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions[o].index, "value": false, "lastUpdate": today ,"fillings":[]});
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                            }
                                        }
                                        
                                        for (var a = 0; a < dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length; a++) {
                                            let SameCkbTxts = [];
                                            SameTxt.forEach(function (item) {
                                                if (item.dataset.checkboxindex == dataObj2.Groups[i].Rows[sn].Cols[c].Answers[a].index) {
                                                    SameCkbTxts.push(item);
                                                }
                                            });
                                            let txtsn = 1;
                                            if (SameCkbTxts.length > dataObj2.Groups[i].Rows[sn].Cols[c].Answers[a].fillings.length) {
                                                for (var t = 0; t < SameCkbTxts.length; t++) {
                                                    if (SameCkbTxts[t].dataset.checkboxindex == dataObj2.Groups[i].Rows[sn].Cols[c].Answers[a].index) {
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[a].fillings.push({ "index": txtsn, "value": SameCkbTxts[t].value, "lastUpdate": today });
                                                        txtsn++;
                                                    }
                                                }
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
                                        if (dataObj2.Groups[i].Rows[sn].Cols[c].hasOtherAnswers) {
                                            dataObj2.Groups[i].Rows[sn].Cols[c].otherAnswer.length = 0;
                                            dataObj2.Groups[i].Rows[sn].Cols[c].otherAnswer.push({ "index": 1, "value": otherCkb.value, "lastUpdate": today });
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                        }
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                        break;
                                    case "radio":
                                        if (inputs[d].type == "radio") {
                                            let SmaeRadios = document.getElementsByName(inputs[d].name);
                                            let Radios = [];
                                            let Txts = [];
                                            let rfillings = [];
                                            let others = document.querySelectorAll(".other");
                                            let other;
                                            SmaeRadios.forEach(function (item) {
                                                if (item.dataset.isqfilling) {
                                                    rfillings.push(item);
                                                }
                                            });
                                            SmaeRadios.forEach(function (item) {
                                                if (item.type == "radio" && !item.classList.contains("otherAns")) {
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
                                                    dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions[o].index, "value": false, "lastUpdate": today, "fillings": [] });
                                                }
                                            }
                                            dataObj2.Groups[i].Rows[sn].Cols[c].fillings = [];
                                            for (var f = 0; f < rfillings.length; f++) {
                                                dataObj2.Groups[i].Rows[sn].Cols[c].fillings.push({ "index": rfillings[f].dataset.filling, "value": rfillings[f].value, "lastUpdate": today });
                                            }

                                            for (var r = 0; r < Radios.length; r++) {
                                                if (dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length > r) {
                                                    if (Radios[r].checked) {
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].value = true;
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].lastUpdate = today;
                                                        let optCount = Txts.length / dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length;
                                                        console.log("optCount" + optCount);
                                                        for (var t = 0; t < Txts.length; t++) {
                                                            if (Txts[t].dataset.radioindex == Radios[r].value && optCount > dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].fillings.length) {
                                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].fillings.push({ "index": Number(Txts[t].dataset.textindex), "value": Txts[t].value, "lastUpdate": today });
                                                            }
                                                        }
                                                    } else {
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].value = false;
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].lastUpdate = today;
                                                        let optCount = Txts.length / dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length;
                                                        for (var t = 0; t < Txts.length; t++) {
                                                            if (Txts[t].dataset.radioindex == Radios[r].value && optCount > dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].fillings.length) {
                                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].fillings.push({ "index": Number(Txts[t].dataset.textindex), "value": "", "lastUpdate": today });
                                                            }

                                                        }
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                                    }

                                                }
                                            }
                                            if (dataObj2.Groups[i].Rows[sn].Cols[c].hasOtherAnswers) {
                                                dataObj2.Groups[i].Rows[sn].Cols[c].otherAnswer.length = 0;
                                                let isTrue = other.value != null && other.value !=""? true : false;
                                                dataObj2.Groups[i].Rows[sn].Cols[c].otherAnswer.push({ "index": 1, "value": isTrue, "lastUpdate": today, "fillings": [{ "index": 1, "value": other.value, "lastUpdate": today }] });
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                            }
                                            //給新QuestionID
                                            //dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID = dataObj2.Groups[i].Rows[sn].Cols[c].QuestionID + today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                        }

                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                        break;
                                    case "display":
                                        let fillingboxes = document.getElementsByName(inputs[d].name);
                                        console.log("fillingboxes:" + fillingboxes);
                                        let fillingStr = dataObj2.Groups[i].Rows[sn].Cols[c].QuestionText;
                                        let StrArr = fillingStr.split("##");
                                        let n = 1;
                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                        dataObj2.Groups[i].Rows[sn].Cols[c].fillings = [];
                                        if (fillingboxes.length > dataObj2.Groups[i].Rows[sn].Cols[c].fillings.length) {
                                            for (var f = 0; f < fillingboxes.length; f++) {
                                                dataObj2.Groups[i].Rows[sn].Cols[c].fillings.push({ "index": n, "value": fillingboxes[f].value, "lastUpdate": today });
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
                                        let qtxt = [];
                                        items.forEach(function (item) {
                                            if (item.type == "img") {
                                                img.push(item);
                                            }
                                        });
                                        items.forEach(function (item) {
                                            if (item.dataset.isqfilling) {
                                                qtxt.push(item);
                                            }
                                        });
                                        dataObj2.Groups[i].Rows[sn].Cols[c].fillings = [];
                                        for (var f = 0; f < qtxt.length; f++) {
                                            dataObj2.Groups[i].Rows[sn].Cols[c].fillings.push({ "index": qtxt[f].dataset.filling, "value": qtxt[f].value, "lastUpdate": today });
                                        }
                                        for (var m = 0; m < img.length; m++) {
                                            let signId = img[m].id.substring(4);
                                            dataObj2.Groups[i].Rows[sn].Cols[c].Answers[0].push({ "index": 1, "value": null, "image": signId, "lastUpdate": today });
                                        }
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));

                                        break;
                                    case "RadioMixCheckbox":
                                        if (inputs[d].type == "radio") {
                                            console.log("RadioMixCheckBox")
                                            let Smaeradios = document.getElementsByName(inputs[d].name);

                                            let Radios = [];
                                            let Ckbs = [];
                                            let txts = [];//input text
                                            let rcfillings = [];
                                            let others = document.querySelectorAll(".other");
                                            let other;//其他
                                            if (!remove) {
                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length = 0;
                                            }
                                            others.forEach(function (item) {
                                                if (item.dataset.isqfilling) {
                                                    rcfillings.push(item);
                                                }
                                            });
                                            others.forEach(function (item) {
                                                if (item.dataset.qid == inputs[d].name) {
                                                    other = item;
                                                }
                                            });
                                            Smaeradios.forEach(function (item) {
                                                if (item.type == "radio" && !item.classList.contains("otherAns")) {
                                                    Radios.push(item);
                                                }
                                            });
                                            Smaeradios.forEach(function (item) {
                                                if (item.type == "checkbox") {
                                                    Ckbs.push(item);
                                                }
                                            });
                                            Smaeradios.forEach(function (item) {
                                                if (item.type == "text" && !item.classList.contains("otherAns")) {
                                                    txts.push(item);
                                                }
                                            });
                                            dataObj2.Groups[i].Rows[sn].Cols[c].fillings = [];
                                            for (var f = 0; f < rcfillings.length; f++) {
                                                dataObj2.Groups[i].Rows[sn].Cols[c].fillings.push({ "index": rcfillings[f].dataset.filling, "value": rcfillings[f].value, "lastUpdate": today});
                                            }
                                            if (dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length > dataObj2.Groups[i].Rows[sn].Cols[c].Answers.length) {
                                                for (var o = 0; o < dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length; o++) {
                                                    dataObj2.Groups[i].Rows[sn].Cols[c].Answers.push({ "index": dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions[o].index, "value": false, "lastUpdate": "","fillings":[], "Answers": [] });
                                                }
                                            }
                                            for (var r = 0; r < Radios.length; r++) {
                                                if (dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length >r) {
                                                    if (Radios[r].checked) {//radio 被選
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].value = true;
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].lastUpdate = today;
                                                        for (var t = 0; t < txts.length; t++) {//radio下面的fillings
                                                            if (txts[t].dataset.radioindex == Radios[r].value && txts[t].dataset.checkboxindex==null) {
                                                                if (txts[t].dataset.textindex>dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].fillings.length) {
                                                                    dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].fillings.push({ "index": Number(txts[t].dataset.textindex), "value": txts[t].value, "lastUpdate": today });
                                                                    dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].fillings = dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].fillings.sort(function (a, b) { return a.index < b.index ? 1 : -1 });
                                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));

                                                                }
                                                            }
                                                        }
                                                        for (var b = 0; b < Ckbs.length; b++) {//radio 下面的 checkbox
                                                            if (Ckbs[b].dataset.radioindex == Radios[r].value && dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions[r].AnswerOptions.length > dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers.length) {
                                                                if (Ckbs[b].checked) {
                                                                    dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers.push({ "index": Number(Ckbs[b].dataset.checkboxindex), "value": true, "lastUpdate": today ,"fillings":[]});
                                                                    //checkbox 下面的fillings
                                                                    for (var t = 0; t < txts.length; t++) {
                                                                        if (txts[t].dataset.radioindex == Radios[r].value && txts[t].dataset.checkboxindex == Ckbs[b].dataset.checkboxindex) {
                                                                            for (var a = 0; a < dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers.length; a++) {
                                                                                if (txts[t].dataset.textindex > dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers[a].fillings.length) {
                                                                                    dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers[a].fillings.push({ "index": txts[t].dataset.textindex, "value": txts[t].value, "lastUpdate": today });
                                                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                                                                }
                                                                            }
                                  
                                                                        }
                                                                    }
                                                                } else {
                                                                    dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers.push({ "index": Number(Ckbs[b].dataset.checkboxindex), "value": false, "lastUpdate": today, "fillings": [] });
                                                                    for (var t = 0; t < txts.length; t++) {
                                                                        if (txts[t].dataset.radioindex == Radios[r].value && txts[t].dataset.checkboxindex == Ckbs[b].dataset.checkboxindex) {
                                                                            for (var a = 0; a < dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers.length; a++) {
                                                                                if (txts[t].dataset.textindex > dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers[a].fillings.length) {
                                                                                    dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers[a].fillings.push({ "index": txts[t].dataset.textindex, "value": txts[t].value, "lastUpdate": today });
                                                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                                                                }
                                                                            }

                                                                        }
                                                                    }

                                                                }
                                                            }
                                                        }
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));

                                                    } else {//radip 未被選
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].value = false;
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].lastUpdate = today;
                                                        for (var t = 0; t < txts.length; t++) {
                                                            if (txts[t].dataset.radioindex == Radios[r].value && txts[t].dataset.checkboxindex==null) {
                                                                if (txts[t].dataset.textindex > dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].fillings.length) {
                                                                    dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].fillings.push({ "index": txts[t].dataset.textindex, "value": "", "lastUpdate": today });
                                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                                                }

                                                            }
                                                        }
                                                        
                                                        for (var b = 0; b < Ckbs.length; b++) {
                                                            if (Ckbs[b].dataset.radioindex == Radios[r].value && dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions[r].AnswerOptions.length > dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers.length) {
                                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers.push({ "index": Number(Ckbs[b].dataset.checkboxindex), "value": false, "lastUpdate": today,"fillings":[] });
                                                                for (var t = 0; t < txts.length; t++) {
                                                                    if (txts[t].dataset.radioindex == Ckbs[b].dataset.radioindex && txts[t].dataset.checkboxindex == Ckbs[b].dataset.checkboxindex) {
                                                                        for (var a = 0; a < dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers.length; a++) {
                                                                            if (txts[t].dataset.textindex > dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers[a].fillings.length) {
                                                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers[r].Answers[a].fillings.push({ "index": txts[t].dataset.textindex, "value": txts[t].value, "lastUpdate": today });
                                                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                                                            }
                                                                        }

                                                                    }
                                                                }

                                                            }
                                                        }
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj2));
                                                    }

                                                }

                                                if (dataObj2.Groups[i].Rows[sn].Cols[c].hasOtherAnswers == true) {
                                                    dataObj2.Groups[i].Rows[sn].Cols[c].otherAnswer.length = 0;
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
                                            let optCount = Txts.length / dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length;

                                            for (var b = 0; b < Checkboxs.length; b++) {
                                                if (Checkboxs[b].checked) {
                                                    if (dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length>b) {
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].value = true;
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].lastUpdate = today;
                                                        for (var t = 0; t < Txts.length; t++) {
                                                            if (Txts[t].dataset.checkboxindex == Checkboxs[b].value && optCount > dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].Answers.length) {
                                                                dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].Answers.push({ "index": Number(Txts[t].dataset.textindex), "value": Txts[t].value, "lastUpdate": today });
                                                            }
                                                        }
                                                    }
                                                } else {
                                                    if (dataObj2.Groups[i].Rows[sn].Cols[c].AnswerOptions.length > b) {
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].value = false;
                                                        dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].lastUpdate = today;
                                                        for (var t = 0; t < Txts.length; t++) {
                                                            if (Txts[t].dataset.checkboxindex == Checkboxs[b].value && optCount > dataObj2.Groups[i].Rows[sn].Cols[c].Answers[b].Answers.length) {
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
                                                dataObj2.Groups[i].Rows[sn].Cols[c].otherAnswer.length = 0;
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
                        let time = new Date().getMilliseconds();
                        dataObj2.Groups[i].Rows[lastRow].Cols[c].QuestionID = dataObj2.Groups[i].Rows[lastRow].Cols[c].QuestionID + row + col + time;
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
        //row 刪除 
        function DeleteRow(event) {
            var dataObj = GetJsonData();
            let gid = event.currentTarget.dataset.gid;
            let row = Number(event.currentTarget.dataset.row);
            if (dataObj.Groups[gid].Rows.length==2) {
                for (var i = 0; i < dataObj.Groups[gid].Rows[row].Cols.length; i++) {
                    dataObj.Groups[gid].Rows[row].Cols[i].Answers.length = 0;
                }
                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

            } else {
                dataObj.Groups[gid].Rows.splice(row, 1);
                for (var i = 0; i < dataObj.Groups[gid].Rows.length; i++) {
                    dataObj.Groups[gid].Rows[i], index = i + 1;
                }
                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

            }
            let allRow = document.querySelectorAll(".rowPart");
            for (var i = 0; i < allRow.length; i++) {
                allRow[i].innerHTML = "";
            }
            let normals = document.querySelectorAll(".normal");
            for (var i = 0; i < normals.length; i++) {
                normals[i].innerHTML = "";
            }
            GroupsTemplate(dataObj);
        }

        //Table跟Row的 資料變動時改變Json內容
        function changeTableJsonData(event) {
            var dataObj = GetJsonData();
            let thischange = event.currentTarget;
            let thischangeType = thischange.type;
            let thischangeQ = thischange.name;
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
                                    /*var re = /\.(jpg|png|doc|pdf|docx)$/i; */ //允許的副檔名
                                    console.log("file");
                                    if (fileName != null) {
                                        //let AppendFileName = document.querySelector("#MainContent_AppendFile");
                                        //if (!re.test(fileName)) {
                                        //    alert("檔案格式錯誤!!請檢查!!")
                                        //    break;
                                        //} else {
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
                                                    let oldfileName = fileName.split("_");
                                                    event.currentTarget.innerText = oldfileName[1];
                                                    alert("檔案上傳成功!")
                                                } else if (dataObj.Groups[i].GroupType == "table") {
                                                    let oldfileName = fileName.split("_");
                                                    event.currentTarget.parentNode.innerText ="上傳檔案:"+oldfileName[1];
                                                    dataObj.Groups[i].Rows[j].Cols[q].Answers.push({ "index": 1, "value": fileName, "lastUpdate": today})
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                   
                                                }
                                            }
                                    //    }
                                    }

                                }

                            }
                        }
                    }
                    break;
                case "textarea":
                case "text":
                case "number":
                case "date":
                case "select-one":
                    console.log("CheckboxMixRadio");
                    for (let t = 0; t < dataObj.Groups.length; t++) {
                        if (dataObj.Groups[t].GroupType != "normal") {
                            for (let i = 0; i < dataObj.Groups[t].Rows.length; i++) {
                                for (let c = 0; c < dataObj.Groups[t].Rows[i].Cols.length; c++) {
                                    if (dataObj.Groups[t].Rows[i].Cols[c].QuestionID == thischangeQ && dataObj.Groups[t].Rows[i].Cols[c].QuestionType == "text") {
                                        if (thischange.dataset.isfilling) {//table
                                            let sn = Number(thischange.dataset.filling) - 1;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        } else if (thischange.dataset.isqfilling) {//row
                                            console.log("Rows" + i);
                                            let sn = Number(thischange.dataset.filling) - 1;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        }
                                        else {
                                            dataObj.Groups[t].Rows[i].Cols[c].Answers[0].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].Answers[0].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        }
                                    }
                                    else if (dataObj.Groups[t].Rows[i].Cols[c].QuestionID == thischangeQ && dataObj.Groups[t].Rows[i].Cols[c].QuestionType == "memo") {
                                        if (thischange.dataset.isfilling) {//table
                                            let sn = Number(thischange.dataset.filling) - 1;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        } else if (thischange.dataset.isqfilling) {//row
                                            console.log("Rows" + i);
                                            let sn = Number(thischange.dataset.filling) - 1;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        }
                                        else {
                                            dataObj.Groups[t].Rows[i].Cols[c].Answers[0].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].Answers[0].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        }
                                    }
                                    else if (dataObj.Groups[t].Rows[i].Cols[c].QuestionID == thischangeQ && dataObj.Groups[t].Rows[i].Cols[c].QuestionType == "number") {
                                        if (thischange.dataset.isfilling) {
                                            
                                            let sn = Number(thischange.dataset.filling) - 1;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        } else {
                                            dataObj.Groups[t].Rows[i].Cols[c].Answers[0].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].Answers[0].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        }
                                    }
                                    else if (dataObj.Groups[t].Rows[i].Cols[c].QuestionID == thischangeQ && dataObj.Groups[t].Rows[i].Cols[c].QuestionType == "date") {
                                        if (thischange.dataset.isfilling) {
                                            console.log("date isfilling");
                                            let sn = Number(thischange.dataset.filling) - 1;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        } else {
                                            dataObj.Groups[t].Rows[i].Cols[c].Answers[0].value = Date.parse(thischange.value);
                                            dataObj.Groups[t].Rows[i].Cols[c].Answers[0].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        }
                                    }
                                    else if (dataObj.Groups[t].Rows[i].Cols[c].QuestionID == thischangeQ && dataObj.Groups[t].Rows[i].Cols[c].QuestionType == "sign") {
                                        if (thischange.dataset.isfilling) {
                                            let sn = Number(thischange.dataset.filling) - 1;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        } 
                                    } else if (dataObj.Groups[t].Rows[i].Cols[c].QuestionID == thischangeQ && dataObj.Groups[t].Rows[i].Cols[c].QuestionType == "file") {
                                        if (thischange.dataset.isfilling) {
                                            console.log("file");
                                            let sn = Number(thischange.dataset.filling) - 1;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        } else if (thischange.dataset.isqfilling) {
                                            let sn = Number(thischange.dataset.filling) - 1;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        }
                                    }
                                    else if (dataObj.Groups[t].Rows[i].Cols[c].QuestionID == thischangeQ && dataObj.Groups[t].Rows[i].Cols[c].QuestionType == "select") {
                                        if (thischange.dataset.isfilling) {
                                            let sn = Number(thischange.dataset.filling) - 1;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        } else {
                                            dataObj.Groups[t].Rows[i].Cols[c].Answers[0].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].Answers[0].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        }
                                    }
                                    else if (dataObj.Groups[t].Rows[i].Cols[c].QuestionID == thischangeQ && dataObj.Groups[t].Rows[i].Cols[c].QuestionType == "display") {
                                        console.log("display");
                                        if (dataObj.Groups[t].Rows[i].Cols[c].QuestionText.includes("##^")) {
                                            let fsn = Number(thischange.dataset.filling)-1;
                                            let indexfsn = Number(thischange.dataset.filling);
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[fsn].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[fsn].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        }
                                    }
                                    else if (dataObj.Groups[t].Rows[i].Cols[c].QuestionType == "radio" && dataObj.Groups[t].Rows[i].Cols[c].QuestionID == thischangeQ) {
                                        console.log("radio");
                                        if (thischange.classList.contains("other")) {
                                            dataObj.Groups[t].Rows[i].Cols[c].otherAnswer[0].value = true;
                                            dataObj.Groups[t].Rows[i].Cols[c].otherAnswer[0].fillings[0].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].otherAnswer[0].lastUpdate = today;
                                            dataObj.Groups[t].Rows[i].Cols[c].otherAnswer[0].fillings[0].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        }
                                        if (thischange.dataset.isfilling) {
                                            let sn = Number(thischange.dataset.filling) - 1;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

                                        } else {
                                            let radioindex = thischange.dataset.radioindex;
                                            let textindex = thischange.dataset.textindex;

                                            for (let o = 0; o < dataObj.Groups[t].Rows[i].Cols[c].Answers.length; o++) {
                                                if (dataObj.Groups[t].Rows[i].Cols[c].Answers[o].index == radioindex) {
                                                    for (var a = 0; a < dataObj.Groups[t].Rows[i].Cols[c].Answers[o].fillings.length; a++) {
                                                        if (dataObj.Groups[t].Rows[i].Cols[c].Answers[o].fillings[a].index == textindex) {
                                                            if (dataObj.Groups[t].Rows[i].Cols[c].Answers[o].value == true) {
                                                                dataObj.Groups[t].Rows[i].Cols[c].Answers[o].fillings[a].value = thischange.value;
                                                                dataObj.Groups[t].Rows[i].Cols[c].Answers[o].fillings[a].lastUpdate = today;
                                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                            }
                                                        }
                                                    }
                                                } else {
                                                    for (var a = 0; a < dataObj.Groups[t].Rows[i].Cols[c].Answers[o].fillings.length; a++) {
                                                        dataObj.Groups[t].Rows[i].Cols[c].Answers[o].fillings[a].value = "";
                                                        dataObj.Groups[t].Rows[i].Cols[c].Answers[o].fillings[a].lastUpdate = today;
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

                                                    }

                                                }
                                            }

                                        }
                                    }
                                    else if (dataObj.Groups[t].Rows[i].Cols[c].QuestionType == "checkbox" && dataObj.Groups[t].Rows[i].Cols[c].QuestionID == thischange.name) {//Checkbox下面的filling
                                        console.log("Checkbox filling")
                                        if (thischange.classList.contains("other")) {
                                            dataObj.Groups[t].Rows[i].Cols[c].otherAnswer[0].value = true;
                                            dataObj.Groups[t].Rows[i].Cols[c].otherAnswer[0].fillings[0].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].otherAnswer[0].lastUpdate = today;
                                            dataObj.Groups[t].Rows[i].Cols[c].otherAnswer[0].fillings[0].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        }
                                        if (thischange.dataset.isfilling) {
                                            let sn = Number(thischange.dataset.filling) - 1;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        } else {
                                            
                                            let checkboxindex = Number(thischange.dataset.checkboxindex);
                                            let textindex = Number(thischange.dataset.textindex);
                                            if (dataObj.Groups[t].Rows[i].Cols[c].Answers[checkboxindex-1].value) {
                                                dataObj.Groups[t].Rows[i].Cols[c].Answers[checkboxindex - 1].fillings[textindex-1].value = thischange.value;
                                                dataObj.Groups[t].Rows[i].Cols[c].Answers[checkboxindex - 1].fillings[textindex-1].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            }
                                        //    for (let o = 0; o < dataObj.Groups[t].Rows[i].Cols[c].Answers.length; o++) {
                                        //        if (dataObj.Groups[t].Rows[i].Cols[c].Answers[o].index == checkboxindex) {
                                        //            for (var a = 0; a < dataObj.Groups[t].Rows[i].Cols[c].Answers[o].fillings.length; a++) {
                                        //                if (dataObj.Groups[t].Rows[i].Cols[c].Answers[o].fillings[a].index == textindex) {
                                                            
                                        //                    if (dataObj.Groups[t].Rows[i].Cols[c].Answers[o].value == true) {
                                        //                        dataObj.Groups[t].Rows[i].Cols[c].Answers[o].fillings[a].value = thischange.value;
                                        //                        dataObj.Groups[t].Rows[i].Cols[c].Answers[o].fillings[a].lastUpdate = today;

                                        //                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        //                    } else {
                                        //                        dataObj.Groups[t].Rows[i].Cols[c].Answers[o].fillings[a].value = "";
                                        //                        dataObj.Groups[t].Rows[i].Cols[c].Answers[o].fillings[a].lastUpdate = today;
                                        //                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

                                        //                    }
                                        //                }
                                        //            }
                                        //        }
                                        //    }
                                        }
                                    }
                                    else if (dataObj.Groups[t].Rows[i].Cols[c].QuestionType == "CheckboxMixImage" && dataObj.Groups[t].Rows[i].Cols[c].QuestionID == thischange.name ) {
                                        if (thischange.dataset.isfilling) {
                                            let sn = Number(thischange.dataset.filling) - 1;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        } else {
                                            let checkboxindex = thischange.dataset.checkboxindex;
                                            let textindex = thischange.dataset.textindex;
                                            for (let o = 0; o < dataObj.Groups[t].Rows[i].Cols[c].Answers.length; o++) {
                                                if (dataObj.Groups[t].Rows[i].Cols[c].Answers[o].index == checkboxindex) {
                                                    for (var a = 0; a < dataObj.Groups[t].Rows[i].Cols[c].Answers[o].fillings.length; a++) {
                                                        if (dataObj.Groups[t].Rows[i].Cols[c].Answers[o].fillings[a].index == textindex) {
                                                            if (dataObj.Groups[t].Rows[i].Cols[c].Answers[o].value) {
                                                                dataObj.Groups[t].Rows[i].Cols[c].Answers[o].fillings[a].value = thischange.value;
                                                                dataObj.Groups[t].Rows[i].Cols[c].Answers[o].fillings[a].lastUpdate = today;
                                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                            } else {
                                                                dataObj.Groups[t].Rows[i].Cols[c].Answers[o].fillings[a].value = "";
                                                                dataObj.Groups[t].Rows[i].Cols[c].Answers[o].fillings[a].lastUpdate = today;
                                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    else if (dataObj.Groups[t].Rows[i].Cols[c].QuestionType == "RadioMixCheckbox" && dataObj.Groups[t].Rows[i].Cols[c].QuestionID == thischange.name) {
                                        if (thischange.dataset.isfilling) {
                                            let sn = Number(thischange.dataset.filling) - 1;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        } else {
                                            let radioindex = thischange.dataset.radioindex;
                                            let textindex = thischange.dataset.textindex;
                                            let checkboxindex = thischange.dataset.checkboxindex;
                                            if (checkboxindex == undefined) {
                                                //fillings of radio has change value
                                                let radioSn = Number(radioindex) - 1;
                                                let txtSn = Number(textindex) - 1;
                                                dataObj.Groups[t].Rows[i].Cols[c].Answers[radioSn].fillings[txtSn].value = thischange.value;
                                                dataObj.Groups[t].Rows[i].Cols[c].Answers[radioSn].fillings[txtSn].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            } else {
                                                //fillings of checkbox has change value
                                                let radioSn = Number(radioindex) - 1;
                                                let CbSn = Number(checkboxindex) - 1;
                                                let txtSn = Number(textindex) - 1;
                                                dataObj.Groups[t].Rows[i].Cols[c].Answers[radioSn].Answers[CbSn].fillings[txtSn].value = thischange.value;
                                                dataObj.Groups[t].Rows[i].Cols[c].Answers[radioSn].Answers[CbSn].fillings[txtSn].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            }

                                        }
                                    }
                                    else if (dataObj.Groups[t].Rows[i].Cols[c].QuestionType == "CheckboxMixRadio" && dataObj.Groups[t].Rows[i].Cols[c].QuestionID == thischange.name) {
                                       
                                        if (thischange.dataset.isfilling) {
                                            let sn = Number(thischange.dataset.filling) - 1;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].value = thischange.value;
                                            dataObj.Groups[t].Rows[i].Cols[c].fillings[sn].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        } else {
                                           
                                            let radioindex = thischange.dataset.rd;
                                            let textindex = thischange.dataset.textindex;
                                            let checkboxindex = thischange.dataset.ckb;
                                            let fsn = thischange.dataset.fsn;
                                            if (fsn == undefined) {
                                                //fillings of radio has change value 第二層
                                                
                                                let radioSn = Number(radioindex) - 1;
                                                let txtSn = Number(textindex) - 1;
                                                let CbSn = Number(checkboxindex) - 1;
                                                dataObj.Groups[t].Rows[i].Cols[c].Answers[CbSn].Answers[radioSn].fillings[txtSn].value = thischange.value;
                                                dataObj.Groups[t].Rows[i].Cols[c].Answers[CbSn].Answers[radioSn].fillings[txtSn].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            } else {
                                                //fillings of checkbox has change value 第一層
                                                
                                                let CbSn = Number(checkboxindex) - 1;
                                                let txtSn = Number(fsn) - 1;
                                                dataObj.Groups[t].Rows[i].Cols[c].Answers[CbSn].fillings[txtSn].value = thischange.value;
                                                dataObj.Groups[t].Rows[i].Cols[c].Answers[CbSn].fillings[txtSn].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            }

                                        }
                                    }
                                    else if (thischange.classList.contains("other")) {
                                        for (let c = 0; c < dataObj.Groups[t].Rows[i].Cols.length; c++) {
                                            if (dataObj.Groups[t].Rows[i].Cols[c].hasOtherAnswers && dataObj.Groups[t].Rows[i].Cols[c].QuestionID == thischange.name) {
                                                console.log("other" + thischange.value);
                                                dataObj.Groups[t].Rows[i].Cols[c].otherAnswer[0].fillings[0].value = thischange.value;
                                                dataObj.Groups[t].Rows[i].Cols[c].otherAnswer[0].fillings[0].lastUpdate = today;
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
                                                    if (dataObj.Groups[i].Rows[r].Cols[c].hasOtherAnswers) {
                                                        dataObj.Groups[i].Rows[r].Cols[c].otherAnswer[0].value = null;
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                    }
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                }
                                            }
                                        } else {
                                            for (var a = 0; a < dataObj.Groups[i].Rows[r].Cols[c].Answers.length; a++) {
                                                if (thischange.value == dataObj.Groups[i].Rows[r].Cols[c].Answers[a].index) {
                                                    dataObj.Groups[i].Rows[r].Cols[c].fillings.forEach(function (fill) {
                                                        fill.value = "";
                                                        fill.lastUpdate = today;
                                                    });
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
                                                dataObj.Groups[t].Rows[i].Cols[c].otherAnswer[0].fillings[0].value = thischange.value;
                                                dataObj.Groups[t].Rows[i].Cols[c].otherAnswer[0].fillings[0].lastUpdate = today;
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
                                                            for (var f = 0; f < dataObj.Groups[i].Rows[r].Cols[c].Answers[a].Answers[aa].fillings.length; f++) {
                                                                dataObj.Groups[i].Rows[r].Cols[c].Answers[a].Answers[aa].fillings[f].value = "";
                                                                dataObj.Groups[i].Rows[r].Cols[c].Answers[a].Answers[aa].fillings[f].lastUpdate = today;
                                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                            }
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
                                                if (thischange.classList.contains("otherAns")) {
                                                    dataObj.Groups[i].Rows[r].Cols[c].otherAnswer[0].value = null;
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                }
                                                for (var a = 0; a < dataObj.Groups[i].Rows[r].Cols[c].Answers.length; a++) {
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
            let date = new Date();
            let today = date.getTime();
            console.log(thischange.type)
            switch (thischange.type) {

                case "file":
                case "image":
                    for (var i = 0; i < dataObj.Groups.length; i++)  {
                        if (dataObj.Groups[i].GroupType == "normal") {
                            for (var j = 0; j < dataObj.Groups[i].Questions.length; j++) {
                                //檢查檔名
                                let fileName = thischange.value;
                                /*var re = /\.(jpg|png|doc|pdf|docx|excel)$/i;  //允許的副檔名*/
                                console.log("file");
                                //let AppendFileName = document.querySelector("#MainContent_AppendFile");
                                //if (!re.test(fileName)) {
                                //    alert("檔案格式錯誤!!請檢查!!")
                                //    break;
                                //} else {
                                //}
                                if (dataObj.Groups[i].Questions[j].QuestionID == event.currentTarget.name) {
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
                                        dataObj.Groups[i].Questions[j].Answers.push({ "index": 1, "value": fileName, "lastUpdate": today, "fillings": [] });
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        alert("檔案上傳成功!")
                                    }
                                }

                            }
                        }
                    }
                    break;
                case "textarea":
                case "text":
                case "number":
                case "date":
                case "select-one":
                    let ThisName = event.currentTarget.name;
                    let thisNameQ = ThisName.split("_");
                    for (var i = 0; i < dataObj.Groups.length; i++) {
                        if (dataObj.Groups[i].GroupType == "normal") {
                            for (var j = 0; j < dataObj.Groups[i].Questions.length; j++) {
                                if (dataObj.Groups[i].Questions[j].QuestionID == event.currentTarget.name) {
                                    switch (dataObj.Groups[i].Questions[j].QuestionType) {
                                        case "memo":
                                        case "text":
                                        case "number":
                                        case "select":
                                            if (event.currentTarget.dataset.isquentionfilling) {
                                                let sn = Number(event.currentTarget.dataset.textindex) - 1
                                                dataObj.Groups[i].Questions[j].fillings[sn].value = event.currentTarget.value;
                                                dataObj.Groups[i].Questions[j].fillings[sn].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            } else {
                                                dataObj.Groups[i].Questions[j].Answers.length = 0;
                                                dataObj.Groups[i].Questions[j].Answers.push({ "index": 1, "value": event.currentTarget.value, "lastUpdate": today, "fillings": [] });
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            }
                                            break;
                                        case "date":
                                            dataObj.Groups[i].Questions[j].Answers.length = 0;
                                            let time = new Date(event.currentTarget.value).getTime();
                                            if (event.currentTarget.dataset.isquentionfilling) {
                                                let sn = Number(event.currentTarget.dataset.textindex) - 1
                                                dataObj.Groups[i].Questions[j].fillings[sn].value = event.currentTarget.value;
                                                dataObj.Groups[i].Questions[j].fillings[sn].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            } else {
                                                dataObj.Groups[i].Questions[j].Answers.push({ "index": 1, "value": time, "lastUpdate": today, "fillings": [] });
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            }
                                            break;
                                        case "checkbox":
                                            if (event.currentTarget.classList.contains("otherAns")) {
                                                dataObj.Groups[i].Questions[j].otherAnswer.length = 0;
                                                dataObj.Groups[i].Questions[j].otherAnswer.push({ "index": 1, "value": true, "lastUpdate": today, "fillings": [{ "index": 1, "value": event.currentTarget.value, "lastUpdate": today }] })
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            }

                                            let ckbSn = Number(event.currentTarget.dataset.ckb) - 1;
                                            let hasCkbSn = isNaN(ckbSn);
                                            let value = thischange.value;
                                            let fsn = Number(event.currentTarget.dataset.fsn) - 1
                                            if (!hasCkbSn) {
                                                console.log("dataObj.Groups[i].Questions[j].QuestionText_" + dataObj.Groups[i].Questions[j].QuestionText + dataObj.Groups[i].Questions[j].Answers.length);
                                                if (dataObj.Groups[i].Questions[j].Answers[ckbSn].value) {
                                                    dataObj.Groups[i].Questions[j].Answers[ckbSn].fillings[fsn].value = value;
                                                    dataObj.Groups[i].Questions[j].Answers[ckbSn].fillings[fsn].lastUpdate = today;
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                }
                                            }
                                            if (event.currentTarget.dataset.isquentionfilling) {
                                                let txtSn = Number(event.currentTarget.dataset.textindex) - 1;
                                                dataObj.Groups[i].Questions[j].fillings[txtSn].value = event.currentTarget.value;
                                                dataObj.Groups[i].Questions[j].fillings[txtSn].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            }

                                            break;
                                        case "radio":
                                            let rdSn = Number(event.currentTarget.dataset.rd) - 1;
                                            let rsn = Number(event.currentTarget.dataset.fsn) - 1;
                                            let hasRdSn = isNaN(rdSn);
                                            if (event.currentTarget.classList.contains("otherAns")) {
                                                
                                                for (var a = 0; a < dataObj.Groups[i].Questions[j].Answers.length; a++) {
                                                    dataObj.Groups[i].Questions[j].Answers[a].value = false;
                                                    dataObj.Groups[i].Questions[j].Answers[a].lastUpdate = today;
                                                    for (var f = 0; f < dataObj.Groups[i].Questions[j].Answers[a].fillings.length; f++) {
                                                        dataObj.Groups[i].Questions[j].Answers[a].fillings[f].value = "";
                                                        dataObj.Groups[i].Questions[j].Answers[a].fillings[f].lastUpdate = today;
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                    }
                                                }
                                                dataObj.Groups[i].Questions[j].otherAnswer.length = 0;
                                                dataObj.Groups[i].Questions[j].otherAnswer.push({ "index": 1, "value": true, "lastUpdate": today, "fillings": [{ "index": 1, "value": event.currentTarget.value, "lastUpdate": today}] })
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            }
                                            
                                            if (!hasRdSn) {
                                                if (dataObj.Groups[i].Questions[j].Answers[rdSn].value) {
                                                    console.log("rdSn" + rdSn);
                                                    console.log("rsn" + rsn);
                                                    dataObj.Groups[i].Questions[j].Answers[rdSn].fillings[rsn].value = event.currentTarget.value;
                                                    dataObj.Groups[i].Questions[j].Answers[rdSn].fillings[rsn].lastUpdate = today;
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                } 
                                            }
                                            if (event.currentTarget.dataset.isquentionfilling) {
                                                let txtSn = Number(event.currentTarget.dataset.textindex) - 1;
                                                dataObj.Groups[i].Questions[j].fillings[txtSn].value = event.currentTarget.value;
                                                dataObj.Groups[i].Questions[j].fillings[txtSn].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            }
                                            break;
                                        case "display":
                                        case "sign":
                                        case "file":
                                            console.log("sign");
                                            let sn = Number(event.currentTarget.dataset.textindex) - 1;
                                            dataObj.Groups[i].Questions[j].fillings[sn].value = event.currentTarget.value;
                                            dataObj.Groups[i].Questions[j].fillings[sn].lastUpdate = today;
                                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            break;
                                        case "CheckboxMixRadio":
                                            if (event.currentTarget.classList.contains("otherAns")) {
                                                dataObj.Groups[i].Questions[j].Answers.forEach(function (item) {
                                                    item.value = false;
                                                    item.lastUpdate = today;
                                                    item.fillings.forEach(function (filling) {
                                                        filling.value = "";
                                                        filling.lastUpdate = today;
                                                    });
                                                    item.Answers.forEach(function (ans) {
                                                        ans.value = false;
                                                        ans.lastUpdate = today;
                                                        ans.fillings.forEach(function (filling) {
                                                            filling.value = "";
                                                            filling.lastUpdate = today;
                                                        });
                                                    });
                                                })
                                                dataObj.Groups[i].Questions[j].otherAnswer.length = 0;
                                                dataObj.Groups[i].Questions[j].otherAnswer.push({ "index": 1, "value": true, "lastUpdate": today, "fillings": [{ "index": 1, "value": event.currentTarget.value, "lastUpdate": today }] })
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

                                            }
                                            //題目的填充
                                            if (event.currentTarget.dataset.isquentionfilling) {
                                                let sn = Number(event.currentTarget.dataset.textindex) - 1;
                                                dataObj.Groups[i].Questions[j].fillings[sn].value = event.currentTarget.value;
                                                dataObj.Groups[i].Questions[j].fillings[sn].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            } else if (event.currentTarget.dataset.rd > 0 && event.currentTarget.dataset.ckb > 0) { //radio的填充
                                                let rSn = Number(event.currentTarget.dataset.rd) - 1;
                                                let txtSn = Number(event.currentTarget.dataset.textindex) - 1;
                                                let CkbSn = Number(event.currentTarget.dataset.ckb) - 1;

                                                dataObj.Groups[i].Questions[j].Answers[rSn].Answers[CkbSn].fillings[txtSn].value = event.currentTarget.value;
                                                dataObj.Groups[i].Questions[j].Answers[rSn].Answers[CkbSn].fillings[txtSn].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            }
                                            else if (event.currentTarget.dataset.ckb > 0) {//checkbox 的填充
                                                let CkbSn = Number(event.currentTarget.dataset.ckb) - 1;
                                                let fsn = Number(event.currentTarget.dataset.fsn) - 1;
                                                dataObj.Groups[i].Questions[j].Answers[CkbSn].fillings[fsn].value = event.currentTarget.value;
                                                dataObj.Groups[i].Questions[j].Answers[CkbSn].fillings[fsn].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

                                            }

                                            break;
                                        case "RadioMixCheckbox":
                                            console.log(dataObj.Groups[i].Questions[j].QuestionID);
                                            if (event.currentTarget.classList.contains("otherAns")) {
                                                dataObj.Groups[i].Questions[j].Answers.forEach(function (item) {
                                                    item.value = false;
                                                    item.lastUpdate = today;
                                                    item.fillings.forEach(function (filling) {
                                                        filling.value = "";
                                                        filling.lastUpdate = today;
                                                    });
                                                    item.Answers.forEach(function (ans) {
                                                        ans.value = false;
                                                        ans.lastUpdate = today;
                                                        ans.fillings.forEach(function (filling) {
                                                            filling.value = "";
                                                            filling.lastUpdate = today;
                                                        });
                                                    });
                                                })
                                                dataObj.Groups[i].Questions[j].otherAnswer.length = 0;
                                                dataObj.Groups[i].Questions[j].otherAnswer.push({ "index": 1, "value": true, "lastUpdate": today, "fillings": [{ "index": 1, "value": event.currentTarget.value, "lastUpdate": today}] })
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

                                            }
                                            //題目的填充
                                            if (event.currentTarget.dataset.isquentionfilling) {
                                                let sn = Number(event.currentTarget.dataset.textindex) - 1;
                                                dataObj.Groups[i].Questions[j].fillings[sn].value = event.currentTarget.value;
                                                dataObj.Groups[i].Questions[j].fillings[sn].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            } else if (event.currentTarget.dataset.rd > 0 && event.currentTarget.dataset.ckb > 0) { //checkbox的填充
                                                let rSn = Number(event.currentTarget.dataset.rd) - 1;
                                                let txtSn = Number(event.currentTarget.dataset.fsn) - 1;
                                                let CkbSn = Number(event.currentTarget.dataset.ckb) - 1;

                                                dataObj.Groups[i].Questions[j].Answers[rSn].Answers[CkbSn].fillings[txtSn].value = event.currentTarget.value;
                                                dataObj.Groups[i].Questions[j].Answers[rSn].Answers[CkbSn].fillings[txtSn].lastUpdate= today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            }
                                            else if (event.currentTarget.dataset.rd > 0) {//radio 的填充
                                                let rSn = Number(event.currentTarget.dataset.rd) - 1;
                                                let fsn = Number(event.currentTarget.dataset.textindex) - 1;
                                                dataObj.Groups[i].Questions[j].Answers[rSn].fillings[fsn].value = event.currentTarget.value;
                                                dataObj.Groups[i].Questions[j].Answers[rSn].fillings[fsn].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

                                            }
                                            break;
                                        case "CheckboxMixImage":
                                            if (event.currentTarget.classList.contains("otherAns")) {
                                                dataObj.Groups[i].Questions[j].otherAnswer.length = 0;
                                                dataObj.Groups[i].Questions[j].otherAnswer.push({ "index": 1, "value": true, "lastUpdate": today, "fillings": [{ "index": 1, "value": event.currentTarget.value, "lastUpdate": today }] })
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            }

                                            let CkbSn = Number(event.currentTarget.dataset.ckb) - 1;
                                            let HasCkbSn = isNaN(CkbSn);
                                            let Value = thischange.value;
                                            let Fsn = Number(event.currentTarget.dataset.fsn) - 1
                                            if (!HasCkbSn) {
                                                console.log("dataObj.Groups[i].Questions[j].QuestionText_" + dataObj.Groups[i].Questions[j].QuestionText + dataObj.Groups[i].Questions[j].Answers.length);
                                                if (dataObj.Groups[i].Questions[j].Answers[CkbSn].value) {
                                                    dataObj.Groups[i].Questions[j].Answers[CkbSn].fillings[Fsn].value = Value;
                                                    dataObj.Groups[i].Questions[j].Answers[CkbSn].fillings[Fsn].lastUpdate = today;
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                }
                                            }
                                            if (event.currentTarget.dataset.isquentionfilling) {
                                                let txtSn = Number(event.currentTarget.dataset.textindex) - 1;
                                                dataObj.Groups[i].Questions[j].fillings[txtSn].value = event.currentTarget.value;
                                                dataObj.Groups[i].Questions[j].fillings[txtSn].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            }

                                            break;
                                    }
                                } 
                                else if (dataObj.Groups[i].Questions[j].QuestionType == "CheckboxMixFilling") {
                                    let thisValue = event.currentTarget.name;
                                    let ansValue = thisValue.split("_");
                                    let ckb = event.currentTarget.dataset.ckb;
                                    console.log(ckb)
                                    for (var ansO = 0; ansO < dataObj.Groups[i].Questions[j].AnswerOptions.length; ansO++) {
                                        if (dataObj.Groups[i].Questions[j].AnswerOptions[ansO].index == ckb) {
                                            for (var f = 0; f < dataObj.Groups[i].Questions[j].Answers[ansO].Answers.length; f++) {
                                                if (dataObj.Groups[i].Questions[j].Answers[ansO].Answers[f].index == ansValue[1]) {
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
                                    let rd = event.currentTarget.dataset.rd;
                                    for (var ansO = 0; ansO < dataObj.Groups[i].Questions[j].AnswerOptions.length; ansO++) {
                                        if (dataObj.Groups[i].Questions[j].AnswerOptions[ansO].index == rd) {
                                            for (var f = 0; f < dataObj.Groups[i].Questions[j].Answers[ansO].Answers.length; f++) {
                                                if (dataObj.Groups[i].Questions[j].Answers[ansO].Answers[f].index == ansValue[1]) {
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
                        if (dataObj.Groups[i].GroupType == "normal") {
                            for (var j = 0; j < dataObj.Groups[i].Questions.length; j++) {
                                if (dataObj.Groups[i].Questions[j].QuestionText == event.currentTarget.name && dataObj.Groups[i].Questions[j].QuestionType == "checkbox") {
                                    if (event.currentTarget.checked) {
                                        for (var ic = 0; ic < dataObj.Groups[i].Questions[j].AnswerOptions.length; ic++) {
                                            if (dataObj.Groups[i].Questions[j].AnswerOptions[ic].index == event.currentTarget.value) {
                                                dataObj.Groups[i].Questions[j].Answers[ic].value = true;
                                                dataObj.Groups[i].Questions[j].Answers[ic].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            }
                                        }
                                    } else {
                                        for (let cc = 0; cc < dataObj.Groups[i].Questions[j].AnswerOptions.length; cc++) {
                                            if (dataObj.Groups[i].Questions[j].AnswerOptions[cc].index == event.currentTarget.value) {
                                                dataObj.Groups[i].Questions[j].Answers[cc].value = false;
                                                dataObj.Groups[i].Questions[j].Answers[cc].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                if (dataObj.Groups[i].Questions[j].AnswerOptions[cc].AnsText.includes("##^")) {
                                                    for (var a = 0; a < dataObj.Groups[i].Questions[j].Answers[cc].fillings.length; a++) {
                                                        dataObj.Groups[i].Questions[j].Answers[cc].fillings[a].value = "";
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                    }
                                                }

                                            }

                                        }
                                    }
                                }
                                else if (dataObj.Groups[i].Questions[j].QuestionType == "CheckboxMixFilling" && dataObj.Groups[i].Questions[j].QuestionID == event.currentTarget.name) {
                                    if (event.currentTarget.checked) {
                                        for (var y = 0; y < dataObj.Groups[i].Questions[j].AnswerOptions.length; y++) {
                                            if (dataObj.Groups[i].Questions[j].AnswerOptions[y].index == event.currentTarget.value) {
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
                                            if (dataObj.Groups[i].Questions[j].AnswerOptions[y].index == event.currentTarget.value) {
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
                                } else if (dataObj.Groups[i].Questions[j].QuestionType == "RadioMixCheckbox" && dataObj.Groups[i].Questions[j].QuestionID == event.currentTarget.name) {
                                    if (event.currentTarget.checked) {
                                        for (var y = 0; y < dataObj.Groups[i].Questions[j].AnswerOptions.length; y++) {
                                            if (dataObj.Groups[i].Questions[j].AnswerOptions[y].index == event.currentTarget.dataset.rd) {
                                                for (var x = 0; x < dataObj.Groups[i].Questions[j].AnswerOptions[y].AnswerOptions.length; x++) {
                                                    if (dataObj.Groups[i].Questions[j].AnswerOptions[y].AnswerOptions[x].index == event.currentTarget.value) {
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
                                            if (dataObj.Groups[i].Questions[j].AnswerOptions[y].index == event.currentTarget.dataset.rd) {
                                                for (var x = 0; x < dataObj.Groups[i].Questions[j].AnswerOptions[y].AnswerOptions.length; x++) {
                                                    if (dataObj.Groups[i].Questions[j].AnswerOptions[y].AnswerOptions[x].index == event.currentTarget.value) {
                                                        dataObj.Groups[i].Questions[j].Answers[y].Answers[x].value = false;
                                                        dataObj.Groups[i].Questions[j].Answers[y].Answers[x].lastUpdate = today;
                                                        dataObj.Groups[i].Questions[j].Answers[y].Answers[x].fillings.forEach(function (item) {
                                                            item.value = "";
                                                            item.lastUpdate = today;
                                                        });
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                else if (dataObj.Groups[i].Questions[j].QuestionType == "CheckboxMixRadio" && dataObj.Groups[i].Questions[j].QuestionID == event.currentTarget.name) {
                                    let sn = event.currentTarget.value - 1;
                                    if (event.currentTarget.checked) {
                                        for (var y = 0; y < dataObj.Groups[i].Questions[j].AnswerOptions.length; y++) {
                                            if (dataObj.Groups[i].Questions[j].AnswerOptions[y].index == event.currentTarget.dataset.ckb) {
                                                dataObj.Groups[i].Questions[j].Answers[y].value = true;
                                                dataObj.Groups[i].Questions[j].Answers[y].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            }
                                        }
                                    }
                                    else {
                                        for (var y = 0; y < dataObj.Groups[i].Questions[j].AnswerOptions.length; y++) {
                                            if (dataObj.Groups[i].Questions[j].AnswerOptions[y].index == event.currentTarget.dataset.ckb) {
                                                if (dataObj.Groups[i].Questions[j].AnswerOptions[y].AnswerOptions[sn].index == event.currentTarget.value) {
                                                    dataObj.Groups[i].Questions[j].Answers[y].value = false;
                                                    dataObj.Groups[i].Questions[j].Answers[y].lastUpdate = today;
                                                    dataObj.Groups[i].Questions[j].Answers[y].fillings.forEach(function (item) {
                                                        item.value = "";
                                                        item.lastUpdate = today;
                                                    });
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                }
                                            }
                                        }
                                    }
                                }
                                else if (dataObj.Groups[i].Questions[j].QuestionType == "CheckboxMixImage" && dataObj.Groups[i].Questions[j].QuestionID == event.currentTarget.name) {
                                    if (event.currentTarget.checked) {
                                        for (var ic = 0; ic < dataObj.Groups[i].Questions[j].AnswerOptions.length; ic++) {
                                            if (dataObj.Groups[i].Questions[j].AnswerOptions[ic].index == event.currentTarget.value) {
                                                dataObj.Groups[i].Questions[j].Answers[ic].value = true;
                                                dataObj.Groups[i].Questions[j].Answers[ic].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            }
                                        }
                                    } else {
                                        for (let cc = 0; cc < dataObj.Groups[i].Questions[j].AnswerOptions.length; cc++) {
                                            if (dataObj.Groups[i].Questions[j].AnswerOptions[cc].index == event.currentTarget.value) {
                                                dataObj.Groups[i].Questions[j].Answers[cc].value = false;
                                                dataObj.Groups[i].Questions[j].Answers[cc].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            }
                                        }
                                    }

                                }
                                else if (event.currentTarget.classList.contains("otherAns")) {
                                    if (!event.currentTarget.checked) {
                                        dataObj.Groups[i].Questions[j].otherAnswer.length = 0;
                                        dataObj.Groups[i].Questions[j].otherAnswer.push({ "index": 1, "value": "", "lastUpdate": today, "fillings": [{ "index": 1, "value": "", "lastUpdate": today }] });
                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                        console.log("沒勾:" + dataObj.Groups[i].Questions[j].otherAnswer[0].value);
                                    }
                                }
                            }
                        }
                    }
                    break;
                case "radio":
                    for (var i = 0; i < dataObj.Groups.length; i++) {
                        if (dataObj.Groups[i].GroupType == "normal") {
                            for (var j = 0; j < dataObj.Groups[i].Questions.length; j++) {
                                if (dataObj.Groups[i].Questions[j].QuestionID == event.currentTarget.name && dataObj.Groups[i].Questions[j].QuestionType == "radio") {
                                    if (event.currentTarget.checked) {
                                        for (var r = 0; r < dataObj.Groups[i].Questions[j].AnswerOptions.length; r++) {
                                            if (dataObj.Groups[i].Questions[j].AnswerOptions[r].index == event.currentTarget.value) {
                                                console.log("radio change");
                                                dataObj.Groups[i].Questions[j].Answers[r].value = true;
                                                dataObj.Groups[i].Questions[j].Answers[r].lastUpdate = today;
                                                if (dataObj.Groups[i].Questions[j].hasOtherAnswers) {
                                                    console.log("radio other");
                                                    dataObj.Groups[i].Questions[j].otherAnswer.length = 0;
                                                    dataObj.Groups[i].Questions[j].otherAnswer.push({ "index": 1, "value": false, "lastUpdate": today, "fillings": [{ "index": 1, "value": "", "lastUpdate": today }] });
                                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                }
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            } else {
                                                dataObj.Groups[i].Questions[j].Answers[r].value = false;
                                                dataObj.Groups[i].Questions[j].Answers[r].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                                if (dataObj.Groups[i].Questions[j].AnswerOptions[r].AnsText.includes("##^")) {
                                                    for (var a = 0; a < dataObj.Groups[i].Questions[j].Answers[r].fillings.length; a++) {
                                                        dataObj.Groups[i].Questions[j].Answers[r].fillings[a].value = "";
                                                        dataObj.Groups[i].Questions[j].Answers[r].fillings[a].lastUpdate = today;
                                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));

                                                    }
                                                }
                                            }
                                        }
                                    }
                                } else if (dataObj.Groups[i].Questions[j].QuestionID == event.currentTarget.name && dataObj.Groups[i].Questions[j].QuestionType == "RadioMixCheckbox") {
                                    if (event.currentTarget.checked) {
                                        console.log(dataObj.Groups[i].Questions[j].QuestionID);
                                        for (var rc = 0; rc < dataObj.Groups[i].Questions[j].AnswerOptions.length; rc++) {
                                            if (dataObj.Groups[i].Questions[j].AnswerOptions[rc].index == event.currentTarget.value) {
                                                dataObj.Groups[i].Questions[j].Answers[rc].value = true;
                                                dataObj.Groups[i].Questions[j].otherAnswer.length = 0;
                                                dataObj.Groups[i].Questions[j].Answers[rc].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            } else {
                                                dataObj.Groups[i].Questions[j].Answers[rc].value = false;
                                                dataObj.Groups[i].Questions[j].Answers[rc].lastUpdate = today;
                                                for (var f = 0; f < dataObj.Groups[i].Questions[j].Answers[rc].fillings.length; f++) {
                                                    dataObj.Groups[i].Questions[j].Answers[rc].fillings[f].value = "";

                                                for (var c = 0; c < dataObj.Groups[i].Questions[j].Answers[rc].Answers.length; c++) {
                                                    dataObj.Groups[i].Questions[j].Answers[rc].Answers[c].value = false;
                                                    dataObj.Groups[i].Questions[j].Answers[rc].Answers[c].lastUpdate = today;
                                                    dataObj.Groups[i].Questions[j].Answers[rc].Answers[c].lastUpdate = today;
                                                    }
                                                }
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            }
                                        }
                                    }
                                }
                                else if (dataObj.Groups[i].Questions[j].QuestionID == event.currentTarget.name && dataObj.Groups[i].Questions[j].QuestionType == "CheckboxMixRadio") {
                                    if (event.currentTarget.checked) {
                                        let sn = Number(event.currentTarget.value) - 1;
                                        for (var rc = 0; rc < dataObj.Groups[i].Questions[j].AnswerOptions.length; rc++) {
                                            if (dataObj.Groups[i].Questions[j].AnswerOptions[rc].index == event.currentTarget.dataset.ckb) {
                                                dataObj.Groups[i].Questions[j].Answers[rc].Answers[sn].value = true;
                                                dataObj.Groups[i].Questions[j].otherAnswer.length=0;
                                                dataObj.Groups[i].Questions[j].Answers[rc].Answers[sn].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
                                            } else {
                                                dataObj.Groups[i].Questions[j].Answers[rc].Answers[sn].value = false;
                                                dataObj.Groups[i].Questions[j].Answers[rc].Answers[sn].lastUpdate = today;
                                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(dataObj));
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
                console.log("signDate_" + singDate.length);
                if (singDate[i].innerText == today || singDate[i].innerText == "") {
                    console.log("signDate_" + today);
                    singDate[i].innerText = today;
                }
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
                                        if (JsonObj.Groups[i].Rows[k].Cols[c].rotate) {
                                            SignImage.classList.add("signRotated", "mt-5", "mb-3","ml_1");
                                            SignImage.style.width = "150%";
                                        }
                                        
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
                    //SignBoxFather.classList.add("d-flex", "justify-content-end");
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
                                    var singDateT = document.getElementsByName(JsonObj.Groups[i].Rows[k].Cols[c].QuestionID)
                                    singDateT.innerText = today;

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
        //checkbox勾選 Row
        function CleanOptionforRow(event) {//不刪radio的checked
            let gfather = event.currentTarget.parentNode.parentNode;//form-check 上上一層
            let normalfather = event.currentTarget.parentNode;
            let selfradio = gfather.childNodes;//form-check 全部的孩子
            let normals = normalfather.childNodes;//radio box 同一層
            let otherAns = gfather.getElementsByClassName("otherAns");
            if (otherAns.length > 0) {
                otherAns[0].disabled = true;
            }

            let other = gfather.getElementsByClassName("other");
            for (var i = 0; i < other.length; i++) {
                if (other[i].dataset.qid == event.currentTarget.name) {
                    other[i].disabled = true;
                }
            }
            //先全清

            //checkbox part //

            for (var i = 0; i < selfradio.length; i++) {
                let selfckbs = selfradio[i].childNodes;

                for (var cki = 0; cki < selfckbs.length; cki++) {
                    if (selfckbs[cki].type == "checkbox" && selfckbs[cki].name == event.currentTarget.name) {
                        selfckbs[cki].checked = false;
                        selfckbs[cki].disabled = true;
                    }
                    else if (selfckbs[cki].type == "text" && selfckbs[cki].name == event.currentTarget.name ) {
                        console.log("selfckbs[cki].type" + selfckbs[cki].type);
                        if (selfckbs[cki].dataset.radioindex == event.currentTarget.value && selfckbs[cki].dataset.checkboxindex==null) {//同QID
                            selfckbs[cki].disabled = false;

                        } else {
                            selfckbs[cki].disabled = true;
                            selfckbs[cki].value = "";

                        }
                    }
                }
            }
            event.currentTarget.checked = true;

            let selfchbox = event.currentTarget.parentNode.childNodes;
            for (var c = 0; c < selfchbox.length; c++) {

                if (selfchbox[c].name == event.currentTarget.name && selfchbox[c].type == "checkbox") {
                    selfchbox[c].disabled = false;
                }
            }


            event.currentTarget.disabled = false;
        }
        //清空 cleanOptionforRadioMixCheckbox
        function cleanOptionforRadioMixCheckbox(event) {
            //先抓同Name的物件
            let allInputs = document.getElementsByName(event.currentTarget.name);
            //radio一群
            let radios = [];
            //checkbox 一群
            let checkboxes = [];
            //text 一群
            let texts = [];
            allInputs.forEach(function (item) {
                switch (item.type) {
                    case "radio":
                        radios.push(item);
                        break;
                    case "checkbox":
                        checkboxes.push(item);
                        break;
                    case "text":
                        texts.push(item);
                        break;
                }
            });
            radios.forEach(function (radio) {
                if (radio.checked) {
                    console.log("checkboxes" + checkboxes.length);
                    checkboxes.forEach(function (cbx) {
                        console.log("cbx");
                        if (cbx.dataset.rd == radio.value) {
                            cbx.disabled = false;
                        } else {
                            cbx.disabled = true;
                            cbx.checked = false;
                        }
                    });
                    texts.forEach(function (txt) {
                        if (txt.dataset.rd == radio.value && txt.dataset.ckb == undefined || txt.dataset.isquentionfilling=="true") {
                            txt.disabled = false;
                        } else {
                            txt.disabled = true;
                            txt.value = "";
                        }
                    });
                }
            });
        }
        //清空  radio勾選 一般
        function CleanOption(event) {//不刪radio的checked
            let gfather = event.currentTarget.parentNode.parentNode;
            let normalfather = event.currentTarget.parentNode;
            let selfradio = gfather.childNodes;//radio box
            let normals = normalfather.childNodes;//全部的孩子
            let allTxt = document.getElementsByName(event.currentTarget.name);
            let otherAns = gfather.getElementsByClassName("otherAns");
            if(otherAns.length>0){
                otherAns[0].disabled = true;
            }
            
            let other = gfather.getElementsByClassName("other");
            
            for (var i = 0; i < other.length; i++) {
                if (other[i].dataset.qid == event.currentTarget.name) {
                    other[i].disabled = true;
                }
            }
            if (event.currentTarget.type == "radio") {
                console.log("allTxt[i].type:" + allTxt[i].type)
                console.log("allTxt.length:" + allTxt.length)
                for (var i = 0; i < allTxt.length; i++) {
                    if (allTxt[i].dataset.rd != undefined) {
                        console.log("allTxt[i].dataset.rd:" + allTxt[i].dataset.rd)
                        allTxt[i].disabled = true;
                    }
                }

                for (var i = 0; i < normals.length; i++) {
                    if (normals[i].type == "text" && normals[i].dataset.rd == event.currentTarget.value) {
                        normals[i].disabled = false;
                    } 
                }
                event.currentTarget.checked = true;
                event.currentTarget.disabled = false;

            } else {
                for (var i = 0; i < selfradio.length; i++) {
                    let selfckbs = selfradio[i].childNodes;

                    for (var cki = 0; cki < selfckbs.length; cki++) {
                        if (selfckbs[cki].type == "checkbox" && selfckbs[cki].name == event.currentTarget.name) {
                            selfckbs[cki].checked = false;
                            selfckbs[cki].disabled = true;
                        } else if (selfckbs[cki].type == "checkbox" && selfckbs[cki].name != event.currentTarget.value) {
                            selfckbs[cki].checked = false;
                            selfckbs[cki].disabled = true;
                        }
                        else if (selfckbs[cki].type == "checkbox" && selfckbs[cki].name == event.currentTarget.value) {

                            selfckbs[cki].checked = false;
                            selfckbs[cki].disabled = true;
                        }
                    }
                }
                for (var i = 0; i < selfradio.length; i++) {
                    let selfckbs = selfradio[i].childNodes;

                    for (var cki = 0; cki < selfckbs.length; cki++) {
                        if (selfckbs[cki].type == "text" && selfckbs[cki].name == event.currentTarget.name) {
                            selfckbs[cki].disabled = true;
                        } else if (selfckbs[cki].type == "text" && selfckbs[cki].name != event.currentTarget.value) {
                            selfckbs[cki].disabled = true;
                        }
                        else if (selfckbs[cki].type == "text" && selfckbs[cki].name == event.currentTarget.value) {
                            selfckbs[cki].disabled = true;
                        }
                    }
                }

                event.currentTarget.checked = true;

                let selfchbox = event.currentTarget.parentNode.childNodes;
                for (var c = 0; c < selfchbox.length; c++) {

                    if (selfchbox[c].name == event.currentTarget.name) {
                        selfchbox[c].disabled = false;
                    }
                }

                for (var b = 0; b < selfradio.length; b++) {
                    selfradio[b].childNodes[0].disabled = false;
                }
                for (var i = 0; i < normals.length; i++) {
                    if (normals[i].type == "checkbox" && normals[i].name == event.currentTarget.value) {
                        normals[i].disabled = false;
                    }
                }
                for (var i = 0; i < normals.length; i++) {
                    if (normals[i].type == "checkbox" || normals[i].type == "text") {
                        normals[i].disabled = false;
                    }
                }

                event.currentTarget.disabled = false;

            }

        }
        //清空 checkbox勾選 Table跟row
        function CleanOptionforTable(event) {//不刪radio的checked
            let gfather = event.currentTarget.parentNode;
            let selfradio = gfather.childNodes;//radio box
            for (var i = 0; i < selfradio.length; i++) {
                let selfckbs = selfradio[i].childNodes;
                for (var cki = 0; cki < selfckbs.length; cki++) {
                    console.log("CleanOptionforTable");
                    selfckbs[cki].checked = false;
                    selfckbs[cki].disabled = true;
                }
            }
            event.currentTarget.checked = true;

            let selfchbox = event.currentTarget.parentNode.childNodes;
            for (var c = 0; c < selfchbox.length; c++) {
                selfchbox[c].disabled = false;
            //    selfckbs[cki].checked = false;
            }

            for (var b = 0; b < selfradio.length; b++) {
                selfradio[b].disabled = false;
            }
            event.currentTarget.disabled = false;
        }
        // table radio mix checkbox mix filling
        function swich(event) {
            //radio 的 text 沒有 checkboxindex
            //checkbox 沒有 textindex
            //checkbox  的 text 都有
            let myInputs = event.currentTarget.parentNode.childNodes;
            let cks = [];
            let txt = [];

            let allInputs = document.getElementsByName(event.currentTarget.name);
           //先全部都disabled clean
            for (var i = 0; i < allInputs.length; i++) {
                if (allInputs[i].type == "checkbox") {
                    allInputs[i].disabled = true;
                    allInputs[i].checked = false;
                }
                if (allInputs[i].type == "text") {
                    if (!allInputs[i].dataset.isfilling) {
                        console.log("allInputs")
                        allInputs[i].disabled = true;
                        allInputs[i].value = "";
                    }
                }
            }
           
            for (var i = 0; i < myInputs.length; i++) {
                if (myInputs[i].type == "checkbox") {
                    cks.push(myInputs[i]);
                } else if (myInputs[i].type == "text") {
                    txt.push(myInputs[i]);
                }
            }
            //點radio radio 的 text 跟 checkbox 可以選 其他的清空跟 不能選
            for (var i = 0; i < txt.length; i++) {
                if (txt[i].dataset.radioindex == event.currentTarget.value && txt[i].dataset.checkboxindex == undefined) {
                    txt[i].disabled = false;
                }
            }
            for (var i = 0; i < cks.length; i++) {
                if (cks[i].dataset.radioindex == event.currentTarget.value) {
                    console.log(cks[i].dataset.radioindex );
                    cks[i].disabled = false;
                }
            }
        }
        //table radio mix checkbox mix filling 的checkbox的filling 切換
        function swichDisabledTrue(event) {

            let allInputs = document.getElementsByName(event.currentTarget.name);
            let texts = [];
            for (var i = 0; i < allInputs.length; i++) {
                if (allInputs[i].type == "text") {
                    texts.push(allInputs[i]);
                }
            }
            for (var i = 0; i < texts.length; i++) {
                if (texts[i].dataset.checkboxindex == event.currentTarget.dataset.checkboxindex && texts[i].name == event.currentTarget.name && texts[i].dataset.radioindex == event.currentTarget.dataset.radioindex) {
                    if (event.currentTarget.checked) {
                        texts[i].disabled = false;
                    } else {
                        texts[i].disabled = true;
                    }
                }
            }
        }
       //清空 填充跟切換Disabled 
        function CleanOthersForRow(event) {
            let Allinputs = document.getElementsByName(event.currentTarget.name);
            console.log("Allinputs" + Allinputs.length)

            let fillings = [];
            let radios = [];
            let ckbs= [];
            let others;
            Allinputs.forEach(function (item) {
                if (item.type == "text" && !item.classList.contains("other")) {
                    fillings.push(item);
                } else if (item.type == "text" && item.classList.contains("other")) {
                    others = item;
                } else if (item.type == "radio" ) {
                    radios.push(item);
                } else if (item.type == "checkbox") {
                    ckbs.push(item);
                }
            });
            if (radios.length == 0 && fillings.length!=0) {
                //checkbox mix fillings
                for (var i = 0; i < ckbs.length; i++) {
                    if (ckbs[i].checked) {
                        for (var f = 0; f < fillings.length; f++) {
                            if (fillings[f].dataset.checkboxindex == ckbs[i].value) {
                                fillings[f].disabled = false;
                            }
                        }
                    } else {
                        for (var f = 0; f < fillings.length; f++) {
                            if (fillings[f].dataset.checkboxindex == ckbs[i].value) {
                                fillings[f].disabled = true;
                                fillings[f].value = "";
                            }
                        }
                    }
                }

            } else if (ckbs == 0 && fillings.length !== 0) {
                if (event.currentTarget.checked) {
                    for (var f = 0; f < fillings.length; f++) {
                        if (fillings[f].dataset.radioindex == event.currentTarget.value) {
                            fillings[f].disabled = false;
                        } else {
                            fillings[f].disabled = true;
                            fillings[f].value = "";
                        }
                    }
                } 
            }
        }

        //清空 填充跟切換Disabled
        function CleanOthers(event) {
            let gfather = event.currentTarget.parentNode.parentNode;
            let Allinputs = gfather.childNodes;
            for (var i = 0; i < Allinputs.length; i++) {
                let fillings = Allinputs[i].childNodes;
                let Fillings = [];//其他
                fillings.forEach(function (item) {
                    if (item.type == "text" && item.classList.contains("other")) {
                        Fillings.push(item);
                    }
                })

                for (var f = 0; f < fillings.length; f++) {
                    if (fillings[f].type == "text") {
                        let fName = fillings[f].name.split("_");
                        if (!fillings[f].classList.contains("other")) {
                            if (fillings[f].name == event.currentTarget.name) {
                                fillings[f].value = "";
                                fillings[f].disabled = true;
                            } else if (fillings[f].name != event.currentTarget.name && fName[0] != event.currentTarget.value) {
                                console.log("fName" + fName[0]);
                                fillings[f].value = "";
                                fillings[f].disabled = true;
                            }
                        } else {
                            if (fillings[f].dataset.qid == event.currentTarget.name && fillings[f].dataset.qid == event.currentTarget.name) {
                                console.log("dataset.qid" + fillings[f].dataset.qid);
                                fillings[f].value = "";
                                fillings[f].disabled = true;
                            } else if (fillings[f].dataset.qid == event.currentTarget.name) {
                                fillings[f].disabled = true;
                            }
                        }
                    }/* else if (fillings[f].type == "checkbox") {*/
                    //    let radioindex = fillings[f].dataset.radioindex;
                    //    if (vent.currentTarget != radioindex) {
                    //        fillings[f].checked = false;
                    //    //    myFilling[m].disabled = true;
                    //    }

                    //}
                    fillings[0].disabled = false;
                }
            }

            let myFilling = event.currentTarget.parentNode.childNodes;
            for (var m = 0; m < myFilling.length; m++) {
                if (myFilling[m].type == "text") {
                    let checkboxindex = myFilling[m].dataset.checkboxindex;
                    if (checkboxindex == undefined) {
                        myFilling[m].disabled = false;
                    }
                } else if (myFilling[m].type == "checkbox") {
                    myFilling[m].disabled = false;
                }
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
        //檢查Row 顯示答案quetionText是否有fillings
        function checkRowShowAnsFilling(Obj, Gsn, Rsn, ColSn) {
            console.log("ColSn" + ColSn);
            let tampleteStr = "";
            let fillingStr = Obj.Groups[Gsn].Rows[Rsn].Cols[ColSn].QuestionText;
            let StrArr = fillingStr.split("##");
            let n = 1;
            let N = 0;//第幾個填充答案
            for (var s = 0; s < StrArr.length; s++) {
                if (StrArr[s].includes("^")) {
                    let reStr = StrArr[s].substring(2);
                    tampleteStr += "<input type=\"text\"style=\"max-width: 50px\" class=\"form-control-border form-control-sm form-control d-inline mb-2\"value=\"" + Obj.Groups[Gsn].Rows[Rsn].Cols[ColSn].fillings[N].value + "\">";
                    tampleteStr += reStr;
                    n++;
                    N++;
                } else {
                    tampleteStr += StrArr[s];
                }
            }
            tampleteStr  +="</br>";
            return tampleteStr;
        }
        //檢查Row quetionText是否有fillings
        function CheckRowFilling(Obj, GroupsSn, RowsSn, ColsSn, Ansrow) {
            console.log("Ansrow:" + Ansrow);
            let insertBodyStr = "";
            let fillingStr = Obj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            let StrArr = fillingStr.split("##");
            let n = 1;
            let N = 0;//第幾個填充答案
            for (var s = 0; s < StrArr.length; s++) {
                if (StrArr[s].includes("^")) {
                    if (Ansrow != null) {
                        insertBodyStr += "<input type=\"text\" onchange=\"changeTableJsonData(event)\" style=\"max-width:100px\"  class=\"form-control-border form-control-sm form-control d-inline mb-2\"name=\"";
                        insertBodyStr += Obj.Groups[GroupsSn].Rows[Ansrow].Cols[ColsSn].QuestionID + "\"";
                    } else {
                        insertBodyStr += "<input type=\"text\" style=\"max-width:100px\"  class=\"form-control-border form-control-sm form-control d-inline mb-2\"name=\"";
                        insertBodyStr += Obj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID + "\"";
                    }
                    insertBodyStr += "data-isQfilling=\"true\" data-filling=\"" + n + "\"";
                    if (Ansrow!=null) {
                        if (Obj.Groups[GroupsSn].Rows[Ansrow].Cols[ColsSn].fillings != undefined) {
                            insertBodyStr += "value=\"" + Obj.Groups[GroupsSn].Rows[Ansrow].Cols[ColsSn].fillings[N].value + "\"";
                        }
                    }
                    insertBodyStr += ">";
                    n++;
                    N++;
                    let txt = StrArr[s].substring(2);
                    if (txt != null) {
                        insertBodyStr += "<span>" + txt + "</span>";
                    }
                } else {
                    insertBodyStr += "<span>" + StrArr[s] + "</span>";
                }
            }
            return insertBodyStr;
        }
       
        //檢查table 首欄 quetionText是否有fillings
        function checkTableFirstIsFilling(Obj, GroupsSn, RowsSn, ColsSn) {
            let TampleteStr = "";
            TampleteStr += "<th class=\"sorting sorting_asc rowPart\">";
            let fillingStr = Obj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            let StrArr = fillingStr.split("##");
            let n = 1;
            let fsn = 1;
            let N = 0;//第幾個填充答案
            Obj.Groups[i].Rows[0].Cols[r].fillings = [];
            for (var s = 0; s < StrArr.length; s++) {
                if (StrArr[s].includes("^")) {
                    if (n + 1 > Obj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].fillings.length) {
                        Obj.Groups[i].Rows[0].Cols[r].fillings.push({ "index": fsn, "value": "", "lastUpdate": "" });
                        fsn++;
                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                    }
                    TampleteStr += "<input type=\"text\" onchange=\"changeTableJsonData(event)\" style=\"max-width:100px\"  class=\"form-control-sm form-control-border form-control d-inline mr-1 ml-1 mb-2\"name=\"";
                    TampleteStr += Obj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID + "\"";
                    TampleteStr += "data-filling=\"" + n + "\"";
                    if (Obj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].fillings.length > 0) {
                        TampleteStr += "value=\"" + Obj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].fillings[N].value + "\"";
                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
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
            TampleteStr += "</th>";
            return TampleteStr;
        }
        //檢查table quetionText是否有fillings
        function checkTableIsFilling(Obj, GroupsSn, RowsSn, ColsSn) {
            let TampleteStr = "";
            let fillingStr = Obj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionText;
            let StrArr = fillingStr.split("##");
            let n = 1;
            let fsn = 1;
            let N = 0;//第幾個填充答案
            if (Obj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].fillings == undefined) {
                Obj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].fillings = [];
                Obj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].fillings.push({ "index": n, "value": "", "lastUpdate": "" });
            }
            for (var s = 0; s < StrArr.length; s++) {
                if (StrArr[s].includes("^")) {
                    if (n > Obj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].fillings.length) {
                        Obj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].fillings.push({ "index": fsn, "value": "", "lastUpdate": "" });
                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                    }
                    TampleteStr += "<input type=\"text\" onchange=\"changeTableJsonData(event)\" style=\"max-width:100px\" class=\"form-control-sm form-control-border form-control d-inline mr-1 ml-1 mb-2\"name=\"";
                    TampleteStr += Obj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].QuestionID + "\"";
                    TampleteStr += "data-filling=\"" + n + "\"";
                    TampleteStr += "data-isfilling=\"" + true + "\"";
                    if (Obj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].fillings.length > 0) {
                        TampleteStr += "value=\"" + Obj.Groups[GroupsSn].Rows[RowsSn].Cols[ColsSn].fillings[N].value + "\"";
                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                    }
                    TampleteStr += ">";
                    n++;
                    N++;
                    fsn++;
                    let txt = StrArr[s].substring(2);
                    if (txt != null) {
                        TampleteStr += "<span>" + txt + "</span>";
                    }
                } else {
                    TampleteStr += "<span>" + StrArr[s] + "</span>";
                }
            }
            return TampleteStr;
        }
        //檢查quetionText是否有fillings
        function checkIsFilling(QuestionText, GroupSn,QusetionSn, DataObj) {
            if (QuestionText.includes("##^")) {
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].fillings == undefined) {
                    DataObj.Groups[GroupSn].Questions[QusetionSn].fillings = [];
                }
                let Qtext = QuestionText;//把填充題目取出
                let strOfFilling = Qtext.split("##");
                let AnsSn = 0;
                let index = AnsSn + 1;
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].fillings.length == 0) {
                    for (var sf = 0; sf < strOfFilling.length; sf++) {
                        if (strOfFilling[sf].includes("^")) {//有^就是要填的位置
                            DataObj.Groups[GroupSn].Questions[QusetionSn].fillings.push({ "index": index, "value": "", "lastUpdate": "" });
                            index++;
                        }
                    }
                    return DataObj;
                } else {
                    return DataObj;
                }
            } else {
                return DataObj;
            }
        }
        function CreateNormalTypeMemo(DataObj, GroupSn, QusetionSn, Parent) {

            let inputBox = document.createElement("div");
            inputBox.classList.add("col-6", "mb-5");
            Parent.append(inputBox);
            //let colbox = document.createElement('div');
            //colbox.classList.add("col-3");
            //Parent.append(colbox);
            let TextInput = document.createElement("textarea");
            TextInput.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length > 0) {
                TextInput.innerText = DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[0].value;
            }
            TextInput.setAttribute("onchange", "changeJsonData(event)");
            TextInput.classList.add("form-control", "form-control-user", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
            inputBox.append(TextInput);

            let newData = checkIsFilling(DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText, GroupSn, QusetionSn, DataObj);
            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(newData));

        }

        function CreateNormalTypeText(DataObj, GroupSn, QusetionSn, Parent) {

            let inputBox = document.createElement("div");
            inputBox.classList.add("col-6", "mb-5");
            Parent.append(inputBox);
            //let colbox = document.createElement('div');
            //colbox.classList.add("col-3");
            //Parent.append(colbox);
            let TextInput = document.createElement("input");
            TextInput.setAttribute("type", "text");
            TextInput.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length > 0) {
                TextInput.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[0].value);
            }
            TextInput.setAttribute("onchange", "changeJsonData(event)");
            TextInput.classList.add("form-control", "form-control-user", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
            inputBox.append(TextInput);

            let newData = checkIsFilling(DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText, GroupSn, QusetionSn, DataObj);
            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(newData));

        }
        function CreateNormalTypeNumber(DataObj, GroupSn, QusetionSn, Parent) {
            let inputNumsBox = document.createElement("div");
            inputNumsBox.classList.add("col-6", "mb-5");
            Parent.append(inputNumsBox);
            //let colNumsbox = document.createElement('div');
            //colNumsbox.classList.add("col-3");
            //Parent.append(colNumsbox);
            let NumsInput = document.createElement("input");
            NumsInput.setAttribute("type", "number");
            NumsInput.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length > 0) {
                NumsInput.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[0].value);
            }
            NumsInput.setAttribute("onchange", "changeJsonData(event)");
            NumsInput.classList.add("form-control", "form-control-user", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
            inputNumsBox.append(NumsInput);
            let newData = checkIsFilling(DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText, GroupSn, QusetionSn, DataObj);
            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(newData));
        };
        //不會有
        function CreateNormalTypeRadio(DataObj, GroupSn, QusetionSn, Parent) {

            for (var ar = 0; ar < DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length; ar++) {
                //空白表單 要先把所有選項給Answers
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length > DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length) {
                    let today = new Date().getTime();
                    DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.push({ "index": DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[ar].index, "value": false, "lastUpdate": today});
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
                RadioInput.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText);
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
            if (DataObj.Groups[GroupSn].Questions[QusetionSn].hasOtherAnswers == true) {
                let otherR = document.createElement("input");
                otherR.setAttribute("type", "radio");
                otherR.setAttribute("onclick", "DisabledTrue(event)");
                otherR.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText);
                let inputRadioBox = document.createElement("div");
                inputRadioBox.classList.add("col-3","mt-2");
                inputRadioBox.append(otherR);
                Parent.append(inputRadioBox);
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].otherAnswer.length > 0) {
                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].otherAnswer[0].value != null) {
                        otherR.setAttribute("checked", "true");
                    }
                }

                normalTypeOther(DataObj, GroupSn, QusetionSn, inputRadioBox);
            }
        }
        //不會有
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
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[ac].value == true) {
                    CheckboxInput.setAttribute("checked", "true");
                }
                inputCheckbox.append(CheckboxInput);
                inputCheckbox.append(CheckLabel);
            }
            if (DataObj.Groups[GroupSn].Questions[QusetionSn].hasOtherAnswers == true) {
                let otherCkb= document.createElement("input");
                otherCkb.setAttribute("type", "checkbox");
                otherCkb.setAttribute("onclick", "DisabledTrue(event)");
                otherCkb.setAttribute("onchange", "changeJsonData(event)");
                otherCkb.classList.add("otherAns");
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].otherAnswer.length > 0) {
                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].otherAnswer[0].value != null) {
                        otherCkb.setAttribute("checked", "true");
                    }
                }
                let inputCheckbox = document.createElement('div');
                inputCheckbox.classList.add("col-3", "position-relative","mt-1");
                inputCheckbox.append(otherCkb);
                Parent.append(inputCheckbox);
                normalTypeOther(DataObj, GroupSn, QusetionSn, inputCheckbox);
            }
        }
        //不會有
        function CreateNormalTypeSelect(DataObj, GroupSn, QusetionSn, Parent) {
            let Selectbox = document.createElement('div');
            Selectbox.classList.add("col-6", "mb-5");
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
            Select.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
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

            let newData = checkIsFilling(DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText, GroupSn, QusetionSn, DataObj);
            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(newData));

        }
        function CreateNormalTypeImage(DataObj, GroupSn, QusetionSn, Parent) {
            let ImageBox = document.createElement("div");
            ImageBox.classList.add("col-8", "pt-2");
            Parent.append(ImageBox);
            let ImageInput = document.createElement("input");
            ImageInput.setAttribute("type", "file");
            ImageInput.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
            ImageInput.setAttribute("id", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
            ImageInput.setAttribute("onchange", "changeJsonData(event)");
            ImageInput.classList.add("Upload");
            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[0] != null) {
                let filename = document.createElement("span");
                filename.innerText = DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[0].value;
                filename.classList.add("mr-1");
                let download = document.createElement("a");
                download.href = "Upload/" + DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[0].value;
                download.classList.add("btn", "btn-default", "btn-sm", "mr-3","download");
                let icon = document.createElement("i");
                icon.classList.add("fas", "fa-cloud-download-alt");
                ImageBox.append(filename);
                download.append(icon);
                ImageBox.append(download);
            }
            ImageBox.append(ImageInput);
            let newData = checkIsFilling(DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText, GroupSn, QusetionSn, DataObj);
            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(newData));

        }
        function CreateNormalTypeDate(DataObj, GroupSn, QusetionSn, Parent) {
            let DateBox = document.createElement("div");
            DateBox.classList.add("col-6", "mb-5");
            Parent.append(DateBox);
            let DateInput = document.createElement("input");
            DateInput.setAttribute("type", "date");
            DateInput.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
            DateInput.setAttribute("onchange", "changeJsonData(event)");
            DateInput.classList.add("form-control", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[0] != null) {//顯示答案
                let date = new Date(DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[0].value);
                date = date.Format("yyyy-MM-dd")
                DateInput.setAttribute("value", date);
                DateInput.innerText = date;
            }
            DateBox.append(DateInput);
            let newData = checkIsFilling(DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText, GroupSn, QusetionSn, DataObj);
            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(newData));
        }
        function CreateNormalTypeSign(DataObj, GroupSn, QusetionSn, Parent) {
            let SignBox = document.createElement("div");
            SignBox.classList.add("col-6", "mb-5", "SignBox");
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
            signdate.classList.add("d-inline","signDate");
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
            let newData = checkIsFilling(DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText, GroupSn, QusetionSn, DataObj);
            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(newData));

        }
        function CreateNormalTypeFilling(DataObj, GroupSn, QusetionSn, Parent) {
            let today = new Date().getTime();
            let FillingBox = document.createElement("div");
            FillingBox.classList.add("col-12", "pt-2", "FillingBox", "d-flex");
            Parent.append(FillingBox);
            let Qtext = DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText;//把填充題目取出
            let strOfFilling = Qtext.split("##");
            let AnsSn = 0;
            let index = AnsSn + 1;
            console.log("DataObj.Groups[GroupSn].Questions[QusetionSn].fillings" + DataObj.Groups[GroupSn].Questions[QusetionSn].fillings)
            if (DataObj.Groups[GroupSn].Questions[QusetionSn].fillings == undefined) {
                DataObj.Groups[GroupSn].Questions[QusetionSn].fillings = [];
            }
            for (var sf = 0; sf < strOfFilling.length; sf++) {
                if (strOfFilling[sf].includes("^")) {//有^就是要填的位置
                    
                    let fillinfPlace = document.createElement("input");//有要填的地方放Input
                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].fillings.length > 1) {
                        fillinfPlace.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].fillings[index-1].value);
                    }

                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));

                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].fillings.length < strOfFilling.length - 1) {
                        DataObj.Groups[GroupSn].Questions[QusetionSn].fillings.push({ "index": index, "value": "", "lastUpdate": today });
                    }

                    fillinfPlace.setAttribute("type", "text");
                    fillinfPlace.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                    fillinfPlace.setAttribute("data-textindex", index);
                    fillinfPlace.setAttribute("onchange", "changeJsonData(event)");//todo 檢查 有順序問題
                    fillinfPlace.classList.add("form-control", "form-control-user", "col-1","form-control-sm","form-control-border", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                    FillingBox.append(fillinfPlace);
                    let words = strOfFilling[sf].substring(2);
                    if (words != null) {
                        let wds = document.createElement('div');
                        wds.classList.add("ml-1", "mr-1", "pt-1", "myTextColor");
                        wds.style.fontSize = "20px";
                        wds.innerText = words;
                        FillingBox.append(wds);
                    }
                    AnsSn++;
                    index++;
                } else {
                    let Words = document.createElement('div');
                    Words.classList.add("ml-1", "mr-1", "pt-1", "myTextColor");
                    Words.innerText = strOfFilling[sf];
                    Words.style.fontSize = "20px";
                    FillingBox.append(Words);
                }

            }

        }
        function CreateNormalTypeCheckboxMixFilling(DataObj, GroupSn, QusetionSn, Parent) {
            let today = new Date().getTime();
            let fillingAns = 0;//ANS的項次
            let optionAns = 0;
            let index = 1;
            let optIndex = 1;
            let isDisabled = true;
            let father = document.createElement("div");//父層
            father.classList.add("row","col-12");
            
            Parent.append(father);
            for (var acf = 0; acf < DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length; acf++) {//checkbox部分
                let checkboxFillngBox = document.createElement("div");
                checkboxFillngBox.classList.add("col-12", "pt-2", "d-flex","ml-5","mt-3", "checkboxFillngBox", "justify-content-start", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                father.append(checkboxFillngBox);
                let ckboxInput = document.createElement("input");
                ckboxInput.setAttribute("type", "checkbox");
                ckboxInput.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText);
                ckboxInput.setAttribute("onchange", "changeJsonData(event)");
                ckboxInput.setAttribute("onclick", "DisabledTrue(event)");
                ckboxInput.classList.add("CheckboxMixFilling", "mycheckbox","mt-2", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                ckboxInput.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[acf].index);//
                checkboxFillngBox.append(ckboxInput);
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length > DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length) {
                    DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.push({ "index": DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[acf].index, "value": false, "lastUpdate": today, "fillings": [] });
                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                }

                if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[acf].value) {
                    ckboxInput.setAttribute("checked", "true");
                    isDisabled = false;

                }
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[acf].AnsText.includes("##^")) {//有填空 填空部分
                    let AnsText = DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[acf].AnsText;//答案選項
                    let AnsAStr = AnsText.split("##");//切等分要放input text
                    console.log("AnsAStr" + AnsAStr.length);
                    let fsn = 1;
                    for (var ocf = 0; ocf < AnsAStr.length; ocf++) {//把切好的陣列
                       
                        if (AnsAStr[ocf].includes("^")) {//要填空的位置
                            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[acf].fillings.length <AnsAStr.length-1) {
                                DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[acf].fillings.push({ "index": index, "value": "", "lastUpdate": today });
                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                                index++;
                            }

                            let place = document.createElement("input");
                            place.setAttribute("type", "text");
                            place.setAttribute("onchange", "changeJsonData(event)");
                            place.disabled = isDisabled;
                            place.classList.add("form-control", "form-control-sm", "form-control-border", "mr-2", "mt-3", "ml-1", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                            place.style.maxWidth = "100px";
                            checkboxFillngBox.append(place);
                            let Txts = AnsAStr[ocf].substring("2");//填空後面的字
                            //place.classList.add(Txts);
                            place.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID/* AnsText + "_" +*//* DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[acf].*//*optIndex*/);
                            place.setAttribute("data-ckb", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[acf].index);
                            place.setAttribute("data-fsn", fsn);
                            optIndex++;
                            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[acf].fillings[optionAns].value!="") {
                                place.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[acf].fillings[optionAns].value);
                            }

                            if (Txts != null) {
                                let txts = document.createElement('span');
                                txts.classList.add("mt-3");//, Txts
                                txts.innerText = Txts;
                                checkboxFillngBox.append(txts);//沒有填空的文字
                            }
                            optionAns++;
                            fsn++;
                        }
                        else {
                            let TXTS = document.createElement("span");//一開始的文字
                            TXTS.classList.add("mt-3");
                            TXTS.innerText = AnsAStr[ocf];
                            checkboxFillngBox.append(TXTS);
                        }
                    }
                } else {
                    let TXTS = document.createElement("span");//一開始的文字
                    TXTS.innerText = DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[acf].AnsText;
                    checkboxFillngBox.append(TXTS);
                }
                fillingAns++;
                optionAns = 0;
                optIndex = 1;
                index = 1;
            }
            if (DataObj.Groups[GroupSn].Questions[QusetionSn].hasOtherAnswers == true) {
                let checkboxFillngBox = document.createElement("div");
                checkboxFillngBox.classList.add("col-5", "mt-3", "pt-2", "d-flex", "ml-5", "checkboxFillngBox", "justify-content-start", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                father.append(checkboxFillngBox);
                let ckboxInput = document.createElement("input");
                ckboxInput.setAttribute("type", "checkbox");
                ckboxInput.setAttribute("onclick", "DisabledTrue(event)");
                ckboxInput.setAttribute("onchange", "changeJsonData(event)");
                ckboxInput.classList.add("otherAns","mt-2");
                checkboxFillngBox.append(ckboxInput);
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].otherAnswer.length > 0) {
                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].otherAnswer[0].value) {
                        ckboxInput.setAttribute("checked", "true");                    }
                }
                normalTypeOther(DataObj, GroupSn, QusetionSn, checkboxFillngBox);
            }
            let newData = checkIsFilling(DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText, GroupSn, QusetionSn, DataObj);
            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(newData));

        }
        function CreateNormalTypeCheckboxMixRadio(DataObj, GroupSn, QusetionSn, Parent) {
            let today = new Date().getTime();
            let checkboxFillngBox = document.createElement("div");
            let isDisabled = true;
            checkboxFillngBox.classList.add("row", "col-12");
            Parent.append(checkboxFillngBox);

            for (var arc = 0; arc < DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length; arc++) {//chexbox
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length > DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length) {
                    DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.push({ "index": DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].index, "value": false, "lastUpdate": today, "fillings": [], "Answers": [] });
                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                }
                let FillngBox = document.createElement("div");
                FillngBox.classList.add("col-12", "pt-2", "d-flex", "mt-2", "justify-content-start", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                checkboxFillngBox.append(FillngBox);
                let ckboxInput = document.createElement("input");
                ckboxInput.setAttribute("type", "checkbox");
                ckboxInput.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText);
                ckboxInput.setAttribute("onchange", "changeJsonData(event)");
                ckboxInput.setAttribute("onclick", "DisabledTrue(event)");
                ckboxInput.classList.add( "ml-3", "mycheckbox", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                ckboxInput.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].index);//
                ckboxInput.setAttribute("data-ckb", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].index);//
                FillngBox.append(ckboxInput);
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnswerOptions.length > DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length) {
                    DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].Answers.push({ "index": DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].index, "value": false, "lastUpdate": today, "fillings": [] });
                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                }

                if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].value) {
                    ckboxInput.setAttribute("checked", "true");
                    isDisabled = false;
                }

                if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnsText.includes("##^")) {//有填空 填空部分
                    let AnsText = DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnsText;//答案選項
                    let AnsAStr = AnsText.split("##");//切等分要放input text
                    let fsn = 1;
                    for (var ocf = 0; ocf < AnsAStr.length; ocf++) {//把切好的陣列
                        if (AnsAStr[ocf].includes("^")) {//要填空的位置
                            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].fillings.length < AnsAStr.length - 1) {
                                DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].fillings.push({ "index": fsn, "value": "", "lastUpdate": today });
                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                            }

                            let place = document.createElement("input");
                            place.setAttribute("type", "text");
                            place.setAttribute("onchange", "changeJsonData(event)");
                            place.disabled = isDisabled;
                            place.classList.add("form-control", "form-control-sm", "form-control-border", "mr-2", "ml-1", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                            place.style.maxWidth = "100px";
                            FillngBox.append(place);
                            let Txts = AnsAStr[ocf].substring("2");//填空後面的字
                            //place.classList.add(Txts);
                            place.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID/* AnsText + "_" +*//* DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[acf].*//*optIndex*/);
                            place.setAttribute("data-ckb", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].index);
                            place.setAttribute("data-fsn", fsn);
                            //optIndex++;
                            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].fillings.length > 0) {
                                place.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].fillings[fsn - 1].value);
                            }
                            fsn++;
                            if (Txts != null) {
                                let txts = document.createElement('span');
                                 txts.classList.add("mt-1");//, Txts
                                txts.innerText = Txts;
                                FillngBox.append(txts);//沒有填空的文字
                            }
                        }
                        else {
                            let TXTS = document.createElement("span");//一開始的文字
                             TXTS.classList.add("mt-1");
                            TXTS.innerText = AnsAStr[ocf];
                            FillngBox.append(TXTS);
                        }
                    }
                } else {
                    let TXTS = document.createElement("span");//一開始的文字
                    TXTS.innerText =DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnsText;
                    FillngBox.append(TXTS);
                }
                optionAns = 0;
                optIndex = 1;
                index = 1;

                //radio
                for (var acf = 0; acf < DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnswerOptions.length; acf++) {//radio部分
                    let RCinputBox = document.createElement("div");
                    RCinputBox.classList.add("col-12", "pt-2", "ml-5", "position-relative");
                    checkboxFillngBox.append(RCinputBox);
                    let radioLabel = document.createElement("label");
                    radioLabel.classList.add("form-check-label", "myLabelrc");

                    let rcRadio = document.createElement("input");
                    rcRadio.setAttribute("type", "radio");
                    rcRadio.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnswerOptions[acf].index);
                    rcRadio.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                    rcRadio.setAttribute("data-ckb", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].index);
                    rcRadio.setAttribute("onchange", "changeJsonData(event)");//
                    rcRadio.setAttribute("onclick", "CleanOption(event)");
                    //跟答案比對 有的被選起來
                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].Answers[acf].value) {
                        rcRadio.setAttribute("checked", "true");
                    }

                    rcRadio.classList.add("pl-1", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                    RCinputBox.append(rcRadio);
                    
                    //有填充 答案是3層
                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnswerOptions[acf].AnsText.includes("##^")) {
                        let rfAnstext = DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnswerOptions[acf].AnsText.split("##");
                        let fillingAns = 0;
                        let fillingAnsSn = fillingAns + 1;
                        for (var rfo = 0; rfo < rfAnstext.length; rfo++) {
                            if (rfAnstext[rfo].includes("^")) {
                                let placeRf = document.createElement("input");
                                placeRf.setAttribute("type", "text");//ttxx
                                placeRf.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID/*AnswerOptions[arc].AnsText + "_" + fillingAnsSn*/);
                                placeRf.setAttribute("onchange", "changeJsonData(event)");
                                placeRf.classList.add("form-control", "form-control-border", "form-control-sm", "d-inline", "mr-2", "ml-1", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                                placeRf.setAttribute("data-rd", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnswerOptions[acf].index);
                                placeRf.setAttribute("data-ckb", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].index);
                                placeRf.setAttribute("data-textindex", fillingAnsSn);
                                placeRf.disabled = true;
                                //placeRf.classList.add(rfAnstext[rfo].substring("2"))
                                if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].Answers[acf].fillings.length < rfAnstext.length - 1) {
                                    DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].Answers[acf].fillings.push({ "index": fillingAnsSn, "value": "", "lastUpdate": today });//radio 的filling
                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                                }
                                placeRf.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].Answers[acf].fillings[fillingAns].value);
                                placeRf.style.maxWidth = "100px";
                                RCinputBox.append(placeRf);
                                if (rfAnstext[rfo].substring("2") != null) {
                                    let AnsTXT = document.createElement("span");
                                    AnsTXT.innerText = rfAnstext[rfo].substring("2");
                                    RCinputBox.append(AnsTXT)
                                }
                                fillingAns++;
                                fillingAnsSn++;
                            } else {
                                let AnsTXT = document.createElement("span");
                                AnsTXT.innerText = rfAnstext[rfo];
                                RCinputBox.append(AnsTXT)
                            }
                        }
                    } else {
                        radioLabel.innerText = DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnswerOptions[acf].AnsText;
                        RCinputBox.append(radioLabel)
                    }

                }
            }
            if (DataObj.Groups[GroupSn].Questions[QusetionSn].hasOtherAnswers) {
                let otherR = document.createElement("input");
                otherR.setAttribute("type", "radio");
                otherR.setAttribute("onclick", "DisabledTrue(event)");
                otherR.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                let inputRadioBox = document.createElement("div");
                inputRadioBox.classList.add("col-3", "pt-2", "position-relative", "ml-5");
                inputRadioBox.append(otherR);
                RadioMixCheckboxBox.append(inputRadioBox);
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].otherAnswer.length > 0) {
                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].otherAnswer[0].value != null) {
                        otherR.setAttribute("checked", "true");
                    }
                }
                normalTypeOther(DataObj, GroupSn, QusetionSn, inputRadioBox);
            }
            let newData = checkIsFilling(DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText, GroupSn, QusetionSn, DataObj);
            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(newData));

        }
        function CreateNormalTypeRadioMixCheckbox(DataObj, GroupSn, QusetionSn, Parent) {
            let today = new Date().getTime();
            let RadioMixCheckboxBox = document.createElement("div");
            RadioMixCheckboxBox.classList.add("row","col-12");
            Parent.append(RadioMixCheckboxBox);

            for (var arc = 0; arc < DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length; arc++) {//radio
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length > DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length) {
                    DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.push({ "index": DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].index, "value": false, "lastUpdate": today,"fillings":[],"Answers": [] });
                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                }
                let RCinputBox = document.createElement("div");
                RCinputBox.classList.add("col-12", "pt-2","ml-5","position-relative");
                Parent.append(RCinputBox);
                let radioLabel = document.createElement("label");
                radioLabel.classList.add("form-check-label", "myLabelrc");

                let rcRadio = document.createElement("input");
                rcRadio.setAttribute("type", "radio");
                rcRadio.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].index);
                rcRadio.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                rcRadio.setAttribute("onchange", "changeJsonData(event)");//
                rcRadio.setAttribute("onclick", "cleanOptionforRadioMixCheckbox(event)");
                //跟答案比對 有的被選起來
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].value) {
                    rcRadio.setAttribute("checked", "true");
                }

                rcRadio.classList.add("pl-1", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                RCinputBox.append(rcRadio);
                RadioMixCheckboxBox.append(RCinputBox);
                //有填充 答案是3層
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnsText.includes("##^")) {
                    let rfAnstext = DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnsText.split("##");
                    let fillingAns = 0;
                    let fillingAnsSn = fillingAns + 1;
                    for (var rfo = 0; rfo < rfAnstext.length; rfo++) {
                        if (rfAnstext[rfo].includes("^")) {
                            let placeRf = document.createElement("input");
                            placeRf.setAttribute("type", "text");//ttxx
                            placeRf.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID/*AnswerOptions[arc].AnsText + "_" + fillingAnsSn*/);
                            placeRf.setAttribute("onchange", "changeJsonData(event)");
                            placeRf.classList.add("form-control", "form-control-border", "form-control-sm", "d-inline", "mr-2", "ml-1", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                            placeRf.setAttribute("data-rd", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].index);
                            placeRf.setAttribute("data-textindex", fillingAnsSn);
                            placeRf.disabled = true;
                            //placeRf.classList.add(rfAnstext[rfo].substring("2"))
                            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].fillings.length < rfAnstext.length - 1) {
                                DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].fillings.push({"index": fillingAnsSn, "value":"", "lastUpdate": today });//radio 的filling
                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                            }
                            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].value) {
                                placeRf.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].fillings[fillingAns].value);
                                placeRf.disabled = false;
                            }
                            placeRf.style.maxWidth = "100px";
                            RCinputBox.append(placeRf);
                            if (rfAnstext[rfo].substring("2") != null) {
                                let AnsTXT = document.createElement("span");
                                AnsTXT.innerText = rfAnstext[rfo].substring("2");
                                RCinputBox.append(AnsTXT)
                            }
                            fillingAns++;
                            fillingAnsSn++;
                        } else {
                            let AnsTXT = document.createElement("span");
                            AnsTXT.innerText = rfAnstext[rfo];
                            RCinputBox.append(AnsTXT)
                        }
                    }
                } else {
                    radioLabel.innerText = DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnsText;
                    RCinputBox.append(radioLabel)
                }
                //chexbox
                for (var acf = 0; acf < DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnswerOptions.length; acf++) {//checkbox部分
                    let checkboxFillngBox = document.createElement("div");
                    checkboxFillngBox.classList.add("col-12", "pt-2", "d-flex", "ml-5", "mt-2", "checkboxFillngBox", "justify-content-start", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                    RadioMixCheckboxBox.append(checkboxFillngBox);
                    let ckboxInput = document.createElement("input");
                    ckboxInput.setAttribute("type", "checkbox");
                    ckboxInput.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                    ckboxInput.setAttribute("onchange", "changeJsonData(event)");
                    ckboxInput.setAttribute("onclick", "DisabledTrue(event)");
                    ckboxInput.classList.add("CheckboxMixFilling","ml-3","mycheckbox", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                    ckboxInput.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnswerOptions[acf].index);//
                    ckboxInput.setAttribute("data-rd", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].index);//
                    ckboxInput.disabled = true;
                    let isFillingsDisable = true;
                    checkboxFillngBox.append(ckboxInput);
                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnswerOptions.length > DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].Answers.length) {
                        DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].Answers.push({ "index": DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnswerOptions[acf].index, "value": false, "lastUpdate": today, "fillings": [] });
                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                    }

                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].Answers[acf].value) {
                        ckboxInput.setAttribute("checked", "true");
                        ckboxInput.disabled = false;
                        isFillingsDisable = false;
                    }
                    
                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnswerOptions[acf].AnsText.includes("##^")) {//有填空 填空部分
                        let AnsText = DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnswerOptions[acf].AnsText;//答案選項
                        let AnsAStr = AnsText.split("##");//切等分要放input text
                        console.log("AnsAStr" + AnsAStr.length);
                        let fsn = 1;
                        for (var ocf = 0; ocf < AnsAStr.length; ocf++) {//把切好的陣列
                            if (AnsAStr[ocf].includes("^")) {//要填空的位置
                                if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].Answers[acf].fillings.length < AnsAStr.length - 1) {
                                    DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].Answers[acf].fillings.push({ "index": fsn, "value": "", "lastUpdate": today });
                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                                }

                                let place = document.createElement("input");
                                place.setAttribute("type", "text");
                                place.setAttribute("onchange", "changeJsonData(event)");
                                place.disabled = isFillingsDisable;
                                place.classList.add("form-control", "form-control-sm", "form-control-border", "mr-2","ml-1", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                                place.style.maxWidth = "100px";
                                checkboxFillngBox.append(place);
                                let Txts = AnsAStr[ocf].substring("2");//填空後面的字
                                //place.classList.add(Txts);
                                place.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID/* AnsText + "_" +*//* DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[acf].*//*optIndex*/);
                                place.setAttribute("data-rd", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].index);
                                place.setAttribute("data-ckb", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnswerOptions[acf].index);
                                place.setAttribute("data-fsn", fsn);
                                //optIndex++;
                                if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].Answers[acf].fillings.length > 0) {
                                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].Answers[acf].value) {
                                        place.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arc].Answers[acf].fillings[fsn - 1].value);
                                    }
                                }
                                fsn++;
                                if (Txts != null) {
                                    let txts = document.createElement('span');
                                   /* txts.classList.add("mt-3");//, Txts*/
                                    txts.innerText = Txts;
                                    checkboxFillngBox.append(txts);//沒有填空的文字
                                }
                            }
                            else {
                                let TXTS = document.createElement("span");//一開始的文字
                               /* TXTS.classList.add("mt-3");*/
                                TXTS.innerText = AnsAStr[ocf];
                                checkboxFillngBox.append(TXTS);
                            }
                        }
                    } else {
                        let TXTS = document.createElement("span");//一開始的文字
                        TXTS.innerText = DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arc].AnswerOptions[acf].AnsText;
                        checkboxFillngBox.append(TXTS);
                    }
                    optionAns = 0;
                    optIndex = 1;
                    index = 1;
                }
            }
            if (DataObj.Groups[GroupSn].Questions[QusetionSn].hasOtherAnswers) {
                let otherR = document.createElement("input");
                otherR.setAttribute("type", "radio");
                otherR.setAttribute("onclick", "DisabledTrue(event)");
                otherR.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                let inputRadioBox = document.createElement("div");
                inputRadioBox.classList.add("col-3", "pt-2", "position-relative","ml-5");
                inputRadioBox.append(otherR);
                RadioMixCheckboxBox.append(inputRadioBox);
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].otherAnswer.length > 0) {
                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].otherAnswer[0].value != null) {
                        otherR.setAttribute("checked", "true");
                    }
                }

                normalTypeOther(DataObj, GroupSn, QusetionSn, inputRadioBox);
            }
            let newData = checkIsFilling(DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText, GroupSn, QusetionSn, DataObj);
            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(newData));

        }
        function CreateNormalTypeRadioMixFilling(DataObj, GroupSn, QusetionSn, Parent) {
            let today = new Date().getTime();
            let isDisabled = true;
            let rfRadfillBoxFather = document.createElement("div");
            rfRadfillBoxFather.classList.add("row","col-12");
            Parent.append(rfRadfillBoxFather)
            for (var arf = 0; arf < DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length; arf++) {//radio
                let rfRadfillBox = document.createElement("div");
                rfRadfillBox.classList.add("rfRadfillBox", "col-12", "ml-5", "position-relative");
                rfRadfillBoxFather.append(rfRadfillBox);
                let rfRadio = document.createElement("input");
                rfRadio.setAttribute("type", "radio");
                rfRadio.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                rfRadio.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arf].index);
                rfRadio.setAttribute("onchange", "changeJsonData(event)");
                rfRadio.setAttribute("onclick", "CleanOthers(event)");
                rfRadio.classList.add("myRadio", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length > DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length) {
                    DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.push({ "index": DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arf].index, "value": false, "lastUpdate": today,"fillings":[],"Answers":[]});
                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                }

                if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length > 0) {
                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arf].value) {
                        rfRadio.setAttribute("checked", "true");
                        isDisabled = false;
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
                            placeRf.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                            placeRf.setAttribute("onchange", "changeJsonData(event)");
                            placeRf.classList.add("form-control","form-control-border","form-control-sm", "mb-3", "d-inline", "mr-2", "ml-1", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                            placeRf.setAttribute("data-rd", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[arf].index);
                            placeRf.setAttribute("data-fsn", fillingAnsSn);
                            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arf].fillings.length < rfAnstext.length - 1) {
                                DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arf].fillings.push({ "index": fillingAnsSn, "value": "", "lastUpdate": today});
                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                            }

                            placeRf.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arf].fillings[fillingAns].value);
                            placeRf.disabled = DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[arf].fillings[fillingAns].value == "" ? true : false;;
                            placeRf.style.maxWidth ="100px";
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
            if (DataObj.Groups[GroupSn].Questions[QusetionSn].hasOtherAnswers) {
                let otherR = document.createElement("input");
                otherR.setAttribute("type", "radio");
                otherR.setAttribute("onclick", "CleanOthers(event)");
                otherR.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);

                let inputRadioBox = document.createElement("div");
                inputRadioBox.classList.add("col-12","ml-5", "position-relative");
                inputRadioBox.append(otherR);//rfRadfillBoxFather
                rfRadfillBoxFather.append(inputRadioBox);
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].otherAnswer.length>0) {
                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].otherAnswer[0].value) {
                        otherR.setAttribute("checked", "true");
                    }
                }
                normalTypeOther(DataObj, GroupSn, QusetionSn, inputRadioBox);
            }
            let newData = checkIsFilling(DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionText, GroupSn, QusetionSn, DataObj);
            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(newData));

        }
        function CreateNormalTypeCheckboxMixImage(DataObj, GroupSn, QusetionSn, Parent) {
            let today = new Date().getTime();
            for (var cbi = 0; cbi < DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length; cbi++) {
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions.length > DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.length) {
                    DataObj.Groups[GroupSn].Questions[QusetionSn].Answers.push({ "index": DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[cbi].index, "value": false, "lastUpdate": today,"fillings":[]});
                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                }
                let CBimagebox = document.createElement("div");
                CBimagebox.classList.add("col-12", "position-relative", "ml-5");
                Parent.append(CBimagebox);
                let checkbox = document.createElement("input");
                checkbox.setAttribute("type", "checkbox");
                checkbox.setAttribute("onchange", "changeJsonData(event)");//todo 檢查 抓子節點圖片ID
                checkbox.classList.add("mycheckbox", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                checkbox.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[cbi].index);
                checkbox.setAttribute("onclick", "DisabledTrue(event)");
                checkbox.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                //顯示答案
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[cbi].value == true) {
                    checkbox.setAttribute("checked", "true");
                }
                CBimagebox.append(checkbox);
                //checkbox 選項是否有填充
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[cbi].AnsText.includes("##^")) {//有填空 填空部分
                    let AnsText = DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[cbi].AnsText;//答案選項
                    let AnsAStr = AnsText.split("##");//切等分要放input text
                    let index = 1;//填充答案的index
                    console.log("AnsAStr" + AnsAStr.length);
                    let optIndex = 1;
                    //填充的Index
                    let optionAns = 0;
                    for (var ocf = 0; ocf < AnsAStr.length; ocf++) {//把切好的陣列
                        
                        if (AnsAStr[ocf].includes("^")) {//要填空的位置
                            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[cbi].fillings.length < AnsAStr.length - 1) {
                                DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[cbi].fillings.push({ "index": index, "value":"", "lastUpdate": today });
                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(DataObj));
                                index++;
                            }

                            let place = document.createElement("input");
                            place.setAttribute("type", "text");
                            place.setAttribute("onchange", "changeJsonData(event)");
                            place.disabled = true;
                            place.classList.add("d-inline","form-control", "form-control-sm", "form-control-border", "mr-2", "mt-3", "ml-1", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                            place.style.maxWidth = "100px";
                            CBimagebox.append(place);
                            let Txts = AnsAStr[ocf].substring("2");//填空後面的字
                            //place.classList.add(Txts);
                            place.setAttribute("name", /*AnsText + "_" +/*/ DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);//*optIndex*/);
                            place.setAttribute("data-ckb", DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[cbi].index);
                            place.setAttribute("data-fsn", optIndex);
                            optIndex++;
                            if (DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[cbi].value) {
                                place.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].Answers[cbi].fillings[optionAns].value);
                                place.disabled = false;
                            }

                            if (Txts != null) {
                                let txts = document.createElement('span');
                                txts.classList.add("mt-3");//, Txts
                                txts.innerText = Txts;
                                CBimagebox.append(txts);//沒有填空的文字
                            }
                            optionAns++;
                        }
                        else {
                            let TXTS = document.createElement("span");//一開始的文字
                            TXTS.classList.add("mt-3");
                            TXTS.innerText = AnsAStr[ocf];
                            CBimagebox.append(TXTS);
                        }
                    }
                } else {
                    let TXTS = document.createElement("span");//一開始的文字
                    TXTS.innerText = DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[ocf].AnsText;
                    CBimagebox.append(TXTS);
                }
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[cbi].image != 0) {
                    let img = document.createElement("img");
                    img.src = "ShowAdminImg.aspx?id=" + DataObj.Groups[GroupSn].Questions[QusetionSn].AnswerOptions[cbi].image;
                    img.style.maxWidth = "200px";
                    img.classList.add("col-12", "ml-5", "mt-3","d-block");
                    CBimagebox.append(img)
                }

            }
            if (DataObj.Groups[GroupSn].Questions[QusetionSn].hasOtherAnswers == true) {
                let checkboxFillngBox = document.createElement("div");
                checkboxFillngBox.classList.add("col-12","position-relative","mt-3", "pt-2","ml-5", "checkboxFillngBox", "justify-content-start", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
                Parent.append(checkboxFillngBox);
                let ckboxInput = document.createElement("input");
                ckboxInput.setAttribute("type", "checkbox");
                ckboxInput.setAttribute("onclick", "DisabledTrue(event)");
                ckboxInput.setAttribute("onchange", "changeJsonData(event)");
                ckboxInput.classList.add("otherAns", "mt-2");
                checkboxFillngBox.append(ckboxInput);
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].otherAnswer.length > 0) {
                    if (DataObj.Groups[GroupSn].Questions[QusetionSn].otherAnswer[0].value) {
                        ckboxInput.setAttribute("checked", "true");
                    }
                }
                normalTypeOther(DataObj, GroupSn, QusetionSn, checkboxFillngBox);
            }

        }
        //normal 其他選項題型
        function normalTypeOther(DataObj, GroupSn,QusetionSn,Parent) {
            let otherSpan = document.createElement("span");
            otherSpan.classList.add("pt-2");
            otherSpan.innerText = "其他:"
            Parent.append(otherSpan);
            let other = document.createElement("input");
            other.setAttribute("name", DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID);
            other.setAttribute("type", "text");
            other.style.maxWidth = "100px";
           
            other.setAttribute("onchange", "changeJsonData(event)");
            if (DataObj.Groups[GroupSn].Questions[QusetionSn].otherAnswer.length > 0) {
                if (DataObj.Groups[GroupSn].Questions[QusetionSn].otherAnswer[0].value) {
                    other.setAttribute("value", DataObj.Groups[GroupSn].Questions[QusetionSn].otherAnswer[0].fillings[0].value);
                    other.disabled = false;
                } else {
                    other.setAttribute("value", "");
                    other.disabled = true;
                }
            }
            other.classList.add("col-3", "form-control", "ml-1", "otherAns", "d-inline", "form-control-sm", "form-control-border");
            Parent.append(other);
        }


    </script>
</asp:Content>
