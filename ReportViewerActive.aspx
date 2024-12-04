<%@ Page Title="Reports" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ReportViewerActive.aspx.vb" Inherits="CFMISNew.ReportViewerActive" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<%--<asp:Content ID="Content2" ContentPlaceHolderID="cphMainMenu" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphQuickMenu" runat="server">
</asp:Content>--%>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <%--<div style="padding-left: 150px;">
    <div align="center" style="width: 80%; height: 100%; padding-left: 5px; padding-right: 5px; background-color: white;">--%>
        <rsweb:ReportViewer ID="rvFS" runat="server" Height="800px" Width="100%" ProcessingMode="Remote" Font-Size="8pt" >
             <%-- Dev--%>
<%--            <ServerReport ReportServerUrl="http://vacoappssrs.dva.va.gov/Reportserver" />    --%>
           <%-- Prod--%>
           <ServerReport ReportServerUrl="http://vacoappssrs.dva.va.gov/Reportserver" /> 

        </rsweb:ReportViewer>
    <%--</div>
    </div>--%>

</asp:Content>
