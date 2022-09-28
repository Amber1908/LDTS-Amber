<%@ Page Title="" Language="C#" MasterPageFile="~/LDTS.Master" AutoEventWireup="true" CodeBehind="FormGeneration.aspx.cs" Inherits="LDTS.FormGeneration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>表單產生器</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Default">Home</a></li>
                        <li class="breadcrumb-item">表單產生器</li>
                    </ol>
                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="row m-2">
                <asp:HiddenField ID="QID" runat="server" Value="0"></asp:HiddenField>
                <asp:TextBox ID="OutputJson" runat="server" TextMode="MultiLine" Rows="6" CssClass="form-control" Text='{"Groups":[]}'></asp:TextBox>
            </div>
            <div class="row m-2">
                <div class="card border-secondary w-100 mb-3">
                    <div class="card-body">
                        <div class="row">
                            <table class="col-md-9" cellpadding="5">
                                <tr>
                                    <td width="40%">
                                        <div class="form-group">
                                            <label for="FormTitle">表單名稱</label>
                                            <asp:TextBox ID="FormTitle" runat="server" CssClass="form-control" placeholder="表單名稱"></asp:TextBox>
                                        </div>
                                    </td>
                                    <td width="35%">
                                        <div class="form-group">
                                            <label for="Version">表單版本<span style="color:red">(上傳新範本時，請記得更換)</span></label>
                                            <asp:TextBox ID="Version" runat="server" CssClass="form-control" Text="1.0"></asp:TextBox>
                                        </div>
                                    </td>
                                    <td width="10%">
                                        <div class="form-group">
                                            <label for="Status">表單狀態</label>
                                            <asp:RadioButtonList ID="Status" runat="server" RepeatDirection="Horizontal">
                                                <asp:ListItem Text="正常" Value="1" Selected="True"></asp:ListItem>
                                                <asp:ListItem Text="停用" Value="2"></asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </td>
                                    <td>
