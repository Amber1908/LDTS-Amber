<%@ Page Title="" Language="C#" MasterPageFile="~/LDTS.Master" AutoEventWireup="true" CodeBehind="Ao.aspx.cs" Inherits="LDTS.Ao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <section class="Ao content-header">
        <div class="AoContainer container-fluid">
            <div class="AoTitle row mb-2">
                <div class="col-sm-6">
                    <h1>人員權限設定</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Default">Home</a></li>
                        <li class="breadcrumb-item">人員權限設定</li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
    <!-- Main content -->
    <asp:TextBox TextMode="MultiLine" runat="server" ID="jsonDefult" CssClass=""></asp:TextBox><!--d-none -->

    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2">
                    <div class="card card-primary card-outline">
                        <div class="card-body box-profile text-center">
                            <i class="fas fal fa-user-edit pr-1" style="font-size: 15px"></i><span>簽核</span>
                            <i class="fas fa-pen-alt pr-1 pl-2" style="font-size: 15px"></i><span>編輯</span>
                        </div>
                    </div>
                </div>
                <div class="AoMain col-md-10">
                    <div class="AoMainCard card">
                        <div class="AoMainCardBody card-body">
                            <div class="AoMainform form-horizontal">
                            </div>
                        </div>
                    </div>
                    <div class="aoApplication d-flex justify-content-end mb-5">
                        <input id="save" class="mb-3 btn btn-primary" value="儲存" type="button" />
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script>
        var AoMainform = document.querySelector(".AoMainform");
        var jsonDefault = document.getElementById("mainPlaceHolder_jsonDefult").value;
        const DataObj = JSON.parse(jsonDefault);
        window.onload = function () {
            var AoMainform = document.querySelector(".AoMainform");
            AoMainform.innerHTML = processTemplete(DataObj);
        }
        var btnSave = document.getElementById("save");
        btnSave.addEventListener("click", function save() {
            function DataResult() {
                var allSignCheckboxs = document.querySelectorAll('.Sign');
                var backObjs = [];
                for (var i = 0; i < allSignCheckboxs.length; i++) {
                    if (allSignCheckboxs[i].checked == true) {
                        var backObj = new Object();
                        let Datas = allSignCheckboxs[i].value.split(',');
                        let statues = Datas[0].split('_');
                        var fid = Datas[1].split(':');
                        backObj.admin_id = DataObj[0].admin_id;
                        backObj.QID = fid[1];
                        backObj.status = statues[1];
                        backObjs.push(backObj);
                    }
                }
                var allEditCheckboxs = document.querySelectorAll('.Edit');
                var resultObjs = [];
                for (var i = 0; i < allEditCheckboxs.length; i++) {
                    if (allEditCheckboxs[i].checked == true) {
                        var EditObj = new Object();
                        var edits = allEditCheckboxs[i].value.split(',');
                        let statuess = edits[0].split('_');
                        var Fid = edits[1].split(':');
                        EditObj.admin_id = DataObj[0].admin_id;
                        EditObj.QID = Fid[1];
                        EditObj.status = statuess[1];
                        backObjs.push(EditObj);
                    }
                }
                const set = new Set();
                resultObjs = backObjs.filter(item => !set.has(item.QID) ? set.add(item.QID) : false);
                return resultObjs;
            }
            var Data = DataResult();
            ajax1 = $.ajax({
                type: "post",
                url: "InsertAdminFormService.ashx",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(Data),
                success: function (res) {
                    alert(res);
                }
            });
        });
        function processTemplete(Obj) {
            var str = "";
            for (var i = 0; i < DataObj.length; i++) {
                str += '<div id="ProcessRow" class="row ProcessRowstyle pt-3 pb-3" style="border-bottom: solid 1px; border-block-color: lightgray">'
                //展開的按鈕
                str += '<div class="open-btn d-flex align-items-center justify-content-center btn-outline-primary btn btn-circle" style="border-radius: 100%; width: 2.8rem">';
                str += '<i class="plus-Process fas fa-plus-circle" style="font-size: 20px" onclick="changeIconToOpenOrClose(event)"></i>';
                str += '<i class="dash-Process fas fa-minus-circle d-none" style="font-size: 20px" onclick="changeIconToOpen(event)"></i></div>';
                //全簽核 
                str += '<div class="col-1 checkSign">';
                str += '<div class="row d-flex justify-content-center">';
                str += '<label for="PsignAll';
                str += DataObj[i].PID;
                str += '"><i class="fas fal fa-user-edit pr-1" style="font-size: 20px"></i></label></div>';
                str += '<div class="row d-flex ml-4">';
                str += '<input type="checkbox" onclick="allCheckBoxesChecked(event)" class="myCheckbox" name="status" id="PsignAll';
                str += DataObj[i].PID;
                str += '" /></div>';
                str += '</div>';
                //全編輯
                str += '<div class="col-1 checkEdit">';
                str += '<div class="row d-flex justify-content-start">';
                str += '<label for="PEditAll';
                str += DataObj[i].PID;
                str += '"><i class="fas fa-pen-alt pr-1 pl-2" style="font-size: 20px"></i></label></div>';
                str += '<div class="row d-flex ml-1">';
                str += '<input type="checkbox" name="status" class="myCheckbox EditCheckBox" onclick="allEditCheckBoxesChecked(event)" id="PEditAll';
                str += DataObj[i].PID;
                str += '" /></div>';
                str += '</div>';
                //程序書 名稱
                str += '<div class="col-9 pname-box">';
                str += '<div class="row d-flex align-items-end">';
                str += '<div class="row pname-style"></div>';
                str += '<a class="text-justify align-bottom" style="font-size: 30px" id="Pname">';
                str += DataObj[i].Pname;
                str += '</a>';
                str += '</div>';
                str += '</div>';
                //標準作業書
                if (DataObj[i].ChildrenSwbs.length > 0) {
                    for (var s = 0; s < DataObj[i].ChildrenSwbs.length; s++) {
                        str += '<div class="SWB-container container mt-3 d-none ">';
                        str += '<div class=" SWB-row  row d-flex justify-content-end">';
                        //展開的按鈕
                        str += '<div class="col-1 pl-5 pt-2" >';
                        str += '<div class="open-btn d-flex align-items-center justify-content-center btn-outline-info btn btn-circle" style="border-radius: 100%; width: 2.15rem">';
                        str += '<i class="plus-Process fas fa-plus-circle" style="font-size: 20px" onclick="changeSWBIconToClose(event)"></i>';
                        str += '<i class="dash-Process fas fa-minus-circle d-none" style="font-size: 20px" onclick="changeSWBIconToOpen(event)"></i>';
                        str += '</div>';
                        str += '</div>';
                        //全簽核 
                        str += '<div class="col-1 checkSign">';
                        str += '<div class="row d-flex justify-content-center">';
                        str += '<label for="SsignAll';
                        str += DataObj[i].ChildrenSwbs[s].SID;
                        str += '"><i class="fas fal fa-user-edit pr-1" style="font-size: 20px"></i></label></div>';
                        str += '<div class="row d-flex ml-4">';
                        str += '<input type="checkbox" name="status"onclick="allSWBCheckBoxesChecked(event)" class="myCheckbox SWBCheckBox" id="SsignAll';
                        str += DataObj[i].ChildrenSwbs[s].SID;
                        str += '" /></div>';
                        str += '</div>';
                        //全編輯
                        str += '<div class="col-1 checkEdit">';
                        str += '<div class="row d-flex justify-content-start">';
                        str += '<label for="SEditAll';
                        str += DataObj[i].ChildrenSwbs[s].SID;
                        str += '"><i class="fas fa-pen-alt pr-1 pl-2" style="font-size: 20px"></i></label></div>';
                        str += '<div class="row d-flex ml-1">';
                        str += '<input type="checkbox" name="status" onclick="allEditSWBCheckBoxesChecked(event)" class="myCheckbox SWBCheckBox EditCheckBox" id="SEditAll';
                        str += DataObj[i].ChildrenSwbs[s].SID;
                        str += '" /></div>';
                        str += '</div>';
                        //標準書 名稱
                        str += '<div class="col-8 sname-box">';
                        str += '<a class="text-justify align-bottom " style="font-size: 30px" id="Sname">';
                        str += DataObj[i].ChildrenSwbs[s].Sname;
                        str += '</a>';
                        str += '</div>';
                        if (DataObj[i].ChildrenSwbs[s].ChildrenSWBforms.length > 0) {
                            for (var c = 0; c < DataObj[i].ChildrenSwbs[s].ChildrenSWBforms.length; c++) {
                                //SWB-F-container 標準書下面的表單
                                str += '<div class="SWB-F-container container mt-2 d-none">';//d-none
                                str += '<div class="row SWB-F-row  d-flex justify-content-end">';
                                //全部簽核
                                str += '<div class="col-1 checkSign SWB-F-Checkbox">';
                                str += '<div class="row d-flex justify-content-start ml-1">';
                                str += '<label for="SFsign';
                                if (DataObj[i].ChildrenSwbs[s].ChildrenSWBforms[c].form!=null) {
                                    str += DataObj[i].ChildrenSwbs[s].ChildrenSWBforms[c].form.QID;
                                }
                                str += '"><i class="fas fal fa-user-edit pr-1" style="font-size: 20px"></i></label></div>';
                                str += '<div class="row d-flex ml-1">';
                                str += '<input type="checkbox" name="status" class="SWBCheckBox Sign" id="SFsign';
                                if (DataObj[i].ChildrenSwbs[s].ChildrenSWBforms[c].form!=null) {
                                    str += DataObj[i].ChildrenSwbs[s].ChildrenSWBforms[c].form.QID;
                                }
                                str += '" ';
                                if (DataObj[i].ChildrenSwbs[s].ChildrenSWBforms[c].form != null) {
                                    str += 'value="status_2,F_id:' + DataObj[i].ChildrenSwbs[s].ChildrenSWBforms[c].form.QID + '"';
                                } else {
                                    str += 'value="status_2,F_id:' + 0 + '"';
                                }
                                if (DataObj[i].ChildrenSwbs[s].ChildrenSWBforms[c].status == 2) {
                                    str += 'checked';
                                }
                                str +='/></div >';
                                str += '</div>';
                                //全部編輯
                                str += '<div class="col-1 pb-2 checkEdit SWB-F-Checkbox">';
                                str += '<div class="row d-flex justify-content-start">';
                                str += '<label for="SFEdit';
                                if (DataObj[i].ChildrenSwbs[s].ChildrenSWBforms[c].form != null) {
                                    str += DataObj[i].ChildrenSwbs[s].ChildrenSWBforms[c].form.QID;
                                } else {
                                    str += 0;
                                }
                                str += '"><i class="fas fa-pen-alt pr-1 pl-2" style="font-size: 20px"></i></label></div>';
                                str += '<div class="row d-flex ml-1">';
                                str += '<input type="checkbox" class="SWBCheckBox SWBEditCheckBox Edit" name="status" id="SFEdit';
                                if (DataObj[i].ChildrenSwbs[s].ChildrenSWBforms[c].form != null) {
                                    str += DataObj[i].ChildrenSwbs[s].ChildrenSWBforms[c].form.QID;
                                } else {
                                    str +=0;
                                }
                                str += '"';
                                if (DataObj[i].ChildrenSwbs[s].ChildrenSWBforms[c].form != null) {
                                    str += 'value="status_1,F_id:' + DataObj[i].ChildrenSwbs[s].ChildrenSWBforms[c].form.QID + '"';
                                }
                                else {
                                    str +='value=" 0"';
                                }
                                if (DataObj[i].ChildrenSwbs[s].ChildrenSWBforms[c].status == 1 || DataObj[i].ChildrenSwbs[s].ChildrenSWBforms[c].status ==2) {
                                    str += 'checked';
                                }
                                str += ' /></div>';
                                str += '</div>';
                                //標準書下面的表單 表單名稱
                                str += '<div class="col-7 s-fname-box pb-2 pt-2">';
                                str += '<a class="text-justify align-bottom" style="font-size: 25px;color:gray" id="S-Fname">';
                                if (DataObj[i].ChildrenSwbs[s].ChildrenSWBforms[c].form!=null) {
                                    str += DataObj[i].ChildrenSwbs[s].ChildrenSWBforms[c].form.Title;
                                }
                                str += '</a >';
                                str += '</div>';
                                str += '</div>';
                                str += '</div>';//SWB-F-container
                            }
                        }
                        str += '</div>';//SWB-row
                        str += '</div>';//SWB-container
                    }
                }

                //process下面的 form
                if (DataObj[i].ChildrenForms.length > 0) {
                    for (var g = 0; g < DataObj[i].ChildrenForms.length; g++) {
                        str += '<div class="P-Fcontainer container pt-3 d-none">';//P-Fcontainer
                        str += '<div class="P-F-row row  d-flex justify-content-end">';//P-F-row
                        //全部簽核
                        str += '<div class="col-1 checkSign F-Checkbox">';
                        str += '<div class="row d-flex justify-content-start ml-1">';
                        str += '<label for="P-fsignAll';
                        if (DataObj[i].ChildrenForms[g].form!=null) {
                            str += DataObj[i].ChildrenForms[g].form.QID;
                        }
                        str += '"><i class="fas fal fa-user-edit pr-1" style="font-size: 20px"></i></label></div>';
                        str += '<div class="row d-flex ml-1">';
                        str += '<input type="checkbox" class="myCheckbox Sign" name="status" id="P-fsignAll';
                        if (DataObj[i].ChildrenForms[g].form!=null) {
                            str += DataObj[i].ChildrenForms[g].form.QID;
                        }
                        str += '"';
                        if (DataObj[i].ChildrenForms[g].form != null) {
                            str += 'value="status_2,F_id:' + DataObj[i].ChildrenForms[g].form.QID + '"';
                        } else {
                            str += 'value="status_2,F_id:' +0 + '"';
                        }
                        
                        if (DataObj[i].ChildrenForms[g].status == 2) {
                            str += 'checked';
                        }
                        str += ' /></div>';
                        str += '</div>';
                        //全部編輯
                        str += '<div class="col-1 pb-2 checkEdit F-Checkbox">';
                        str += '<div class="row d-flex justify-content-start">';
                        str += '<label for="P-fEditAll';
                        if (DataObj[i].ChildrenForms[g].form!=null) {
                            str += DataObj[i].ChildrenForms[g].form.QID;
                        }
                        str += '"><i class="fas fa-pen-alt pr-1 pl-2" style="font-size: 20px"></i></label>';
                        str += '</div>';
                        str += '<div class="row d-flex ml-1">';
                        str += '<input type="checkbox" class="myCheckbox EditCheckBox Edit" name="status" id="P-fEditAll';
                        if (DataObj[i].ChildrenForms[g].form != null) {
                            str += DataObj[i].ChildrenForms[g].form.QID;
                        }
                        str += '"';
                        if (DataObj[i].ChildrenForms[g].form!=null) {
                            str += 'value="status_1,F_id:' + DataObj[i].ChildrenForms[g].form.QID + '"';
                        }
                        
                        if (DataObj[i].ChildrenForms[g].status == 2 || DataObj[i].ChildrenForms[g].status==1) {
                            str += 'checked';
                        }
                        str += ' /></div>';
                        str += '</div>';
                        //程序書-表單 名稱
                        str += '<div class="col-7 fname-box-box pb-2">';
                        str += '<a class="text-justify align-bottom " style="font-size: 30px" id="Fname">';
                        if (DataObj[i].ChildrenForms[g].form != null) {
                            str += DataObj[i].ChildrenForms[g].form.Title;
                        }
                        str += '</a >';
                        str += '</div>';
                        str += '</div>';//P-F-row
                        str += '</div>';//P-Fcontainer
                    }
                }
                //ProcessRow
                str += '</div>';
            };
            return str;
        }
        function changeIconToOpenOrClose(event) {
            var open = event.currentTarget;
            var ProcessRow = event.currentTarget.parentNode.parentNode;
            var SwbContainer = ProcessRow.querySelectorAll('.SWB-container');
            var PFcontainer = ProcessRow.querySelectorAll('.P-Fcontainer');
            var close = event.currentTarget.parentNode.querySelector(".dash-Process");
            if (open.classList.contains("d-none")) {
                open.classList.remove('d-none');
                close.classList.add('d-none')
                for (var i = 0; i < SwbContainer.length; i++) {
                    SwbContainer[i].classList.add('d-none');
                }
                for (var i = 0; i < PFcontainer.length; i++) {
                    PFcontainer[i].classList.add('d-none');
                }

            } else {
                open.classList.add("d-none");
                close.classList.remove("d-none");
                for (var i = 0; i < SwbContainer.length; i++) {
                    SwbContainer[i].classList.remove("d-none");
                }
                for (var i = 0; i < PFcontainer.length; i++) {
                    PFcontainer[i].classList.remove("d-none");
                }
            }
        }
        function changeIconToOpen(event) {
            var close = event.currentTarget;
            var open = event.currentTarget.parentNode.querySelector(".plus-Process");
            var ProcessRow = event.currentTarget.parentNode.parentNode;
            var SwbContainer = ProcessRow.querySelectorAll('.SWB-container');
            var PFcontainer = ProcessRow.querySelectorAll('.P-Fcontainer');
            if (close.classList.contains("d-none")) {
                close.classList.remove("d-none");
                open.classList.add("d-none");
                for (var i = 0; i < SwbContainer.length; i++) {
                    SwbContainer[i].classList.remove('d-none');
                }
                for (var i = 0; i < PFcontainer.length; i++) {
                    PFcontainer[i].classList.remove('d-none');
                }
            } else {
                close.classList.add("d-none");
                open.classList.remove("d-none");
                for (var i = 0; i < SwbContainer.length; i++) {
                    SwbContainer[i].classList.add('d-none');
                }
                for (var i = 0; i < PFcontainer.length; i++) {
                    PFcontainer[i].classList.add('d-none');
                }

            }
        }
        function changeSWBIconToClose(event) {
            console.log("changeSWBIconToClose");
            var open = event.currentTarget;
            var openBtn = open.parentNode;
            var close = openBtn.querySelector(".dash-Process");
            var SWBrow = event.currentTarget.parentNode.parentNode.parentNode;
            var SWBFcontainers = SWBrow.querySelectorAll(".SWB-F-container");
            if (!open.classList.contains("d-none")) {
                open.classList.add("d-none");
                close.classList.remove("d-none");
                for (var i = 0; i < SWBFcontainers.length; i++) {
                    SWBFcontainers[i].classList.remove("d-none");
                }
            }
        }
        function changeSWBIconToOpen(event) {
            var close = event.currentTarget;
            var openBtn = close.parentNode;
            var open = openBtn.querySelector(".plus-Process");
            var SWBrow = event.currentTarget.parentNode.parentNode.parentNode;
            var SWBFcontainers = SWBrow.querySelectorAll(".SWB-F-container");
            console.log(SWBFcontainers[0]);
            if (!close.classList.contains("d-none")) {
                open.classList.remove("d-none");
                close.classList.add("d-none");
                for (var i = 0; i < SWBFcontainers.length; i++) {
                    SWBFcontainers[i].classList.add("d-none");
                }
            }
        }
        function allCheckBoxesChecked(event) {
            var thisCheckBox = event.currentTarget;
            var ProcessRow = thisCheckBox.parentNode.parentNode.parentNode;
            var allCheckBoxes = ProcessRow.querySelectorAll(".myCheckbox");
            if (thisCheckBox.checked) {
                for (var i = 0; i < allCheckBoxes.length; i++) {
                    allCheckBoxes[i].checked = true;
                }
                thisCheckBox.checked = true;
            } else {
                for (var i = 0; i < allCheckBoxes.length; i++) {
                    allCheckBoxes[i].checked = false;
                }
                thisCheckBox.checked = false;
            }
        }
        function allSWBCheckBoxesChecked(event) {
            var thisCheckBox = event.currentTarget;
            var SWBrow = thisCheckBox.parentNode.parentNode.parentNode.parentNode;
            var allCheckBoxes = SWBrow.querySelectorAll(".SWBCheckBox");
            if (thisCheckBox.checked) {
                for (var i = 0; i < allCheckBoxes.length; i++) {
                    allCheckBoxes[i].checked = true;
                }
                thisCheckBox.checked = true;
            } else {
                for (var i = 0; i < allCheckBoxes.length; i++) {
                    allCheckBoxes[i].checked = false;
                }
                thisCheckBox.checked = false;
            }
        }
        function allEditCheckBoxesChecked(event) {
            var thisCheckBox = event.currentTarget;
            var ProcessRow = thisCheckBox.parentNode.parentNode.parentNode;
            var allEditCheckboxes = ProcessRow.querySelectorAll(".EditCheckBox");
            if (thisCheckBox.checked) {
                for (var i = 0; i < allEditCheckboxes.length; i++) {
                    allEditCheckboxes[i].checked = true;
                }
                thisCheckBox.checked = true;
            } else {
                for (var i = 0; i < allEditCheckboxes.length; i++) {
                    allEditCheckboxes[i].checked = false;
                }
                thisCheckBox.checked = false;
            }
        }
        function allEditSWBCheckBoxesChecked(event) {
            var thisCheckBox = event.currentTarget;
            var SWBrow = thisCheckBox.parentNode.parentNode.parentNode.parentNode;
            var allEditCheckboxes = SWBrow.querySelectorAll(".SWBEditCheckBox");
            if (thisCheckBox.checked) {
                for (var i = 0; i < allEditCheckboxes.length; i++) {
                    allEditCheckboxes[i].checked = true;
                }
                thisCheckBox.checked = true;
            } else {
                for (var i = 0; i < allEditCheckboxes.length; i++) {
                    allEditCheckboxes[i].checked = false;
                }
                thisCheckBox.checked = false;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jqueryPlaceHolder" runat="server">
</asp:Content>
