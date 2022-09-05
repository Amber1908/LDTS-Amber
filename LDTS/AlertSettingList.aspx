<%@ Page Title="" Language="C#" MasterPageFile="~/LDTS.Master" AutoEventWireup="true" CodeBehind="AlertSettingList.aspx.cs" Inherits="LDTS.AlertSettingList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>提醒列表</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Default">Home</a></li>
                        <li class="breadcrumb-item">提醒列表</li>
                    </ol>
                </div>
            </div>
        </div>
    </section>
    <!-- /.content Header -->

    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Alert List</h3>
                            <div class="card-tools">
                                <a href="AlertSettingEdit" class="btn btn-app">
                                    <i class="fas fa-plus-circle"></i>New
                                </a>
                            </div>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body table-responsive p-3">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover text-nowrap" DataSourceID="SqlDataSource1" DataKeyNames="ALID" EmptyDataText="無提醒資料" OnRowDataBound="GridView1_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="ALID" HeaderText="代碼">
                                        <ItemStyle Width="60px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ALTitle" HeaderText="提醒說明" />
                                    <asp:BoundField DataField="ALType" HeaderText="週期">
                                        <ItemStyle Width="60px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ALFactor" HeaderText="提醒條件" />
                                    <asp:BoundField DataField="ALForm" HeaderText="關聯表單" />
                                    <asp:BoundField DataField="Status" HeaderText="狀態">
                                        <ItemStyle Width="60px" />
                                    </asp:BoundField>

                                    <asp:HyperLinkField DataNavigateUrlFormatString="AlertSettingEdit?ALID={0}" DataTextFormatString="{0:c}" DataNavigateUrlFields="ALID" Text="<i class='fa fa-pen-square fa-lg'></i>" ControlStyle-ForeColor="Black" HeaderText="修改">
                                        <ControlStyle ForeColor="Black"></ControlStyle>
                                        <ItemStyle HorizontalAlign="Center" Width="60px" />
                                    </asp:HyperLinkField>

                                    <asp:CommandField DeleteText="<i class='fa fa-ban fa-lg'></i>" ShowDeleteButton="True" HeaderText="刪除">
                                        <ControlStyle ForeColor="Black"></ControlStyle>
                                        <ItemStyle HorizontalAlign="Center" Width="60px" />
                                    </asp:CommandField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LDTSConnectionString %>" SelectCommand="select * from AlertSetting" DeleteCommand="delete AlertSetting where ALID=@ALID">
                                <DeleteParameters>
                                    <asp:ControlParameter ControlID="GridView1" Name="ALID" Type="Int32" PropertyName="SelectedDataKey" />
                                </DeleteParameters>
                            </asp:SqlDataSource>
                        </div>
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                </div>
            </div>
        </div>
    </section>
    <!-- /.content -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jqueryPlaceHolder" runat="server">
    <script>
        $('.formnamelist').click(function () {
            var selstring = $(this).text();

            $('.formnamelist').css('background', '');

            $('.formnamelist').each(function () {
                if ($(this).text() == selstring)
                    $(this).css('background', 'LightPink');
            });
        })
    </script>
</asp:Content>