<%--                                        <button type="button" class="btn btn-default mt-3" onclick="preview()">瀏覽表單</button>--%>
                                        <asp:Button ID="SaveForm" runat="server" Text="儲存" CssClass="btn btn-primary mt-3" OnClick="SaveForm_Click" OnClientClick="return ValidForm();" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <div class="form-group">
                                            <label for="Description">備註</label>
                                            <asp:TextBox ID="Description" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="備註"></asp:TextBox>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <div class="formVerList pt-1 col-md-3" style="border: #ddd solid 0.1px;border-radius: 5px;">
                                <div class="form-group">
                                    <label for="PrintTemplate">表單列印範本</label>
                                    <asp:HiddenField ID="TemplateFile" runat="server" Value="" />
                                    <asp:FileUpload ID="PrintTemplate" runat="server" CssClass="form-control" placeholder="表單列印範本"></asp:FileUpload>
                                </div>
                                <div id="VersGroup" runat="server" class="form-group">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <div class="form-inline">
                            <input id="Gsn" type="number" class="form-control" style="width: 170px" placeholder="起始編號(選擇性)" />
                            <input id="Gname" type="text" class="form-control ml-3" style="width: 250px" placeholder="群組名稱" />
                            <select id="GroupType" class="form-control ml-3" onchange="changeGroupType()">
                                <option value="normal" selected>Normal</option>
                                <option value="table">Table</option>
                                <option value="row">Row</option>
                            </select>
                            <input id="GRowCount" type="number" class="form-control ml-3" style="width: 100px; display: none;" placeholder="列數" />
                            <input id="GColCount" type="number" class="form-control ml-3" style="width: 100px; display: none;" placeholder="行數" />
                            <button class="btn btn-info ml-3" onclick="return AddGroup();">Add Group</button>
                        </div>
                    </div>
                </div>
            </div>
            <div id="QuestArea" class="row m-2">
            </div>
        </div>
    </section>
    <!-- /.content -->
    <!-- Add Question Modal -->
    <div class="modal fade" id="AddQuestionModal" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-sm" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="AddQuestionModalTitle">Add Question</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input id="GroupIndex" type="hidden" />
                    <input id="QuestionIndex" type="hidden" />
                    <select id="GroupTypeSelect" class="form-control">
                        <option value="display" selected>display</option>
                        <option value="text">text</option>
                        <option value="number">number</option>
                        <option value="radio">radio</option>
                        <option value="checkbox">checkbox</option>
                        <option value="select">select</option>
                        <option value="sign">sign</option>
                        <option value="date">date</option>
                        <option value="file">file</option>
                        <option value="RadioMixCheckbox">RadioMixCheckbox</option>
                        <option value="CheckboxMixImage">CheckboxMixImage</option>
                    </select>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="return AddSelectQuestion()">Select</button>
                </div>
            </div>
        </div>
    </div>
    <!-- display Modal -->
    <div class="modal fade" id="displayModal" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="displayModalTitle">display</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <span class="text-info">填充位置請以
                    <label class="text-danger">##^n</label>
                    來表示，例如: 檢體大小
                    <label class="text-danger">##^1</label>
                    x
                    <label class="text-danger">##^2</label>
                    。</span>

                    <input id="displayInput" type="text" class="form-control w-100" placeholder="請輸入題目" />
                    <div id="displayUploadDiv" class="form-inline mt-2">
                        <label for="displayFile">附加圖片</label>
                        <input id="displayFile" type="file" class="ml-2" placeholder="圖片上傳" />
                    </div>
                    <div id="displayOverlayDiv" class="overlay" style="display: none;">
                        <i class="fas fa-2x fa-sync fa-spin"></i>
                    </div>
                    <div id="displayImageDiv" class="mt-2" style="display: none;">
                        <input id="displayImageSN" type="hidden" />
                        <img id="displayImage" src="#" height="80" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="imageUploadButton" type="button" class="btn btn-warning" onclick="return uploadImage()">Image upload</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="return SaveQuestion('display')">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <!-- text Modal -->
    <div class="modal fade" id="textModal" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="textModalTitle">text</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input id="textInput" type="text" class="form-control" placeholder="請輸入題目" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="return SaveQuestion('text')">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <!-- number Modal -->
    <div class="modal fade" id="numberModal" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="numberModalTitle">number</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input id="numberInput" type="text" class="form-control" placeholder="請輸入題目" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="return SaveQuestion('number')">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="selectModal" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="selectModalTitle">select</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-inline">
                        <input id="selectInput" type="text" class="form-control w-100" placeholder="請輸入題目" />
                    </div>
                    <hr />
                    <button type="button" class="btn btn-block btn-outline-info btn-sm" onclick="return AddOption('selectBody')">添加選項</button>
                    <div id="selectBody" class="mt-2">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="return SaveQuestion('select')">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <!-- sign Modal -->
    <div class="modal fade" id="signModal" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="signModalTitle">sign</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-inline">
                        <input id="signInput" type="text" class="form-control w-75" placeholder="請輸入題目" />
                        <div class="form-check ml-3">
                            <input type="checkbox" class="form-check-input" id="signCheck">
                            <label class="form-check-label" for="radioCheck">直式顯示</label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="return SaveQuestion('sign')">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <!-- filling Modal -->
    <div class="modal fade" id="fillingModal" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="fillingModalTitle">filling</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input id="fillingInput" type="text" class="form-control" placeholder="請輸入題目" />
                    <span class="text-info">填充位置請以
                        <label class="text-danger">##^n</label>
                        來表示，例如: 檢體大小
                        <label class="text-danger">##^1</label>
                        x
                        <label class="text-danger">##^2</label>
                        。</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="return SaveQuestion('filling')">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <!-- date Modal -->
    <div class="modal fade" id="dateModal" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="dateModalTitle">date</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input id="dateInput" type="text" class="form-control" placeholder="請輸入題目" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="return SaveQuestion('date')">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <!-- file Modal -->
    <div class="modal fade" id="fileModal" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="fileModalTitle">file</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input id="fileInput" type="text" class="form-control" placeholder="請輸入題目" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="return SaveQuestion('file')">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <!-- RadioMixCheckbox Modal -->
    <div class="modal fade" id="RadioMixCheckboxModal" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="RadioMixCheckboxModalTitle">RadioMixCheckbox</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                                            <span class="text-info">填充位置請以
                        <label class="text-danger">##^n</label>
                        來表示，例如: 檢體大小
                        <label class="text-danger">##^1</label>
                        x
                        <label class="text-danger">##^2</label>
                        。</span>

                    <div class="form-inline">

                        <input id="RadioMixCheckboxInput" type="text" class="form-control w-75" placeholder="請輸入題目" />
                        <div class="form-check ml-3">
                            <input type="checkbox" class="form-check-input" id="RadioMixCheckboxCheck">
                            <label class="form-check-label" for="radioCheck">包含其他選項</label>
                        </div>
                    </div>
                    <hr />
                    <button type="button" class="btn btn-block btn-outline-info btn-sm" onclick="return RadioAddOption('RadioMixCheckboxBody')">添加選項</button>
                    <div id="RadioMixCheckboxBody" class="mt-2">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="return SaveQuestion('RadioMixCheckbox')">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <!-- radioModal Modal -->
    <div class="modal fade" id="radioModal" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="radioModalTitle">radio</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-inline">
                        <input id="radioInput" type="text" class="form-control w-75" placeholder="請輸入題目" />
                        <div class="form-check ml-3">
                            <input type="checkbox" class="form-check-input" id="radioCheck">
                            <label class="form-check-label" for="radioCheck">包含其他選項</label>
                        </div>
                    </div>
                    <hr />
                    <button type="button" class="btn btn-block btn-outline-info btn-sm" onclick="return AddOption('radioBody')">添加選項</button>
                    <span class="text-info">填充位置請以
                        <label class="text-danger">##^n</label>
                        來表示，例如: 檢體大小
                        <label class="text-danger">##^1</label>
                        x
                        <label class="text-danger">##^2</label>
                        。</span>
                    <div id="radioBody" class="mt-2">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="return SaveQuestion('radio')">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <!-- CheckboxMixImage Modal -->
    <div class="modal fade" id="CheckboxMixImageModal" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="CheckboxMixImageModalTitle">CheckboxMixImage</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <div class="form-inline">
                        <input id="CheckboxMixImageInput" type="text" class="form-control w-75" placeholder="請輸入題目" />
                        <div class="form-check ml-3">
                            <input type="checkbox" class="form-check-input" id="CheckboxMixImageCheck">
                            <label class="form-check-label" for="radioCheck">包含其他選項</label>
                        </div>
                    </div>
                    <hr />
                        <span class="text-info">選項填充位置請以
                        <label class="text-danger">##^n</label>
                        來表示，例如: 檢體大小
                        <label class="text-danger">##^1</label>
                        x
                        <label class="text-danger">##^2</label>
                        。</span>

                    <button type="button" class="btn btn-block btn-outline-info btn-sm" onclick="return CheckboxMinImageAddOption()">添加選項</button>
                    <div id="CheckboxMixImageOverlayDiv" class="overlay" style="display: none;">
                        <i class="fas fa-2x fa-sync fa-spin"></i>
                    </div>
                    <div id="CheckboxMixImageBody" class="mt-2">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="return SaveQuestion('CheckboxMixImage')">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <!-- checkboxModal Modal -->
    <div class="modal fade" id="checkboxModal" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="checkboxModalTitle">CheckboxMixFilling</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-inline">
                        <input id="checkboxInput" type="text" class="form-control w-75" placeholder="請輸入題目" />
                        <div class="form-check ml-3">
                            <input type="checkbox" class="form-check-input" id="checkboxCheck">
                            <label class="form-check-label" for="checkboxCheck">包含其他選項</label>
                        </div>
                    </div>
                    <hr />
                    <button type="button" class="btn btn-block btn-outline-info btn-sm" onclick="return AddOption('checkboxBody')">添加選項</button>
                    <span class="text-info">填充位置請以
                        <label class="text-danger">##^n</label>
                        來表示，例如: 檢體大小
                        <label class="text-danger">##^1</label>
                        x
                        <label class="text-danger">##^2</label>
                        。</span>
                    <div id="checkboxBody" class="mt-2">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="return SaveQuestion('checkbox')">Save changes</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jqueryPlaceHolder" runat="server">
    <script>
        const outputJsonBox = $("#<%= OutputJson.ClientID %>");
        showQuestion();
        function preview() {
            //let sonWindow = window.open('Preview');
            let sonWindow = window.open('');
            let fatherWindow = sonWindow.opener;
            let previewJsonStr = document.getElementById("mainPlaceHolder_OutputJson").value;
            let previewObj = JSON.parse(previewJsonStr);
            let preview = GroupsTemplate(previewObj);
            let head = sonWindow.document.head;
            let link = sonWindow.document.createElement("link");
            link.rel = "stylesheet";
            link.href = "plugins/fontawesome-free/css/all.min.css";
            let Theme = sonWindow.document.createElement("link");
            Theme.rel = "stylesheet";
            Theme.href = "dist/css/adminlte.css";
            let bootstrap = sonWindow.document.createElement("link");
            bootstrap.rel = "stylesheet";
            bootstrap.href = "https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css";
            bootstrap.integrity = "sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N";
            bootstrap.crossOrigin = "anonymous";
            let LDTSstyle = sonWindow.document.createElement("link");
            LDTSstyle.rel = "stylesheet";
            LDTSstyle.href = "dist/css/LDTS_StyleSheet.css";
            head.appendChild(link);
            head.appendChild(Theme);
            head.appendChild(bootstrap);
            head.appendChild(LDTSstyle);
            sonWindow.document.body.innerHTML = GroupsTemplate(previewObj);
            console.log(contentWrapper);
            

        };
        function GroupsTemplate(Obj) {
            const container = document.body;//產出畫面的位置
            let previewStr = "<div class=\" content\"><div class=\" container-fluid\"><div class=\" row\"><div class=\"ansEdit col-md-3\"></div>";
            previewStr += "<div class=\"ansEdit col-md-9\">";
            previewStr += "<div class=\"card\">";
            previewStr += "<div class=\"card-body\">";
            previewStr += "<div class=\"ansEditForm\">";
            for (var i = 0; i < Obj.Groups.length; i++) {
                let hasSn = Obj.Groups[i].hasSN;
                let Gsn = i;
                switch (Obj.Groups[i].GroupType) {//先判斷GroupType
                    case "normal":
                        previewStr += "<div class=\"row normal\">";
                        previewStr += "<h3 class=\"col-12 GroupName\">" + Obj.Groups[i].GroupName;
                        previewStr += "</h3>";
                        previewStr += "</div>";
                        previewStr += "<div class=\"card-body row\">";//卡片的Body 全部產出的問題會在這邊顯示
                        for (var q = 0; q < Obj.Groups[i].Questions.length; q++) {
                            
                            if (Obj.Groups[i].Questions[q].QuestionType == "filling") {
                                previewStr += "<div class=\"col-12 pt-2 d-flex justify-content-start\">"
                            }
                            if (Obj.Groups[i].Questions[q].QuestionType == "display") {
                                previewStr += "<div class=\"col-12 pt-2 d-flex justify-content-start\">"
                                if (Obj.Groups[i].Questions[q].AnswerOptions.length > 0) {
                                    previewStr += "<img style=\"80%\" src=\"ShowAdminImg?id" + Obj.Groups[i].Questions[q].AnswerOptions[0].image+"\""+">";
                                }
                            } else {
                                previewStr += "<div class=\"col-3 pt-2 d-flex justify-content-start\">"
                            }
                            if (Obj.Groups[i].Questions[q].QuestionType == "RadioMixCheckbox" || Obj.Groups[i].Questions[q].QuestionType == "CheckboxMixFilling" || Obj.Groups[i].Questions[q].QuestionType == "RadioMixFilling") {
                                previewStr += "<p class=\"nQuestion p-1 myTextColor mt-5\">"
                            } else {
                                previewStr += "<p class=\"nQuestion p-1 myTextColor\">"
                            }
                            if (Obj.Groups[i].Questions[q].QuestionType == "filling" && hasSn > 0) {//有項次
                                previewStr += hasSn-1;
                            } else if (hasSn > 0) {
                                previewStr += hasSn;
                                hasSn++;
                            }
                            if (Obj.Groups[i].Questions[q].QuestionType == "filling") {
                                previewStr += "";
                            } else {
                                previewStr += Obj.Groups[i].Questions[q].QuestionText;//QuestionText
                            }
                            previewStr += "</p>";
                            previewStr += "</div>";//問題的部分
                            switch (Obj.Groups[i].Questions[q].QuestionType) {//產出對應的問題
                                case "text":
                                    previewStr += "<div class=\"inputBox col-6 pt-2\">";
                                    previewStr += "<input type=\"text\"name=\"Obj.Groups[i].Questions[q].QuestionText\" class=\"form-control form-control-user DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID\">";
                                    previewStr += "</div>";
                                    previewStr += "<div class=\"col-3 colbox\"></div>";
                                    break;
                                case "number":
                                    previewStr += "<div class=\"inputBox col-6 pt-2\">";
                                    previewStr += "<input type=\"number\"name=\"Obj.Groups[i].Questions[q].QuestionText\" class=\"form-control form-control-user DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID\">";
                                    previewStr += "</div>";
                                    previewStr += "<div class=\"col-3 colbox\"></div>";
                                    break;
                                case "radio":
                                    for (var a = 0; a < Obj.Groups[i].Questions[q].AnswerOptions.length; a++) {
                                        previewStr += "<div class=\"inputRadioBox col-1 pt-2\">";//inputRadioBox

                                        previewStr += "<input type=\"radio\"name=\"Obj.Groups[i].Questions[q].QuestionText\" class=\"myRadio DataObj.Groups[GroupSn].Questions[QusetionSn].QuestionID\"";
                                        previewStr += "value=\"Obj.Groups[i].Questions[q].AnswerOptions[a].AnsText\"";
                                        previewStr += ">";
                                        previewStr += "<label class=\"form-check-label pl-1\">";
                                        previewStr += Obj.Groups[i].Questions[q].AnswerOptions[a].AnsText;
                                        previewStr += "</label>";

                                        previewStr += "</div>";//inputRadioBox

                                    }
                                    if (Obj.Groups[i].Questions[q].hasOtherAnswers) {
                                        previewStr += "<div class=\"inputRadioOtherBox col-3 mt-2\">";
                                        previewStr += "<input type=\"radio\"name=\"Obj.Groups[i].Questions[q].QuestionText\" onclick=\"DisabledTrue(event)\">";
                                        previewStr += "<span class=\"pt-2\">其他:</span>";
                                        previewStr += "<input type=\"text\"name =\"Obj.Groups[i].Questions[q].QuestionText\"style=\"max-width:\"100px\" class=\"col-3 form-control ml-1 otherAns d-inline form-control-sm form-control-border\">";
                                        previewStr += "</div>";
                                    }

                                    break;
                                case "CheckboxMixFilling":
                                    previewStr += "<div >";

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

                            /*Qlabel.append(nQuestion);*/
                        }
                        break;
                //    case "table":
                //        let ansEditFormT = document.querySelector(".ansEditForm");
                //        let TampleteStr = "";
                //        TampleteStr += "<div class=\"rowPart\">";
                //        TampleteStr += "<div class=\"rowPart\">";
                //        TampleteStr += "<h3 class=\"rowPart\">" + Obj.Groups[i].GroupName;
                //        TampleteStr += "</h3>";
                //        TampleteStr += "<div class=\"rowContainer row card mb-4 rowPart\">";
                //        TampleteStr += "<div class=\"rowPart\">";
                //        TampleteStr += "<div class=\"table-responsive rowPart\" style=\"overflow-x:hidden\">";
                //        TampleteStr += "<div class=\"row\">";
                //        TampleteStr += "<div class=\"col-sm-12 col-12 rowPart\">";
                //        TampleteStr += "<table class=\"table table-bordered dataTable rowPart\" style=\"width: 100%;\">";
                //        TampleteStr += "<thead>";//thead
                //        TampleteStr += "<tr role=\"row\">";
                //        if (Obj.Groups[i].hasSN > 0) {
                //            TampleteStr += "<th style=\"width:5%\" class=\"sorting sorting_asc rowPart\">" + "項次";
                //            TampleteStr += "</th>";
                //        }
                //        for (var r = 0; r < Obj.Groups[i].Rows[0].Cols.length; r++) {//首列的標題

                //            switch (Obj.Groups[i].Rows[0].Cols[r].QuestionType) {
                //                case "display":
                //                    TampleteStr += "<th class=\"sorting sorting_asc rowPart\">" + Obj.Groups[i].Rows[0].Cols[r].QuestionText;
                //                    TampleteStr += "</th>";
                //                    break;
                //                case "text":
                //                    TampleteStr += "<th class=\"sorting sorting_asc rowPart\">" + Obj.Groups[i].Rows[0].Cols[r].QuestionText;
                //                    TampleteStr += "<input type=\"text\" value=\"" + Obj.Groups[i].Rows[0].Cols[r].Answers[0].value + "\">";
                //                    TampleteStr += "</th>";
                //                    break;
                //                case "sign":
                //                    if (Obj.Groups[i].Rows[0].Cols[r].QuestionText != "") {
                //                        TampleteStr += "<th class=\"sorting sorting_asc rowPart\">" + Obj.Groups[i].Rows[0].Cols[r].QuestionText;
                //                        if (Obj.Groups[i].Rows[0].Cols[r].Answers.length == 0) {
                //                            Obj.Groups[i].Rows[0].Cols[r].Answers.push({ "index": 1, "value": 0, "lastUpdate": "" });
                //                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                        }
                //                        let signImgID = document.getElementById("mainPlaceHolder_adminSign").value;
                //                        let time = new Date();
                //                        let today = time.Format("yyyy-MM-dd");

                //                        if (Number(Obj.Groups[i].Rows[0].Cols[r].Answers[0].value) > 0) {
                //                            TampleteStr += "<div class=\"col-12 pt-2 tableSign\">";
                //                            if (signImgID == Obj.Groups[i].Rows[0].Cols[c].Answers[0].value) {
                //                                TampleteStr += "<div data-Staut=\"Edit\" style=\"font-size:10px\" data-GidandRow=\"GID\" onchange=\"changeTableJsonData(event)\" onclick=\"SignByAdminId(event)\" class=\"btn btn-primary Signbtn ml-2 rowPart\" >";//
                //                                TampleteStr += "取消簽核";
                //                                TampleteStr += "</div>";
                //                            }
                //                            TampleteStr += "<div class=\"mt-5 d-inline\">";//SignImageBox
                //                            TampleteStr += "<img style=\"width:100px;\" src=\"";//img
                //                            TampleteStr += "ShowAdminImg?id=" + Obj.Groups[i].Rows[0].Cols[r].Answers[0].value + "\"";
                //                            TampleteStr += "id=\"sign" + Obj.Groups[i].Rows[0].Cols[r].Answers[0].value + "\"";
                //                            TampleteStr += "class=\"" + Obj.Groups[i].Rows[0].Cols[r].QuestionID;
                //                            if (Obj.Groups[i].Rows[w].Cols[c].rotate == true) {
                //                                TampleteStr += " " + "signRotated mt-5 mb-3 ml_1";
                //                            }
                //                            TampleteStr += "\"name=\"" + Obj.Groups[i].Rows[0].Cols[r].QuestionID;
                //                            TampleteStr += "\">";//img
                //                            TampleteStr += "<span style=\"font-weight:lighter;\" name=\"" + Obj.Groups[i].Rows[0].Cols[r].QuestionID;//
                //                            if (Obj.Groups[i].Rows[0].Cols[r].rotate == true) {
                //                                TampleteStr += "\" class=\" signDate mt-3\">";//d-flex justify-content-start
                //                            } else {
                //                                TampleteStr += "\" class=\"signDate mt-3\">";//d-flex  justify-content-end
                //                            }
                //                            time = new Date(Obj.Groups[i].Rows[0].Cols[r].Answers[0].lastUpdate);
                //                            TampleteStr += time.Format("yyyy-MM-dd");
                //                            TampleteStr += "</span>";
                //                            TampleteStr += "</div>";//SignImageBox
                //                            TampleteStr += "</div>";
                //                        } else {
                //                            TampleteStr += "<div class=\"col-12 pt-2 tableSign\">";
                //                            TampleteStr += "<div data-Staut=\"Edit\" style=\"font-size:10px\" data-GidandRow=\"GID\" onchange=\"changeTableJsonData(event)\" onclick=\"SignByAdminId(event)\" class=\"btn btn-primary Signbtn ml-2 rowPart\" >";//
                //                            TampleteStr += "簽核";
                //                            TampleteStr += "</div>";
                //                            TampleteStr += "<div class=\"mt-5 d-none\">";//SignImageBox
                //                            TampleteStr += "<img style=\"width:100px\" src=\"";//img
                //                            TampleteStr += "ShowAdminImg.aspx?id=" + signImgID + "\"";
                //                            TampleteStr += "id=\"sign" + signImgID + "\"";
                //                            TampleteStr += "class=\"" + Obj.Groups[i].Rows[0].Cols[r].QuestionID;
                //                            TampleteStr += "\"name=\"" + Obj.Groups[i].Rows[0].Cols[r].QuestionID;
                //                            TampleteStr += "\">";//img
                //                            TampleteStr += "<span style=\"font-weight:lighter;\" name=\"" + Obj.Groups[i].Rows[0].Cols[r].QuestionID;
                //                            TampleteStr += "\" class=\" signDate mt-3\">";//d-flex justify-content-end
                //                            TampleteStr += today;
                //                            TampleteStr += "</span>";
                //                            TampleteStr += "</div>";//SignImageBox
                //                            TampleteStr += "</div>";
                //                        }

                //                        TampleteStr += "</th>";
                //                    }
                //                    break;
                //                case "date":
                //                    TampleteStr += "<th class=\"sorting sorting_asc rowPart\">"

                //                    if (Obj.Groups[i].Rows[0].Cols[r].QuestionText != "") {
                //                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionText;
                //                    }
                //                    if (Obj.Groups[i].Rows[0].Cols[r].Answers.length == 0) {
                //                        Obj.Groups[i].Rows[0].Cols[r].Answers.push({ "index": 1, "value": 0, "lastUpdate": "" });
                //                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                    }
                //                    TampleteStr += "<input type=\"date\" onchange=\"changeTableJsonData(event)\" class=\"form-control mb-3\"name=\"";
                //                    TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionID + "\"";
                //                    if (Obj.Groups[i].Rows[0].Cols[r].Answers[0].value != 0) {
                //                        let v = new Date(Obj.Groups[i].Rows[0].Cols[r].Answers[0].value);
                //                        console.log("v" + v);
                //                        if (v > 0) {
                //                            v = v.Format("yyyy-MM-dd");
                //                        }
                //                        TampleteStr += "value=\"" + v + "\"";
                //                    }
                //                    TampleteStr += ">";
                //                    TampleteStr += "</th>";

                //                    break;
                //                case "radio":
                //                    TampleteStr += "<th class=\"sorting sorting_asc rowPart\">"

                //                    if (Obj.Groups[i].Rows[0].Cols[r].QuestionText != "") {
                //                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionText;
                //                    }
                //                    for (var o = 0; o < Obj.Groups[i].Rows[0].Cols[r].AnswerOptions.length; o++) {
                //                        if (Obj.Groups[i].Rows[0].Cols[r].AnswerOptions.length > Obj.Groups[i].Rows[0].Cols[r].Answers.length) {
                //                            Obj.Groups[i].Rows[0].Cols[r].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "" });
                //                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                        }
                //                        TampleteStr += "<div class=\"form-check\">"
                //                        TampleteStr += "<input type=\"radio\" onclick=\"CleanOthers(event)\" onchange=\"changeTableJsonData(event)\" class=\" mr-1\"name=\"";
                //                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionID + "\"";
                //                        TampleteStr += "value=\"";
                //                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].index;
                //                        TampleteStr += "\"id=\"";
                //                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].AnsText;
                //                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].index + w;
                //                        TampleteStr += "\"";
                //                        if (Obj.Groups[i].Rows[0].Cols[r].Answers.length > 0) {
                //                            if (Obj.Groups[i].Rows[0].Cols[r].Answers[o].value == true) {
                //                                TampleteStr += "checked";
                //                            }
                //                        }
                //                        TampleteStr += ">";
                //                        TampleteStr += "<label for=\"";
                //                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].AnsText;
                //                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].index + w;
                //                        TampleteStr += "\"class=\"\">" + Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].AnsText + "</label>";
                //                        TampleteStr += "</div>";
                //                    }
                //                    if (Obj.Groups[i].Rows[0].Cols[r].hasOtherAnswers) {
                //                        if (Obj.Groups[i].Rows[0].Cols[r].otherAnswer.length == 0) {
                //                            Obj.Groups[i].Rows[0].Cols[r].otherAnswer.push({ "index": 1, "value": null, "lastUpdate": "" });
                //                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                        }
                //                        TampleteStr += "<div class=\"form-check\">"
                //                        TampleteStr += "<input class=\"otherAns\" type=\"radio\" onclick=\"CleanOthers(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                //                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionID;
                //                        TampleteStr += "\"";
                //                        if (Obj.Groups[i].Rows[0].Cols[r].otherAnswer.length > 0) {
                //                            if (Obj.Groups[i].Rows[0].Cols[r].otherAnswer[0].value != null) {
                //                                TampleteStr += "checked";
                //                            }
                //                        }
                //                        TampleteStr += ">";
                //                        TampleteStr += "<label >其他</label>";
                //                        TampleteStr += "<input type=\"text\"onchange=\"changeTableJsonData(event)\" disabled class=\"other form-control-border form-control form-control-sm mb-3\"name=\"";
                //                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionID + "\"";
                //                        if (Obj.Groups[i].Rows[0].Cols[r].otherAnswer.length > 0) {
                //                            if (Obj.Groups[i].Rows[0].Cols[r].otherAnswer[0].value != null) {
                //                                TampleteStr += "value=\"" + Obj.Groups[i].Rows[0].Cols[r].otherAnswer[0].value + "\"";
                //                            }
                //                        }
                //                        TampleteStr += ">";

                //                        TampleteStr += "</div>";

                //                    }
                //                    TampleteStr += "</th>";
                //                    break;
                //                case "checkbox":
                //                    TampleteStr += "<th class=\"sorting sorting_asc rowPart\">";
                //                    if (Obj.Groups[i].Rows[0].Cols[r].QuestionText != "") {
                //                        Obj.Groups[i].Rows[0].Cols[r].QuestionText;
                //                    }
                //                    for (var o = 0; o < Obj.Groups[i].Rows[0].Cols[r].AnswerOptions.length; o++) {
                //                        if (Obj.Groups[i].Rows[0].Cols[r].AnswerOptions.length > Obj.Groups[i].Rows[0].Cols[r].Answers.length) {
                //                            Obj.Groups[i].Rows[0].Cols[r].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "" });
                //                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                        }
                //                        TampleteStr += "<div class=\"form-check\">"
                //                        TampleteStr += "<input type=\"checkbox\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                //                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].QuestionID + "\"";
                //                        TampleteStr += "value=\"";
                //                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].index;
                //                        TampleteStr += "\"id=\"";
                //                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].AnsText;
                //                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].index;
                //                        TampleteStr += "\"";
                //                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                //                            if (Obj.Groups[i].Rows[0].Cols[r].Answers[o].value == true) {
                //                                TampleteStr += "checked";
                //                            }
                //                        }
                //                        TampleteStr += ">";
                //                        TampleteStr += "<label for=\"";
                //                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].AnsText;
                //                        TampleteStr += Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].index;
                //                        TampleteStr += "\"class=\"\">" + Obj.Groups[i].Rows[0].Cols[r].AnswerOptions[o].AnsText + "</label>"
                //                        TampleteStr += "</div>";
                //                    }

                //                    if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers == true) {
                //                        if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length == 0) {
                //                            Obj.Groups[i].Rows[w].Cols[c].otherAnswer.push({ "index": 1, "value": null, "lastUpdate": "" });
                //                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                        }
                //                        TampleteStr += "<div class=\"form-check\">"
                //                        TampleteStr += "<input class=\"otherAns\" type=\"checkbox\" onclick=\"DisabledTrue(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                //                        TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                //                        TampleteStr += "\"";
                //                        if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                //                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != null) {
                //                                TampleteStr += "checked";
                //                            }
                //                        }
                //                        TampleteStr += ">";
                //                        TampleteStr += "<label >其他</label>";
                //                        TampleteStr += "<input type=\"text\"onchange=\"changeTableJsonData(event)\" disabled class=\"other form-control-border form-control mb-3\"name=\"";
                //                        TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                //                        if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                //                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != null) {
                //                                TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value + "\"";
                //                            }
                //                        }
                //                        TampleteStr += ">";

                //                        TampleteStr += "</div>";
                //                    }
                //                    TampleteStr += "</th>";
                //                    break;

                //                default:
                //            }
                //        }
                //        TampleteStr += "</thead>";//thead
                //        TampleteStr += "<tbody>";//
                //        let No = Obj.Groups[i].hasSN;
                //        for (var w = 1; w < Obj.Groups[i].Rows.length; w++) {
                //            TampleteStr += "<tr class=\"odd\">";
                //            if (Obj.Groups[i].hasSN > 0) {
                //                TampleteStr += " <td class=\"dtr-control sorting_1\">";
                //                TampleteStr += No;
                //                TampleteStr += "</td>";
                //                No++;
                //            }
                //            for (var c = 0; c < Obj.Groups[i].Rows[w].Cols.length; c++) {//答案的顯示 存JSON的答案
                //                TampleteStr += "<td class=\"dtr-control sorting_1\">";
                //                switch (Obj.Groups[i].Rows[w].Cols[c].QuestionType) {
                //                    case "text":
                //                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length == 0) {
                //                            Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": 1, "value": "", "lastUpdate": "" });
                //                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                        }
                //                        if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                //                            TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                //                        }
                //                        TampleteStr += "<input type=\"text\"onchange=\"changeTableJsonData(event)\" class=\"form-control mb-3\"name=\"";
                //                        TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";

                //                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                //                            TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value + "\"";
                //                        }
                //                        TampleteStr += ">";
                //                        break;
                //                    case "number":
                //                        if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                //                            TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                //                        }
                //                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length == 0) {
                //                            Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": 1, "value": "", "lastUpdate": "" });
                //                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                        }
                //                        TampleteStr += "<input type=\"number\" onchange=\"changeTableJsonData(event)\" class=\"form-control mb-3\"name=\"";
                //                        TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                //                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                //                            TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value + "\"";
                //                        }
                //                        TampleteStr += ">";
                //                        break;
                //                    //case "select":
                //                    //    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].Answers[0].value;
                //                    //    break;
                //                    case "display":
                //                        TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionText;
                //                        break;
                //                    case "date":
                //                        if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                //                            TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                //                        }
                //                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length == 0) {
                //                            Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": 1, "value": 0, "lastUpdate": "" });
                //                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                        }
                //                        TampleteStr += "<input type=\"date\" onchange=\"changeTableJsonData(event)\" class=\"form-control mb-3\"name=\"";
                //                        TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                //                        if (Obj.Groups[i].Rows[w].Cols[c].Answers[0].value != 0) {
                //                            let v = new Date(Obj.Groups[i].Rows[w].Cols[c].Answers[0].value);
                //                            console.log("v" + v);
                //                            if (v > 0) {
                //                                v = v.Format("yyyy-MM-dd");
                //                            }
                //                            TampleteStr += "value=\"" + v + "\"";
                //                        }
                //                        TampleteStr += ">";

                //                        break;
                //                    case "radio":
                //                        if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                //                            TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                //                        }
                //                        for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++) {
                //                            if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers.length) {
                //                                Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "" });
                //                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                            }
                //                            TampleteStr += "<div class=\"form-check\">"
                //                            TampleteStr += "<input type=\"radio\" onclick=\"CleanOthers(event)\" onchange=\"changeTableJsonData(event)\" class=\" mr-1\"name=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                //                            TampleteStr += "value=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                //                            TampleteStr += "\"id=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index + w;
                //                            TampleteStr += "\"";
                //                            if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                //                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].value == true) {
                //                                    TampleteStr += "checked";
                //                                }
                //                            }
                //                            TampleteStr += ">";
                //                            TampleteStr += "<label for=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index + w;
                //                            TampleteStr += "\"class=\"\">" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText + "</label>";
                //                            TampleteStr += "</div>";
                //                        }
                //                        if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers) {
                //                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length == 0) {
                //                                Obj.Groups[i].Rows[w].Cols[c].otherAnswer.push({ "index": 1, "value": null, "lastUpdate": "" });
                //                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                            }
                //                            TampleteStr += "<div class=\"form-check d-flex mt-1\">"
                //                            TampleteStr += "<input class=\"otherAns\" type=\"radio\" onclick=\"CleanOthers(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                //                            TampleteStr += "\"";
                //                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                //                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != null) {
                //                                    TampleteStr += "checked";
                //                                }
                //                            }
                //                            TampleteStr += ">";
                //                            TampleteStr += "<label class=\"pt-2 pl-1 mr-1\">其他</label>";
                //                            TampleteStr += "<input style=\"max-width:100px\" type=\"text\"onchange=\"changeTableJsonData(event)\" disabled class=\"other form-control-border d-inline form-control form-control-sm mb-3\"name=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                //                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                //                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != null) {
                //                                    TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value + "\"";
                //                                }
                //                            }
                //                            TampleteStr += ">";

                //                            TampleteStr += "</div>";
                //                        }

                //                        break;
                //                    case "checkbox":
                //                        //case "CheckboxMixImage":
                //                        if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                //                            TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                //                        }
                //                        for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++) {
                //                            if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers.length) {
                //                                Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "" });
                //                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                            }
                //                            TampleteStr += "<div class=\"form-check\">"
                //                            TampleteStr += "<input type=\"checkbox\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                //                            TampleteStr += "value=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                //                            TampleteStr += "\"id=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                //                            TampleteStr += "\"";
                //                            if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                //                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].value == true) {
                //                                    TampleteStr += "checked";
                //                                }
                //                            }
                //                            TampleteStr += ">";
                //                            TampleteStr += "<label for=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                //                            TampleteStr += "\"class=\"\">" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText + "</label>"
                //                            TampleteStr += "</div>";
                //                        }

                //                        if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers == true) {
                //                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length == 0) {
                //                                Obj.Groups[i].Rows[w].Cols[c].otherAnswer.push({ "index": 1, "value": null, "lastUpdate": "" });
                //                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                            }
                //                            TampleteStr += "<div class=\"form-check d-flex mt-1\">"
                //                            TampleteStr += "<input class=\"otherAns\" type=\"checkbox\" onclick=\"DisabledTrue(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                //                            TampleteStr += "\"";
                //                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                //                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != null) {
                //                                    TampleteStr += "checked";
                //                                }
                //                            }
                //                            TampleteStr += ">";
                //                            TampleteStr += "<label class=\"pt-2 pl-1 pr-1\">其他</label>";
                //                            TampleteStr += "<input style=\"max-width:100px\" type=\"text\"onchange=\"changeTableJsonData(event)\" disabled class=\"other form-control-border d-inline form-control form-control-sm mb-3\"name=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                //                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                //                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != null) {
                //                                    TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value + "\"";
                //                                }
                //                            }
                //                            TampleteStr += ">";

                //                            TampleteStr += "</div>";
                //                        }

                //                        break;
                //                    case "CheckboxMixImage":
                //                        if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                //                            TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                //                        }
                //                        for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++) {
                //                            if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers.length) {
                //                                Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "" });
                //                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                            }
                //                            TampleteStr += "<div class=\"form-check\">"
                //                            TampleteStr += "<input type=\"checkbox\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                //                            TampleteStr += "value=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                //                            TampleteStr += "\"id=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                //                            TampleteStr += "\"";
                //                            if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                //                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].value == true) {
                //                                    TampleteStr += "checked";
                //                                }
                //                            }
                //                            TampleteStr += ">";
                //                            TampleteStr += "<label for=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                //                            TampleteStr += "\"class=\"mb-5\">" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText + "</label>";
                //                            TampleteStr += "<img style =\"height:50px\"src=\"ShowAdminImg?id=" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].image + "\"" + "/>";

                //                            TampleteStr += "</div>";
                //                        }
                //                        if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers == true) {
                //                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length == 0) {
                //                                Obj.Groups[i].Rows[w].Cols[c].otherAnswer.push({ "index": 1, "value": null, "lastUpdate": "" });
                //                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                            }
                //                            TampleteStr += "<div class=\"form-check d-flex mt-1\">"
                //                            TampleteStr += "<input class=\"otherAns\" type=\"checkbox\" onclick=\"DisabledTrue(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                //                            TampleteStr += "\"";
                //                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                //                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != null) {
                //                                    TampleteStr += "checked";
                //                                }
                //                            }
                //                            TampleteStr += ">";
                //                            TampleteStr += "<label class=\"pt-2 pl-1 mr-1\">其他</label>";
                //                            TampleteStr += "<input style=\"max-width:100px\" type=\"text\"onchange=\"changeTableJsonData(event)\" disabled class=\"other form-control-border d-inline form-control form-control-sm mb-3\"name=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                //                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                //                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != null) {
                //                                    TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value + "\"";
                //                                }
                //                            }
                //                            TampleteStr += ">";

                //                            TampleteStr += "</div>";
                //                        }

                //                        break;
                //                    case "sign":
                //                        if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                //                            TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                //                        }
                //                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length == 0) {
                //                            Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": 1, "value": 0, "lastUpdate": "" });
                //                            document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                        }
                //                        let signImgID = document.getElementById("mainPlaceHolder_adminSign").value;
                //                        let time = new Date();
                //                        let today = time.Format("yyyy-MM-dd");

                //                        if (Number(Obj.Groups[i].Rows[w].Cols[c].Answers[0].value) > 0) {
                //                            TampleteStr += "<div class=\"col-12 pt-2 tableSign\">";
                //                            if (signImgID == Obj.Groups[i].Rows[w].Cols[c].Answers[0].value) {
                //                                TampleteStr += "<div data-Staut=\"Edit\" style=\"font-size:10px\" data-GidandRow=\"GID\" onchange=\"changeTableJsonData(event)\" onclick=\"SignByAdminId(event)\" class=\"btn btn-primary Signbtn ml-2 rowPart\" >";//
                //                                TampleteStr += "取消簽核";
                //                                TampleteStr += "</div>";
                //                            }
                //                            TampleteStr += "<div class=\"mt-5 d-inline\">";//SignImageBox
                //                            TampleteStr += "<img style=\"width:100px \" src=\"";//img
                //                            TampleteStr += "ShowAdminImg?id=" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value + "\"";
                //                            TampleteStr += "id=\"sign" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value + "\"";
                //                            TampleteStr += "class=\"" + Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                //                            if (Obj.Groups[i].Rows[w].Cols[c].rotate == true) {
                //                                TampleteStr += " " + "signRotated mt-5 mb-3 ml_1";
                //                            }
                //                            TampleteStr += "\"name=\"" + Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                //                            TampleteStr += "\">";//img
                //                            TampleteStr += "<span  name=\"" + Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                //                            if (Obj.Groups[i].Rows[w].Cols[c].rotate == true) {
                //                                TampleteStr += "\" class=\"d-flex justify-content-start signDate mt-3\">";
                //                            } else {
                //                                TampleteStr += "\" class=\"signDate mt-3\">";//d-flex justify-content-end 
                //                            }
                //                            time = new Date(Obj.Groups[i].Rows[w].Cols[c].Answers[0].lastUpdate);
                //                            TampleteStr += time.Format("yyyy-MM-dd");
                //                            TampleteStr += "</span>";
                //                            TampleteStr += "</div>";//SignImageBox
                //                            TampleteStr += "</div>";
                //                        } else {
                //                            TampleteStr += "<div class=\"col-12 pt-2 tableSign\">";
                //                            TampleteStr += "<div data-Staut=\"Edit\" style=\"font-size:10px\" data-GidandRow=\"GID\" onchange=\"changeTableJsonData(event)\" onclick=\"SignByAdminId(event)\" class=\"btn btn-primary Signbtn ml-2 rowPart\" >";//
                //                            TampleteStr += "簽核";
                //                            TampleteStr += "</div>";
                //                            TampleteStr += "<div class=\"mt-5 d-none\">";//SignImageBox
                //                            TampleteStr += "<img style=\"width:100px \" src=\"";//img
                //                            TampleteStr += "ShowAdminImg.aspx?id=" + signImgID + "\"";
                //                            TampleteStr += "id=\"sign" + signImgID + "\"";
                //                            TampleteStr += "class=\"" + Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                //                            TampleteStr += "\"name=\"" + Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                //                            TampleteStr += "\">";//img
                //                            TampleteStr += "<span  name=\"" + Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                //                            TampleteStr += "\" class=\" signDate mt-3\">";//d-flex justify-content-end
                //                            TampleteStr += today;
                //                            TampleteStr += "</span>";
                //                            TampleteStr += "</div>";//SignImageBox
                //                            TampleteStr += "</div>";
                //                        }

                //                        break;
                //                    case "filling":
                //                        let fillingStr = Obj.Groups[i].Rows[w].Cols[c].QuestionText;
                //                        let StrArr = fillingStr.split("##");
                //                        let n = 1;
                //                        let N = 0;//第幾個填充答案
                //                        for (var s = 0; s < StrArr.length; s++) {
                //                            if (StrArr[s].includes("^")) {
                //                                if (n > Obj.Groups[i].Rows[w].Cols[c].Answers.length) {
                //                                    Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": n, "value": "", "lastUpdate": "" });
                //                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                                }
                //                                TampleteStr += "<input type=\"text\" onchange=\"changeTableJsonData(event)\" style=\"width:20%\"  class=\"form-control d-inline mr-1 ml-1 mb-2\"name=\"";
                //                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                //                                TampleteStr += "data-filling=\"" + n + "\"";
                //                                if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                //                                    TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].Answers[N].value + "\"";
                //                                }
                //                                TampleteStr += ">";
                //                                n++;
                //                                N++;
                //                                let txt = StrArr[s].substring(2);
                //                                if (txt != null) {
                //                                    TampleteStr += "<span>" + txt + "</span>";
                //                                }
                //                            } else {
                //                                TampleteStr += "<span>" + StrArr[s] + "</span>";
                //                            }
                //                        }
                //                        break;
                //                    case "file"://要可以下載檔案
                //                        if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                //                            TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                //                        }
                //                        TampleteStr += "<span class=\"mb-3 btn btn-default btn-file\"><i class=\"fas fa-paperclip\"></i>";
                //                        TampleteStr += "<input  onchange=\"changeTableJsonData(event)\" type=\"file\" class=\"Upload form-control mb-3\"name=\"";
                //                        TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\">";
                //                        TampleteStr += "上傳檔案";
                //                        TampleteStr += "</span>";
                //                        if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                //                            TampleteStr += "</br>";
                //                            TampleteStr += "<span class=\"ml-3\">" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value + "</span>"
                //                            TampleteStr += "<a class=\"download btn btn-default btn-sm ml-3\" href=\"Upload" + "/" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value + "\">";
                //                            TampleteStr += "<i class=\"fas fa-cloud-download-alt\"></i>";
                //                            TampleteStr += "</a>";
                //                        }
                //                        break;
                //                    case "CheckboxMixFilling":
                //                        if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                //                            TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                //                        }
                //                        for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++) {
                //                            if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers.length) {
                //                                Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "", "Answers": [] });
                //                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                            }
                //                            TampleteStr += "<div class=\"form-check mt-2\">"
                //                            TampleteStr += "<input type=\"checkbox\"onchange=\"changeTableJsonData(event)\" onclick=\"DisabledTrue(event)\" class=\" mr-1\"name=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                //                            TampleteStr += "value=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                //                            TampleteStr += "\"id=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                //                            TampleteStr += "\"";
                //                            if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                //                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].value == true) {
                //                                    TampleteStr += "checked";
                //                                }
                //                            }
                //                            TampleteStr += ">";
                //                            let fillingStr = Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                //                            let fSn = 1;
                //                            let n = 0;
                //                            let StrArr = fillingStr.split("##");
                //                            for (var s = 0; s < StrArr.length; s++) {
                //                                if (StrArr[s].includes("^")) {
                //                                    if (fSn > Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.length) {
                //                                        Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.push({ "index": fSn, "value": "", "lastUpdate": "" });
                //                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                                    }
                //                                    TampleteStr += "<input type=\"text\" disabled style=\"width:20%\" onchange=\"changeTableJsonData(event)\"  class=\"form-control form-control-border form-control-sm d-inline ml-1 mr-1 mb-2\"name=\"";
                //                                    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                //                                    TampleteStr += "data-checkboxIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index + "\"";
                //                                    TampleteStr += "data-TextIndex=\"" + fSn + "\"";
                //                                    if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.length > 0) {
                //                                        TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers[n].value + "\"";
                //                                    }
                //                                    TampleteStr += ">";
                //                                    fSn++;
                //                                    n++;
                //                                    let txt = StrArr[s].substring(2);
                //                                    if (txt != null) {

                //                                        TampleteStr += "<span>" + txt + "</span>";
                //                                    }
                //                                } else {

                //                                    TampleteStr += "<span>" + StrArr[s] + "</span>";
                //                                }
                //                            }
                //                            TampleteStr += "</div>";

                //                        }
                //                        if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers == true) {
                //                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length == 0) {
                //                                Obj.Groups[i].Rows[w].Cols[c].otherAnswer.push({ "index": 1, "value": null, "lastUpdate": "" });
                //                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                            }
                //                            TampleteStr += "<div class=\"form-check d-flex  mt-2\">"
                //                            TampleteStr += "<input class=\"otherAns\" type=\"checkbox\" onclick=\"DisabledTrue(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                //                            TampleteStr += "\"";
                //                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                //                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != null) {
                //                                    TampleteStr += "checked";
                //                                }
                //                            }
                //                            TampleteStr += ">";
                //                            TampleteStr += "<label class=\"pt-2 pl-1 pr-1\">其他</label>";
                //                            TampleteStr += "<input style=\"max-width:100px\" type=\"text\"onchange=\"changeTableJsonData(event)\" disabled class=\"other form-control-border d-inline form-control form-control-sm mb-3\"name=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                //                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                //                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != null) {
                //                                    TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value + "\"";
                //                                }
                //                            }
                //                            TampleteStr += ">";

                //                            TampleteStr += "</div>";
                //                        }

                //                        break;
                //                    case "RadioMixFilling":
                //                        if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                //                            TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                //                        }
                //                        for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++) {
                //                            if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers.length) {
                //                                Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "", "Answers": [] });
                //                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                            }
                //                            TampleteStr += "<div class=\"form-check mt-2\">"
                //                            TampleteStr += "<input type=\"radio\" onclick=\"CleanOthers(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                //                            TampleteStr += "value=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                //                            TampleteStr += "\"id=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                //                            TampleteStr += "\"";
                //                            if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].value == true) {
                //                                TampleteStr += "checked";
                //                            }
                //                            TampleteStr += ">";
                //                            let fillingStr = Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                //                            let StrArr = fillingStr.split("##");
                //                            let fSn = 1;
                //                            let n = 0;
                //                            for (var s = 0; s < StrArr.length; s++) {
                //                                if (StrArr[s].includes("^")) {
                //                                    if (fSn > Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.length) {
                //                                        Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.push({ "index": fSn, "value": "", "lastUpdate": "" });
                //                                        document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                                    }
                //                                    TampleteStr += "<input type=\"text\" onchange=\"changeTableJsonData(event)\"  disabled style=\"max-width:100px\" class=\"form-control-border form-control form-control-sm ml-1 mr-1 d-inline mb-2\"name=\"";//data-gidandrow
                //                                    TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                //                                    TampleteStr += "data-RadioIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index + "\"";
                //                                    TampleteStr += "data-TextIndex=\"" + fSn + "\"";
                //                                    if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.length > 0) {
                //                                        TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers[n].value + "\"";
                //                                    }
                //                                    TampleteStr += ">";
                //                                    fSn++;
                //                                    n++;
                //                                    let txt = StrArr[s].substring(2);
                //                                    if (txt != null) {
                //                                        TampleteStr += "<span>" + txt + "</span>";
                //                                    }
                //                                } else {
                //                                    TampleteStr += "<span>" + StrArr[s] + "</span>";
                //                                }
                //                            }
                //                            TampleteStr += "</div>";
                //                        }
                //                        if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers == true) {
                //                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length == 0) {
                //                                Obj.Groups[i].Rows[w].Cols[c].otherAnswer.push({ "index": 1, "value": null, "lastUpdate": "" });
                //                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                            }
                //                            TampleteStr += "<div class=\"form-check d-flex mt-2\">"
                //                            TampleteStr += "<input class=\"otherAns\" type=\"radio\" onclick=\"CleanOthers(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                //                            TampleteStr += "\"";
                //                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                //                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != null) {
                //                                    TampleteStr += "checked";
                //                                }
                //                            }
                //                            TampleteStr += ">";
                //                            TampleteStr += "<label class=\"pt-2 pl-1 pr-1\">其他</label>";
                //                            TampleteStr += "<input style=\"max-width:100px\" type=\"text\"onchange=\"changeTableJsonData(event)\" disabled class=\"other form-control-border d-inline form-control form-control-sm mb-3\"name=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                //                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                //                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != null) {
                //                                    TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value + "\"";
                //                                }
                //                            }
                //                            TampleteStr += ">";

                //                            TampleteStr += "</div>";
                //                        }

                //                        break;
                //                    case "RadioMixCheckbox":
                //                        if (Obj.Groups[i].Rows[w].Cols[c].QuestionText != "") {
                //                            TampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].QuestionText + "</span>";
                //                        }

                //                        for (var o = 0; o < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length; o++) {
                //                            if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers.length) {
                //                                Obj.Groups[i].Rows[w].Cols[c].Answers.push({ "index": o + 1, "value": false, "lastUpdate": "", "Answers": [] });
                //                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                            }
                //                            TampleteStr += "<div class=\"form-check\">"
                //                            TampleteStr += "<input type=\"radio\" onchange=\"changeTableJsonData(event)\" onclick=\"CleanOption(event)\" class=\" mr-1\"name=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                //                            TampleteStr += "value=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                //                            TampleteStr += "\"id=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText;
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index;
                //                            TampleteStr += "\"";
                //                            if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                //                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].value == true) {
                //                                    TampleteStr += "checked";
                //                                }
                //                            }
                //                            TampleteStr += ">";
                //                            TampleteStr += "<span class=\"mr-2\" style=\"font-weight:bold \">" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnsText + "</span>";
                //                            for (var k = 0; k < Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions.length; k++) {
                //                                if (Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions.length > Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.length) {
                //                                    Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.push({ "index": k + 1, "value": false, "lastUpdate": "" });
                //                                    document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                                }

                //                                TampleteStr += "<input onchange=\"changeTableJsonData(event)\" type=\"checkbox\" disabled class=\"mr-1\"name=\"";
                //                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                //                                TampleteStr += "value=\"";
                //                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index;
                //                                TampleteStr += "\"id=\"";
                //                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].AnsText;
                //                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index;
                //                                TampleteStr += "\"";
                //                                TampleteStr += "data-RadioIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].index + "\"";
                //                                TampleteStr += "data-CheckboxIndex=\"" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index + "\"";
                //                                console.log("RadioMixCheckbox");
                //                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers.length > 0) {
                //                                    if (Obj.Groups[i].Rows[w].Cols[c].Answers[o].Answers[k].value == true) {
                //                                        TampleteStr += "checked";
                //                                    }
                //                                }
                //                                TampleteStr += ">";
                //                                TampleteStr += "<label for=\"";
                //                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].AnsText;
                //                                TampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].index;
                //                                TampleteStr += "\"class=\"mr-2\">" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[o].AnswerOptions[k].AnsText + "</label>";
                //                            }
                //                            TampleteStr += "</div>";
                //                        }
                //                        console.log("hasOtherAnswers" + Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers);
                //                        if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers == true) {

                //                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length == 0) {
                //                                Obj.Groups[i].Rows[w].Cols[c].otherAnswer.push({ "index": 1, "value": null, "lastUpdate": "" });
                //                                document.querySelector("#mainPlaceHolder_jsonData").setAttribute("value", JSON.stringify(Obj));
                //                            }
                //                            TampleteStr += "<div class=\"form-check d-flex mt-1\">"
                //                            TampleteStr += "<input class=\"otherAns\" type=\"radio\" onclick=\"CleanOthers(event)\" onchange=\"changeTableJsonData(event)\"  class=\" mr-1\"name=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID;
                //                            TampleteStr += "\"";
                //                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                //                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != null) {
                //                                    TampleteStr += "checked";
                //                                }
                //                            }
                //                            TampleteStr += ">";
                //                            TampleteStr += "<label class=\"pt-2 pl-1 pr-1\">其他</label>";
                //                            TampleteStr += "<input style=\"max-width:100px\" type=\"text\"onchange=\"changeTableJsonData(event)\" disabled class=\"other form-control-border d-inline form-control form-control-sm mb-3\"name=\"";
                //                            TampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionID + "\"";
                //                            if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer.length > 0) {
                //                                if (Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != null) {
                //                                    TampleteStr += "value=\"" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value + "\"";
                //                                }
                //                            }
                //                            TampleteStr += ">";

                //                            TampleteStr += "</div>";
                //                        }

                //                        break;
                //                    default:
                //                }

                //                TampleteStr += "</td>";
                //            }
                //        }
                //        TampleteStr += "</tbody>";
                //        TampleteStr += "</table>";
                //        TampleteStr += "<div class=\"d-flex justify-content-center\"><div class=\" mb-3\">";
                //        TampleteStr += "</div></div>";
                //        TampleteStr += "</div>";//col-12
                //        TampleteStr += "</div>";//row
                //        TampleteStr += "</div>";//table-responsive
                //        TampleteStr += "</div>";//rowPart
                //        TampleteStr += "</div>";//rowContainer
                //        TampleteStr += "</div>";//rowPart

                //        ansEditFormT.innerHTML += TampleteStr;

                //        break;
                //    case "row":
                //        let insertTitle = document.querySelector(".insertTitle");
                //        insertTitle.innerText = Obj.Groups[i].GroupName;
                //        let ansEditForm = document.querySelector(".ansEditForm ");
                //        let tampleteStr = "";
                //        tampleteStr += "<div class=\"rowPart\">";
                //        tampleteStr += "<div class=\"rowPart\">";
                //        tampleteStr += "<h3 class=\"rowPart\">" + Obj.Groups[i].GroupName;
                //        tampleteStr += "</h3>";
                //        tampleteStr += "<div class=\"rowContainer row card mb-4 rowPart\">";
                //        tampleteStr += "<div class=\"rowPart\">";
                //        tampleteStr += "<div class=\"table-responsive rowPart\" style=\"overflow-x:hidden\">";
                //        tampleteStr += "<div class=\"row\">";
                //        tampleteStr += "<div class=\"col-sm-12 col-12 rowPart\">";
                //        tampleteStr += "<table class=\"table table-bordered dataTable rowPart\" style=\"width: 100%;\">";
                //        tampleteStr += "<thead>";//thead
                //        tampleteStr += "<tr role=\"row\">";
                //        if (Obj.Groups[i].hasSN > 0) {
                //            tampleteStr += "<th class=\"sorting sorting_asc rowPart\">" + "項次";
                //            tampleteStr += "</th>";
                //        }
                //        for (var r = 0; r < Obj.Groups[i].Rows[0].Cols.length; r++) {//首列的標題

                //            switch (Obj.Groups[i].Rows[0].Cols[r].QuestionType) {
                //                case "display":
                //                    tampleteStr += "<th class=\"sorting sorting_asc rowPart\">" + Obj.Groups[i].Rows[0].Cols[r].QuestionText;
                //                    tampleteStr += "</th>";
                //                    break;
                //                case "text":
                //                    tampleteStr += "<th class=\"sorting sorting_asc rowPart\">" + Obj.Groups[i].Rows[0].Cols[r].QuestionText;
                //                    tampleteStr += "<input type=\"text\" value=\"" + Obj.Groups[i].Rows[0].Cols[r].Answers[0].value + "\">";
                //                    tampleteStr += "</th>";
                //                    break;
                //                default:
                //            }
                //        }
                //        tampleteStr += "<th class=\"sorting sorting_asc rowPart\">" + "編輯";
                //        tampleteStr += "</th>";
                //        tampleteStr += "<th class=\"sorting sorting_asc rowPart\">" + "刪除";
                //        tampleteStr += "</th>";
                //        tampleteStr += "</tr>";
                //        tampleteStr += "</thead>";//thead
                //        tampleteStr += "<tbody>";//
                //        //有項次
                //        let no = Obj.Groups[i].hasSN;
                //        if (Obj.Groups[i].hasSN > 0) {

                //            tampleteStr += "<tr class=\"odd\">";
                //            tampleteStr += "<td class=\"dtr-control sorting_1\">";
                //            tampleteStr += no;
                //            tampleteStr += "</td>";
                //            tampleteStr += "</tr>";
                //            no++;
                //        }
                //        for (var w = 1; w < Obj.Groups[i].Rows.length; w++) {
                //            tampleteStr += "<tr class=\"odd\">";
                //            for (var c = 0; c < Obj.Groups[i].Rows[w].Cols.length; c++) {//答案的顯示 存JSON的答案
                //                tampleteStr += "<td class=\"dtr-control sorting_1\">";
                //                if (Obj.Groups[i].Rows[w].Cols[c].Answers.length > 0) {
                //                    switch (Obj.Groups[i].Rows[w].Cols[c].QuestionType) {
                //                        case "file":
                //                        case "image":
                //                            tampleteStr += "<span>" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value + "</span>";
                //                            tampleteStr += "<a  class=\"ml-1 btn btn-default btn-sm download\" href=\"Upload/" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value + "\">";
                //                            tampleteStr += "<i class=\"fas fa-cloud-download-alt\"></i>";
                //                            tampleteStr += "</a>";
                //                            break;
                //                        case "text":
                //                        case "number":
                //                        case "select":
                //                            tampleteStr += Obj.Groups[i].Rows[w].Cols[c].Answers[0].value;
                //                            break;
                //                        case "display":
                //                            tampleteStr += Obj.Groups[i].Rows[w].Cols[c].QuestionText;
                //                            break;
                //                        case "date":
                //                            let dateValue = Obj.Groups[i].Rows[w].Cols[c].Answers[0].value;
                //                            console.log("dateValue_" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value)
                //                            let dateStr = new Date(dateValue);
                //                            dateStr = dateStr.Format("yyyy-MM-dd");
                //                            if (!dateStr.includes("Na") && dateValue != null) {//
                //                                tampleteStr += dateStr;
                //                            }
                //                            break;
                //                        case "radio":
                //                        case "checkbox":
                //                            for (var r = 0; r < Obj.Groups[i].Rows[1].Cols[c].Answers.length; r++) {
                //                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[r].value == true) {
                //                                    tampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[r].AnsText + "</br>";
                //                                }
                //                            }
                //                            if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers && Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != null && Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != "") {
                //                                tampleteStr += "其他:" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value + "</br>";
                //                            }
                //                            break;
                //                        case "CheckboxMixImage":
                //                            for (var r = 0; r < Obj.Groups[i].Rows[1].Cols[c].Answers.length; r++) {
                //                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[r].value == true) {
                //                                    tampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[r].AnsText + "</br>";
                //                                    tampleteStr += "<img style=\"height:50px\"src=\"ShowAdminImg?id=" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[r].image + "\"" + "/>" + "</br>";
                //                                }
                //                            }
                //                            if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers && Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != null && Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != "") {
                //                                tampleteStr += "其他:" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value + "</br>";
                //                            }

                //                            break;
                //                        case "sign":
                //                            if (Obj.Groups[i].Rows[w].Cols[c].Answers[0].value != null && Obj.Groups[i].Rows[w].Cols[c].Answers[0].value != 0) {
                //                                let time = new Date(Obj.Groups[i].Rows[w].Cols[c].Answers[0].lastUpdate);
                //                                let strTime = time.Format("yyyy-MM-dd");
                //                                tampleteStr += "<img style=\"width:20%\" id=\"sign\" src=\"" + "ShowAdminImg.aspx?id=" + Obj.Groups[i].Rows[w].Cols[c].Answers[0].value + "\">";
                //                                tampleteStr += "<span>" + strTime + "</span>";
                //                            }
                //                            break;
                //                        case "filling":
                //                            let fillingStr = Obj.Groups[i].Rows[w].Cols[c].QuestionText;
                //                            let StrArr = fillingStr.split("##");
                //                            let n = 1;
                //                            let N = 0;//第幾個填充答案
                //                            if (Obj.Groups[i].Rows[w].Cols[c].Answers[N].value == "") {
                //                                tampleteStr += "";
                //                            } else {
                //                                for (var s = 0; s < StrArr.length; s++) {
                //                                    if (StrArr[s].includes("^")) {
                //                                        let reStr = StrArr[s].substring(2);
                //                                        tampleteStr += Obj.Groups[i].Rows[w].Cols[c].Answers[N].value + reStr;
                //                                        n++;
                //                                        N++;
                //                                    } else {
                //                                        tampleteStr += StrArr[s];
                //                                    }
                //                                }
                //                            }
                //                            break;
                //                        case "CheckboxMixFilling":
                //                        case "RadioMixFilling":
                //                            for (var r = 0; r < Obj.Groups[i].Rows[w].Cols[c].Answers.length; r++) {
                //                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[r].value == true) {
                //                                    let fillingStr = Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[r].AnsText;
                //                                    let StrArr = fillingStr.split("##");
                //                                    let SN = 0;//第幾個填充答案
                //                                    let n = 1;
                //                                    for (var s = 0; s < StrArr.length; s++) {
                //                                        if (StrArr[s].includes("^")) {
                //                                            let reStr = StrArr[s].substring(2);
                //                                            tampleteStr += Obj.Groups[i].Rows[w].Cols[c].Answers[r].Answers[SN].value + reStr;
                //                                            n++;
                //                                            SN++;
                //                                        } else {
                //                                            tampleteStr += StrArr[s];
                //                                        }
                //                                    }
                //                                }
                //                            }
                //                            if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers && Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != null && Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != "") {
                //                                tampleteStr += "其他:" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value;
                //                            }

                //                            break;
                //                        case "RadioMixCheckbox":
                //                            for (var r = 0; r < Obj.Groups[i].Rows[w].Cols[c].Answers.length; r++) {
                //                                if (Obj.Groups[i].Rows[w].Cols[c].Answers[r].value == true) {
                //                                    tampleteStr += Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[r].AnsText + ":";
                //                                    for (var b = 0; b < Obj.Groups[i].Rows[w].Cols[c].Answers[r].Answers.length; b++) {
                //                                        if (Obj.Groups[i].Rows[w].Cols[c].Answers[r].Answers[b].value == true) {
                //                                            tampleteStr += "</br>" + Obj.Groups[i].Rows[w].Cols[c].AnswerOptions[r].AnswerOptions[b].AnsText;
                //                                        }
                //                                    }
                //                                }
                //                            }
                //                            if (Obj.Groups[i].Rows[w].Cols[c].hasOtherAnswers && Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != null && Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value != "") {
                //                                tampleteStr += "其他:" + Obj.Groups[i].Rows[w].Cols[c].otherAnswer[0].value;
                //                            }

                //                            break;
                //                        default:
                //                    }

                //                }
                //                tampleteStr += "</td>";
                //            }
                //            tampleteStr += "<td class=\"dtr-control sorting_1\">";
                //            tampleteStr += "<button type=\"button\" class=\"btn btn-secondary\" data-toggle=\"modal\" data-isInsert=\"false\" data-target=\"#modal-update\"onclick =\"showModal(event)\"";
                //            tampleteStr += "data-gid=\"" + Gsn + "\"" + "data-row=\"" + w + "\"";
                //            tampleteStr += ">" + "編輯";
                //            tampleteStr += "</button>"
                //            tampleteStr += "</td>";
                //            tampleteStr += "<td class=\"dtr-control sorting_1\">";
                //            tampleteStr += "<button type=\"button\"onclick =\"DeleteRow(event)\" class=\"btn btn-danger\" data-toggle=\"modal\"  data-target=\"#modal-danger\"";
                //            tampleteStr += "data-gid=\"" + Gsn + "\"" + "data-row=\"" + w + "\"";
                //            tampleteStr += ">" + "刪除";
                //            tampleteStr += "</button>"
                //            tampleteStr += "</td>";
                //            tampleteStr += "</tr>";
                //        }
                //        tampleteStr += "</tbody>";
                //        tampleteStr += "</table>";
                //        tampleteStr += "<div class=\"d-flex justify-content-center\"><div class=\" mb-3\">";
                //        tampleteStr += "<button type=\"button\" class=\"btn btn-app \" data-toggle=\"modal\" data-isInsert=\"true\" data-target=\"#modal-insert\"data-gid=\"";
                //        tampleteStr += Gsn + "\"";
                //        tampleteStr += "onclick =\"showModal(event)\">";
                //        tampleteStr += "<i class=\" fas fa-plus-circle\"><i>";
                //        tampleteStr += "</button>";
                //        tampleteStr += "</div></div>";
                //        tampleteStr += "</div>";//col-12
                //        tampleteStr += "</div>";//row
                //        tampleteStr += "</div>";//table-responsive
                //        tampleteStr += "</div>";//rowPart
                //        tampleteStr += "</div>";//rowContainer
                //        tampleteStr += "</div>";//rowPart

                //        previewStr += "</div>";//卡片的Body
                }
            }
            previewStr += "</div>";//ansEditForm
            previewStr += "</div>";//card-body
            previewStr += "</div>";//card
            previewStr += "</div>";//ansEdit
            previewStr += "</div>";//row
            previewStr += "</div>";//container-fluid
            previewStr += "</div>";//content
            return previewStr;
        }

        // 初始化輸入 Modal
        $('#displayModal').on('shown.bs.modal', function () {
            $("#displayUploadDiv").show();
            $("#displayOverlayDiv").hide();
            $("#displayImageDiv").hide();
            $("#displayInput").val('');
            $("#displayFile").val('');
            $("#displayImageSN").val('');
            $("#displayImage").attr("src", `#`);
            $('#displayInput').trigger('focus');
            $("#imageUploadButton").prop('disabled', false);
        });
        $('#textModal').on('shown.bs.modal', function () {
            $("#textInput").val('');
            $('#textInput').trigger('focus');
        });
        $('#numberModal').on('shown.bs.modal', function () {
            $("#numberInput").val('');
            $('#numberInput').trigger('focus');
        });
        $('#radioModal').on('shown.bs.modal', function () {
            $("#radioInput").val('');
            $("#radioCheck").prop("checked", false);
            $("#radioBody").html('');
            $('#radioInput').trigger('focus');
        });
        $('#checkboxModal').on('shown.bs.modal', function () {
            $("#checkboxInput").val('');
            $("#checkboxCheck").prop("checked", false);
            $("#checkboxBody").html('');
            $('#checkboxInput').trigger('focus');
        });
        $('#selectModal').on('shown.bs.modal', function () {
            $("#selectInput").val('');
            $("#selectBody").html('');
            $('#selectInput').trigger('focus');
        });
        $('#signModal').on('shown.bs.modal', function () {
            $("#signInput").val('');
            $("#signCheck").prop("checked", false);
            $('#signInput').trigger('focus');
        });
        $('#fillingModal').on('shown.bs.modal', function () {
            $("#fillingInput").val('');
            $('#fillingInput').trigger('focus');
        });
        $('#dateModal').on('shown.bs.modal', function () {
            $("#dateInput").val('');
            $('#dateInput').trigger('focus');
        });
        $('#fileModal').on('shown.bs.modal', function () {
            $("#fileInput").val('');
            $('#fileInput').trigger('focus');
        });
        $('#RadioMixCheckboxModal').on('shown.bs.modal', function () {
            $("#RadioMixCheckboxInput").val('');
            $("#RadioMixCheckboxCheck").prop("checked", false);
            $("#RadioMixCheckboxBody").html('');
            $('#RadioMixCheckboxInput').trigger('focus');
        });
        $('#RadioMixFillingModal').on('shown.bs.modal', function () {
            $("#RadioMixFillingInput").val('');
            $("#RadioMixFillingCheck").prop("checked", false);
            $("#RadioMixFillingBody").html('');
            $('#RadioMixFillingInput').trigger('focus');
        });
        $('#CheckboxMixImageModal').on('shown.bs.modal', function () {
            $("#CheckboxMixImageInput").val('');
            $("#CheckboxMixImageCheck").prop("checked", false);
            $("#CheckboxMixImageBody").html('');
            $('#CheckboxMixImageInput').trigger('focus');
        });
        $('#CheckboxMixFillingModal').on('shown.bs.modal', function () {
            $("#CheckboxMixFillingInput").val('');
            $("#CheckboxMixFillingCheck").prop("checked", false);
            $("#CheckboxMixFillingBody").html('');
            $('#CheckboxMixFillingInput').trigger('focus');
        });
        function Preview() {

        }
        // Valid Form
        function ValidForm() {
            const vf = $("#<%= FormTitle.ClientID %>");
            vf.removeClass("is-invalid");

            if (vf.val().length < 1) {
                vf.addClass("is-invalid");
                vf.focus();
                return false;
            }

            return true;
        }
        //選擇下載版本
        function changeVer(){
            console.log("changeVer");
            let ver= $("#Ver option:selected").val();
            let downloadLink=$("#downloadVer");
            downloadLink.attr("href",ver);
        }

        // 選擇群組類型
        function changeGroupType() {
            const sel = $("#GroupType option:selected").val();
            const Gname = $("#Gname");
            const GRowCount = $("#GRowCount");
            const GColCount = $("#GColCount");
            Gname.removeClass("is-invalid");
            GRowCount.removeClass("is-invalid");
            GColCount.removeClass("is-invalid");

            switch (sel) {
                case "normal":
                    $("#GRowCount").hide();
                    $("#GColCount").hide();
                    break;
                case "table":
                    $("#GRowCount").show();
                    $("#GColCount").show();
                    break;
                case "row":
                    $("#GRowCount").hide();
                    $("#GColCount").show();
                    break;
            }
            return false;
        }

        // 檢查群組設定
        function validGroupType() {
            var isValid = true;
            const Gname = $("#Gname");
            const GRowCount = $("#GRowCount");
            const GColCount = $("#GColCount");
            const sel = $("#GroupType option:selected").val();
            Gname.removeClass("is-invalid");
            GRowCount.removeClass("is-invalid");
            GColCount.removeClass("is-invalid");

            switch (sel) {
                case "normal":
                    if (Gname.val() == "") {
                        Gname.addClass("is-invalid");
                        Gname.focus();
                        isValid = false;
                    }
                    break;
                case "table":
                    if (GColCount.val() == "") {
                        GColCount.addClass("is-invalid");
                        GColCount.focus();
                        isValid = false;
                    }
                    if (GRowCount.val() == "") {
                        GRowCount.addClass("is-invalid");
                        GRowCount.focus();
                        isValid = false;
                    }
                    if (Gname.val() == "") {
                        Gname.addClass("is-invalid");
                        Gname.focus();
                        isValid = false;
                    }
                    break;
                case "row":
                    if (GColCount.val() == "") {
                        GColCount.addClass("is-invalid");
                        GColCount.focus();
                        isValid = false;
                    }
                    if (Gname.val() == "") {
                        Gname.addClass("is-invalid");
                        Gname.focus();
                        isValid = false;
                    }
                    break;
            }

            return isValid;
        }

        // 圖片上傳處理
        function uploadImage() {
            $("#imageUploadButton").prop('disabled', true);
            $("#displayUploadDiv").hide();
            $("#displayOverlayDiv").show();

            var formData = new FormData();
            formData.append("file", $("#displayFile")[0].files[0]);

            $.ajax({
                url: 'Service/ImageService.asmx/UploadImage',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (SN) {
                    $("#displayImageSN").val(SN);
                    $("#displayImage").attr("src", `showimage?SN=${SN}`);
                    $("#displayOverlayDiv").hide();
                    $("#displayImageDiv").show();
                }
            });

            return false;
        }

        // CheckboxMinImage 圖片上傳處理
        function chekcboxUploadImage(obj) {
            $("#CheckboxMixImageOverlayDiv").show();
            var formData = new FormData();
            formData.append("file", obj.files[0]);

            $.ajax({
                url: 'Service/ImageService.asmx/UploadImage',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (SN) {
                    $("#CheckboxMixImageOverlayDiv").hide();
                    $(obj).parent().parent().children("input.CheckboxMixImageHidden").val(`${SN}`);
                    const sobj = $(obj).parent('span');
                    sobj.html(`<img src="showimage?SN=${SN}" width="100%" />`);
                }
            });

            return false;
        }

        // CheckboxMinImage 題目新增選項
        function CheckboxMinImageAddOption() {
            const rb = $(`#CheckboxMixImageBody`);

            const item = `<div class="input-group mt-2">
                            <input type="text" class="form-control CheckboxMixImageBody" />
                            <input type="hidden" class="CheckboxMixImageHidden" value="0" />
                            <span class="btn btn-default btn-file">
                                <i class="fas fa-paperclip"></i>
                                <input type="file" onchange="chekcboxUploadImage(this)" />
                            </span>
                        </div>`;

            rb.append(item);
            return false;
        }

        // 題目新增選項
        function AddOption(option) {
            const rb = $(`#${option}`);
            rb.append(`<input type="text" class="form-control mt-2 ${option}" />`);
            return false;
        }

        // RadioMixCheckbox 新增選項
        function RadioAddOption(option) {
            const item = `<div class="mt-2">
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-circle"></i>
                                    </span>
                                    <input type="text" class="form-control rounded-0 ${option}">
                                    <span class="input-group-append">
                                        <button type="button" class="btn btn-info btn-flat" onclick="return RadioAddSunOption(this);"><i class="fa fa-plus"></i></button>
                                    </span>
                                </div>
                            </div>`;
            const rb = $(`#${option}`);
            rb.append(item);
            return false;
        }

        // RadioMixCheckbox 新增子選項
        function RadioAddSunOption(obj) {
            const ob = $(obj).parent().parent().parent();
            ob.append(`<div class="input-group mt-1 ml-5 w-75">
                            <div class="input-group-append">
                                <span class="input-group-text"><i class="fas fa-check"></i></span>
                            </div>
                            <input type="text" class="form-control RadioMixCheckboxSun">
                        </div>`);
            return false;
        }

        // 排序群組與題目並重新建立 index
        function sortGroupAndQuestion() {
            var json = jQuery.parseJSON(outputJsonBox.text());
            var Gindex = 0;
            var Qindex = 0;

            $.each(json.Groups, function () {
                Gindex++;
                this.index = Gindex;
                this.GroupID = `Group_${Gindex}`;
                switch (this.GroupType) {
                    case "normal":
                        $.each(this.Questions, function () {
                            Qindex++;
                            this.index = Qindex;
                            this.QuestionID = `Question_${Qindex}`;
                        });
                        break;
                    case "table":
                    case "row":
                        $.each(this.Rows, function () {
                            $.each(this.Cols, function () {
                                Qindex++;
                                this.index = Qindex;
                                this.QuestionID = `Question_${Qindex}`;
                            });
                        });
                        break;
                }
            });

            outputJsonBox.text(JSON.stringify(json));
            return false;
        }

        // 新增群組
        function AddGroup() {
            const sel = $("#GroupType option:selected").val();
            var Gsn = $("#Gsn").val();
            const Gname = $("#Gname").val();
            const GRowCount = Number($("#GRowCount").val());
            const GColCount = Number($("#GColCount").val());

            if (!validGroupType())
                return false;

            if (Gsn == "")
                Gsn = -1;
            else
                Gsn = Number(Gsn);

            var json = jQuery.parseJSON(outputJsonBox.text());
            var jsonObjectString = `{"index": 0, "GroupID": "", "GroupName": "${Gname}", "GroupType": "${sel}", "hasSN": ${Gsn},`;

            switch (sel) {
                case "normal":
                    jsonObjectString += ` "Questions": [`;
                    break;
                case "table":
                    jsonObjectString += ` "Rows": [`;
                    for (var i = 1; i <= GRowCount; i++) {
                        jsonObjectString += `{"index": ${i}, "Cols": [`;
                        for (var j = 1; j <= GColCount; j++) {
                            jsonObjectString += `{"index": 1, "hasOtherAnswers": false, "QuestionID": "", "QuestionText": "", "QuestionType": "", "AnswerOptions": [], "Answers": [], "otherAnswer": []},`;
                        }
                        jsonObjectString += `]},`;
                    }
                    break;
                case "row":
                    jsonObjectString += ` "Rows": [`;
                    for (var i = 1; i <= 2; i++) {
                        jsonObjectString += `{"index": ${i}, "Cols": [`;
                        for (var j = 1; j <= GColCount; j++) {
                            jsonObjectString += `{"index": 1, "hasOtherAnswers": false, "QuestionID": "", "QuestionText": "", "QuestionType": "", "AnswerOptions": [], "Answers": [], "otherAnswer": []},`;
                        }
                        jsonObjectString += `]},`;
                    }
                    break;
            }

            jsonObjectString += `]}`;
            jsonObjectString = jsonObjectString.replaceAll(",]", "]");
            var jsonObject = JSON.parse(jsonObjectString);
            json.Groups.push(jsonObject);
            outputJsonBox.text(JSON.stringify(json));
            $("#Gsn").val('');
            $("#Gname").val('');
            $("#GRowCount").val('');
            $("#GColCount").val('');
            sortGroupAndQuestion();
            showQuestion();
            return false;
        }

        // 移除群組
        function RemoveGroup(Gindex) {
            var json = jQuery.parseJSON(outputJsonBox.text());

            json.Groups.splice(Gindex - 1, 1);
            outputJsonBox.text(JSON.stringify(json));
            sortGroupAndQuestion();
            showQuestion();
        }

        // 新增題目選擇
        function AddQuestionSelect(Gindex, Qindex) {
            $("#GroupIndex").val(Gindex);
            $("#QuestionIndex").val(Qindex);
            $("#AddQuestionModal").modal('show');
            return false;
        }

        // 確認新增題目
        function AddSelectQuestion() {
            $("#AddQuestionModal").modal('hide');
            AddQuestion();
            return false;
        }

        // 新增題目
        function AddQuestion() {
            const Qtype = $("#GroupTypeSelect").val();
            $("#GroupIndex").val();
            switch (Qtype) {
                case "display":
                    $("#displayModal").modal('show');
                    break;
                case "text":
                    $("#textModal").modal('show');
                    break;
                case "number":
                    $("#numberModal").modal('show');
                    break;
                case "radio":
                    $("#radioModal").modal('show');
                    break;
                case "checkbox":
                    $("#checkboxModal").modal('show');
                    break;
                case "select":
                    $("#selectModal").modal('show');
                    break;
                case "sign":
                    $("#signModal").modal('show');
                    break;
                case "filling":
                    $("#fillingModal").modal('show');
                    break;
                case "date":
                    $("#dateModal").modal('show');
                    break;
                case "file":
                    $("#fileModal").modal('show');
                    break;
                case "RadioMixCheckbox":
                    $("#RadioMixCheckboxModal").modal('show');
                    break;
                case "RadioMixFilling":
                    $("#RadioMixFillingModal").modal('show');
                    break;
                case "CheckboxMixImage":
                    $("#CheckboxMixImageModal").modal('show');
                    break;
                case "CheckboxMixFilling":
                    $("#CheckboxMixFillingModal").modal('show');
                    break;
            }

            return false;
        }

        // 儲存題目
        function SaveQuestion(Qtype) {
            var json = jQuery.parseJSON(outputJsonBox.text());
            const Gindex = Number($("#GroupIndex").val());
            const Qindex = Number($("#QuestionIndex").val());
            const Gtype = json.Groups[Gindex - 1].GroupType;
            var item = {};

            switch (Qtype) {
                case "display":
                    const displayInput = $("#displayInput").val();
                    const displayImageSN = $("#displayImageSN").val();
                    item = { index: 0, hasOtherAnswers: false, QuestionID: "Question", QuestionText: `${displayInput}`, QuestionType: "display", AnswerOptions: [], Answers: [], otherAnswer: [] };
                    if (displayImageSN != '') {
                        var SN = Number(displayImageSN);
                        item.AnswerOptions.push({ index: 1, AnsText: '', image: SN });
                    }
                    $("#displayModal").modal('hide');
                    break;
                case "text":
                    const textInput = $("#textInput").val();
                    item = { index: 0, hasOtherAnswers: false, QuestionID: "Question", QuestionText: `${textInput}`, QuestionType: "text", AnswerOptions: [], Answers: [], otherAnswer: [] };
                    $("#textModal").modal('hide');
                    break;
                case "number":
                    const numberInput = $("#numberInput").val();
                    item = { index: 0, hasOtherAnswers: false, QuestionID: "Question", QuestionText: `${numberInput}`, QuestionType: "number", AnswerOptions: [], Answers: [], otherAnswer: [] };
                    $("#numberModal").modal('hide');
                    break;
                case "radio":
                    const redioInput = $("#radioInput").val();
                    const radioCheck = $('#radioCheck').is(":checked");
                    item = { index: 0, hasOtherAnswers: radioCheck, QuestionID: "Question", QuestionText: `${redioInput}`, QuestionType: "radio", AnswerOptions: [], Answers: [], otherAnswer: [] };
                    $(".radioBody").each(function (index) {
                        item.AnswerOptions.push({ index: index + 1, AnsText: `${$(this).val()}` });
                    });
                    $("#radioModal").modal('hide');
                    break;
                case "checkbox":
                    const checkboxInput = $("#checkboxInput").val();
                    const checkboxCheck = $('#checkboxCheck').is(":checked");
                    item = { index: 0, hasOtherAnswers: checkboxCheck, QuestionID: "Question", QuestionText: `${checkboxInput}`, QuestionType: "checkbox", AnswerOptions: [], Answers: [], otherAnswer: [] };
                    $(".checkboxBody").each(function (index) {
                        item.AnswerOptions.push({ index: index + 1, AnsText: `${$(this).val()}` });
                    });
                    $("#checkboxModal").modal('hide');
                    break;
                case "select":
                    const selectInput = $("#selectInput").val();
                    item = { index: 0, hasOtherAnswers: false, QuestionID: "Question", QuestionText: `${selectInput}`, QuestionType: "select", AnswerOptions: [], Answers: [], otherAnswer: [] };
                    $(".selectBody").each(function (index) {
                        item.AnswerOptions.push({ index: index + 1, AnsText: `${$(this).val()}` });
                    });
                    $("#selectModal").modal('hide');
                    break;
                case "sign":
                    const signInput = $("#signInput").val();
                    const signCheck = $('#signCheck').is(":checked");
                    item = {
                        index: 0, hasOtherAnswers: false, QuestionID: "Question", QuestionText: `${signInput}`, QuestionType: "sign", rotate: signCheck, AnswerOptions: [], Answers: [], otherAnswer: []
                    };
                    $("#signModal").modal('hide');
                    break;
                case "filling":
                    const fillingInput = $("#fillingInput").val();
                    item = { index: 0, hasOtherAnswers: false, QuestionID: "Question", QuestionText: `${fillingInput}`, QuestionType: "filling", AnswerOptions: [], Answers: [], otherAnswer: [] };
                    $("#fillingModal").modal('hide');
                    break;
                case "date":
                    const dateInput = $("#dateInput").val();
                    item = { index: 0, hasOtherAnswers: false, QuestionID: "Question", QuestionText: `${dateInput}`, QuestionType: "date", AnswerOptions: [], Answers: [], otherAnswer: [] };
                    $("#dateModal").modal('hide');
                    break;
                case "file":
                    const fileInput = $("#fileInput").val();
                    item = { index: 0, hasOtherAnswers: false, QuestionID: "Question", QuestionText: `${fileInput}`, QuestionType: "file", AnswerOptions: [], Answers: [], otherAnswer: [] };
                    $("#fileModal").modal('hide');
                    break;
                case "RadioMixCheckbox":
                    const RadioMixCheckbox = $("#RadioMixCheckboxInput").val();
                    const RadioMixCheckboxCheck = $('#RadioMixCheckboxCheck').is(":checked");
                    item = { index: 0, hasOtherAnswers: RadioMixCheckboxCheck, QuestionID: "Question", QuestionText: `${RadioMixCheckbox}`, QuestionType: "RadioMixCheckbox", AnswerOptions: [], Answers: [], otherAnswer: [] };
                    $(".RadioMixCheckboxBody").each(function (index) {
                        item.AnswerOptions.push({ index: index + 1, AnsText: `${$(this).val()}`, "AnswerOptions": [] });
                        var pre = $(this).parent().parent().find("input.RadioMixCheckboxSun");
                        pre.each(function (sindex) {
                            item.AnswerOptions[index].AnswerOptions.push({ index: sindex + 1, AnsText: `${$(this).val()}` });
                        });
                    });
                    $("#RadioMixCheckboxModal").modal('hide');
                    break;
                case "RadioMixFilling":
                    const RadioMixFillingInput = $("#RadioMixFillingInput").val();
                    const RadioMixFillingCheck = $('#RadioMixFillingCheck').is(":checked");
                    item = { index: 0, hasOtherAnswers: RadioMixFillingCheck, QuestionID: "Question", QuestionText: `${RadioMixFillingInput}`, QuestionType: "RadioMixFilling", AnswerOptions: [], Answers: [], otherAnswer: [] };
                    $(".RadioMixFillingBody").each(function (index) {
                        item.AnswerOptions.push({ index: index + 1, AnsText: `${$(this).val()}` });
                    });
                    $("#RadioMixFillingModal").modal('hide');
                    break;
                case "CheckboxMixImage":
                    const CheckboxMixImageInput = $("#CheckboxMixImageInput").val();
                    const CheckboxMixImageCheck = $('#CheckboxMixImageCheck').is(":checked");
                    item = { index: 0, hasOtherAnswers: CheckboxMixImageCheck, QuestionID: "Question", QuestionText: `${CheckboxMixImageInput}`, QuestionType: "CheckboxMixImage", AnswerOptions: [], Answers: [], otherAnswer: [] };
                    $(".CheckboxMixImageBody").each(function (index) {
                        const imageID = Number($(this).parent('div').children("input.CheckboxMixImageHidden").val());
                        item.AnswerOptions.push({ index: index + 1, AnsText: `${$(this).val()}`, image: imageID });
                    });
                    $("#CheckboxMixImageModal").modal('hide');
                    break;
                case "CheckboxMixFilling":
                    const CheckboxMixFillingInput = $("#CheckboxMixFillingInput").val();
                    const CheckboxMixFillingCheck = $('#CheckboxMixFillingCheck').is(":checked");
                    item = { index: 0, hasOtherAnswers: CheckboxMixFillingCheck, QuestionID: "Question", QuestionText: `${CheckboxMixFillingInput}`, QuestionType: "CheckboxMixFilling", AnswerOptions: [], Answers: [], otherAnswer: [] };
                    $(".CheckboxMixFillingBody").each(function (index) {
                        item.AnswerOptions.push({ index: index + 1, AnsText: `${$(this).val()}` });
                    });
                    $("#CheckboxMixFillingModal").modal('hide');
                    break;
            }

            if (Gtype == "normal") {
                if (Qindex == 0) {
                    json.Groups[Gindex - 1].Questions.push(item);
                }
                else {
                    $.each(json.Groups[Gindex - 1].Questions, function (index) {
                        if (Qindex == this.index) {
                            json.Groups[Gindex - 1].Questions[index] = item;
                        }
                    });
                }
            }
            else {
                $.each(json.Groups[Gindex - 1].Rows, function (RowIndex) {
                    $.each(this.Cols, function (ColIndex) {
                        if (this.index == Qindex) {
                            json.Groups[Gindex - 1].Rows[RowIndex].Cols[ColIndex] = item;
                        }
                    });
                });
            }

            $("#GroupIndex").val('');
            outputJsonBox.text(JSON.stringify(json));
            sortGroupAndQuestion();
            showQuestion();
            return false;
        }

        // 移除題目
        function RemoveQuestion(Gindex, Qindex) {
            var json = jQuery.parseJSON(outputJsonBox.text());

            $.each(json.Groups[Gindex - 1].Questions, function (sn) {
                if (this.index == Qindex)
                    json.Groups[Gindex - 1].Questions.splice(sn, 1);
            });

            outputJsonBox.text(JSON.stringify(json));
            sortGroupAndQuestion();
            showQuestion();
            return false;
        }

        // 顯示目前表單
        function showQuestion() {
            var json = jQuery.parseJSON(outputJsonBox.text());
            var QHtml = "";
            var showHtml = "";
            try {
                $.each(json.Groups, function () {
                    const Gindex = this.index;
                    switch (this.GroupType) {
                        case "normal":
                            QHtml = `<table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th style="width: 10px">#</th>
                                                <th style="width: 120px">Question ID</th>
                                                <th style="width: 160px">類型</th>
                                                <th>題目</th>
                                                <th>選項</th>
                                                <th style="width: 60px;text-align: center;">變更</th>
                                                <th style="width: 60px;text-align: center;">刪除</th>
                                            </tr>
                                        </thead>
                                    <tbody>`;

                            $.each(this.Questions, function () {
                                QHtml += `<tr>
                                        <td>${this.index}.</td>
                                        <td>${this.QuestionID}</td>
                                        <td>${this.QuestionType}</td>
                                        <td>${this.QuestionText}</td>
                                        <td>`;

                                switch (this.QuestionType) {
                                    case "display":
                                        if (this.AnswerOptions.length > 0)
                                            QHtml += `<img src="showimage?SN=${this.AnswerOptions[0].image}" height="50" />`;
                                        break;
                                    case "text":
                                    case "number":
                                    case "image":
                                    case "filling":
                                    case "date":
                                    case "file":
                                        break;
                                    case "sign":
                                        if (this.rotate)
                                            QHtml += `直式顯示`;
                                        break;
                                    case "RadioMixCheckbox":
                                        $.each(this.AnswerOptions, function () {
                                            QHtml += `${this.index}.&nbsp;<input type="radio" />&nbsp;${this.AnsText}`;

                                            $.each(this.AnswerOptions, function () {
                                                QHtml += `&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" />&nbsp;${this.AnsText}`;
                                            });

                                            QHtml += "<br />";
                                        });
                                        if (this.hasOtherAnswers)
                                            QHtml += `${this.AnswerOptions.length + 1}.&nbsp;<input type="radio" />&nbsp;其他 _____`;
                                        break;
                                    case "RadioMixFilling":
                                    case "CheckboxMixFilling":
                                        $.each(this.AnswerOptions, function () {
                                            QHtml += `${this.index}.&nbsp;${this.AnsText}<br />`;
                                        });
                                        if (this.hasOtherAnswers)
                                            QHtml += `${this.AnswerOptions.length + 1}.&nbsp;其他 _____`;
                                        break;
                                    case "CheckboxMixImage":
                                        $.each(this.AnswerOptions, function () {
                                            var showimage = "";
                                            var oc = this.image;
                                            if (oc > 0)
                                                showimage = `<br />&nbsp;&nbsp;&nbsp;&nbsp;<image src="showimage?SN=${oc}" height="40" />`;
                                            QHtml += `${this.index}.&nbsp;<input type="checkbox" />&nbsp;${this.AnsText}${showimage}<br />`;
                                        });
                                        if (this.hasOtherAnswers)
                                            QHtml += `${this.AnswerOptions.length + 1}.&nbsp;<input type="checkbox" />&nbsp;其他 _____`;
                                        break;
                                    case "radio":
                                        $.each(this.AnswerOptions, function () {
                                            QHtml += `${this.index}.&nbsp;<input type="radio" />&nbsp;${this.AnsText}<br />`;
                                        });
                                        if (this.hasOtherAnswers)
                                            QHtml += `${this.AnswerOptions.length + 1}.&nbsp;<input type="radio" />&nbsp;其他 _____`;
                                        break;
                                    case "checkbox":
                                        $.each(this.AnswerOptions, function () {
                                            QHtml += `${this.index}.&nbsp;<input type="checkbox" />&nbsp;${this.AnsText}<br />`;
                                        });
                                        if (this.hasOtherAnswers)
                                            QHtml += `${this.AnswerOptions.length + 1}.&nbsp;<input type="checkbox" />&nbsp;其他 _____`;
                                        break;
                                    case "select":
                                        QHtml += `<select class="form-control">`;
                                        $.each(this.AnswerOptions, function () {
                                            QHtml += `<option>${this.AnsText}</option>`;
                                        });
                                        if (this.hasOtherAnswers)
                                            QHtml += `<option>其他</option>`;
                                        QHtml += "</select>";
                                        break;
                                    default:
                                        break;
                                }

                                QHtml += `</td>
                                        <td style="text-align: center;"><i class="fas fa-edit" style="cursor: pointer;" onclick="AddQuestionSelect(${Gindex}, ${this.index})"></i></td>
                                        <td style="text-align: center;"><i class="fas fa-trash" style="cursor: pointer;" onclick="RemoveQuestion(${Gindex}, ${this.index})"></i></td>
                                    </tr>`;
                            });

                            QHtml += `</tbody></table>`;

                            showHtml += `<div class="col-md-12">
                                            <div class="card card-primary">
                                                <div class="card-header">
                                                    <h3 class="card-title">${this.GroupName} ( ID: ${this.GroupID} Type: ${this.GroupType} )</h3>
                                                    <div class="card-tools">
                                                        <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                                            <i class="fas fa-minus"></i>
                                                        </button>
                                                        <button type="button" class="btn btn-tool" data-card-widget="remove" title="Remove" onclick="RemoveGroup(${this.index})">
                                                            <i class="fas fa-times"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                                <div class="card-body">
                                                    ${QHtml}
                                                </div>
                                                <div class="card-footer">
                                                    <a class="btn btn-app">
                                                        <i class="fas fa-plus-circle" style="cursor: pointer;" onclick="return AddQuestionSelect(${this.index}, 0);" title="Add Question"></i>
                                                        New
                                                    </a>
                                                </div>
                                            </div>
                                        </div>`;
                            break;
                        case "table":
                            QHtml = `<table class="table table-bordered">`;

                            $.each(this.Rows, function () {
                                QHtml += `<tr>`;

                                $.each(this.Cols, function () {
                                    QHtml += `<td>
                                                <div class="info-box" style="max-width: 230px;">
                                                    <span class="info-box-icon bg-info">
                                                        <i class="far fa-edit" style="cursor: pointer;" onclick="return AddQuestionSelect(${Gindex}, ${this.index});" title="Edit"></i>
                                                    </span>
                                                    <div class="info-box-content">
                                                        <span class="info-box-text text-sm"><b>${this.QuestionType}</b></span>
                                                        <span class="info-box-text text-sm" data-toggle="tooltip" data-placement="top" title data-original-title="${this.QuestionText}">${this.QuestionText}</span>
                                                    </div>
                                                </div></td>`;
                                });

                                QHtml += `</tr>`;
                            });

                            QHtml += `</table>`;

                            showHtml += `<div class="col-md-12">
                                            <div class="card card-success">
                                                <div class="card-header">
                                                    <h3 class="card-title">${this.GroupName} ( ID: ${this.GroupID} Type: ${this.GroupType} )</h3>
                                                    <div class="card-tools">
                                                        <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                                            <i class="fas fa-minus"></i>
                                                        </button>
                                                        <button type="button" class="btn btn-tool" data-card-widget="remove" title="Remove" onclick="RemoveGroup(${this.index})">
                                                            <i class="fas fa-times"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                                <div class="card-body">${QHtml}</div>
                                            </div>
                                        </div>`;
                            break;
                        case "row":
                            QHtml = `<table class="table table-bordered">`;

                            $.each(this.Rows, function () {
                                QHtml += `<tr>`;

                                $.each(this.Cols, function () {
                                    QHtml += `<td>
                                                <div class="info-box" style="max-width: 250px;">
                                                    <span class="info-box-icon bg-info">
                                                        <i class="far fa-edit" style="cursor: pointer;" onclick="return AddQuestionSelect(${Gindex}, ${this.index});"></i>
                                                    </span>
                                                    <div class="info-box-content">
                                                        <span class="info-box-text">${this.QuestionType}</span>
                                                        <span class="info-box-text" data-toggle="tooltip" data-placement="top" title data-original-title="${this.QuestionText}">${this.QuestionText}</span>
                                                    </div>
                                                </div></td>`;
                                });

                                QHtml += `</tr>`;
                            });

                            QHtml += `</table>`;

                            showHtml += `<div class="col-md-12">
                                            <div class="card card-warning">
                                                <div class="card-header">
                                                    <h3 class="card-title">${this.GroupName} ( ID: ${this.GroupID} Type: ${this.GroupType} )</h3>
                                                    <div class="card-tools">
                                                        <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                                            <i class="fas fa-minus"></i>
                                                        </button>
                                                        <button type="button" class="btn btn-tool" data-card-widget="remove" title="Remove" onclick="RemoveGroup(${this.index})">
                                                            <i class="fas fa-times"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                                <div class="card-body">${QHtml}</div>
                                            </div>
                                        </div>`;
                            break;
                    }
                });
            }
            catch (e) {
                console.error(e);
            }

            $("#QuestArea").html(showHtml);
            toolTipSet();
        }

        function toolTipSet() {
            $("[data-toggle='tooltip']").tooltip();
        }
    </script>
</asp:Content>
