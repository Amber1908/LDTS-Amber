<%@ Page Title="" Language="C#" MasterPageFile="~/LDTS.Master" AutoEventWireup="true" CodeBehind="PersonnelManagement.aspx.cs" Inherits="LDTS.PersonnelManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <!-- Content Header (Page header) -->
    <section class="personnelManagement content-header">
        <div class="personnelManagementContainer container-fluid">
            <div class="personnelManagementTitle row mb-2">
                <div class="col-sm-6">
                    <h1>人員新增</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Default.aspx">Home</a></li>
                        <li class="breadcrumb-item">人員新增</li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
    <!-- Content Header (Page header) -->
    <!-- Main content -->
    <section class="personnelManagementIfo content">
        <div class="personnelManagementContainer container-fluid">
            <div class="row">
                <div class="personnelManagementIfo col-md-4">
                    <div class="card card-primary card-outline">
                        <div class="card-body box-profile">
                            <div class="text-center">
                                <img id="Mug" runat="server" class="personnelManagementIfoMug profile-user-img img-fluid" src="dist/img/default-150x150.png" />
                            </div>
                            <div class="personnelManagementIfoName form-group">
                                <label for="Name" style="font-size: 12px; color: #00000080">姓名</label>
                                <asp:TextBox ID="Name" runat="server" CssClass="form-control form-control-border"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator" runat="server" Display="Dynamic" ErrorMessage="請填寫人員姓名!" ForeColor="Red" ControlToValidate="Name"></asp:RequiredFieldValidator>
                            </div>
                            <div class="personnelManagementIfoAdmndID form-group">
                                <label for="AdmndID" style="font-size: 12px; color: #00000080">帳號</label>
                                <asp:TextBox ID="AdmndID" runat="server" CssClass="form-control form-control-border"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="請填寫帳號!" ForeColor="Red" ControlToValidate="AdmndID"></asp:RequiredFieldValidator>

                            </div>
                            <div class="personnelManagementIfoStatus form-group">
                                <label for="status" style="font-size: 12px; color: #00000080">人員狀態</label>
                                <asp:RadioButton ID="statusSetNotWork" CssClass="ml-3 mr-3" runat="server" GroupName="status" Text="停用" TabIndex="0" />
                                <asp:RadioButton ID="statusSetNormal" CssClass="mr-3" runat="server" GroupName="status" Text="正常" TabIndex="1" />
                            </div>
                            <div class="personnelManagementIfoMemo form-group">
                                <label for="memoTextbox" style="font-size: 12px; color: #00000080">備註</label>
                                <asp:TextBox ID="memoTextbox" CssClass="myMemoTextbox form-control" Rows="5" TextMode="MultiLine" runat="server"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="personnelManagementMain col-md-8">
                    <div class="personnelManagementMainCard card">
                        <div class="personnelManagementMainMain CardHeader card-header p-2">
                            <h6 class="p-1">基本資料</h6>
                        </div>
                        <div class="personnelManagementMainCardBody card-body">
                            <div class="form-horizontal">
                                <div class="personnelManagementMainPhone form-group row">
                                    <label for="PhoneTextBox1" class="col-sm-2 col-form-label">手機</label>
                                    <div class="col-sm-10">
                                        <asp:TextBox ID="PhoneTextBox1" TextMode="Phone" CssClass="form-control" runat="server" placeholder="手機格式如:0912345678"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ErrorMessage="請填寫手機!" ForeColor="Red" ControlToValidate="PhoneTextBox1"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" Display="Dynamic" ErrorMessage="手機格式不符合!" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^09[0-9]{8}$" ControlToValidate="PhoneTextBox1"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                <div class="personnelManagementMainEmail form-group row">
                                    <label for="Email" class="col-sm-2 col-form-label">Email</label>
                                    <div class="col-sm-10">
                                        <asp:TextBox ID="EmailTextBox2" TextMode="Email" CssClass="form-control" runat="server" placeholder="E-mail"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="電子信箱規格不符!" Display="Dynamic" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="EmailTextBox2"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                <div class="personnelManagementMainAo form-group row">
                                    <label for="personnalManagement" class="col-sm-2 col-form-label">權限</label>
                                    <div class="col-sm-10">
                                        <asp:CheckBox runat="server" ID="personnalManagement" CssClass="AoPerson mr-3 spanStatus" Text="人員管理" />
                                        <p class="personEditMainItemTile ml-4" style="margin-bottom: -1px">權限包含:</p>
                                        <div class="ml-4 mb-3">
                                            <div>
                                                <div>
                                                    <i class="fa-solid fa-check fa" style="font-size: 12pt"></i><span class="ml-2">新增人員</span>
                                                </div>
                                                <div>
                                                    <i class="fa-solid fa-check fa"></i><span class="ml-2">設定人員權限</span>
                                                </div>
                                            </div>
                                            <div>
                                                <div>
                                                    <i class="fa-solid fa-check fa"></i><span class="ml-2">刪除人員</span>
                                                </div>
                                                <div>
                                                    <i class="fa-solid fa-check fa"></i><span class="ml-2">單位基本資料設定</span>
                                                </div>
                                            </div>
                                        </div>
                                        <asp:CheckBox runat="server" ID="formManagement" CssClass="mt-3 mr-3 AoForm spanStatus" Text="表單管理" />
                                        <p class="personEditMainItemTile ml-4" style="margin-bottom: -1px">權限包含:</p>
                                        <div class="ml-4">
                                            <div>
                                                <div>
                                                    <i class="fa-solid fa-check fa" style="font-size: 12pt"></i><span class="ml-2">表單產生器(含上傳報表)</span>
                                                </div>
                                                <div>
                                                    <i class="fa-solid fa-check fa"></i><span class="ml-2">程序書清單建立</span>
                                                </div>
                                            </div>
                                            <div>
                                                <div>
                                                    <i class="fa-solid fa-check fa"></i><span class="ml-2">建立程序書與表單關係</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="personnelManagementMainUploadSign ">
                        <div class="personnelManagementMainUploadCard card">
                            <div class="personnelManagementMainUploadCardHeader card-header p-2">
                                <h6 class="pt-1">上傳簽名檔</h6>
                            </div>
                            <div class="personnelManagementMainUploadCardBody card-body">
                                <div class="form-horizontal d-flex justify-content-center">
                                    <asp:Image runat="server" CssClass="img-fluid pad mb-3" ID="signImg" Height="200px" />
                                </div>
                                <div class="personnelManagementMainUpload form-group row">
                                    <label for="signNameUpload" class="col-sm-2 col-form-label">上傳簽名</label>
                                    <div class="col-sm-10">
                                        <div class="input-group">
                                            <div class="signName custom-file">
                                                <asp:FileUpload ID="signNameUpload" CssClass="custom-file-input Upload" runat="server" />
                                                <asp:Label ID="signNameEdit" runat="server" CssClass="custom-file-label">選擇簽名檔</asp:Label>
                                            </div>
                                            <div class="input-group-append">
                                                <span class="input-group-text" onclick="showImg(event)">確認</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="personnelManagementMainMug">
                        <div class="personnelManagementMainMugCard card">
                            <div class="personnelManagementMainMugCardHeader card-header p-2">
                                <h6 class="pt-1">上傳大頭照</h6>
                            </div>
                            <div class="personnelManagementMainMugCardBody card-body">
                                <div class="form-horizontal d-flex justify-content-center">
                                    <asp:Image runat="server" CssClass="personEditIfoMug img-fluid pad CardbodyMug mb-3" ID="ImageMug" Width="50%" />
                                </div>
                                <div class="form-group row">
                                    <label for="MugUpload" class="col-sm-2 col-form-label">上傳大頭照</label>
                                    <div class="col-sm-10">
                                        <div class="input-group">
                                            <div class="Mug custom-file">
                                                <asp:FileUpload ID="FileUpload" CssClass="custom-file-input Upload" runat="server" />
                                                <asp:Label ID="fileNameImgEdit" runat="server" CssClass="custom-file-label">選擇照片</asp:Label>
                                            </div>
                                            <div class="input-group-append">
                                                <span class="input-group-text" onclick="showMug(event)">確認</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="personnelManagementMainApplication d-flex justify-content-end mb-5">
                        <asp:Button runat="server" ID="SaveButton" CssClass="btn btn-primary" Text="儲存" OnClick="SaveButton_Click"/>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Main content -->
    <script>
        function showMug(event) {
            var father = event.currentTarget.parentNode.parentNode;
            var input = father.querySelector(".Upload");
            var reader = new FileReader();
            reader.readAsDataURL(input.files[0]);
            reader.onload = function () {
                var Url = reader.result;
                var Mug = document.getElementById("mainPlaceHolder_ImageMug");
                Mug.src = Url;
                //    Mug.classList.remove("d-none");
            }
        }
        function showImg(event) {
            var father = event.currentTarget.parentNode.parentNode;
            var input = father.querySelector(".Upload");
            var reader = new FileReader();
            reader.readAsDataURL(input.files[0]);
            reader.onload = function () {
                var Url = reader.result;
                var img = document.getElementById("mainPlaceHolder_signImg");
                img.src = Url;
            }
        }
        var FileUpload = document.getElementById("mainPlaceHolder_FileUpload");
        FileUpload.addEventListener('change', function () {
            if (FileUpload.value.length > 0) {
                var fileNameImgEdit = document.getElementById("mainPlaceHolder_fileNameImgEdit");
                fileNameImgEdit.innerText = "已選擇檔案:" + FileUpload.value;
            }
        })

        var signNameUpload = document.getElementById("mainPlaceHolder_signNameUpload");
        signNameUpload.addEventListener('change', function () {
            if (signNameUpload.value.length > 0) {
                var MainContent_signName = document.getElementById("mainPlaceHolder_signNameEdit");
                MainContent_signName.innerText = "已選擇檔案:" + signNameUpload.value;
            }
        })

    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jqueryPlaceHolder" runat="server">
</asp:Content>
