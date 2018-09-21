<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.ASPxHtmlEditor.v14.2, Version=14.2.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxHtmlEditor" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxSpellChecker.v14.2, Version=14.2.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxSpellChecker" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Implementing custom Preview popup</title>
    <script type="text/javascript">
        function onCloseUp() {
            previewPopup.RefreshContentUrl();
        }
        function onCustomCommand(commandName) {
            if (commandName == "Preview") {
                previewPopup.Show();
                window.setTimeout("setHtmlInPreviewIFrame()", 800);
            }
        }
        function setHtmlInPreviewIFrame() {
            var previewIFrameElement = getFrameByIFrameElement(previewPopup.GetContentIFrame());
            var previewIFrameDoc = null;
            if (previewIFrameElement.document)
                previewIFrameDoc = previewIFrameElement.document;
            else
                previewIFrameDoc = previewIFrameElement.contentDocument

            previewIFrameDoc.body.innerHTML = ASPxHtmlEditor1.GetHtml();
        }
        function getFrameByIFrameElement(iframeElement) {
            var name = (new Date()).toString();
            iframeElement.contentWindow.name = name;
            var frameIndex = getFrameByWindowName(name);
            return window.frames[frameIndex];
        }
        function getFrameByWindowName(name) {
            var count = window.top.frames.length;
            for (var i = 0; i < count; i++) {
                if (window.top.frames[i].window.name === name)
                    return i;
            }
            return -1;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <dx:ASPxHtmlEditor ID="ASPxHtmlEditor1" runat="server"
            Html="This &lt;a href=&quot;http://www.devexpress.com/&quot; target=&quot;_blank&quot;&gt;LINK&lt;/a&gt; with target=&quot;_blank&quot; is opened in a new window.&lt;br /&gt;&lt;br /&gt;This &lt;a href=&quot;Default2.aspx&quot; target=&quot;_self&quot;&gt;LINK&lt;/a&gt; with target=&quot;_self&quot; is opened in the same frame (in popup).">
            <SettingsImageUpload>
                <ValidationSettings AllowedContentTypes="image/jpeg,image/pjpeg,image/gif,image/png,image/x-png">
                </ValidationSettings>
            </SettingsImageUpload>
            <Settings AllowPreview="False" />
            <Toolbars>
                <dx:HtmlEditorToolbar>
                    <Items>
                        <dx:CustomToolbarButton CommandName="Preview" Text="Preview">
                        </dx:CustomToolbarButton>
                        <dx:ToolbarInsertLinkDialogButton>
                        </dx:ToolbarInsertLinkDialogButton>
                    </Items>
                </dx:HtmlEditorToolbar>
            </Toolbars>
            <ClientSideEvents CustomCommand="function(s, e) { onCustomCommand(e.commandName); }" />
        </dx:ASPxHtmlEditor>
        <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server"
            ClientInstanceName="previewPopup" Modal="True" Height="340px"
            Width="724px" AllowDragging="True" HeaderText="Preview"
            PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter"
            ContentUrl="~/PreviewDocument.htm" AllowResize="True"
            FooterText="Resize window" ShowFooter="True">
            <ClientSideEvents CloseUp="function(s, e) { onCloseUp(); }" />
            <ContentCollection>
                <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>
    </form>
</body>
</html>
