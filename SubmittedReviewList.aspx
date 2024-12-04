<%@ Page Title="Review List" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="SubmittedReviewList.aspx.vb" Inherits="CFMISNew.SubmittedReviewList" %>
<%@ Register Src="~/UserControl/UCMenuAdmin.ascx" TagPrefix="uc1" TagName="UCMenuAdmin" %>
<%@ Register Src="~/UserControl/UCMenuGeneral.ascx" TagPrefix="uc1" TagName="UCMenuGeneral" %>
<%@ Register Src="~/UserControl/UCMenuEnvEngineer.ascx" TagPrefix="uc1" TagName="UCMenuEnvEngineer" %> 
<%@ Register Src="~/UserControl/UCMenuEnvDirector.ascx" TagPrefix="uc1" TagName="UCMenuEnvDirector" %> 
<%@ Register Src="~/UserControl/UCMenuSustainability.ascx" TagPrefix="uc1" TagName="UCMenuSustainability" %> 
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="false"></asp:ScriptManager>
    <table width="98%"><tr>
<%--        
       <td  style="vertical-align:top; width:200px">
         <uc1:UCMenuAdmin runat="server" id="UCMenuAdmin" />
         <uc1:UCMenuGeneral runat="server" ID="UCMenuGeneral" />
         <uc1:UCMenuEnvEngineer runat="server" id="UCMenuEnvEngineer" />
         <uc1:UCMenuEnvDirector runat="server" id="UCMenuEnvDirector" />
       </td>
    --%>
        
        <td valign="top" width="20%"> 
            <div style="padding-left:25px;  height:475px; background-color:#b3ccff;">
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblRole" runat="server" Visible="False"></asp:Label>
                            <uc1:UCMenuAdmin runat="server" id="UCMenuAdmin" />
                            <uc1:UCMenuGeneral runat="server" ID="UCMenuGeneral" />
                            <uc1:UCMenuEnvEngineer runat="server" id="UCMenuEnvEngineer" />
                            <uc1:UCMenuEnvDirector runat="server" id="UCMenuEnvDirector" />
                            <uc1:UCMenuSustainability runat="server" id="UCMenuSustainability" />
                        </td>
                    </tr>
                </table>
            </div>
         </td> 

        <td valign="top">                   
<div style="padding-left:5px;">

    <asp:Label ID="lblAccessMsg" runat="server" Text="This page is for Regional and Final Reviewers of the Factsheet." Visible="False" Font-Bold="True" Font-Size="Medium"></asp:Label>
    <asp:Panel ID="pnlFinalReview" runat="server">
    <asp:Label ID="lblReviewListHdg" runat="server" Text="List of projects submitted for final review:" Font-Bold="True" Font-Size="12px"></asp:Label>
    <br />
    <br />
    <asp:GridView ID="gvSubmittedReview" runat="server" AllowPaging="True" AllowSorting="True" OnDataBound="gvSubmittedReview_DataBound"
        AutoGenerateColumns="False" DataSourceID="odsrcListOfSubmittedReview"
        EmptyDataText="No match found"  ForeColor="#333333" GridLines="None" Width="90%">
         <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>           
            <asp:HyperLinkField DataNavigateUrlFields="ProjectID" DataNavigateUrlFormatString="FSDetails.aspx?project_pk={0}" DataTextField="projectno" HeaderText="Project #" ItemStyle-ForeColor="#0000CC" SortExpression="projectCode">
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle Font-Bold="False" Font-Underline="True" ForeColor="Blue" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="city" HeaderText="City" SortExpression="city" >
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="state" HeaderText="State" SortExpression="state" >
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="mainProjectTitle" HeaderText="Project Title" SortExpression="mainProjectTitle" >
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="full_name" HeaderText="Project Manager" SortExpression="full_name" >
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="VISN" HeaderText="VISN" SortExpression="VISN" >
            <HeaderStyle HorizontalAlign="Center" />
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="region" HeaderText="Region" SortExpression="region" >
            <HeaderStyle HorizontalAlign="Center" />
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="submitDate" DataFormatString="{0:d}" HeaderText="Submitted" SortExpression="submitDate">
            <HeaderStyle HorizontalAlign="Center" />
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="projectID" HeaderText="projectID" SortExpression="projectID" Visible="False" />
        </Columns>
        <PagerTemplate>
                    <asp:LinkButton ID="lbFirst" runat="server" CommandArgument="First" Enabled= '<%#IIf((gvSubmittedReview.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="Black">&lt;&lt; First</asp:LinkButton>
                    <asp:LinkButton ID="lbPrev" runat="server" CommandArgument="Prev" Enabled= '<%#IIf((gvSubmittedReview.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="Black">&lt; Prev</asp:LinkButton> 
                    [Total Pg No: <%=gvSubmittedReview.PageCount%>][Current pg: <%=gvSubmittedReview.PageIndex + 1%>]
                    <asp:LinkButton ID="lbNext" runat="server" CommandArgument="Next" Enabled= '<%#IIf((gvSubmittedReview.PageCount)=(gvSubmittedReview.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="Black">Next &gt;</asp:LinkButton>
                    <asp:LinkButton ID="lbLast" runat="server" CommandArgument="Last" Enabled= '<%#IIf((gvSubmittedReview.PageCount)=(gvSubmittedReview.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="Black">Last &gt;&gt;</asp:LinkButton><br />
                         <asp:Label ID="lblGoTo" runat="server" Text="Go to Pg:"></asp:Label>    
                    <asp:DropDownList ID="ddlPaging" runat="server" AutoPostBack="True" 
                        Height="21px" OnSelectedIndexChanged="ddlPaging_SelectedIndexChanged" 
                        Width="45px">
                    </asp:DropDownList>
                    <asp:Label ID="lblCurrentPg" runat="server"></asp:Label>    
                </PagerTemplate>
                        <PagerStyle HorizontalAlign="Center"  BackColor="#A8BFE1" ForeColor="White" />
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

    <asp:ObjectDataSource ID="odsrcListOfSubmittedReview" runat="server" OldValuesParameterFormatString="original_{0}" 
        SelectMethod="GetSubmittedFinalReview" TypeName="FactSheetApp.FactSheetNewTableAdapters.SubmittedReviewForDirectorTableAdapter">
        <InsertParameters>           
        </InsertParameters>
        <UpdateParameters>          
        </UpdateParameters>
    </asp:ObjectDataSource>
        <br />
        
        <asp:Button ID="btnViewAll" runat="server" Text="View All Lists" />

