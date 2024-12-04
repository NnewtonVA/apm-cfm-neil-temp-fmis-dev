<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="EnvironmentalReport.aspx.vb" Inherits="CFMISNew.EnvironmentalReport" %>
<%@ Register Src="~/UserControl/UCMenuAdmin.ascx" TagPrefix="uc1" TagName="UCMenuAdmin" %>
<%@ Register Src="~/UserControl/UCMenuGeneral.ascx" TagPrefix="uc1" TagName="UCMenuGeneral" %>
<%@ Register Src="~/UserControl/UCMenuEnvEngineer.ascx" TagPrefix="uc1" TagName="UCMenuEnvEngineer" %> 
<%@ Register Src="~/UserControl/UCMenuEnvDirector.ascx" TagPrefix="uc1" TagName="UCMenuEnvDirector" %> 

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style4 {
            width: 153px;
            height: 25px;
        }
        .auto-style5 {
            width: 365px;
            height: 25px;
        }
        .auto-style6 {
            width: 153px;
            height: 30px;
        }
        .auto-style7 {
            width: 365px;
            height: 30px;
        }
    </style>
</asp:Content>
<%--<asp:Content ID="Content2" ContentPlaceHolderID="cphMainMenu" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphQuickMenu" runat="server">
</asp:Content>--%>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">

    <table style="width:98%;">
        <tr>
<%--        <td style="vertical-align:top; width:200px">
             <uc1:UCMenuAdmin runat="server" id="UCMenuAdmin" />
        <uc1:UCMenuGeneral runat="server" ID="UCMenuGeneral" />
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
            
            <td  valign="top">
            <div class="wideBox" style="padding-left:15px; height: 241px;">
                  <h3>View Active Reports:</h3>
                <table style="border: thin none #000080; height: 80px; width: 98%;">
                    <tr><td class="auto-style6" align="left" bgcolor="#D7D7D7">
                        <b>Report Name</b></td><td align="left" class="auto-style7" bgcolor="#D7D7D7">
                            <b>Report Description</b></td></tr>
                    <tr><td class="auto-style4">
                        <asp:HyperLink ID="hlVhaReport" runat="server" Text="Environmental 1st Report" Font-Bold="True" NavigateUrl="~/ReportViewerActive.aspx?report=EnvironmentalProject"></asp:HyperLink>
                    </td><td class="auto-style5">

                    </td></tr><tr><td class="auto-style4">
                        <asp:HyperLink ID="hlNcaReport" runat="server" Text="Environmental 2nd Report" Font-Bold="True"  NavigateUrl="~/ReportViewerActive.aspx?report=EnviroProjectReportDetail"></asp:HyperLink>
                    </td><td class="auto-style5">

                    </td></tr>

<%--                    <tr><td class="auto-style4">
                       <asp:HyperLink ID="hlVhaHistoryReport" runat="server" Text="Funding History for VHA" Font-Bold="True"  NavigateUrl="~/ReportViewerActive.aspx?report=AppendixFundingVHA"></asp:HyperLink>
                        </td><td class="auto-style5">

                            &nbsp;</td></tr>--%>

<%--                    <tr><td class="auto-style4">
                        <asp:HyperLink ID="hlFundingHistoryDetail" runat="server" Text="Funding History Detail for VHA" Font-Bold="True"  NavigateUrl="~/ReportViewerActive.aspx?report=FundingHisory_VHA"></asp:HyperLink>
                        </td><td class="auto-style5">

                            &nbsp;</td></tr>--%>

                </table>
            </div>

        </td></tr>

    </table>

</asp:Content>
