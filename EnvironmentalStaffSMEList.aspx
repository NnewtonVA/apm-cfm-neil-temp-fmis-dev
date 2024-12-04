<%@ Page Title="Environmental Staff SME List" Language="vb"  AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="EnvironmentalStaffSMEList.aspx.vb" Inherits="CFMISNew.EnvironmentalStaffSMEList" %>

<%@ Register Src="~/UserControl/UCMenuAdmin.ascx" TagPrefix="uc1" TagName="UCMenuAdmin" %>
<%@ Register Src="~/UserControl/UCMenuGeneral.ascx" TagPrefix="uc1" TagName="UCMenuGeneral" %>
<%@ Register Src="~/UserControl/UCMenuEnvEngineer.ascx" TagPrefix="uc1" TagName="UCMenuEnvEngineer" %> 
<%@ Register Src="~/UserControl/UCMenuEnvDirector.ascx" TagPrefix="uc1" TagName="UCMenuEnvDirector" %> 

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="false"></asp:ScriptManager>
    <table width="98%"><tr>
  
<%--        <td  style="vertical-align:top; width:200px">
           <uc1:UCMenuAdmin runat="server" id="UCMenuAdmin" />
           <uc1:UCMenuGeneral runat="server" ID="UCMenuGeneral" />
           <uc1:UCMenuEnvEngineer runat="server" id="UCMenuEnvEngineer" />
           <uc1:UCMenuEnvDirector runat="server" id="UCMenuEnvDirector" />
        </td>--%>
        
        <td valign="top" width="20%"> 
              <div style="padding-left:25px;  height:475px; background-color:#b3ccff;">
                 <table>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" Visible="False"></asp:Label>
                            <uc1:UCMenuAdmin runat="server" id="UCMenuAdmin" />
                            <uc1:UCMenuGeneral runat="server" ID="UCMenuGeneral" />
                            <uc1:UCMenuEnvEngineer runat="server" id="UCMenuEnvEngineer" />
                            <uc1:UCMenuEnvDirector runat="server" id="UCMenuEnvDirector" />
                        </td>
                    </tr>
                 </table>
              </div>
        </td> 

        <td valign="top">                   
<div style="padding-left:10px;">
    <br />
    <asp:Label ID="lblPendingHdg" runat="server" Text="List of Environmental Staff SME forms:" Font-Size="14px" Font-Bold="True"></asp:Label>
    <br />
    <br />
    <asp:GridView ID="gvEnvironmentalStaffSMESummary" runat="server" AutoGenerateColumns="False" DataKeyNames="project_pk" DataSourceID="sdsrcEnvironmentalStaffSMESummary" AllowSorting="True" EmptyDataText="No match found"  
            ForeColor="#333333" GridLines="None" Width="98%" AllowPaging="True" OnDataBound="gvEnvironmentalStaffSMESummary_DataBound" PageSize="20" CssClass="gvPadding">
        <Columns>
            <%--<asp:BoundField DataField="projectCode" HeaderText="projectCode" SortExpression="projectCode" />--%>
            <asp:BoundField DataField="project_pk" HeaderText="project_pk" ReadOnly="True" SortExpression="project_pk" Visible="False" />
            <asp:HyperLinkField DataNavigateUrlFields="project_pk" DataNavigateUrlFormatString="EnvironmentalStaffForm.aspx?project_pk={0}" DataTextField="projectCode" HeaderText="Project #" ItemStyle-ForeColor="#0000CC" SortExpression="projectCode">
            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
            <ItemStyle Font-Bold="False" Font-Underline="True" ForeColor="Blue" Width="50px" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="projectDesc" HeaderText="Project Title" SortExpression="projectDesc" >
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle Width="400px" />
            </asp:BoundField>
            <asp:BoundField DataField="Region" HeaderText="Region" ReadOnly="True" SortExpression="Region" >
            <HeaderStyle HorizontalAlign="Left" />
                <ItemStyle Width="120px" />
            </asp:BoundField>
            <asp:BoundField DataField="city" HeaderText="City" SortExpression="city" >
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle Width="100px" />
            </asp:BoundField>
            <asp:BoundField DataField="stateName" HeaderText="State" SortExpression="stateName" >
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle Width="100px" />
            </asp:BoundField>
            <asp:BoundField DataField="Name" HeaderText="Project Manager" ReadOnly="True" SortExpression="Name" >
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle Width="200px" />
            </asp:BoundField>
            <asp:BoundField DataField="EnvEngineer" HeaderText="Environmental Engineer" ReadOnly="True" SortExpression="EnvEngineer" >
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle Width="200px" />
            </asp:BoundField>
<%--            <asp:BoundField DataField="NEPAStatus" HeaderText="NEPA Status" ReadOnly="True" SortExpression="NEPAStatus" >
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle Width="110px" />
            </asp:BoundField>--%>
            <asp:BoundField DataField="submitdate" HeaderText="Initial Response Submitted Date" ReadOnly="True" SortExpression="submitdate" DataFormatString="{0:d}">
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle Wrap="False" Width="200px" />
            </asp:BoundField>

        </Columns>
        <PagerTemplate>
                    <asp:LinkButton ID="lbFirst" runat="server" CommandArgument="First" Enabled= '<%#IIf((gvEnvironmentalStaffSMESummary.PageIndex) < 1, "false", "true")%>'
                        CommandName="Page" ForeColor="Black">&lt;&lt; First</asp:LinkButton>
                    <asp:LinkButton ID="lbPrev" runat="server" CommandArgument="Prev" Enabled= '<%#IIf((gvEnvironmentalStaffSMESummary.PageIndex) < 1, "false", "true")%>'
                        CommandName="Page" ForeColor="Black">&lt; Prev</asp:LinkButton> 
                    [Total Pg No: <%=gvEnvironmentalStaffSMESummary.PageCount%>][Current pg: <%=gvEnvironmentalStaffSMESummary.PageIndex + 1%>]
                    <asp:LinkButton ID="lbNext" runat="server" CommandArgument="Next" Enabled= '<%#IIf((gvEnvironmentalStaffSMESummary.PageCount) = (gvEnvironmentalStaffSMESummary.PageIndex + 1), "false", "true")%>'
                        CommandName="Page" ForeColor="Black">Next &gt;</asp:LinkButton>
                    <asp:LinkButton ID="lbLast" runat="server" CommandArgument="Last" Enabled= '<%#IIf((gvEnvironmentalStaffSMESummary.PageCount) = (gvEnvironmentalStaffSMESummary.PageIndex + 1), "false", "true")%>'
                        CommandName="Page" ForeColor="Black">Last &gt;&gt;</asp:LinkButton><br />
                         <asp:Label ID="lblGoTo" runat="server" Text="Go to Pg:"></asp:Label>    
                    <asp:DropDownList ID="ddlPagingPending" runat="server" AutoPostBack="True" 
                        Height="21px"  
                        Width="45px" OnSelectedIndexChanged="ddlPagingPending_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:Label ID="lblCurrentPg" runat="server"></asp:Label>    
                </PagerTemplate>
                        <PagerStyle HorizontalAlign="Center"  BackColor="#A3BBE0" ForeColor="Black" />
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

    <asp:SqlDataSource ID="sdsrcEnvironmentalStaffSMESummary" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" 
        SelectCommand="EnvironmentalStaffSMESummary" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
</div>
 </td></tr></table>
</asp:Content>


