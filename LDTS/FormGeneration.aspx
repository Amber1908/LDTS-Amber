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
                                    <td width="60%">
                                        <div class="form-group">
                                            <label for="FormTitle">表單名稱</label>
                                            <asp:TextBox ID="FormTitle" runat="server" CssClass="form-control" placeholder="表單名稱"></asp:TextBox>
                                        </div>
                                    </td>
                                    <td width="15%">
                                        <div class="form-group">
                                            <label for="Version">表單版本</label>
                                            <asp:TextBox ID="Version" runat="server" CssClass="form-control" Text="1.0"></asp:TextBox>
                                        </div>
                                    </td>
                                    <%--                                <td >
                                    <div class="form-group">
                                        <label for="PrintTemplate">表單列印範本</label>
                                        <asp:HiddenField ID="TemplateFile" runat="server" Value="" />
                                        <asp:FileUpload ID="PrintTemplate" runat="server" CssClass="form-control" placeholder="表單列印範本"></asp:FileUpload>
                                    </div>
                                </td>--%>
                                    <td width="20%">
                                        <div class="form-group">
                                            <label for="Status">表單狀態</label>
                                            <asp:RadioButtonList ID="Status" runat="server" RepeatDirection="Horizontal">
                                                <asp:ListItem Text="正常" Value="1" Selected="True"></asp:ListItem>
                                                <asp:ListItem Text="停用" Value="2"></asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </td>
                                    <td>
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
                            <div class="formVerList pt-1 col-md-3">
                                <div class="form-group">
                                    <label for="PrintTemplate">表單列印範本</label>
                                    <asp:HiddenField ID="TemplateFile" runat="server" Value="" />
                                    <asp:FileUpload ID="PrintTemplate" runat="server" CssClass="form-control" placeholder="表單列印範本"></asp:FileUpload>
                                </div>
                                <div id="VersGroup" runat="server" class="form-group">
                                    <label for="Verlist" class="d-block">下載表單列印範本</label>
                                </div>
<%--                                <label for="Verlist" class="d-block">下載表單列印範本</label>
                                <asp:DropDownList runat="server" ID="vers" CssClass="form-control d-inline" Width="80%"></asp:DropDownList>
                                <a id="downloadVer" runat="server" class="btn-sm btn btn-info ml-3 pl-2 pr-2 pt-2">下載表單列印範本</a>--%>
<%--                                <select class="table-responsive p-0" id="Verlist" runat="server" style="height: 150px;">
                                </select>--%>
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
                        <option value="filling">filling</option>
                        <option value="date">date</option>
                        <option value="file">file</option>
                        <option value="RadioMixCheckbox">RadioMixCheckbox</option>
                        <option value="RadioMixFilling">RadioMixFilling</option>
                        <option value="CheckboxMixImage">CheckboxMixImage</option>
                        <option value="CheckboxMixFilling">CheckboxMixFilling</option>
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
    <!-- radio Modal -->
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
    <!-- checkbox Modal -->
    <div class="modal fade" id="checkboxModal" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="checkboxModalTitle">checkbox</h5>
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
    <!-- select Modal -->
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
    <!-- RadioMixFilling Modal -->
    <div class="modal fade" id="RadioMixFillingModal" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="RadioMixFillingModalTitle">RadioMixFilling</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-inline">
                        <input id="RadioMixFillingInput" type="text" class="form-control w-75" placeholder="請輸入題目" />
                        <div class="form-check ml-3">
                            <input type="checkbox" class="form-check-input" id="RadioMixFillingCheck">
                            <label class="form-check-label" for="radioCheck">包含其他選項</label>
                        </div>
                    </div>
                    <hr />
                    <button type="button" class="btn btn-block btn-outline-info btn-sm" onclick="return AddOption('RadioMixFillingBody')">添加選項</button>
                    <span class="text-info">填充位置請以
                        <label class="text-danger">##^n</label>
                        來表示，例如: 檢體大小
                        <label class="text-danger">##^1</label>
                        x
                        <label class="text-danger">##^2</label>
                        。</span>
                    <div id="RadioMixFillingBody" class="mt-2">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="return SaveQuestion('RadioMixFilling')">Save changes</button>
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
    <!-- CheckboxMixFilling Modal -->
    <div class="modal fade" id="CheckboxMixFillingModal" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="CheckboxMixFillingModalTitle">CheckboxMixFilling</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-inline">
                        <input id="CheckboxMixFillingInput" type="text" class="form-control w-75" placeholder="請輸入題目" />
                        <div class="form-check ml-3">
                            <input type="checkbox" class="form-check-input" id="CheckboxMixFillingCheck">
                            <label class="form-check-label" for="radioCheck">包含其他選項</label>
                        </div>
                    </div>
                    <hr />
                    <button type="button" class="btn btn-block btn-outline-info btn-sm" onclick="return AddOption('CheckboxMixFillingBody')">添加選項</button>
                    <span class="text-info">填充位置請以
                        <label class="text-danger">##^n</label>
                        來表示，例如: 檢體大小
                        <label class="text-danger">##^1</label>
                        x
                        <label class="text-danger">##^2</label>
                        。</span>
                    <div id="CheckboxMixFillingBody" class="mt-2">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="return SaveQuestion('CheckboxMixFilling')">Save changes</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jqueryPlaceHolder" runat="server">
    <script>
        const outputJsonBox = $("#<%= OutputJson.ClientID %>");
        showQuestion();

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
