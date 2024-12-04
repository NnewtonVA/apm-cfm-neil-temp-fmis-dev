<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ErrorPage.aspx.vb" Inherits="CFMISNew.ErrorPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <asp:Label ID="lblErrorMessage" runat="server" CssClass="text-alert" Text="Unexpected error has occured. Please contact administrator." Font-Bold="True"></asp:Label>

</asp:Content>
