<%@ Page Title="Report page" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ReportViewer.aspx.vb" Inherits="CFMISNew.ReportViewer" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%--<script type="text/javascript">
        window.open('https://vacosqdrep12.dva.va.gov/ReportServer12Dev', 'title', 'type=fullWindow, fullscreen, scrollbars=yes');

    </script>--%> 

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="padding-left: 150px;">
    <div align="center" style="width: 80%; height: 100%; padding-left: 5px; padding-right: 5px; background-color: white;">
        <rsweb:ReportViewer ID="rvFS" runat="server" Width="100%" Height="100%" ProcessingMode="Remote" SizeToReportContent="true" >
             <%-- Dev--%>
<%--            <ServerReport ReportServerUrl="xhttps://vacosqdrep12.dva.va.gov/ReportServer12Dev" />--%>
           <%-- Prod--%>
          <%--  <ServerReport ReportServerUrl="xhttps://vacosqlrep12.dva.va.gov/Reportserver" />--%>
            <ServerReport ReportServerUrl="http://vacoappssrs.dva.va.gov/Reportserver" />

        </rsweb:ReportViewer>
    </div>
    </div>
</asp:Content>
