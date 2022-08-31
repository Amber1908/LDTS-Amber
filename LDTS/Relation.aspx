<%@ Page Title="" Language="C#" MasterPageFile="~/LDTS.Master" AutoEventWireup="true" CodeBehind="Relation.aspx.cs" Inherits="LDTS.Relation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <section class="relation content-header">
        <div class="relationContainer container-fluid">
            <div class="relationTitle row mb-2">
                <div class="col-sm-6">
                    <h1>程序書關聯設定</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Default">Home</a></li>
                        <li class="breadcrumb-item">程序書關聯設定</li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="container-fluid">
            <div class="card">
                <div class="relationMain col-md-12">
                    <div class="relationMainCardHeader card-header">
                        <span>目前選取:</span>
                        <input type="text" id="processID" runat="server" class="d-none" value="" />
                        <asp:TextBox runat="server" TextMode="MultiLine" CssClass="d-none" ID="AllReProcessForms"></asp:TextBox>
                        <asp:TextBox runat="server" TextMode="MultiLine" CssClass="d-none" ID="AllReProSwb"></asp:TextBox>
                        <input type="text" id="sworkbookID" runat="server" class="d-none" value="" />
                        <asp:TextBox runat="server" TextMode="MultiLine" CssClass="d-none" ID="AllReSwbF"></asp:TextBox>
                        <asp:Label runat="server" CssClass="m-0 font-weight-bold " ID="current"></asp:Label>
                        <asp:Label runat="server" CssClass="m-0 font-weight-bold text-primary" ID="currentDetail"></asp:Label>
                    </div>
                </div>
                <div class="relationMainCardBody card-body">
                    <div class="row">
                        <div class="col-4">
                            <h5 class=" font-weight-bold text-primary"><a href="Relation.aspx" style="text-decoration: none">程序書清單</a></h5>
                        </div>
                        <div class="col-4">
                            <h5 class="pt-3 font-weight-bold text-primary">標準作業書清單</h5>
                            <input type="checkbox" id="AllSworkbooks" name="AllSworkbooks" />
                            <label for="AllSworkbooks">全選標準作業書</label>
                        </div>
                        <div class="col-4">
                            <h5 class="pt-5 font-weight-bold text-primary">表單清單</h5>
                            <input type="checkbox" id="Allforms" name="Allforms" />
                            <label for="Allforms">全選表單</label>
                        </div>
                    </div>
                    <div class="row">
                        <div id="processStr" runat="server" class="col-4  border-right border-primary">
                        </div>
                        <div id="standar" runat="server" class="col-4  border-right border-primary">
                        </div>
                        <div id="form" runat="server" class="col-4">
                        </div>
                    </div>
                    <div class="row position-relative">
                        <div id="processAdd" class="col-4">
                            <a aria-readonly="true" href="AddProcess.aspx" class=" btn btn-facebook btn-block" style="left: 0px; bottom: 0px">
                                <i class="fas fa-plus-circle">新增程序書</i>
                            </a>
                        </div>
                        <div id="standardAdd" class="col-4">
                            <a href="AddSWorkBook.aspx" class=" btn btn-facebook btn-block" style="left: 0px; bottom: 0px">
                                <i class="fas fa-plus-circle">新增標準書</i>
                            </a>
                        </div>
                        <div id="formAdd" class="col-4">
                            <a href="#" class=" btn btn-facebook btn-block" style="left: 0px; bottom: 0px">
                                <i class="fas fa-plus-circle">新表單</i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jqueryPlaceHolder" runat="server">
</asp:Content>
