<%@ Page Title="" Language="C#" MasterPageFile="~/LDTS.Master" AutoEventWireup="true" CodeBehind="AlertSettingEdit.aspx.cs" Inherits="LDTS.AlertSettingEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headPlaceHolder" runat="server">
    <link rel="stylesheet" href="plugins/bootstrap4-duallistbox/bootstrap-duallistbox.min.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>提醒設定</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Default">Home</a></li>
                        <li class="breadcrumb-item"><a href="AlertSettingList">提醒列表</a></li>
                        <li class="breadcrumb-item">提醒設定</li>
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
                <!-- left column -->
                <div class="col-md-6">
                    <!-- jquery validation -->
                    <div class="card card-info">
                        <div class="card-header">
                            <h3 class="card-title">基本設定</h3>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" data-toggle="tooltip" title="Collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label for="ALID">代碼</label>
                                    <asp:TextBox ID="ALID" runat="server" CssClass="form-control" Enabled="false" placeholder="新提醒自動產生"></asp:TextBox>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="admin_status">狀態</label>
                                    <asp:RadioButtonList ID="Status" runat="server" RepeatDirection="Horizontal" CssClass="form-control" CellPadding="5" CellSpacing="10">
                                        <asp:ListItem Text="&nbsp;啟用" Value="1" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="&nbsp;停用" Value="2"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="ALTitle">提醒說明</label>
                                <asp:TextBox ID="ALTitle" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" MaxLength="500"></asp:TextBox>
                            </div>
                        </div>
                        <div class="card-footer">
                            <asp:Button ID="SEND" runat="server" CssClass="btn btn-primary" Text="Save" OnClick="SEND_Click" OnClientClick="return validForm();" />
                            <a href="AlertSettingList" class="btn btn-secondary ml-1">Cancel</a>
                        </div>
                    </div>
                    <!-- /.card -->
                </div>
                <!--/.col (left) -->
                <!-- right column -->
                <div class="col-md-6">
                    <div class="card card-danger">
                        <div class="card-header">
                            <h3 class="card-title">提醒條件</h3>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" data-toggle="tooltip" title="Collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="form-group">
                                <label for="admin_status">週期</label>
                                <asp:RadioButtonList ID="ALType" runat="server" RepeatDirection="Horizontal" CssClass="form-control SELFACTOR" CellPadding="5" CellSpacing="10">
                                    <asp:ListItem Text="&nbsp;年" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="&nbsp;季" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="&nbsp;月" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="&nbsp;週" Value="4"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-4">
                                    <label>起始提醒日期</label>
                                    <div class="form-inline">
                                        <select id="s_month" class="form-control ml-2">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                            <option>4</option>
                                            <option>5</option>
                                            <option>6</option>
                                            <option>7</option>
                                            <option>8</option>
                                            <option>9</option>
                                            <option>10</option>
                                            <option>11</option>
                                            <option>12</option>
                                        </select>
                                        <label for="s_month" class="ml-2">月</label>
                                        <select id="s_day" class="form-control ml-2">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                            <option>4</option>
                                            <option>5</option>
                                            <option>6</option>
                                            <option>7</option>
                                            <option>8</option>
                                            <option>9</option>
                                            <option>10</option>
                                            <option>11</option>
                                            <option>12</option>
                                            <option>13</option>
                                            <option>14</option>
                                            <option>15</option>
                                            <option>16</option>
                                            <option>17</option>
                                            <option>18</option>
                                            <option>19</option>
                                            <option>20</option>
                                            <option>21</option>
                                            <option>22</option>
                                            <option>23</option>
                                            <option>24</option>
                                            <option>25</option>
                                            <option>26</option>
                                            <option>27</option>
                                            <option>28</option>
                                            <option>29</option>
                                            <option>30</option>
                                            <option>31</option>
                                        </select>
                                        <label for="s_day" class="ml-2">日</label>
                                    </div>
                                </div>
                                <div class="form-group col-md-4">
                                    <label>結束提醒日期</label>
                                    <div class="form-inline">
                                        <select id="e_month" class="form-control ml-2">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                            <option>4</option>
                                            <option>5</option>
                                            <option>6</option>
                                            <option>7</option>
                                            <option>8</option>
                                            <option>9</option>
                                            <option>10</option>
                                            <option>11</option>
                                            <option>12</option>
                                        </select>
                                        <label for="e_month" class="ml-2">月</label>
                                        <select id="e_day" class="form-control ml-2">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                            <option>4</option>
                                            <option>5</option>
                                            <option>6</option>
                                            <option>7</option>
                                            <option>8</option>
                                            <option>9</option>
                                            <option>10</option>
                                            <option>11</option>
                                            <option>12</option>
                                            <option>13</option>
                                            <option>14</option>
                                            <option>15</option>
                                            <option>16</option>
                                            <option>17</option>
                                            <option>18</option>
                                            <option>19</option>
                                            <option>20</option>
                                            <option>21</option>
                                            <option>22</option>
                                            <option>23</option>
                                            <option>24</option>
                                            <option>25</option>
                                            <option>26</option>
                                            <option>27</option>
                                            <option>28</option>
                                            <option>29</option>
                                            <option>30</option>
                                            <option>31</option>
                                        </select>
                                        <label for="e_day" class="ml-2">日</label>
                                    </div>
                                </div>
                                <div class="form-group col-md-4">
                                    <label>提醒日</label>
                                    <div class="form-inline">
                                        <select id="week" class="form-control ml-2" disabled>
                                            <option value="1">星期一</option>
                                            <option value="2">星期二</option>
                                            <option value="3">星期三</option>
                                            <option value="4">星期四</option>
                                            <option value="5">星期五</option>
                                            <option value="6">星期六</option>
                                            <option value="0">星期日</option>
                                        </select>
                                        <button id="AddFactor" class="btn btn-outline-primary btn-flat ml-4" onclick="return false;"><i class="fa fa-plus-circle"></i></button>
                                        <button id="DelFactor" class="btn btn-outline-primary btn-flat ml-1" onclick="return false;"><i class="fa fa-trash"></i></button>
                                    </div>
                                </div>
                            </div>
                            <select id="ALFactorList" class="form-control" multiple></select>
                            <asp:HiddenField ID="ALFactor" runat="server" />
                        </div>
                        <div class="card-footer clearfix">
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.card -->
            <div class="row">
                <div class="col-md-12">
                    <!-- jquery validation -->
                    <div class="card card-warning">
                        <div class="card-header">
                            <h3 class="card-title">關聯表單</h3>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse" data-toggle="tooltip" title="Collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-12">
                                    <div class="form-group">
                                        <asp:ListBox ID="formselect" runat="server" CssClass="duallistbox" multiple="multiple" SelectionMode="Multiple">
                                            <asp:ListItem Selected="True">Alabama</asp:ListItem>
                                            <asp:ListItem>Alaska</asp:ListItem>
                                            <asp:ListItem>California</asp:ListItem>
                                            <asp:ListItem>Delaware</asp:ListItem>
                                            <asp:ListItem>Tennessee</asp:ListItem>
                                            <asp:ListItem>Texas</asp:ListItem>
                                            <asp:ListItem>Washington</asp:ListItem>
                                        </asp:ListBox>
                                    </div>
                                </div>
                                <!-- /.col -->
                            </div>
                        </div>
                        <div class="card-footer clearfix">
                        </div>
                    </div>
                    <!-- /.card -->
                </div>
            </div>
        </div>
    </section>
    <!-- /.Main content -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="jqueryPlaceHolder" runat="server">
    <script src="plugins/bootstrap4-duallistbox/jquery.bootstrap-duallistbox.min.js"></script>
    <script>
        $(function () {
            // Bootstrap Duallistbox
            $('.duallistbox').bootstrapDualListbox({
                nonSelectedListLabel: '未選取表單',
                selectedListLabel: '已選取表單',
                preserveSelectionOnMove: 'moved',
                moveOnSelect: false,
                selectorMinimalHeight: 280,
                infoText: `<h6 class="text-primary">{0}</h6>`,
                infoTextEmpty: `<h6 class="text-danger">0</h6>`
            });

            // init SELECT FACTOR
            initALFactor($(".SELFACTOR input:checked").val());
            if ($("#<%= ALFactor.ClientID %>").val().length > 0) {
                const st = $("#<%= ALFactor.ClientID %>").val().split(',');
                $.each(st, function (index, value) {
                    const alfactor = $("#ALFactorList");
                    switch ($(".SELFACTOR input:checked").val()) {
                        case "1":
                            alfactor.append(new Option(`每年 ${value.split('-')[0].split('/')[0]}月${value.split('-')[0].split('/')[1]}日 - ${value.split('-')[1].split('/')[0]}月${value.split('-')[1].split('/')[1]}日`, `${value.split('-')[0].split('/')[0]}/${value.split('-')[0].split('/')[1]}-${value.split('-')[1].split('/')[0]}/${value.split('-')[1].split('/')[1]}`));
                            break;
                        case "2":
                            alfactor.append(new Option(`每年 ${value.split('-')[0].split('/')[0]}月${value.split('-')[0].split('/')[1]}日 - ${value.split('-')[1].split('/')[0]}月${value.split('-')[1].split('/')[1]}日`, `${value.split('-')[0].split('/')[0]}/${value.split('-')[0].split('/')[1]}-${value.split('-')[1].split('/')[0]}/${value.split('-')[1].split('/')[1]}`));
                            break;
                        case "3":
                            alfactor.append(new Option(`每月 ${value.split('-')[0]}日 - ${value.split('-')[1]}日`, `${value.split('-')[0]}-${value.split('-')[1]}`));
                            break;
                        case "4":
                            alfactor.append(new Option(`每週 ${getWeek(value)}`, `${value}`));
                            break;
                    }
                });
            }

            // SELECT FACTOR
            $(".SELFACTOR input").change(function () {
                $("#ALFactorList").find('option').remove();
                $("#<%= ALFactor.ClientID %>").val('');
                initALFactor($(this).val());
            });

            // Add Factor
            $("#AddFactor").click(function () {
                const alfactor = $("#ALFactorList");
                const s_month = $("#s_month option:selected").val();
                const s_day = $("#s_day option:selected").val();
                const e_month = $("#e_month option:selected").val();
                const e_day = $("#e_day option:selected").val();
                const week = $("#week option:selected");
                switch ($(".SELFACTOR input:checked").val()) {
                    case "1":
                        alfactor.append(new Option(`每年 ${s_month}月${s_day}日 - ${e_month}月${e_day}日`, `${s_month}/${s_day}-${e_month}/${e_day}`));
                        break;
                    case "2":
                        alfactor.append(new Option(`每年 ${s_month}月${s_day}日 - ${e_month}月${e_day}日`, `${s_month}/${s_day}-${e_month}/${e_day}`));
                        break;
                    case "3":
                        alfactor.append(new Option(`每月 ${s_day}日 - ${e_day}日`, `${s_day}-${e_day}`));
                        break;
                    case "4":
                        alfactor.append(new Option(`每週 ${week.text()}`, `${week.val()}`));
                        break;
                }
                var values = $("#ALFactorList option").map(function () {
                    return this.value;
                }).get().join(",");
                $("#<%= ALFactor.ClientID %>").val(`${values}`);
            });

            // Del Factor
            $("#DelFactor").click(function () {
                $("#ALFactorList").find('option').remove();
                $("#<%= ALFactor.ClientID %>").val('');
            });
        });

        // init ALFactor
        function initALFactor(s) {
            $("#s_month").attr('disabled', true);
            $("#s_day").attr('disabled', true);
            $("#e_month").attr('disabled', true);
            $("#e_day").attr('disabled', true);
            $("#week").attr('disabled', true);
            switch (s) {
                case "1":
                    $("#s_month").attr('disabled', false);
                    $("#s_day").attr('disabled', false);
                    $("#e_month").attr('disabled', false);
                    $("#e_day").attr('disabled', false);
                    break;
                case "2":
                    $("#s_month").attr('disabled', false);
                    $("#s_day").attr('disabled', false);
                    $("#e_month").attr('disabled', false);
                    $("#e_day").attr('disabled', false);
                    break;
                case "3":
                    $("#s_day").attr('disabled', false);
                    $("#e_day").attr('disabled', false);
                    break;
                case "4":
                    $("#week").attr('disabled', false);
                    break;
            }
        }

        // valid
        function validForm() {
            $("#<%= ALTitle.ClientID %>").removeClass("is-invalid");
            $("#ALFactorList").removeClass("is-invalid");

            if ($("#<%= ALTitle.ClientID %>").val().length < 1) {
                $("#<%= ALTitle.ClientID %>").addClass("is-invalid");
                $("#<%= ALTitle.ClientID %>").focus();
                return false;
            }
            if ($("#<%= ALFactor.ClientID %>").val().length < 1) {
                $("#ALFactorList").addClass("is-invalid");
                return false;
            }

            return true;
        }

        // get Week
        function getWeek(s) {
            var ss = "";
            switch (s) {
                case "1":
                    ss = "星期一";
                    break;
                case "2":
                    ss = "星期二";
                    break;
                case "3":
                    ss = "星期三";
                    break;
                case "4":
                    ss = "星期四";
                    break;
                case "5":
                    ss = "星期五";
                    break;
                case "6":
                    ss = "星期六";
                    break;
                case "0":
                    ss = "星期日";
                    break;
            }
            return ss;
        }
    </script>
</asp:Content>
