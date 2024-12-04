<%@ Page Title="Station Info" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="StationInfo.aspx.vb" Inherits="CFMISNew.StationInfo" %>

<%@ Register Src="~/UserControl/UCMenuAdmin.ascx" TagPrefix="uc1" TagName="UCMenuAdmin" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
    <style type="text/css">
        .auto-style2 {
            height: 27px;
        }
        .auto-style3 {
            height: 29px;
        }
    </style>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <table style="width:98%;"><tr>
<%--    <td valign="top" width="15%">
           <uc1:UCMenuAdmin runat="server" ID="UCMenuAdmin" />
        </td>--%>
        
            <td valign="top" width="20%"> 
               <div style="padding-left:25px;  height:475px; background-color:#b3ccff;">
                 <table>
                    <tr>
                        <td>
                            <uc1:UCMenuAdmin runat="server" id="UCMenuAdmin1" />
                        </td>
                    </tr>
                 </table>
               </div>
            </td>
        <td valign="top">
        <div class="wideBox" style="padding-left:15px">
            <h3>Search for a Station</h3>
            <asp:Panel ID="pnlSearchStation" runat="server" DefaultButton="btnSearchStn">
<table><tr><td class="auto-style3">
    <asp:Label ID="lblSearchStnNo" runat="server" Text="Station Number:" Font-Bold="True"></asp:Label>
       </td><td class="auto-style3">
           <asp:TextBox ID="txtSearchStnNo" runat="server" Width="212px"></asp:TextBox>
       </td>
    <td class="auto-style3"></td>
    </tr>
    <tr>
        <td class="auto-style3">
            <asp:Label ID="lblSeachStnName" runat="server" Font-Bold="True" Text="Station Name:"></asp:Label>
        </td>
        <td class="auto-style3">
            <asp:TextBox ID="txtSearchStnName" runat="server" Width="212px"></asp:TextBox>
        </td>
        <td class="auto-style3"></td>
    </tr>
    <tr>
        <td class="auto-style3">
            <asp:Label ID="lblSearchStnCity" runat="server" Font-Bold="True" Text="City:"></asp:Label>
        </td>
        <td class="auto-style3">
            <asp:TextBox ID="txtSearchStnCity" runat="server" Width="212px"></asp:TextBox>
        </td>
        <td class="auto-style3"></td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblSearchStnState" runat="server" Font-Bold="True" Text="State:"></asp:Label>
        </td>
        <td class="auto-style2">
            <asp:DropDownList ID="ddlSearchStnState" runat="server" Width="214px" DataSourceID="sdsrcState" 
                DataTextField="stateName" DataValueField="stateName" AppendDataBoundItems="True">
                <asp:ListItem Text="-Select-" Value=""></asp:ListItem>
            </asp:DropDownList>
        </td>
        <td class="auto-style2">
            <asp:SqlDataSource ID="sdsrcState" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" 
                SelectCommand="SELECT [State_pk], [stateCode], [stateName] FROM [lkState] order by stateName"></asp:SqlDataSource>
        </td>
    </tr></table>
<br />

<table style="width: 318px"><tr><td>
         <asp:Button ID="btnSearchStn" runat="server" Text="Search" Font-Bold="True" Width="100px" />
       </td><td>
         <asp:Button ID="btnStnReset" runat="server" Text="Reset" Font-Bold="True" Width="100px" />
       </td></tr></table>
            </asp:Panel>
            <br />
    <asp:Label ID="lblStnSearchError" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
</div>
        <asp:Panel ID="pnlShowGrid" runat="server" Visible="False">
    <div class="wideBox" style="padding-left:15px">
