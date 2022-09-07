<%@ Page Title="" Language="C#" MasterPageFile="~/LDTS.Master" AutoEventWireup="true" CodeBehind="ReportAnswerSearch.aspx.cs" Inherits="LDTS.ReportAnswerSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>關聯表單搜尋</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Default">Home</a></li>
                        <li class="breadcrumb-item">關聯表單搜尋</li>
                    </ol>
                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="input-group col-md-12">
                    <asp:TextBox ID="searchText" runat="server" CssClass="form-control form-control-lg" placeholder="請輸入關鍵字"></asp:TextBox>
                    <div class="input-group-append">
                        <button id="search" runat="server" Class="btn btn-lg btn-default" onclick="return checkText();"><i class='fa fa-search'></i></button>
                    </div>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-md-12">
                    <!-- TO DO List -->
                    <div class="card card-info" style="min-height: 500px">
                        <div class="card-header">
                            <h3 class="card-title">
                                <i class="fa fa-list-ul"></i>
                                Report Answer List
                            </h3>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.card-header -->
                        <div id="SearchDiv" class="card-body" runat="server">
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
    <script>
        function checkText() {
            const txt = $("#<%= searchText.ClientID %>");

            txt.removeClass("is-invalid");
            if (txt.val() == '') {
                txt.addClass("is-invalid");
                txt.focus();
                return false;
            }
            
            return true;
        }
    </script>
</asp:Content>
