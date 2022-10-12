<%@ Page Title="" Language="C#" MasterPageFile="~/LDTS.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LDTS.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Home</h1>
                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6">
                    <!-- TO DO List -->
                    <div class="card card-warning" style="min-height: 500px">
                        <div class="card-header ui-sortable-handle">
                            <h3 class="card-title">
                                <i class="fa fa-bell mr-1"></i>
                                To Do List
                            </h3>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.card-header -->
                        <div id="TodoDiv" class="card-body" runat="server">
                        </div>
                        <!-- /.card-body -->
                        <div class="card-footer clearfix">
                        </div>
                    </div>
                    <!-- /.card -->
                </div>
                <div class="col-md-6">
                    <div class="card card-info" style="min-height: 500px">
                        <div class="card-header ui-sortable-handle">
                            <h3 class="card-title">
                                <i class="fa fa-sticky-note mr-1"></i>
                                待簽核表單
                            </h3>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.card-header -->
                        <div id="UnsignDiv" class="card-body" runat="server">
                        </div>
                        <!-- /.card-body -->
                        <div class="card-footer clearfix">
                        </div>
                    </div>
                    <!-- /.card -->
                </div>
            </div>
        </div>
    </section>
    <!-- /.content -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jqueryPlaceHolder" runat="server">
    <script src="https://cdn.staticfile.org/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
    <script>
        // Alert cookie 處理
        $(function () {
            $.each($("#<%= TodoDiv.ClientID %> input"), function () {
                if (typeof $.cookie($(this).attr("id")) !== 'undefined')
                    $(this).prop('checked', 'checked');
            });

            $("#<%= TodoDiv.ClientID %> input").click(function () {
                // alert($(this).attr("id") + '-' + $(this).attr("expire") + '-' + $(this).prop('checked'));
                if ($(this).prop('checked')) {
                    $.cookie($(this).attr("id"), $(this).attr("id"), { expires: Number($(this).attr("expire")) });
                }
                else {
                    $.removeCookie($(this).attr("id"));
                }
            });
        });
    </script>
</asp:Content>
