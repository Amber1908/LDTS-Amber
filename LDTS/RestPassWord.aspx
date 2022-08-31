<%@ Page Title="" Language="C#" MasterPageFile="~/LDTS.Master" AutoEventWireup="true" CodeBehind="RestPassWord.aspx.cs" Inherits="LDTS.RestPassWord" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <section class="restPassWord content-header">
        <div class="restPassWordContainer container-fluid">
            <div class="restPassWordTitle row mb-2">
                <div class="col-sm-6">
                    <h1>重設密碼</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Default">Home</a></li>
                        <li class="breadcrumb-item">重設密碼</li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-4">
                    <div class="card card-primary card-outline">
                        <div class="card-body box-profile">
                            <div class="oldPsw form-group">
                                <label for="PassWord" style="font-size: 12px; color: #00000080">原密碼</label>
                                <asp:TextBox ID="PassWord" runat="server" TextMode="Password" CssClass="form-control form-control-border"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="請輸入密碼!" ControlToValidate="PassWord" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                            <div class="newPsw form-group">
                                <label for="NewPsw" style="font-size: 12px; color: #00000080">新密碼</label>
                                <asp:TextBox runat="server" ID="NewPsw" TextMode="Password" CssClass="form-control form-control-border"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="請輸入密碼!" ControlToValidate="NewPsw" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                            <div class="confirmPsw form-group">
                                <label for="confirmPassWord" style="font-size: 12px; color: #00000080">新密碼</label>
                                <asp:TextBox runat="server" ID="confirmPassWord" TextMode="Password" CssClass="form-control form-control-border"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="請輸入密碼!" ControlToValidate="confirmPassWord" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:Label runat="server" ID="Errmsg" ForeColor="Red"></asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="restPassWordApplication d-flex justify-content-end mb-5">
                        <asp:Button runat="server" ID="SaveButton" CssClass="btn btn-primary" Text="儲存" OnClick="SaveButton_Click" />
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script>
        var body = document.querySelector(".sidebar-mini");
        body.classList.add("sidebar-collapse");
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jqueryPlaceHolder" runat="server">
</asp:Content>
