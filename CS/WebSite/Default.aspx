<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>
<%@ Register assembly="DevExpress.Web.ASPxHtmlEditor.v9.1" namespace="DevExpress.Web.ASPxHtmlEditor" tagprefix="dxhe" %>
<%@ Register assembly="DevExpress.Web.ASPxEditors.v9.1" namespace="DevExpress.Web.ASPxEditors" tagprefix="dxe" %>
<%@ Register assembly="DevExpress.Web.ASPxSpellChecker.v9.1" namespace="DevExpress.Web.ASPxSpellChecker" tagprefix="dxwsc" %>
<%@ Register assembly="DevExpress.Web.v9.1" namespace="DevExpress.Web.ASPxPopupControl" tagprefix="dxpc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
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
        function getFrameByIFrameElement(iframeElement){
            var name = (new Date()).toString();
            iframeElement.contentWindow.name = name;
            var frameIndex = getFrameByWindowName(name);
            return window.frames[frameIndex];
        }
        function getFrameByWindowName(name){
            var count = window.top.frames.length;
            for(var i = 0; i < count; i++){
                if(window.top.frames[i].window.name === name)
                    return i;
            }
            return -1;
        }                
    </script>

    <dxhe:ASPxHtmlEditor ID="ASPxHtmlEditor1" runat="server"
        
        Html="This &lt;a href=&quot;http://www.devexpress.com/&quot; target=&quot;_blank&quot;&gt;LINK&lt;/a&gt; with target=&quot;_blank&quot; is opened in a new window.&lt;br /&gt;&lt;br /&gt;This &lt;a href=&quot;http://www.devexpress.com/&quot; target=&quot;_self&quot;&gt;LINK&lt;/a&gt; with target=&quot;_self&quot; is opened in the same frame (in popup).">
        <SettingsImageUpload>
            <ValidationSettings AllowedContentTypes="image/jpeg,image/pjpeg,image/gif,image/png,image/x-png">
            </ValidationSettings>
        </SettingsImageUpload>
        <Settings AllowPreview="False" />
        <Toolbars>
            <dxhe:CustomToolbar>
                <Items>
                    <dxhe:CustomToolbarButton CommandName="Preview" Text="Preview">
                    </dxhe:CustomToolbarButton>
                    <dxhe:ToolbarInsertLinkDialogButton>
                    </dxhe:ToolbarInsertLinkDialogButton>
                </Items>
            </dxhe:CustomToolbar>
        </Toolbars>
        <ClientSideEvents CustomCommand="function(s, e) { onCustomCommand(e.commandName); }" />
    </dxhe:ASPxHtmlEditor>
    <dxpc:ASPxPopupControl ID="ASPxPopupControl1" runat="server" 
        ClientInstanceName="previewPopup" Modal="True" Height="340px" 
        Width="724px" AllowDragging="True" HeaderText="Preview" 
        PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" 
        ContentUrl="~/PreviewDocument.htm" AllowResize="True" 
        FooterText="Resize window" ShowFooter="True">
        <ClientSideEvents CloseUp="function(s, e) { onCloseUp(); }" />
        <ContentCollection>
            <dxpc:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
            </dxpc:PopupControlContentControl>
        </ContentCollection>
    </dxpc:ASPxPopupControl> 
    </form>
</body>
</html>
