<%@ Page Title="" Language="C#" MasterPageFile="~/LDTS.Master" AutoEventWireup="true" CodeBehind="ProcessAdd.aspx.cs" Inherits="LDTS.ProcessEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <section class="proAdd content-header">
        <div class="proAddContainer container-fluid">
            <div class="proAddTitle row mb-2">
                <div class="col-sm-6">
                    <h1>新增程序書</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Default">Home</a></li>
                        <li class="breadcrumb-item">新增程序書</li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="processesMain col-md-6">
                    <div class="card card-primary card-outline">
                        <div class="card-body box-profile">
                            <div class="text-start mb-3">
                                <i class="fas fa-book" style="font-size: 30px"></i>
                            </div>
                            <div class="processesName form-group">
                                <label for="processesIndex" style="font-size: 12px; color: #00000080">程序書索引號</label>
                                <asp:TextBox TextMode="Number" ID="proIndex" runat="server" CssClass="form-control form-control-border"></asp:TextBox>
                            </div>

                            <div class="processesName form-group">
                                <label for="processesName" style="font-size: 12px; color: #00000080">程序書名稱</label>
                                <asp:TextBox ID="proName" runat="server" CssClass="form-control form-control-border">未命名</asp:TextBox>
                            </div>
                                                        <div class="processesDesc form-group">
                                <label for="desc" style="font-size: 12px; color: #00000080">程序書描述</label>
                                <asp:TextBox TextMode="MultiLine" ID="desc" runat="server" Rows="5" CssClass="form-control"></asp:TextBox>
                            </div>
                                                        <div class="processesUpload">
                                <div class="personEditUploadCard card">
                                    <div class="personEditUploadCardHeader card-header p-2">
                                        <h6 class="pt-1">上傳程序書</h6>
                                    </div>
                                    <div class="processesUploadCardBody card-body">
                                        <div class="processesUploadMainUpload form-group row">
                                            <div class="col-sm-12">
                                                <div class="input-group">
                                                    <div class="processesUploadName custom-file">
                                                    <asp:HiddenField ID="TemplateFile" runat="server" Value="" />

                                                        <asp:FileUpload ID="processesUpload" CssClass="custom-file-input Upload" runat="server" />

                                                        <asp:Label ID="processesUploadName" runat="server" CssClass="custom-file-label">選擇檔案</asp:Label>
                                                    </div>
<%--                                                    <div class="input-group-append">
                                                        <asp:Button runat="server" ID="uploadfile" CssClass="input-group-text" Text="確認" />
                                                    </div>--%>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="processesApplication form-group">
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
        var processesUploadName = document.getElementById("mainPlaceHolder_processesUploadName");
        var processesUpload = document.getElementById("mainPlaceHolder_processesUpload");
        processesUpload.addEventListener("change", function () {
            if (processesUpload.value.length > 0) {
                processesUploadName.innerText = processesUpload.value;
            }
        });
    </script>
</asp:Content>
