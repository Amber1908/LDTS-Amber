<%@ Page Title="" Language="C#" MasterPageFile="~/LDTS.Master" AutoEventWireup="true" CodeBehind="ProcessEdit.aspx.cs" Inherits="LDTS.ProcessEdit1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <section class="proEdit content-header">
        <div class="proEditContainer container-fluid">
            <div class="proEditTitle row mb-2">
                <div class="col-sm-6">
                    <h1 id="title" runat="server">編輯程序書</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Relation.aspx">程序書關聯設定</a></li>
                        <li class="breadcrumb-item">編輯程序書</li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div id="proInfo" runat="server" class="proEditMain col-md-6">
                    <div class="card card-primary card-outline">
                        <div class="card-body box-profile">
                            <div class="text-center">
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
                                <asp:TextBox ID="proName"  MaxLength="50" runat="server" CssClass="form-control form-control-border">未命名</asp:TextBox>
                            </div>
                            <div class="processesDesc form-group">
                                <label for="desc" style="font-size: 12px; color: #00000080">程序書描述</label>
                                <asp:TextBox TextMode="MultiLine"  MaxLength="200" ID="desc" runat="server" Rows="5" CssClass="form-control"></asp:TextBox>
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
                                <asp:Button runat="server" ID="DeletePro" CssClass="btn btn-danger float-lg-right" Text="刪除" OnClick="DeletePro_Click" />
                                <asp:Button runat="server" ID="SaveButton" CssClass="btn btn-primary float-right mr-2" Text="儲存" OnClick="SaveButton_Click" />
                                <a href="#" download="" runat="server" id="download" class="btn btn-default float-right mr-2"><i class="fas fa-cloud-download-alt">下載程序書</i></a>
<%--                                <input type="text" id="fileName" value="" class="d-none" runat="server" />--%>
                                <asp:TextBox  ID="filemyName" runat="server" CssClass="d-none"></asp:TextBox>
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
            var download = document.getElementById("mainPlaceHolder_download");
            var url = document.getElementById("mainPlaceHolder_filemyName").value;
            
            console.log(url);
            download.setAttribute("download", url)
        </script>

</asp:Content>
