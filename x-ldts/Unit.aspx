<%@ Page Title="" Language="C#" MasterPageFile="~/LDTS.Master" AutoEventWireup="true" CodeBehind="Unit.aspx.cs" Inherits="LDTS.Unit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <section class="Unit content-header">
        <div class="Unitcontainer container-fluid">
            <div class="UnitTitle row mb-2">
                <div class="col-sm-6">
                    <h1>單位資訊</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Default">Home</a></li>
                        <li class="breadcrumb-item"><a href="Unit">單位資訊</a></li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="UnitMain col-md-4 ">
                    <div class="card card-primary card-outline">
                        <div class="card-body box-profile">
                            <div class="text-center">
                                <img id="logo" runat="server" class="img-circle profile-user-img img-fluid" src="~/dist/img/default-150x150.png" />
                                <asp:TextBox runat="server" ID="url" CssClass="d-none"></asp:TextBox>
                            </div>
                            <div class="UnitMainName form-group">
                                <label for="UnitNameTextBox1" style="font-size: 12px; color: #00000080">單位名稱</label>
                                <asp:TextBox ID="UnitNameTextBox1" CssClass="form-control form-control-border" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="請填寫單位名稱!" ForeColor="Red" ControlToValidate="UnitNameTextBox1"></asp:RequiredFieldValidator>
                            </div>
                            <div class="UnitMainID form-group">
                                <label for="IDTextBox1" style="font-size: 12px; color: #00000080">單位統編</label>
                                <asp:TextBox ID="IDTextBox1" CssClass="form-control form-control-border" runat="server"></asp:TextBox>
                            </div>
                            <div class="UnitMainPhone form-group">
                                <label for="PhoneTextBox1" style="font-size: 12px; color: #00000080">單位電話</label>
                                <asp:TextBox ID="PhoneTextBox1" TextMode="Phone" CssClass="form-control form-control-border" runat="server" placeholder="格式如:29474703"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" Display="Dynamic" ErrorMessage="電話格式不符合!" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^[2-8][0-9]{7}$" ControlToValidate="PhoneTextBox1"></asp:RegularExpressionValidator>
                            </div>
                            <div class="UnitMainAddr form-group">
                                <label for="AddrTextBox1" style="font-size: 12px; color: #00000080">單位地址</label>
                                <asp:TextBox ID="AddrTextBox1" CssClass="form-control form-control-border" runat="server"></asp:TextBox>
                            </div>
                            <div class="UnitEmail form-group">
                                <label for="EmailTextBox2" style="font-size: 12px; color: #00000080">電子信箱</label>
                                <asp:TextBox ID="EmailTextBox2" TextMode="Email" CssClass="form-control  form-control-border" runat="server" placeholder="E-mail"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="電子信箱規格不符!" Display="Dynamic" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="EmailTextBox2"></asp:RegularExpressionValidator>
                            </div>
                            <div class="UnitDes">
                                <label for="DesTextbox" style="font-size: 12px; color: #00000080">單位描述</label>
                                <asp:TextBox ID="DesTextbox" CssClass="myMemoTextbox form-control" Rows="5" TextMode="MultiLine" runat="server"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="UnitBoss col-md-8">
                    <div class="UnitBossCard card">
                        <div class="UnitBossCardHeader card-header">
                            <h6 class="p-1">單位代表人資訊</h6>
                        </div>
                        <div class="UnitBossCardBody card-body">
                            <div class="form-horizontal">
                                <div class="UnitBoss form-group row">
                                    <label for="BossTextBox" class="col-sm-2 col-form-label">代表人</label>
                                    <div class="col-sm-10">
                                        <asp:TextBox ID="BossTextBox" CssClass="form-control" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="UnitBossPhone form-group row">
                                    <label for="BossPhone" class="col-sm-2 col-form-label">代表電話</label>
                                    <div class="col-sm-10">
                                        <asp:TextBox ID="BossPhone" placeholder="格式如:0952281033" TextMode="Phone" CssClass="form-control" runat="server"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" Display="Dynamic" ErrorMessage="電話格式不符合!" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^09[0-9]{8}$" ControlToValidate="BossPhone"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                <div class="UnitBossEmail form-group row">
                                    <label for="BossEmail" class="col-sm-2 col-form-label">代表電子信箱</label>
                                    <div class="col-sm-10">
                                        <asp:TextBox ID="BossEmail" TextMode="Email" CssClass=" form-control" placeholder="E-mail" runat="server"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" Display="Dynamic" ErrorMessage="電子信箱格式不符合!" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="BossEmail"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="UnitContact">
                        <div class="UnitContactCard card">
                            <div class="UnitContactCardHeader card-header">
                                <h6>單位連絡人資訊</h6>
                            </div>
                            <div class="UnitContactCardBody card-body">
                                <div class="form-horizontal">
                                    <div class="UnitContact form-group row">
                                        <label for="ContactTextbox" class="col-sm-2 col-form-label">單位連絡人</label>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="ContactTextbox" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="UnitContactPhone form-group row">
                                        <label for="ContactPhoneTexBox" class="col-sm-2 col-form-label">連絡人電話</label>
                                        <div class="col-sm-10">
                                            <asp:TextBox runat="server" TextMode="Phone" ID="ContactPhoneTexBox" CssClass="form-control " placeholder="格式如:29474703"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" Display="Dynamic" ErrorMessage="電話格式不符合!" ForeColor="Red" SetFocusOnError="True" ValidationExpression="^[2-8][0-9]{7}$" ControlToValidate="ContactPhoneTexBox"></asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                    <div class="UnitContactEmail form-group row">
                                        <label for="ContactMailTextbox" class="col-sm-2 col-form-label">聯絡人信箱</label>
                                        <div class="col-sm-10">
                                            <asp:TextBox runat="server" TextMode="Email" ID="ContactMailTextbox" CssClass="form-control" placeholder="E-mail"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" Display="Dynamic" ErrorMessage="電子信箱格式不符合!" ForeColor="Red" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="ContactMailTextbox"></asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="UnitLogo">
                        <div class="UnitLogoCard card">
                            <div class="UnitLogoCardHeader card-header">
                                <h6>上傳單位LOGO</h6>
                            </div>
                            <div class="UnitLogoCardBody card-body">
                                <div class="form-horizontal d-flex justify-content-center">
                                    <asp:Image runat="server" CssClass="mb-3 img-fluid" ID="UnitLogo" Width="25%" ImageUrl="dist/img/default-150x150.png" />
                                </div>
                                <div class="UnitLogoUpload form-group row">
                                    <label for="UnitLogo" class="col-sm-2 col-form-label">上傳單位LOGO</label>
                                    <div class="col-sm-10">
                                        <div class="input-group">
                                            <div class="UnitLogofile custom-file">
                                                <asp:FileUpload ID="FileUpload" CssClass="custom-file-input Upload" runat="server" OnPreRender="Page_Load" />
                                                <asp:Label ID="fileNameImg" runat="server" CssClass="custom-file-label">上傳LOGO圖</asp:Label>
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
                    <div class="UnitApplication d-flex justify-content-end mb-5">
                        <asp:Button  runat="server" ID="SaveButton" CssClass="btn btn-primary" Text="儲存" OnClick="SaveButton_Click"/>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script>
        var body = document.querySelector(".sidebar-mini");
        body.classList.add("sidebar-collapse");

        function showImg(event) {
            var father = event.currentTarget.parentNode.parentNode;
            var input = father.querySelector(".Upload");
            var reader = new FileReader();
            reader.readAsDataURL(input.files[0]);
            reader.onload = function () {
                var Url = reader.result;
                var img = document.getElementById("mainPlaceHolder_UnitLogo");
                img.src = Url;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jqueryPlaceHolder" runat="server">
</asp:Content>