</asp:Panel>
    <br />

    <asp:Panel ID="pnlEastReview" runat="server">
     <asp:Label ID="lblReviewForDirectorEast" runat="server" Text="List of projects submitted for review for Director (East):" Font-Bold="True" Font-Size="12px"></asp:Label>
    <br />

    <asp:GridView ID="gvSubmittedReviewForEastDirector" runat="server" AutoGenerateColumns="False" DataSourceID="odsrcReviewForEastDirector" OnDataBound="gvSubmittedReviewForEastDirector_DataBound"
         EmptyDataText="No match found"  ForeColor="#333333" GridLines="None" Width="90%" AllowPaging="True" AllowSorting="True" DataKeyNames="projectID"  >
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="projectno" HeaderText="Project #" SortExpression="projectno" Visible="False" />
            <asp:HyperLinkField DataNavigateUrlFields="ProjectID" DataNavigateUrlFormatString="FSDetails.aspx?project_pk={0}" DataTextField="projectno" HeaderText="Project #" ItemStyle-ForeColor="#0000CC" SortExpression="projectCode" >
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle Font-Bold="False" Font-Underline="True" ForeColor="Blue" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="mainProjectTitle" HeaderText="Project Title" SortExpression="mainProjectTitle" >
            <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="city" HeaderText="City" SortExpression="city" >
            <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="state" HeaderText="State" SortExpression="state" >
            <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="full_name" HeaderText="Project Manager" SortExpression="full_name" >
            <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="region" HeaderText="Region" SortExpression="region" Visible="False" >
            <HeaderStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="VISN" HeaderText="VISN" SortExpression="VISN">
            <HeaderStyle HorizontalAlign="Center" />
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="submitDate" DataFormatString="{0:d}" HeaderText="Submitted" SortExpression="submitDate" >
            <HeaderStyle HorizontalAlign="Center" />
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="projectID" HeaderText="projectID" SortExpression="projectID" Visible="False" />
        </Columns>
        <PagerTemplate>
                    <asp:LinkButton ID="lbFirst" runat="server" CommandArgument="First" Enabled= '<%#IIf((gvSubmittedReviewForEastDirector.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="Black">&lt;&lt; First</asp:LinkButton>
                    <asp:LinkButton ID="lbPrev" runat="server" CommandArgument="Prev" Enabled= '<%#IIf((gvSubmittedReviewForEastDirector.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="Black">&lt; Prev</asp:LinkButton> 
                    [Total Pg No: <%=gvSubmittedReviewForEastDirector.PageCount%>][Current pg: <%=gvSubmittedReviewForEastDirector.PageIndex + 1%>]
                    <asp:LinkButton ID="lbNext" runat="server" CommandArgument="Next" Enabled= '<%#IIf((gvSubmittedReviewForEastDirector.PageCount)=(gvSubmittedReviewForEastDirector.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="Black">Next &gt;</asp:LinkButton>
                    <asp:LinkButton ID="lbLast" runat="server" CommandArgument="Last" Enabled= '<%#IIf((gvSubmittedReviewForEastDirector.PageCount)=(gvSubmittedReviewForEastDirector.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="Black">Last &gt;&gt;</asp:LinkButton><br />
                         <asp:Label ID="lblGoTo" runat="server" Text="Go to Pg:"></asp:Label>    
                    <asp:DropDownList ID="ddlPagingEast" runat="server" 
                        Height="21px" 
                        Width="45px" OnSelectedIndexChanged="ddlPagingEast_SelectedIndexChanged">
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

    <asp:ObjectDataSource ID="odsrcReviewForEastDirector" runat="server" OldValuesParameterFormatString="original_{0}" 
        SelectMethod="GetSubmitReviewForDirectorEast" TypeName="FactSheetApp.FactSheetNewTableAdapters.SubmittedReviewForDirectorTableAdapter"></asp:ObjectDataSource>
        </asp:Panel>
      <br />
    <asp:Panel ID="pnlWestReview" runat="server">
     <asp:Label ID="lblReviewForDirectorWest" runat="server" Text="List of projects submitted for review for Director (West):" Font-Bold="True" Font-Size="12px"></asp:Label>
    <br />
    <asp:GridView ID="gvSubmittedReviewForWestDirector" runat="server" AutoGenerateColumns="False" OnDataBound="gvSubmittedReviewForWestDirector_DataBound" AllowSorting="True"
         DataSourceID="odsrcReviewForWestDirector" EmptyDataText="No match found"  ForeColor="#333333" GridLines="None" Width="90%" AllowPaging="True" DataKeyNames="projectID" >
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="projectno" HeaderText="projectno" SortExpression="projectno" Visible="False" />
             <asp:HyperLinkField DataNavigateUrlFields="ProjectID" DataNavigateUrlFormatString="FSDetails.aspx?project_pk={0}" DataTextField="projectNo" HeaderText="Project #" ItemStyle-ForeColor="#0000CC" SortExpression="projectCode" >
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle Font-Bold="False" Font-Underline="True" ForeColor="Blue" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="city" HeaderText="City" SortExpression="city" >
            <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="state" HeaderText="State" SortExpression="state" >
            <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="mainProjectTitle" HeaderText="Project Title" SortExpression="mainProjectTitle" >
            <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="full_name" HeaderText="Project Manager" SortExpression="full_name" >
            <HeaderStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="region" HeaderText="Region" SortExpression="region" Visible="False" >
            <HeaderStyle HorizontalAlign="Center" />
            <ItemStyle HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:BoundField DataField="VISN" HeaderText="VISN" SortExpression="VISN">
            <HeaderStyle HorizontalAlign="Center" />
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="submitDate" DataFormatString="{0:d}" HeaderText="Submitted" SortExpression="submitDate" >
            <HeaderStyle HorizontalAlign="Center" />
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="projectID" HeaderText="projectID" SortExpression="projectID" Visible="False" />
        </Columns>
        <PagerTemplate>
                    <asp:LinkButton ID="lbFirst" runat="server" CommandArgument="First" Enabled= '<%#IIf((gvSubmittedReviewForWestDirector.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="Black">&lt;&lt; First</asp:LinkButton>
                    <asp:LinkButton ID="lbPrev" runat="server" CommandArgument="Prev" Enabled= '<%#IIf((gvSubmittedReviewForWestDirector.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="Black">&lt; Prev</asp:LinkButton> 
                    [Total Pg No: <%=gvSubmittedReviewForWestDirector.PageCount%>][Current pg: <%=gvSubmittedReviewForWestDirector.PageIndex + 1%>]
                    <asp:LinkButton ID="lbNext" runat="server" CommandArgument="Next" Enabled= '<%#IIf((gvSubmittedReviewForWestDirector.PageCount)=(gvSubmittedReviewForWestDirector.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="Black">Next &gt;</asp:LinkButton>
                    <asp:LinkButton ID="lbLast" runat="server" CommandArgument="Last" Enabled= '<%#IIf((gvSubmittedReviewForWestDirector.PageCount)=(gvSubmittedReviewForWestDirector.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="Black">Last &gt;&gt;</asp:LinkButton><br />
                         <asp:Label ID="lblGoTo" runat="server" Text="Go to Pg:"></asp:Label>    
                    <asp:DropDownList ID="ddlPagingWest" runat="server" AutoPostBack="True" 
                        Height="21px"  
                        Width="45px" OnSelectedIndexChanged="ddlPagingWest_SelectedIndexChanged">
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

    <asp:ObjectDataSource ID="odsrcReviewForWestDirector" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetSubmitReviewForDirectorWest" TypeName="FactSheetApp.FactSheetNewTableAdapters.SubmittedReviewForDirectorTableAdapter"></asp:ObjectDataSource>
