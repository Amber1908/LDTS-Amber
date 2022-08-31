<%@ Page Title="" Language="C#" MasterPageFile="~/LDTS.Master" AutoEventWireup="true" CodeBehind="StandarWorkbook.aspx.cs" Inherits="LDTS.StandarWorkbook" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <section class="StandarWorkbook content-header">
        <div class="StandarWorkbookContainer container-fluid">
            <div class="StandarWorkbookTitle row mb-2">
                <div class="col-sm-6">
                    <h1>標準作業書</h1>
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
                    <div class="card card-success card-outline">
                        <div class="card-body box-profile">
                            <div class="text-center">
                                <i class="fas fa-book-open" style="font-size: 30px"></i>
                            </div>
                            <div class="StandarWorkbookMainName form-group text-center p-2">
                                <asp:Label  ID="SwbName" runat="server" Font-Size="Large"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="StandarWorkbookList col-md-9" runat="server" id="SwbContainer">

                </div>
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jqueryPlaceHolder" runat="server">
</asp:Content>
