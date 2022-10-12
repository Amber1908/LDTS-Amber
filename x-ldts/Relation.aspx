<%@ Page Title="" Language="C#" MasterPageFile="~/LDTS.Master" AutoEventWireup="true" CodeBehind="Relation.aspx.cs" Inherits="LDTS.Relation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <section class="relation kanban content-header">
        <div class="relationContainer container-fluid">
            <div class="relationTitle row mb-2">
                <div class="col-sm-6">
                    <h1>程序書關聯設定</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Default">Home</a></li>
                        <li class="breadcrumb-item">程序書關聯設定</li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
    <section class="content pb-3">
        <div class="container-fluid h-100">
            <div class="pathPart">
                <div class="info-box">
                    <span class="info-box-icon bg-lightblue disabled ">
                        <i class="far fa-copy"></i>
                    </span>
                    <div class="info-box-content">
                        <span class="info-box-text">目前選取</span>
                        <span id="path" runat="server" class="info-box-number "></span>
                        <span id="pathDetail" runat="server" class="info-box-number "></span>
                    </div>
                </div>
                <div class="info-box pro">
                    <span class="info-box-icon bg-primary ">
                        <a aria-readonly="true" href="ProcessAdd.aspx" class=" btn btn-facebook btn-block" style="left: 0px; bottom: 0px">
                            <i class="fas fa-plus"></i>
                        </a>
                    </span>
                    <div class="info-box-content">
                        <span id="processAdd" runat="server" class="info-box-number ">新增程序書</span>
                    </div>
                </div>
                <div class="info-box swb">
                    <span class="info-box-icon bg-info  ">
                        <a aria-readonly="true" href="StandarWorkbookAdd.aspx" class=" btn btn-facebook btn-block" style="left: 0px; bottom: 0px">
                            <i class="fas fa-plus"></i>
                        </a>
                    </span>
                    <div class="info-box-content">
                        <span id="standardAdd" runat="server" class="info-box-number ">新增標準作業書</span>
                    </div>
                </div>
                <div class="info-box form">
                    <span class="info-box-icon bg-warning ">
                        <a aria-readonly="true" href="FormGeneration.aspx" class=" btn btn-facebook btn-block" style="left: 0px; bottom: 0px">
                            <i class="fas fa-plus"></i>
                        </a>
                    </span>
                    <div class="info-box-content">
                        <span id="formAdd" runat="server" class="info-box-number ">新增表單範本</span>
                    </div>
                </div>
            </div>
            <div class="card card-row card-primary" style="padding-left: 0px; padding-right: 0px">
                <div class="card-header ">
                    <h3 class="card-title ">程序書</h3>
                    <%--                    <div class="float-right proCheckAll">
                        <input id="pro" type="checkbox" />
                        <label for="pro">全選</label>
                    </div>--%>
                </div>
                <div class="card-body">
                    <div id="proFormList" runat="server">
                    </div>
                </div>

            </div>
            <div class="card card-row card-default" style="padding-left: 0px; padding-right: 0px">
                <div class="card-header bg-info ">
                    <h3 class="card-title ">標準作業書</h3>
                    <div class="float-right swbCheckAll">
                        <input id="swb" type="checkbox" />
                        <label for="swb">全選</label>
                    </div>
                </div>
                <div class="card-body">
                    <div id="swbFormList" runat="server">
                    </div>
                </div>

            </div>
            <div class="card card-row card-default " style="padding-left: 0px; padding-right: 0px">
                <div class="card-header bg-warning">
                    <h3 class="card-title">表單清單</h3>
                    <div class="float-right formCheckAll">
                        <input type="checkbox" id="form" />
                        <label for="form">全選</label>
                    </div>
                </div>
                <div class="card-body">
                    <div id="formList" runat="server">
                    </div>
                </div>
            </div>
        </div>
                    <div  id="save" runat="server" class="btn btn-primary float-right " style="position:fixed;right:2vw; bottom:12vh">
                儲存
            </div>

    </section>
    <asp:TextBox runat="server" TextMode="MultiLine" CssClass="d-none" ID="AllReProcessForms"></asp:TextBox>
    <asp:TextBox runat="server" TextMode="MultiLine" CssClass="d-none" ID="AllReProSwb"></asp:TextBox>
    <asp:TextBox runat="server" TextMode="MultiLine" CssClass="d-none" ID="AllReSwbF"></asp:TextBox>
    <input type="text" id="processID" runat="server" class="d-none" value="" />
    <input type="text" id="sworkbookID" runat="server" class="d-none" value="" />

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jqueryPlaceHolder" runat="server">
    <script>
        var body = document.querySelector(".sidebar-mini");
        body.classList.add("sidebar-collapse");
        let wrapper = document.querySelector(".content-wrapper");
        wrapper.classList.add("kanban");
        var AllSworkbooks = document.getElementById("swb");
        var Allforms = document.getElementById("form");
        AllSworkbooks.addEventListener("click", function () {
            var allbooksCheck = document.getElementsByClassName("swbook");
            if (!AllSworkbooks.checked) {
                for (var i = 0; i < allbooksCheck.length; i++) {
                    allbooksCheck[i].checked = false;
                }
            } else {
                for (var i = 0; i < allbooksCheck.length; i++) {
                    allbooksCheck[i].checked = true;
                }
            }
        });
        Allforms.addEventListener("click", function () {
            var formChekbox = document.getElementsByClassName("report");
            
            if (!Allforms.checked) {
                for (var i = 0; i < formChekbox.length; i++) {
                    formChekbox[i].checked = false;
                }
            } else {
                for (var i = 0; i < formChekbox.length; i++) {
                    formChekbox[i].checked = true;
                }
            }
        });
        //顯示該頁的設定
        var showP = document.getElementById("mainPlaceHolder_processID");
        var showS = document.getElementById("mainPlaceHolder_sworkbookID");
        var formsCheckboxs = document.getElementsByClassName("report");
        var SCheckboxs = document.getElementsByClassName("swbook");
        if (!showP.value == 0) {
            var mainPlaceHolder_AllReProcessForms = document.getElementById("mainPlaceHolder_AllReProcessForms");
            var Pobj = JSON.parse(mainPlaceHolder_AllReProcessForms.value);
            for (var p = 0; p < Pobj.length; p++) {
                for (var i = 0; i < formsCheckboxs.length; i++) {
                    if (Pobj[p].QID == formsCheckboxs[i].value) {
                        formsCheckboxs[i].checked = true;
                    }
                }
            }
            var mainPlaceHolder_AllReProSwb = document.getElementById("mainPlaceHolder_AllReProSwb");
            if (mainPlaceHolder_AllReProSwb.value != null) {
                var Sobj = JSON.parse(mainPlaceHolder_AllReProSwb.value);
                for (var s = 0; s < Sobj.length; s++) {
                    for (var sb = 0; sb < SCheckboxs.length; sb++) {
                        if (Sobj[s].SID == SCheckboxs[sb].value) {
                            SCheckboxs[sb].checked = true;
                        }
                    }
                }
            }
        } else if (!showS.value == 0) {
            var AllReSwbF = document.getElementById("mainPlaceHolder_AllReSwbF");
            if (AllReSwbF.value != null) {
                var ReSwbfObj = JSON.parse(AllReSwbF.value);
                for (var i = 0; i < ReSwbfObj.length; i++) {
                    for (var c = 0; c < formsCheckboxs.length; c++) {
                        if (ReSwbfObj[i].QID == formsCheckboxs[c].value) {
                            formsCheckboxs[c].checked = true;
                        }
                    }
                }
            }
        }
        //按儲存
        var save = document.getElementById("mainPlaceHolder_save");
        save.addEventListener("click", function () {
            var PID = document.getElementById("mainPlaceHolder_processID").value;
            var SID = document.getElementById("mainPlaceHolder_sworkbookID").value;
            var forms = document.getElementsByClassName("report");
            var Sworlbooks = document.getElementsByClassName("swbook");

            if (!PID == 0) {
                //  先刪除
                let deleteOld = new Object();
                deleteOld.pid = PID,
                    ajax1 = $.ajax({
                        type: "post",
                        url: "DeleteOldReProForm.ashx",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(deleteOld),
                        success: ""
                    });
                $.when(ajax1).done(function () {
                    for (var i = 0; i < forms.length; i++) {
                        //賦值 給reObj
                        if (forms[i].checked) {
                            let data = new Object();
                            data.pid = PID;
                            data.QID = forms[i].value;
                            //
                            $.ajax({
                                type: "post",
                                url: "RelationService.ashx",
                                contentType: "application/json; charset=utf-8",
                                data: JSON.stringify(data),
                                success: function (res) {
                                }
                            })
                            //ajax
                        }//if forms[i].checked
                    }//for
                })
                let OldSworkbook = new Object;
                OldSworkbook.pid = PID;
                ajaxS = $.ajax({
                    type: "post",
                    url: "DeleteOldReProSworkbook.ashx",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(OldSworkbook),
                    success: ""
                });//ajaxS
                $.when(ajaxS).done(function () {
                    for (var i = 0; i < Sworlbooks.length; i++) {
                        if (Sworlbooks[i].checked) {
                            let dataS = new Object();
                            dataS.pid = PID,
                                dataS.sid = Sworlbooks[i].value;
                            var arr = [];
                            //
                            $.ajax({
                                type: "post",
                                url: "InsertReProSworkbook.ashx",
                                contentType: "application/json; charset=utf-8",
                                data: JSON.stringify(dataS),
                                success: function (res) {
                                    //    alert(res);
                                }
                            })
                        }
                    }//for Sworlbooks.length
                    alert("關聯設定成功!")
                })//ajax 存程序書關聯的標準書
            }//if
            else if (!SID == 0) {
                //先刪除舊的
                let deleteOldS = new Object();
                deleteOldS.sid = SID,

                    ajaxRSwbFD = $.ajax({
                        type: "post",
                        url: "DeleteOldreSworkbookForm.ashx",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(deleteOldS),
                        success: ""
                    });
                $.when(ajaxRSwbFD).done(function () {
                    for (var i = 0; i < forms.length; i++) {
                        if (forms[i].checked) {
                            let dataf = new Object();
                            dataf.sid = SID;
                            dataf.QID = forms[i].value;//form_id改QID
                            $.ajax({
                                type: "post",
                                url: "InsertReSworkbookForm.ashx",
                                contentType: "application/json; charset=utf-8",
                                data: JSON.stringify(dataf),
                                success: ""
                            })//ajax
                        }
                    }//for ajax
                    alert("關聯設定成功!")
                });//ajaxRSwbFD
            }//else if
            else {
                alert("請選欲設定的程序書或標準作業書。")
            }

        })
    </script>
</asp:Content>
