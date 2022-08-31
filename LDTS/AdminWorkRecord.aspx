<%@ Page Title="" Language="C#" MasterPageFile="~/LDTS.Master" AutoEventWireup="true" CodeBehind="AdminWorkRecord.aspx.cs" Inherits="LDTS.AdminWorkRecord" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder" runat="server">
        <style>
        .PagerCss td a:hover {
            padding-top:7.5px;
            padding-bottom:7.5px;
            padding-left:7.5px;
            padding-right:7.5px;
            background-color:lightgray;
            text-decoration: none;
        }

        .PagerCss td a:active {
            width: 1px;
            padding:15px;
            background-color:lightgray;
            font-weight: bold;
            
        }
       
    </style>

    <section class="AdminRecord content-header">
        <div class="AdminRecord container-fluid">
            <div class="AdminRecordTitle row">
                <div class="col-sm-6">
                    <h1>操作紀錄</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Default.aspx">Home</a></li>
                        <li class="breadcrumb-item">系統操作紀錄查詢</li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
    <!--Main content-->
    <section class="AdminRecordmain content">
        <div class="AdminRecordmainContainer container-fluid">
            <div class="row">
                <div class="AdminRecordmainMain col-12">
                    <div class="AdminRecordmainMainCard card">
                        <div class="AdminRecordmainMain CardHeader card-header">
                            <h6 class="card-title">操作紀錄</h6>
                            <div class="AdminRecordmainMain card-tools">
                                <div class="input-group input-group-sm" style="width: 150px">
                                    <asp:TextBox ID="table_search" runat="server" CssClass="form-control float-right" placeholder="Search"></asp:TextBox>
                                    <div class="input-group-append">
                                        <asp:LinkButton ID="search" runat="server" CssClass="btn btn-default" OnClick="search_Click">
                                            <i class="fa fa-search"></i>
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="AdminRecordmainMainCardBody card-body table-responsive p-0">
                            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" PageSize="8" PagerSettings-PageButtonCount="5" PagerStyle-HorizontalAlign="Center" AutoGenerateColumns="False" DataKeyNames="sn" DataSourceID="SqlDataSource1" CssClass="table table-bordered dataTable" ItemStyle-Width="100%" EmptyDataText="目前無資料">
                                <Columns>
                                    <asp:BoundField DataField="sn" HeaderText="序號" ItemStyle-Width="5%" InsertVisible="False" ReadOnly="True" SortExpression="sn">
                                        <ItemStyle Width="5%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="admin_id" HeaderText="帳號" ItemStyle-Width="15%" SortExpression="adminId">
                                        <ItemStyle Width="15%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="admin_name" HeaderText="姓名" ItemStyle-Width="10%" SortExpression="adminName">
                                        <ItemStyle Width="10%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="work_content" HeaderText="操作項目" ItemStyle-Width="50%" SortExpression="workContent">
                                        <ItemStyle Width="50%"></ItemStyle>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="createtime" HeaderText="操作時間" ItemStyle-Width="20%" SortExpression="createtime">
                                        <ItemStyle Width="20%"></ItemStyle>
                                    </asp:BoundField>
                                </Columns>

                                <PagerSettings PageButtonCount="5"></PagerSettings>

                                <PagerStyle HorizontalAlign="Center" Font-Bold="true" Font-Names="Ebrima" Font-Overline="False" Font-Size="Medium" Font-Underline="False" Wrap="True" CssClass="page-item"></PagerStyle>
                                <SortedDescendingHeaderStyle HorizontalAlign="Center" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LDTSConnectionString %>" SelectCommand="SELECT * FROM [AdminWorkRecord] ORDER BY [createtime] DESC"></asp:SqlDataSource>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--body加一個Class 把sidebar收起來-->
    <script>
        var body = document.querySelector(".sidebar-mini");
        body.classList.add("sidebar-collapse");
    </script>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jqueryPlaceHolder" runat="server">
</asp:Content>
