<%@ Page Title="" Language="C#" MasterPageFile="~/LDTS.Master" AutoEventWireup="true" CodeBehind="StandarWorkbook.aspx.cs" Inherits="LDTS.StandarWorkbook" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <section class="StandarWorkbook content-header">
        <div class="StandarWorkbookContainer container-fluid">
            <div class="StandarWorkbookTitle row mb-2">
                <div class="col-sm-6">
                    <h1 id="title" runat="server">標準作業書</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Default">Home</a></li>
                        <li class="breadcrumb-item">標準作業書</li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="StandarWorkbookMain col-md-3">
                    <div class="card card-info card-outline">
                        <div class="card-body box-profile">
                            <!--表單範本目錄-->
                        </div>
                    </div>
                </div>
                <div class="StandarWorkbookList col-md-9" runat="server" id="SwbContainer">
                    <!--表單清單列表-->
                </div>
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jqueryPlaceHolder" runat="server">
    <script>
        var swbUploadName = document.getElementById("mainPlaceHolder_swbUploadName");
        var swbUpload = document.getElementById("mainPlaceHolder_swbUpload");
        swbUpload.addEventListener("change", function () {
            if (swbUpload.value.length > 0) {
                swbUploadName.innerText = swbUpload.value;
            }
        });

    </script>
</asp:Content>
