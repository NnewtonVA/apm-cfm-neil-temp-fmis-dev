<%@ Page Title="Login" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Login.aspx.vb" Inherits="CFMISNew.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <div  class="wideBox" style="padding-left:15px">
         <br />
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"  
            Text="You do not have access to this application. Please contact the administrator for proper access." Font-Size="14px"></asp:Label>
         <br />
         <div>
<h3> Guest user permission:</h3>
             <p style="font-size: 14px">
                 Guest user can search and view the published factsheets of a project. Please use the following link to view factsheets.
             </p>
             <asp:HyperLink ID="hlFactsheet" runat="server" NavigateUrl="~/ReportViewer.aspx?report=FactSheetreportPublic">View Archived Factsheets</asp:HyperLink>
             </div>
    </div>
</asp:Content>
