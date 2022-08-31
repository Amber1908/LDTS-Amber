<%@ Page Title="" Language="C#" MasterPageFile="~/LDTS.Master" AutoEventWireup="true" CodeBehind="Process.aspx.cs" Inherits="LDTS.Processes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <section class="processes content-header">
        <div class="processesContainer container-fluid">
            <div class="processesTitle row mb-2">
                <div class="col-sm-6">
                    <h1>程序書</h1>
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
                <div class="processesMain col-md-3">
                    <div class="card card-primary card-outline">
                        <div class="card-body box-profile">
                            <div class="text-center">
                                <i class="fas fa-book" style="font-size: 30px"></i>
                            </div>
                            <div class="processesMainName form-group text-center p-2">
                                <asp:Label ID="ProcessName" runat="server" Font-Size="Large" ></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="processesList col-md-9" runat="server" id="ProcessContainer">

                </div>
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jqueryPlaceHolder" runat="server">
</asp:Content>