</asp:Panel>
    
      <br />
    <asp:Panel ID="pnlCentralReview" runat="server">
     <asp:Label ID="lblReviewForDirectorCentral" runat="server" Text="List of projects submitted for review for Director (Central):" Font-Bold="True" Font-Size="12px"></asp:Label>
    <br />
    <asp:GridView ID="gvSubmittedReviewForCentralDirector" runat="server" AutoGenerateColumns="False" OnDataBound="gvSubmittedReviewForCentralDirector_DataBound" AllowSorting="True"
        DataSourceID="odsrcSubmittedReviewCentralDirector" EmptyDataText="No match found"  ForeColor="#333333" GridLines="None" Width="90%" AllowPaging="True" DataKeyNames="projectID" >
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
         <Columns>
            <asp:BoundField DataField="projectno" HeaderText="projectno" SortExpression="projectno" Visible="False" />
            <asp:HyperLinkField DataNavigateUrlFields="ProjectID" DataNavigateUrlFormatString="FSDetails.aspx?project_pk={0}" DataTextField="projectNo" HeaderText="Project #" ItemStyle-ForeColor="#0000CC" SortExpression="projectCode" >
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle Font-Bold="False" Font-Underline="True" ForeColor="Blue" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="city" HeaderText="City" SortExpression="city" >
             <HeaderStyle HorizontalAlign="Left" />
             </asp:BoundField>
            <asp:BoundField DataField="state" HeaderText="State" SortExpression="state" >
             <HeaderStyle HorizontalAlign="Left" />
             </asp:BoundField>
            <asp:BoundField DataField="mainProjectTitle" HeaderText="Project Title" SortExpression="mainProjectTitle" >
             <HeaderStyle HorizontalAlign="Left" />
             </asp:BoundField>
            <asp:BoundField DataField="full_name" HeaderText="Project Manager" SortExpression="full_name" >
             <HeaderStyle HorizontalAlign="Left" />
             </asp:BoundField>
            <asp:BoundField DataField="VISN" HeaderText="VISN" SortExpression="VISN">
            <HeaderStyle HorizontalAlign="Center" />
            <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="submitDate" DataFormatString="{0:d}" HeaderText="Submitted" SortExpression="submitDate" >
             <HeaderStyle HorizontalAlign="Center" />
             <ItemStyle HorizontalAlign="Center" />
             </asp:BoundField>
            <asp:BoundField DataField="projectID" HeaderText="projectID" SortExpression="projectID" Visible="False" />
            <asp:BoundField DataField="region" HeaderText="region" SortExpression="region" Visible="False" />
        </Columns>
        <PagerTemplate>
                    <asp:LinkButton ID="lbFirst" runat="server" CommandArgument="First" Enabled= '<%#IIf((gvSubmittedReviewForCentralDirector.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="Black">&lt;&lt; First</asp:LinkButton>
                    <asp:LinkButton ID="lbPrev" runat="server" CommandArgument="Prev" Enabled= '<%#IIf((gvSubmittedReviewForCentralDirector.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="Black">&lt; Prev</asp:LinkButton> 
                    [Total Pg No: <%=gvSubmittedReviewForCentralDirector.PageCount%>][Current pg: <%=gvSubmittedReviewForCentralDirector.PageIndex + 1%>]
                    <asp:LinkButton ID="lbNext" runat="server" CommandArgument="Next" Enabled= '<%#IIf((gvSubmittedReviewForCentralDirector.PageCount)=(gvSubmittedReviewForCentralDirector.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="Black">Next &gt;</asp:LinkButton>
                    <asp:LinkButton ID="lbLast" runat="server" CommandArgument="Last" Enabled= '<%#IIf((gvSubmittedReviewForCentralDirector.PageCount)=(gvSubmittedReviewForCentralDirector.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="Black">Last &gt;&gt;</asp:LinkButton><br />
                         <asp:Label ID="lblGoTo" runat="server" Text="Go to Pg:"></asp:Label>    
                    <asp:DropDownList ID="ddlPagingCentral" runat="server" AutoPostBack="True" 
                        Height="21px"  
                        Width="45px" OnSelectedIndexChanged="ddlPagingCentral_SelectedIndexChanged">
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

    <asp:ObjectDataSource ID="odsrcSubmittedReviewCentralDirector" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetSubmitReviewForDirectorCentral" TypeName="FactSheetApp.FactSheetNewTableAdapters.SubmittedReviewForDirectorTableAdapter"></asp:ObjectDataSource>