<%--   <h3>Search Results</h3>--%>
        <table width="98%"><tr><td align="left">
            Showing records <%=gvStnSearch.PageIndex * gvStnSearch.PageSize + 1%> -
                    <%=(gvStnSearch.PageIndex * gvStnSearch.PageSize + gvStnSearch.Rows.Count)%> 
        <asp:Label ID="lblTotalRec" runat="server"></asp:Label>            
        </td><td align="right">
            <asp:Label ID="lblPageSize" runat="server" Text="Show records per page: "></asp:Label>
        </td><td align="left">
                        <asp:DropDownList ID="ddlPageSize" runat="server" AppendDataBoundItems="True" 
                        AutoPostBack="True" Height="21px" 
                        onselectedindexchanged="ddlPageSize_SelectedIndexChanged" Width="48px">
                        <asp:ListItem>10</asp:ListItem>
                        <asp:ListItem>25</asp:ListItem>
                        <asp:ListItem>50</asp:ListItem>
                        <asp:ListItem>100</asp:ListItem>
                    </asp:DropDownList>
        </td>
        </tr>                           
        </table>
    <asp:GridView ID="gvStnSearch" runat="server" AutoGenerateColumns="False" 
         Width="98%" OnDataBound="gvStnSearch_DataBound" DataSourceID="odsrcSearchStn" 
         AllowPaging="True" EmptyDataText="No match found" 
        AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" Font-Size="12px">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="stationt_pk" HeaderText="station_pk" SortExpression="station_pk" Visible="False" />
            <asp:HyperLinkField DataNavigateUrlFields="station_pk" DataNavigateUrlFormatString="StationDetails.aspx?station_pk={0}" DataTextField="stationNo" HeaderText="Station #" ItemStyle-ForeColor="#0000CC" SortExpression="projectCode">
            <ItemStyle Font-Bold="False" Font-Underline="True" ForeColor="Blue" Wrap="False" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="stationName" HeaderText="Station Name" SortExpression="stationName">
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle Font-Bold="False" HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="stationdesc" HeaderText="Description" SortExpression="stationdesc">
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle Font-Bold="False" HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="stateName" HeaderText="State" SortExpression="stateName">
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle Font-Bold="False" HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="city" HeaderText="City" SortExpression="city">
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle Font-Bold="False" HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="region" HeaderText="Region" SortExpression="region" >
             <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:CheckBoxField DataField="deleted" HeaderText="Deleted" SortExpression="deleted">
            <HeaderStyle HorizontalAlign="Center" />
            <ItemStyle Font-Bold="False" HorizontalAlign="Center" />
            </asp:CheckBoxField>          
            <%--<asp:TemplateField SortExpression="deleted">
                <ItemTemplate>
                    <asp:CheckBox ID="cbDeleted" runat="server"  Text='<%# Bind("deleted") %>' Enabled="False" />
                </ItemTemplate>
            </asp:TemplateField>--%>
            
        </Columns>
        <PagerTemplate>
                    <asp:LinkButton ID="lbFirst" runat="server" CommandArgument="First" Enabled= '<%#IIf((gvStnSearch.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="White">&lt;&lt; First</asp:LinkButton>
                    <asp:LinkButton ID="lbPrev" runat="server" CommandArgument="Prev" Enabled= '<%#IIf((gvStnSearch.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="White">&lt; Prev</asp:LinkButton> 
                    [Total Pg No: <%=gvStnSearch.PageCount%>][Current pg: <%=gvStnSearch.PageIndex + 1%>]
                    <asp:LinkButton ID="lbNext" runat="server" CommandArgument="Next" Enabled= '<%#IIf((gvStnSearch.PageCount)=(gvStnSearch.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="White">Next &gt;</asp:LinkButton>
                    <asp:LinkButton ID="lbLast" runat="server" CommandArgument="Last" Enabled= '<%#IIf((gvStnSearch.PageCount)=(gvStnSearch.PageIndex + 1),"false","true")%>'
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
    <asp:ObjectDataSource ID="odsrcSearchStn" runat="server" 
        SelectMethod="GetSearchStation" 
            TypeName="FactSheetApp.FactSheetNewTableAdapters.StationInfoTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtSearchStnNo" Name="StnNo" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtSearchStnName" Name="StnName" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtSearchStnCity" Name="StnCity" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="ddlSearchStnState" Name="StnState" PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    </div>
     </asp:Panel>  


    </td></tr></table>

</asp:Content>
