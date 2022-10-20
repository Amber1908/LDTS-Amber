<%@ Page Title="" Language="C#" MasterPageFile="~/LDTS.Master" AutoEventWireup="true" CodeBehind="StandarWorkbookAdd.aspx.cs" Inherits="LDTS.StandarWorkbookAdd" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder" runat="server">
        <section class="StandarWorkbook content-header">
        <div class="StandarWorkbookContainer container-fluid">
            <div class="StandarWorkbookTitle row mb-2">
                <div class="col-sm-6">
                    <h1>新增標準作業書</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Relation">程序書關聯設定</a></li>
                        <li class="breadcrumb-item">新增標準作業書</li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="StandarWorkbookMain col-md-6">
                    <div class="card card-info card-outline">
                        <div class="card-body box-profile">
                            <div class="text-start mb-3">
                                <i class="fas fa-book-open" style="font-size: 30px"></i>
                            </div>
                            <div class="StandarWorkbookMainName form-group text-center p-2">
                                <asp:Label ID="SwbName" runat="server" Font-Size="Large"></asp:Label>
                            </div>
                            <div class="form-group">
                                <label for="sIndex" style="font-size: 12px; color: #00000080">標準作業書索引號</label>
                                <asp:TextBox TextMode="Number" ID="sIndex" runat="server" CssClass="form-control form-control-border"></asp:TextBox>
                            </div>

                            <div class="sName form-group">
                                <label for="sName" style="font-size: 12px; color: #00000080">標準作業書名稱</label>
                                <asp:TextBox ID="sName" MaxLength="40" runat="server" CssClass="form-control form-control-border"></asp:TextBox>
                            </div>
                            <div class="sDesc form-group">
                                <label for="desc" style="font-size: 12px; color: #00000080">標準作業書描述</label>
                                <asp:TextBox MaxLength="200" TextMode="MultiLine" ID="desc" runat="server" Rows="5" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="swbUpload">
                                <div class="swbEditUploadCard card">
                                    <div class="swbUploadCardHeader card-header p-2">
                                        <h6 class="pt-1">上傳標準作業書</h6>
                                    </div>
                                    <div class="swbUploadCardBody card-body">
                                        <div class="swbUploadMainUpload form-group row">
                                            <div class="col-sm-12">
                                                <div class="input-group">
                                                    <div class="swbUploadName custom-file">
                                                        <asp:HiddenField ID="TemplateFile" runat="server" Value="" />

                                                        <asp:FileUpload ID="swbUpload" CssClass="custom-file-input Upload" runat="server" />
                                                        <asp:Label ID="swbUploadName" runat="server" CssClass="custom-file-label">選擇檔案</asp:Label>
                                                    </div>
                                                    <div class="input-group-append">
                                                        <asp:Button runat="server" ID="uploadfile" CssClass="input-group-text" Text="確認" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="swbApplication form-group">
                                <asp:Button runat="server" ID="SaveButton" CssClass="btn btn-primary float-right" Text="儲存" OnClick="SaveButton_Click" />
                            </div>
                        </div>
                    </div>
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
