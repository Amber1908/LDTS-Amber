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
                            <div class="text-center">
                                <a href="#" runat="server" id="download" class="btn btn-default btn-sm float-right"><i class="fas fa-cloud-download-alt"></i></a>
                                <i class="fas fa-book" style="font-size: 30px"></i>
                            </div>
                            <div class="processesMainName form-group text-center p-2">
                                <asp:Label ID="ProcessName" runat="server" Font-Size="Large"></asp:Label>
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
                                            <div class="col-sm-10">
                                                <div class="input-group">
                                                    <div class="processesUploadName custom-file">
                                                        <asp:FileUpload ID="processesUpload" CssClass="custom-file-input Upload" runat="server" />
                                                        <asp:Label ID="processesUploadName" runat="server" CssClass="custom-file-label">選擇檔案</asp:Label>
                                                    </div>
                                                    <div class="input-group-append">
                                                        <asp:Button runat="server" ID="uploadfile" CssClass="input-group-text" Text="確認" OnClick="uploadfile_Click" />
                                                    </div>
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
                <div  class="processesList col-md-9" runat="server" id="ProcessContainer">
                </div>
            </div>
        </div>
        <asp:TextBox runat="server" ID="Ao" CssClass="d-none" ></asp:TextBox>
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
