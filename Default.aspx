<%@ Page Title="Home Page" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="CFMISNew._Default" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/UserControl/UCMenuAdmin.ascx" TagPrefix="uc1" TagName="UCMenuAdmin" %>
<%@ Register Src="~/UserControl/UCMenuGeneral.ascx" TagPrefix="uc1" TagName="UCMenuGeneral" %>
<%@ Register Src="~/UserControl/UCMenuEnvEngineer.ascx" TagPrefix="uc1" TagName="UCMenuEnvEngineer" %> 
<%@ Register Src="~/UserControl/UCMenuEnvDirector.ascx" TagPrefix="uc1" TagName="UCMenuEnvDirector" %> 
<%@ Register Src="~/UserControl/UCMenuSustainability.ascx" TagPrefix="uc1" TagName="UCMenuSustainability" %> 


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
     <script type="text/javascript">

         function GoTo(url) {
             window.open(url);
         }
</script>

     <asp:ScriptManager runat="server" ID="tsmFactsheet"></asp:ScriptManager>

    <asp:Label ID="lblRole" runat="server" Visible="False"></asp:Label>
    <table style="width:98%;"><tr>        
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
        <td valign="top" width="60%">
                   <table><tr><td>
                     <div style="padding-left:20px;">
                   <p style="color: #000084; font-weight: bold; font-family:Arial; font-size:12px">
                       CFMIS is a Program and Budget planning tool that captures core project information and budget planning information which is used to distribute and 
                       report project information to various audiences, such as Congress. 
                       <br />
                       Users run reports based on the data available in CFMIS to create the Factsheet and publish it
                       for all users to review them.
                   </p>
               </div>
              </td></tr><tr><td>
                 <div class="Image" >
                    <table><tr><td>
                        <asp:ImageButton ID="imbtnPrev" runat="server" ImageUrl="~/Images/LeftArrow.png" Height="30px" Width="30px" />
                          </td><td>
                              <asp:Image ID="img1" runat="server" Height="200px" Width="300px" ImageUrl="~/images/Slide/sliderConstruction.png" />
                          </td><td>
                              <asp:ImageButton ID="imbtnNext" runat="server" ImageUrl="~/Images/RightArrow.png" Height="30px" Width="30px" />
                          </td></tr></table>
                      <asp:Label ID="lblDesc" runat="server" Text=""></asp:Label><br />
                      <asp:Button ID="btnPlay" runat="server" Text="" />
             
                </div>     
                     </td></tr></table>
                     
        <cc1:SlideShowExtender ID="sseFactsheet" runat="server" BehaviorID="SSBehaviorID"
            TargetControlID="img1" 
            SlideShowServiceMethod="GetSlides" 
            AutoPlay="true" 
            ImageDescriptionLabelID="lblDesc"
            NextButtonID="imbtnNext" 
            PreviousButtonID="imbtnPrev" 
            PlayButtonID="btnPlay" 
            PlayButtonText="Play"
            StopButtonText="Stop"
            Loop="true" >
        </cc1:SlideShowExtender>
        
 </td><td valign="top" width="20%">
     <div style="padding-right:30px; width:175px; height:475px; background-color:#b3ccff;">
         <table width="99%"><tr><td>
             <p style="color: #000084; font-family:Arial; font-size:12pt; padding-left: 10px;">Quick links for related applications</p>
                    </td></tr><tr><td style="padding-top: 5px; padding-bottom: 5px">
                        <asp:HyperLink ID="hlPmdri" runat="server" NavigateUrl="/va_pmdri/default.aspx" Target="_blank"><p><b>PMDRI</b><br />(Project Management Data Retrieval and Integration)</p></asp:HyperLink>
                    </td></tr><tr><td style="padding-top: 5px; padding-bottom: 5px">
                        <asp:HyperLink ID="hlRppts" runat="server" NavigateUrl="/cfm_rppts" Target="_blank"><p><b>RPPTS</b><br />(Real Property Project Tracking System)</p></asp:HyperLink>
                    </td></tr><tr><td style="padding-top: 5px; padding-bottom: 5px">
                        <asp:HyperLink ID="hlDocrs" runat="server" NavigateUrl="/Docrs/login.aspx" Target="_blank"><p><b>DOCRS</b><br />(Document Conversion Retrieval System)</p></asp:HyperLink>
                 </td></tr>
         </table>
         </div>
      </td></tr>
    </table>

</asp:Content>
<asp:Content ID="Content1" runat="server" contentplaceholderid="head">
   
</asp:Content>

