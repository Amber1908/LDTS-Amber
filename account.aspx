<%@ Page Title="" Language="C#" MasterPageFile="~/LDTS.Master" AutoEventWireup="true" CodeBehind="account.aspx.cs" Inherits="LDTS.account" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <setion class="account content-header">
        <div class="accountContainer container-fluid">
            <div class="accountTitle row mb-2">
                <div class="col-sm-6">
                    <h1>編輯個人資訊</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Default">Home</a></li>
                        <li class="breadcrumb-item">編輯個人資訊</li>
                    </ol>
                </div>
            </div>
        </div>
    </setion>
    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="accountIfo col-md-4">
                    <!-- Profile Image -->
                    <div class="card card-primary card-outline">
                        <div class="card-body box-profile">
                            <div class="text-center">
                                <asp:Image ID="Mug" runat="server" CssClass="accountMug profile-user-img img-fluid" />
                            </div>
                            <div class="accountID form-group">
                                <label for="adminIDTextBox1" style="font-size: 12px; color: #00000080">帳號</label>
                                <asp:TextBox ID="adminIDTextBox1" CssClass="form-control form-control-border" runat="server"></asp:TextBox>
                            </div>
                            <div class="accountName form-group">
                                <label for="NameTextBox1" style="font-size: 12px; color: #00000080">姓名</label>
                                <asp:TextBox ID="NameTextBox1" CssClass="form-control form-control-border" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ErrorMessage="請填寫人員姓名!" ForeColor="Red" ControlToValidate="NameTextBox1"></asp:RequiredFieldValidator>
                            </div>
                            <div class="accountPhone form-group">
                                <label for="PhoneTextBox1" style="font-size: 12px; color: #00000080">手機</label>
                                <asp:TextBox ID="PhoneTextBox1" TextMode="Phone" CssClass="form-control form-control-border" runat="server" placeholder="手機格式如:0912345678"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ErrorMessage="請填寫手機!" ForeColor="Red" ControlToValidate="PhoneTextBox1"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" Display="Dynamic" ErrorMessage="手機格式不符合!" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^09[0-9]{8}$" ControlToValidate="PhoneTextBox1"></asp:RegularExpressionValidator>
                            </div>
                            <div class="accountEmail form-group">
                                <label for="EmailTextBox2" style="font-size: 12px; color: #00000080">電子信箱</label>
                                <asp:TextBox ID="EmailTextBox2" TextMode="Email" CssClass="form-control form-control-border" runat="server" placeholder="E-mail"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="電子信箱規格不符!" Display="Dynamic" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="EmailTextBox2"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="accountMain col-md-8">
                    <div class="accountMainCard card">
                        <div class="accountMainCardHeader card-header p-2">
                            <h6 class="p-1">權限</h6>
                        </div>
                        <div class="accountMainCardBody card-body">
                            <div class="form-horizontal">
                                <div class="accountMainAo form-group row">
                                    <label for="personnalManagement" style="font-size: 12px; color: #00000080"></label>
                                    <div class="col-sm-10">
                                        <asp:CheckBox runat="server" ID="personnalManagement" CssClass="mr-3 spanStatus" Text="人員管理" />
                                        <p class="accountMainAoItemTile ml-4" style="margin-bottom: -1px">權限包含:</p>
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
                                        <p class="accountMainAoItemTile ml-4" style="margin-bottom: -1px">權限包含:</p>
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
                    <div class="accountMug">
                        <div class="accountMugCard card">
                            <div class="accountMugCardHeader card-header p-2">
                                <h6 class="pt-1">上傳大頭照</h6>
                            </div>
                            <div class="accountMugCardBody card-body">
                                <div class="form-horizontal d-flex justify-content-center">
                                    <asp:Image runat="server" CssClass="accountMug img-fluid pad CardbodyMug mb-3" ID="ImageMug" Width="50%" />
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
                    <div class="accountVerify">
                        <div class="accountVerifyCard card">
                            <div class="accountVerifyCardHeader card-header p-2">
                                <h6 class="pt-1">變更驗證</h6>
                            </div>
                            <div class="accountVerifyCardBody card-body">
                                <div class="form-group row">
                                    <label for="passWords" class="col-sm-2 col-form-label">請輸入密碼</label>
                                    <div class="col-sm-10">
                                        <asp:TextBox ID="passWords" TextMode="Password" CssClass="form-control" placeholder="密碼" runat="server" ToolTip="請輸入密碼"></asp:TextBox>
                                        <font color="Red"><asp:Literal ID="msgLiteral" runat="server"></asp:Literal></font>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="請輸入密碼!" ControlToValidate="passWords" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="accountApplication d-flex justify-content-end mb-5">
                        <asp:Button runat="server" ID="SaveButton" CssClass="btn btn-primary" Text="儲存" OnClick="SaveButton_Click" />
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script>
        var body = document.querySelector(".sidebar-mini");
        body.classList.add("sidebar-collapse");

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
        var fileUpload = document.getElementById("mainPlaceHolder_FileUpload");
        fileUpload.addEventListener("change", function () {
            if (fileUpload.value.length > 0) {
                var MainContent_fileUpload = document.getElementById("mainPlaceHolder_fileNameImgEdit");
                MainContent_fileUpload.innerText = "已選擇檔案:" + fileUpload.value;
            }
        })

    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jqueryPlaceHolder" runat="server">
</asp:Content>
