<%@ Page Title="Search FS for Project" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="SearchFactsheetReviews.aspx.vb" Inherits="CFMISNew.SearchFactsheetReviews" %>
<%@ Register Src="~/UserControl/UCMenuAdmin.ascx" TagPrefix="uc1" TagName="UCMenuAdmin" %>
<%@ Register Src="~/UserControl/UCMenuGeneral.ascx" TagPrefix="uc1" TagName="UCMenuGeneral" %>
<%@ Register Src="~/UserControl/UCMenuEnvEngineer.ascx" TagPrefix="uc1" TagName="UCMenuEnvEngineer" %> 
<%@ Register Src="~/UserControl/UCMenuEnvDirector.ascx" TagPrefix="uc1" TagName="UCMenuEnvDirector" %> 

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 580px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table style="width:98%;"><tr><td style="vertical-align:top; width:200px">
        <asp:Label ID="lblRole" runat="server" Visible="False"></asp:Label>
        <uc1:UCMenuAdmin runat="server" id="UCMenuAdmin" />
        <uc1:UCMenuGeneral runat="server" ID="UCMenuGeneral" />
        <uc1:UCMenuEnvEngineer runat="server" id="UCMenuEnvEngineer" />
        <uc1:UCMenuEnvDirector runat="server" id="UCMenuEnvDirector" />
           </td><td valign="top" class="auto-style1">
                <div class="wideBox" style="padding-left:15px">
        <h3>Search Projects for Factsheet Review Status</h3>
<table><tr><td style="height: 32px; width: 75px;">
    <asp:Label ID="lblProjNum" runat="server" Text="Project #:" Font-Bold="True"></asp:Label>
</td><td style="height: 32px; width: 144px;">
    <asp:TextBox ID="txtProjectNum" runat="server"></asp:TextBox>
</td></tr><tr><td style="height: 32px; width: 75px;">
        <asp:Label ID="lblProjTitle" runat="server" Text="Project Title:" Font-Bold="True"></asp:Label>
        </td><td style="height: 32px; width: 144px;">
            <asp:TextBox ID="txtProjTitle" runat="server" Width="200px"></asp:TextBox>
            </td></tr><tr><td style="height: 32px; width: 75px;">
        <asp:Label ID="lblManager" runat="server" Font-Bold="True" Text="Manager:"></asp:Label>
        </td><td style="height: 32px; width: 144px;">
           <asp:DropDownList ID="ddlManager" runat="server" DataSourceID="sdsrcRoleManager"
                DataTextField="FullName" DataValueField="FullName" 
                   AppendDataBoundItems="True" Height="21px" Width="201px">
                <asp:ListItem Text="-Select-" Value="0"></asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsrcRoleManager" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" 
                   SelectCommand="Select Concat(firstname, +' '+lastname) as FullName from Personnel Where projManagerFlag = 1"></asp:SqlDataSource></td></tr></table>
            <br />
            <table style="width:250px;"><tr><td style="align-items:center;">
                <asp:Button ID="btnSearch" runat="server" Text="Search" Font-Bold="True" 
            Width="99px"  onclick="btnSearch_Click" />
            </td><td style="align-items:center;">
                    <asp:Button ID="btnClear" runat="server" Font-Bold="True" 
            Text="Clear" Width="99px"  onclick="btnClear_Click" />
            </td>
            </tr></table>
<br />
    <asp:Label ID="lblSearchError" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
    </div>
    <asp:Panel ID="pnlShowGrid" runat="server" Visible="False">
    <div class="wideBox" style="padding-left:15px">
   <h3>Results shows the main projects:</h3>
    <asp:GridView ID="gvFctStSearch" runat="server" AutoGenerateColumns="False" 
        DataSourceID="odsrcSearchFctst" Width="98%" OnDataBound="gvFctStSearch_DataBound"
        Font-Bold="True" AllowPaging="True" EmptyDataText="No match found" 
        AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" DataKeyNames="project_pk">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="project_pk" HeaderText="project_pk" SortExpression="project_pk" Visible="False" ItemStyle-Font-Bold="false" ReadOnly="True" />
             <asp:HyperLinkField DataNavigateUrlFields="project_pk" DataNavigateUrlFormatString="FSDetails.aspx?project_pk={0}" DataTextField="projectCode" HeaderText="Project #" ItemStyle-ForeColor="#0000CC" SortExpression="projectCode" Target="_blank">
            <ItemStyle Font-Bold="False" Font-Underline="True" ForeColor="Blue" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="projectDesc" HeaderText="Title" ItemStyle-Font-Bold="false" SortExpression="projectDesc">
            </asp:BoundField>
            <asp:BoundField DataField="stationName" HeaderText="Station" ItemStyle-Font-Bold="false" SortExpression="stationName" />
            <asp:BoundField DataField="statusName" HeaderText="Status" ItemStyle-Font-Bold="false" SortExpression="statusName" />
            <asp:BoundField DataField="fms_number" HeaderText="FMS #" ItemStyle-Font-Bold="false" SortExpression="fms_number">
            </asp:BoundField>
            <asp:BoundField DataField="Name" HeaderText="Manager" ItemStyle-Font-Bold="false" SortExpression="Name" ReadOnly="True">
            </asp:BoundField>
            <asp:BoundField DataField="region" HeaderText="Region" ItemStyle-Font-Bold="false" SortExpression="region" />
        </Columns>
        <PagerTemplate>
                    <asp:LinkButton ID="lbFirst" runat="server" CommandArgument="First" Enabled= '<%#IIf((gvFctStSearch.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="White">&lt;&lt; First</asp:LinkButton>
                    <asp:LinkButton ID="lbPrev" runat="server" CommandArgument="Prev" Enabled= '<%#IIf((gvFctStSearch.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="White">&lt; Prev</asp:LinkButton> 
                    [Total Pg No: <%=gvFctStSearch.PageCount%>][Current pg: <%=gvFctStSearch.PageIndex + 1%>]
                    <asp:LinkButton ID="lbNext" runat="server" CommandArgument="Next" Enabled= '<%#IIf((gvFctStSearch.PageCount)=(gvFctStSearch.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="White">Next &gt;</asp:LinkButton>
                    <asp:LinkButton ID="lbLast" runat="server" CommandArgument="Last" Enabled= '<%#IIf((gvFctStSearch.PageCount)=(gvFctStSearch.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="White">Last &gt;&gt;</asp:LinkButton><br />
                         <asp:Label ID="lblGoTo" runat="server" Text="Go to Pg:"></asp:Label>    
                    <asp:DropDownList ID="ddlPaging" runat="server" AutoPostBack="True" 
                        Height="21px" OnSelectedIndexChanged="ddlPaging_SelectedIndexChanged" 
                        Width="45px">
                    </asp:DropDownList>
                    <asp:Label ID="lblCurrentPg" runat="server"></asp:Label>    
                </PagerTemplate>
                        <PagerStyle HorizontalAlign="Center"  BackColor="#284775" ForeColor="White" />
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>

    <asp:ObjectDataSource ID="odsrcSearchFctst" runat="server" 
        OldValuesParameterFormatString="original_{0}" 
        SelectMethod="GetMainProjectInfoForFactsheet" 
            TypeName="FactSheetApp.FactSheetNewTableAdapters.SearchProjectInfoTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlManager" Name="Name" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="txtProjectNum" Name="projectCode" 
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtProjTitle" Name="ProjectTitle" PropertyName="Text" 
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    </div>
     </asp:Panel>  
           </td></tr></table>


</asp:Content>
