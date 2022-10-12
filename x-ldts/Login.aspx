<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LDTS.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" lang="zh-tw">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>LDTS | Login</title>
    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css" />
    <!-- icheck bootstrap -->
    <link rel="stylesheet" href="plugins/icheck-bootstrap/icheck-bootstrap.min.css" />
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/adminlte.css" />
</head>
<body class="hold-transition login-page">
    <form id="form1" runat="server">
        <div class="login-box">
            <div class="login-logo">
                <a href="#"><b>LDTS</b>管理系統</a>
            </div>
            <!-- /.login-logo -->
            <div class="card">
                <div class="card-body login-card-body">
                    <p class="login-box-msg">Sign in to start your session</p>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="accountTextbox" Display="Dynamic" ErrorMessage="請填帳號!" ForeColor="Red"></asp:RequiredFieldValidator>
                    <div class="input-group mb-3">
                        <asp:TextBox ID="accountTextbox" CssClass="form-control form-control-user" placeholder="帳號" runat="server" ToolTip="請輸入帳號"></asp:TextBox>
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-user"></span>
                            </div>
                        </div>
                    </div>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="請輸入密碼!" ControlToValidate="passwordTextBox1" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="密碼格式錯誤!" ControlToValidate="passwordTextBox1" Display="Dynamic" ForeColor="Red" ValidationExpression="^[a-zA-Z\d]{4}$"></asp:RegularExpressionValidator>
                    <div class="input-group mb-3">
                        <asp:TextBox ID="passwordTextBox1" TextMode="Password" CssClass="form-control" placeholder="密碼" runat="server" ToolTip="請輸入密碼"></asp:TextBox>
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-8">
                            <div class="icheck-primary">
                                <input type="checkbox" id="remember"/>
                                <asp:CheckBox ID="rememberCheckBox1" runat="server" />
                                <label for="rememberCheckBox1">
                                    記住我
                                </label>
                            </div>
                        </div>
                        <!-- /.col -->
                        <div class="col-4">
                            <asp:Button ID="loginButton1" CssClass="btn btn-primary btn-block" runat="server" Text="登入" OnClick="loginButton1_Click" />
                        </div>
                        <font color="Red"><asp:Literal ID="msgLiteral" runat="server"></asp:Literal></font>
                        <!-- /.col -->
                    </div>
                </div>
                <!-- /.login-card-body -->
            </div>
        </div>
        <!-- /.login-box -->
    </form>
    <!-- jQuery -->
    <script src="plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/adminlte.min.js"></script>
</body>
</html>
