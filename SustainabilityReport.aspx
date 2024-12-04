<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="SustainabilityReport.aspx.vb" Inherits="CFMISNew.SustainabilityReport" %>
<%@ Register Src="~/UserControl/UCMenuAdmin.ascx" TagPrefix="uc1" TagName="UCMenuAdmin" %>
<%@ Register Src="~/UserControl/UCMenuGeneral.ascx" TagPrefix="uc1" TagName="UCMenuGeneral" %>
<%@ Register Src="~/UserControl/UCMenuEnvEngineer.ascx" TagPrefix="uc1" TagName="UCMenuEnvEngineer" %> 
<%@ Register Src="~/UserControl/UCMenuEnvDirector.ascx" TagPrefix="uc1" TagName="UCMenuEnvDirector" %> 
<%@ Register Src="~/UserControl/UCMenuSustainability.ascx" TagPrefix="uc1" TagName="UCMenuSustainability" %>

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
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">

    <table style="width:98%;">
        <tr><%--<td style="vertical-align:top; width:200px; height:675px;">
             <uc1:UCMenuAdmin runat="server" id="UCMenuAdmin" />
        <uc1:UCMenuGeneral runat="server" ID="UCMenuGeneral" />
        </td>--%>
        
        <td valign="top" width="20%"> 
            <div style="padding-left:25px;  height:475px; background-color:#b3ccff;">
                <table>
                    <tr>
                        <td>
                            <uc1:UCMenuAdmin runat="server" id="UCMenuAdmin" />
                            <uc1:UCMenuGeneral runat="server" id="UCMenuGeneral" />
                            <uc1:UCMenuEnvEngineer runat="server" id="UCMenuEnvEngineer" />
                            <uc1:UCMenuEnvDirector runat="server" id="UCMenuEnvDirector" />
                            <uc1:UCMenuSustainability runat="server" id="UCMenuSustainability" />
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
<%--                    <tr>
                        <td class="auto-style5">
                        </td>
                    </tr>--%>
                    <tr>
                        <td class="auto-style4">
                           <asp:HyperLink ID="hlSustainabilityReport" runat="server" Text="Sustainability Report" Font-Bold="True"  NavigateUrl="~/ReportViewerActive.aspx?report=Sustainability"></asp:HyperLink>
                        </td>
                        <td class="auto-style5">
                        </td>
                    </tr>
                </table>
            </div>
        </td></tr>
    </table>

</asp:Content>