</asp:Panel>
    <br />

    <asp:Panel ID="pnlNCAReview" runat="server">
        <asp:Label ID="lblReviewForDirectorNCA" runat="server" Text="List of projects submitted for review for Director (NCA):" Font-Bold="True" Font-Size="12px"></asp:Label>
    <br />
        <asp:GridView ID="gvSubmittedReviewForNCADirector" runat="server" AutoGenerateColumns="False" OnDataBound="gvSubmittedReviewForNCADirector_DataBound" 
            DataSourceID="odsrcNCAReviewList" AllowSorting="True" EmptyDataText="No match found"  
            ForeColor="#333333" GridLines="None" Width="90%" AllowPaging="True" DataKeyNames="projectID" >
            <Columns>
                <asp:BoundField DataField="projectno" HeaderText="projectno" SortExpression="projectno" Visible="False" />
                <asp:HyperLinkField DataNavigateUrlFields="ProjectID" DataNavigateUrlFormatString="FSDetails.aspx?project_pk={0}" DataTextField="projectNo" HeaderText="Project #" ItemStyle-ForeColor="#0000CC" SortExpression="projectCode" >
            <HeaderStyle HorizontalAlign="Left" />
            <ItemStyle Font-Bold="False" Font-Underline="True" ForeColor="Blue" />
            </asp:HyperLinkField>
                <asp:BoundField DataField="city" HeaderText="City" SortExpression="city" >
                <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="state" HeaderText="State" SortExpression="state" >
                <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="mainProjectTitle" HeaderText="Project Title" SortExpression="mainProjectTitle" >
                <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="full_name" HeaderText="Project Manager" SortExpression="full_name" >
                <HeaderStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="projectID" HeaderText="projectID" SortExpression="projectID" Visible="False" />
                <asp:BoundField DataField="VISN" HeaderText="VISN" SortExpression="VISN" >
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="submitDate" DataFormatString="{0:d}" HeaderText="Submited" SortExpression="submitDate" >
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="region" HeaderText="Region" SortExpression="region" Visible="False" />
            </Columns>
                    <PagerTemplate>
                    <asp:LinkButton ID="lbFirst" runat="server" CommandArgument="First" Enabled= '<%#IIf((gvSubmittedReviewForNCADirector.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="Black">&lt;&lt; First</asp:LinkButton>
                    <asp:LinkButton ID="lbPrev" runat="server" CommandArgument="Prev" Enabled= '<%#IIf((gvSubmittedReviewForNCADirector.PageIndex)<1,"false","true")%>'
                        CommandName="Page" ForeColor="Black">&lt; Prev</asp:LinkButton> 
                    [Total Pg No: <%=gvSubmittedReviewForNCADirector.PageCount%>][Current pg: <%=gvSubmittedReviewForNCADirector.PageIndex + 1%>]
                    <asp:LinkButton ID="lbNext" runat="server" CommandArgument="Next" Enabled= '<%#IIf((gvSubmittedReviewForNCADirector.PageCount)=(gvSubmittedReviewForNCADirector.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="Black">Next &gt;</asp:LinkButton>
                    <asp:LinkButton ID="lbLast" runat="server" CommandArgument="Last" Enabled= '<%#IIf((gvSubmittedReviewForNCADirector.PageCount)=(gvSubmittedReviewForNCADirector.PageIndex + 1),"false","true")%>'
                        CommandName="Page" ForeColor="Black">Last &gt;&gt;</asp:LinkButton><br />
                         <asp:Label ID="lblGoTo" runat="server" Text="Go to Pg:"></asp:Label>    
                    <asp:DropDownList ID="ddlPagingNCA" runat="server" AutoPostBack="True" 
                        Height="21px"  
                        Width="45px" OnSelectedIndexChanged="ddlPagingNCA_SelectedIndexChanged">
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

        <asp:ObjectDataSource ID="odsrcNCAReviewList" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetSubmitReviewForDirectorNCA" TypeName="CFMISNew.FactSheetNewTableAdapters.SubmittedReviewForDirectorTableAdapter"></asp:ObjectDataSource>
        <br />
        <br />
    </asp:Panel>
</div>
 </td></tr></table>
</asp:Content>
