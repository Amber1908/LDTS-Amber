<%@ Page Title="" Language="C#" MasterPageFile="~/LDTS.Master" AutoEventWireup="true" CodeBehind="AlertSettingEdit.aspx.cs" Inherits="LDTS.AlertSettingEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <link rel="stylesheet" href="plugins/bootstrap4-duallistbox/bootstrap-duallistbox.min.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>提醒設定</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Default">Home</a></li>
                        <li class="breadcrumb-item"><a href="AlertSettingList">提醒列表</a></li>
                        <li class="breadcrumb-item">提醒設定</li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
    <!-- /.content Header -->

    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <!-- left column -->
                <div class="col-md-6">
                    <!-- jquery validation -->
                    <div class="card card-info">
                        <div class="card-header">
                            <h3 class="card-title">基本設定</h3>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" data-toggle="tooltip" title="Collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="form-group">
                                <label for="ALID">代碼</label>
                                <asp:Label ID="ALID" runat="server" CssClass="form-control" Enabled="false"></asp:Label>
                            </div>
                            <div class="form-group">
                                <label for="ALTitle">提醒說明</label>
                                <asp:TextBox ID="ALTitle" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <label for="admin_status">狀態</label>
                                <asp:RadioButtonList ID="Status" runat="server" RepeatDirection="Horizontal" CssClass="form-control" CellPadding="5" CellSpacing="10">
                                    <asp:ListItem Text="&nbsp;啟用" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="&nbsp;停用" Value="2"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                        <div class="card-footer">
                            <asp:Button ID="SEND" runat="server" CssClass="btn btn-primary" Text="Save" OnClick="SEND_Click" />
                        </div>
                    </div>
                    <!-- /.card -->
                </div>
                <!--/.col (left) -->
                <!-- right column -->
                <div class="col-md-6">
                    <div class="card card-danger">
                        <div class="card-header">
                            <h3 class="card-title">提醒條件</h3>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" data-toggle="tooltip" title="Collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="form-group">
                                <label for="admin_status">週期</label>
                                <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal" CssClass="form-control" CellPadding="5" CellSpacing="10">
                                    <asp:ListItem Text="&nbsp;年" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="&nbsp;季" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="&nbsp;月" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="&nbsp;週" Value="4"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.card -->
        </div>
        <div class="row">
            <div class="col-md-12">
                <!-- jquery validation -->
                <div class="card card-warning">
                    <div class="card-header">
                        <h3 class="card-title">關聯表單</h3>
                        <div class="card-tools">
                            <button type="button" class="btn btn-tool" data-card-widget="collapse" data-toggle="tooltip" title="Collapse">
                                <i class="fas fa-minus"></i>
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-12">
                                <div class="form-group">
                                    <label>表單選取</label>
                                    <asp:ListBox ID="formselect" runat="server" CssClass="duallistbox" multiple="multiple" SelectionMode="Multiple">
                                        <asp:ListItem Selected="True">Alabama</asp:ListItem>
                                        <asp:ListItem>Alaska</asp:ListItem>
                                        <asp:ListItem>California</asp:ListItem>
                                        <asp:ListItem>Delaware</asp:ListItem>
                                        <asp:ListItem>Tennessee</asp:ListItem>
                                        <asp:ListItem>Texas</asp:ListItem>
                                        <asp:ListItem>Washington</asp:ListItem>
                                    </asp:ListBox>
                                </div>
                            </div>
                            <!-- /.col -->
                        </div>
                    </div>
                </div>
                <!-- /.card -->
            </div>
        </div>
        </div>
    </section>
    <!-- /.Main content -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jqueryPlaceHolder" runat="server">
    <script src="plugins/bootstrap4-duallistbox/jquery.bootstrap-duallistbox.min.js"></script>
    <script>
        $(function () {
            //Bootstrap Duallistbox
            $('.duallistbox').bootstrapDualListbox();
        });
    </script>
</asp:Content>
