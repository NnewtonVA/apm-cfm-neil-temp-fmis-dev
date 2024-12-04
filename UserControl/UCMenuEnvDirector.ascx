<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="UCMenuGeneral.ascx.vb" Inherits="CFMISNew.UCMenuGeneral" %>
<link href="App_Themes/Theme1/main.css" rel="stylesheet" />
<asp:Menu ID="mSearch" runat="server"  StaticDisplayLevels="4" CssClass="mainMenu" Height="400px" DataSourceID="smdsrcSearch" OnMenuItemDataBound="mSearch_MenuItemDataBound">
    <LevelMenuItemStyles>
        <asp:MenuItemStyle Font-Bold="True" Font-Size="18px" Font-Underline="False" 
            VerticalPadding="5px"/>
        <asp:MenuItemStyle Font-Bold="True" Font-Underline="False" 
            VerticalPadding="3px" Font-Size="16px" ForeColor="#00287D" />
        <asp:MenuItemStyle Font-Underline="False" HorizontalPadding="3px" Font-Size="14px" />
    </LevelMenuItemStyles>

</asp:Menu>
<asp:SiteMapDataSource ID="smdsrcSearch" runat="server" SiteMapProvider="SiteMap4" />

<script lang="javascript" type="text/javascript" >

    function GoTo(url) {
        window.open(url);
    }

</script>
