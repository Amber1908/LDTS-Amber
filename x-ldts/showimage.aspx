<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="showimage.aspx.cs" Inherits="LDTS.showimage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div>
                <asp:TemplateField HeaderText="登記圖片">
                    <itemtemplate>
                        <image src="showImage.aspx?id=<%#Eval("ID") %>"></image>

                    </itemtemplate>
                </asp:TemplateField>
            </div>

        </div>
    </form>
</body>
</html>
