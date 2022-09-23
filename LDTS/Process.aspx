<%@ Page Title="" Language="C#" MasterPageFile="~/LDTS.Master" AutoEventWireup="true" CodeBehind="Process.aspx.cs" Inherits="LDTS.Processes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <section class="processes content-header">
        <div class="processesContainer container-fluid">
            <div  class="processesTitle row mb-2">
                <div class="col-sm-6">
                    <h1 id="title" runat="server">程序書</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Default">Home</a></li>
                        <li class="breadcrumb-item">程序書</li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div id="processesInf" runat="server" class="processesMain col-md-3">
                    <div class="card card-primary card-outline">
                        <div class="card-body box-profile">
                            <!--表單範本目錄-->
                        </div>
                    </div>
                </div>
                <div  class="processesList col-md-9" runat="server" id="ProcessContainer">
                            <!--表單清單列表-->
                </div>
            </div>
        </div>
        <asp:TextBox runat="server" ID="Ao" CssClass="d-none" ></asp:TextBox>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jqueryPlaceHolder" runat="server">
    <script>
        let rawUrl = window.location.href;
        console.log("rawUrl:" + rawUrl);
        document.cookie = "proUrl=" + window.location.href;
    </script>
</asp:Content>
