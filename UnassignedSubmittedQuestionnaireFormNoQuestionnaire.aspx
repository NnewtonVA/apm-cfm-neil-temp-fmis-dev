<%@ Page Language="vb" MasterPageFile="~/SiteTest.Master" AutoEventWireup="false" CodeBehind="UnassignedSubmittedQuestionnaireFormNoQuestionnaire.aspx.vb" Inherits="CFMISNew.UnassignedSubmittedQuestionnaireForm_Backup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Content/bootstrap-grid.css" rel="stylesheet" />
    <script type="text/javascript" src="Scripts/jquery-3.0.0.js"></script>

    <style type="text/css">
        .txtwidth {
            width: 100%;
        }

        body {
            background: #e6eeff;
            font-family: 'source sans pro';
            font-weight: 400;
            font-size: 16px;
        }

        h1 {
            font-size: 35px;
            color: #2c97de;
            text-align: center;
        }

        .accordionMenu {
            width: 100%;
            margin: 0 auto;
        }

            .accordionMenu input[type=radio] {
                display: none;
            }

            .accordionMenu label {
                display: block;
                height: 40px;
                line-height: 47px;
                padding: 0 25px 0 30px;
                background: #e6ecff;
                font-size: 13px;
                color: black;
                position: relative;
                cursor: pointer;
                border-bottom: 1px solid #e6e6e6;
            }

                .accordionMenu label::after {
                    display: block;
                    content: "";
                    width: 0;
                    height: 0;
                    border-style: solid;
                    border-width: 5px 0 5px 10px;
                    border-color: transparent transparent transparent black;
                    position: absolute;
                    left: 10px;
                    top: 20px;
                    z-index: 10;
                    -webkit-transition: all 0.3s ease-in-out;
                    -moz-transition: all 0.3s ease-in-out;
                    -ms-transition: all 0.3s ease-in-out;
                    -o-transition: all 0.3s ease-in-out;
                    transition: all 0.3s ease-in-out;
                }

            .accordionMenu .content {
                max-height: 0;
                height: 0;
                overflow: hidden;
                -webkit-transition: all 2s ease-in-out;
                -moz-transition: all 2s ease-in-out;
                -o-transition: all 2s ease-in-out;
                transition: all 2s ease-in-out;
            }

            /*.accordionMenu input[type=radio]:checked + label:after {
             -webkit-transform: rotate(90deg);
             -moz-transform: rotate(90deg);
             -ms-transform: rotate(90deg);
             -o-transform: rotate(90deg);
             transform: rotate(90deg);
         }*/

            .accordionMenu input[type=radio]:checked + label + .content {
                max-height: 2000px;
                height: auto;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMainMenu" runat="server">
    <table class="mainHeader">
        <tr>
            <td style="text-align: right; vertical-align: top; padding: 5px;">
                <p>

                    <asp:Label ID="lblUserNm" runat="server"></asp:Label>

                </p>
            </td>
        </tr>
    </table>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="cphQuickMenu" runat="server">
    <table>
        <tr>
            <td align="right" style="padding-left: 25px">
                <asp:ImageButton ID="ibHome" runat="server" ImageUrl="~/Images/Home.png" CssClass="ImgButton" CausesValidation="false" ToolTip="Home" />
            </td>
            <td align="right" style="padding-left: 5px">
                <asp:ImageButton ID="ibSearch" runat="server" ImageUrl="~/Images/Search.png" CssClass="ImgButton" CausesValidation="false" ToolTip="Search" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
     <div style="text-align: center; background-color: #b3ccff;padding-top:5px;padding-bottom:5px;font-size:15px">
        <b> PM Provided Information </b>
    </div>
    <div style="width: 88%; padding-left: 5%; font-size: 15px">
           

<!--begin RVB -->


    <div class="accordionMenu">
        <!-- 1st menu  -->
        <input type="radio" id="acc1" onclick="toggleconntent('content1')">
        <label for="acc1"><b>GENERAL PROJECT QUESTION</b></label>
        <div class="content" id="content1">
            <div class="inner">
                 <table style="width: 100%">
               <div>
                    <tr>

                                                <td style="width:80%">
                                                  <asp:Label ID="lblReuiredmessage" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                    Is the Project Share Point Accessible to Environmental?            </td>                        
                                               <td colspan="2">                                                    
                                                       <input type="radio" id="chkYes" name="chkPinNo" style="display:initial" />
                                                        Yes                                                                                                  
                                                       <input type="radio" id="chkNo" name="chkPinNo" style="display:initial" />
                                                        No                                                                                                      
                                                       <input type="radio" id="chkunk" name="chkPinNo" style="display:initial" />
                                                        Unknown
                                                   </td>                                                                                                    
                                                   </tr>
                    <tr>                                                 
                                                   <td colspan="1">
                                                    <div id="dvPinNo" style="display: none">
                                                  Please provide link and access to Envi SME to Project Share Point here
                                                        </div>
                                                </td>
                                                <td>
                                                   <div id="dvPinNo1" style="display: none">                                                   
                                                     <input type="text" id="txtPinNo"/>
                                                   </div                                            
                                                </td>
                                            </tr>
                    <tr>
                           <td colspan="1">
                                 <asp:Label ID="lblRequiredmessage2" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                               Has this been documented in SEPS coordination with OCFM Regional Office Planners?
                                                </td>
                               <td colspan="2">
                                                    
                                                       <input type="radio" id="chksepsyes" name="chkseps" style="display:initial" />
                                                        Yes
                                                 
                                                 
                                                       <input type="radio" id="chksepsno" name="chkseps" style="display:initial" />
                                                        No
                                                  
                                                    
                                                       <input type="radio" id="chksepsunk" name="chkseps" style="display:initial" />
                                                        Unknown
                                                   </td>
                       </tr>  
                    <tr>
                                                <td colspan="1">
                                                      <asp:Label ID="lblRequiredmessage9" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                                    Is there a Recent Facility Master Plan? 
                                                </td>
                                               
                                                     <td colspan="2">
                                                    
                                                       <input type="radio" id="chkYesmp" name="chkMp" style="display:initial" />
                                                        Yes
                                                 
                                                 
                                                       <input type="radio" id="chkNomp" name="chkMp" style="display:initial" />
                                                        No
                                                  
                                                    
                                                       <input type="radio" id="chkunkmp" name="chkMp" style="display:initial" />
                                                        Unknown
                                                   </td>                                                                                          
                                            </tr>
                    <tr>
                                                 <td colspan="1">
                                                <div id="dvlanduse" style="display: none">
                                Is the project proposed for an existing site that is consistent with the land use/project in the Master Plan?
                                                </div>
                                                     </td>
                                                <td>
                                                     <div id="dvlanduseopt" style="display: none">                                                                                                           
                                                       <input type="radio" id="chkYescnslnd" name="chkcnslnd" style="display:initial" />
                                                        Yes                                                                                                  
                                                       <input type="radio" id="chkNocnslnd" name="chkcnslnd" style="display:initial" />
                                                        No                                                                                                      
                                                       <input type="radio" id="chkuncnslnd" name="chkcnslnd" style="display:initial" />
                                                        Unknown                                                     
                                                   </div>
                                             </td>                                                                                                                                         
                                            </tr>
                    <tr>
                                                
                                                <td colspan="1">
                                                    <div id="dvlnktomap" style="display: none">
                                                    Please provide link to Master Plan
                                                        </div>
                                                </td>
                                                <td>
                                                    <div id="dvlnkmp" style="display: none">
                                                            <input type="text" id="txtPinNo2" />
                                                        </div>
                                                </td>
                                            </tr>
                                       <tr>
                           <td colspan="1">
                                 <asp:Label ID="Label16" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                             Does the site has an "Outlease" through ORP?
                                                </td>
                               <td colspan="2">
                                                    
                                                       <input type="radio" id="chkYesoutleasethroughorp" name="Outleasethroughorp" style="display:initial" runat="server" disabled />
                                                        Yes
                                                 
                                                 
                                                       <input type="radio" id="chkNooutleasethroughorp" name="Outleasethroughorp" style="display:initial"  runat="server" disabled />
                                                        No
                                                  
                                                    
                                                       <input type="radio" id="chkUnkoutleasethroughorp" name="Outleasethroughorp" style="display:initial" runat="server" disabled />
                                                        Unknown
                                                   </td>
                       </tr>  
                    <tr>
                           <td colspan="1">
                                 <asp:Label ID="Label17" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                            Who is the ORP PM handling the "Outlease"?
                                                </td>
                               <td colspan="2">
                                                    
                                                       <input type="radio" id="chkYesorphandlingpm" name="orphandlingpm" style="display:initial" runat="server" disabled />
                                                        Yes
                                                 
                                                 
                                                       <input type="radio" id="chkNoorphandlingpm" name="orphandlingpm" style="display:initial"  runat="server" disabled/>
                                                        No
                                                  
                                                    
                                                       <input type="radio" id="chkUnkorphandlingpm" name="orphandlingpm" style="display:initial"  runat="server" disabled/>
                                                        Unknown
                                                   </td>
                       </tr>  
                    <tr>
                           <td colspan="1">
                                 <asp:Label ID="Label18" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                          What is the expiration date of "Outlease"?
                                                </td>
                               <td colspan="2">
                                                    
                                                       <input type="radio" id="chkYesoutleaseexpirationdate" name="outleaseexpirationdate" style="display:initial" runat="server" disabled />
                                                        Yes
                                                 
                                                 
                                                       <input type="radio" id="chkNooutleaseexpirationdate" name="outleaseexpirationdate" style="display:initial" runat="server" disabled />
                                                        No
                                                  
                                                    
                                                       <input type="radio" id="chkUnkoutleaseexpirationdate" name="outleaseexpirationdate" style="display:initial" runat="server" disabled />
                                                        Unknown
                                                   </td>
                       </tr>  
                     <tr>
                           <td colspan="1">
                                 <asp:Label ID="Label19" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                        Are there known easements for the site?
                                                </td>
                               <td colspan="2">
                                                    
                                                       <input type="radio" id="chkYesknowneasement" name="knowneasement" style="display:initial" runat="server" disabled />
                                                        Yes
                                                 
                                                 
                                                       <input type="radio" id="chkNoknowneasement" name="knowneasement" style="display:initial" runat="server" disabled/>
                                                        No
                                                  
                                                    
                                                       <input type="radio" id="chkUnkknowneasement" name="knowneasement" style="display:initial" runat="server" disabled/>
                                                        Unknown
                                                   </td>
                       </tr>  
                     <tr>
                           <td colspan="1">
                                 <asp:Label ID="Label20" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                      Where are the records of easements and who is the responsible ORP PM?
                                                </td>
                              <td>
                                                                                                   
                                                     <input type="text" id="txtOrprecordsofeasement" runat="server" disabled />                                         
                                                </td>
                       </tr>  
               </div>   
                     </table>
            </div>
        </div>
        <!-- 2nd menu -->
        <input type="radio" name="trg2" id="acc2" onclick="toggleconntent('content2')">
        <label for="acc2"><b>GENERAL ENVIRONMENTAL SITE CARACTERISTICS, RESOURCES, POTENTIAL IMPACTS</b></label>
        <div class="content" id="content2">
            <div class="inner">               
                    <table style="width: 100%">
                        <div>
                        <tr>
               <td colspan="1" style="width:80%">
                     <asp:Label ID="lblRequiredmessage3" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                Please attach a general site map or project boundary map of the proposed project area
                 </td>
                              <td>
                                                   <div id="dvGnrlenv">                                                   
                                                     <input type="text" id="dvRealestateaction" />
                                                    </div                                            
                                                </td>
                   </tr>
                            </div>
                </table>
            </div>
        </div>

        <!-- 3rd menu -->
        <input type="radio" name="trg3" id="acc3" onclick="toggleconntent('content3')">
        <label for="acc3"><b>LAND USE</b></label>
        <div class="content" id="content3">
            <div class="inner">
           <table style="width: 100%">
               <div>
               <tr>
                   <td colspan="1" style="width:80%">
                         <asp:Label ID="lblRequiredmessage4" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                       Will the proposed action alter the present land use of the site?
                   </td>
                    <td colspan="2">                                                    
                    <input type="radio" id="chkYespropactn" name="proposedaction" style="display:initial" />
                    Yes                                                                                                  
                   <input type="radio" id="chkNopropactn" name="proposedaction" style="display:initial" />
                   No                                                                                                      
                  <input type="radio" id="chkunkpropactn" name="proposedaction" style="display:initial" />
                  Unknown
                  </td>   
                   </tr>
               <tr>
                  <td colspan="1">
                        <asp:Label ID="lblRequiremessage5" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                      Does the proposed action involve a real estate action (e.g., purchase, lease, easement, permit, or license, disposal)?
                  </td>
                      <td colspan="2">                                                    
                    <input type="radio" id="chkYespairea" name="pairea" style="display:initial" />
                    Yes                                                                                                  
                   <input type="radio" id="chkNopairea" name="pairea" style="display:initial" />
                   No                                                                                                      
                  <input type="radio" id="chkunkpairea" name="pairea" style="display:initial" />
                  Unknown
                  </td>   
               </tr>
               <tr>
                  <td colspan="1">
                        <div id="dvorpeffort" style="display: none">
                      Is ORP leading this effort, whom is the ORP PM - Name, email and phone # ?
                             </div>
                  </td>
                    
                                                                       
                    <td colspan="2">  
                        <div id="dvorpeffortchk" style="display: none">
                    <input type="radio" id="chkYesrpeffortchk" name="rpeffortchk" style="display:initial" />
                    Yes                                                                                                  
                   <input type="radio" id="chkNorpeffortchk" name="rpeffortchk" style="display:initial" />
                   No                                                                                                      
                  <input type="radio" id="chkunkrpeffortchk" name="rpeffortchk" style="display:initial" />
                  Unknown
                            </div> 
                  </td>   
                                                              
                                                
               </tr>
               <tr>
                  <td colspan="1">
                       <div id="dvadnacres" style="display: none">
                    Require new purchase of additional acres using federal funds? 
                     </div>
                  </td>
                    <td colspan="2">  
                        <div id="dvchkadnacres" style="display: none">
                    <input type="radio" id="chkYesadnacres" name="adnacres" style="display:initial" />
                    Yes                                                                                                  
                   <input type="radio" id="chkNoadnacres" name="adnacres" style="display:initial" />
                   No                                                                                                      
                  <input type="radio" id="chkunkadnacres" name="adnacres" style="display:initial" />
                  Unknown
                            </div> 
                  </td>   
               </tr>
               <tr>
                  <td colspan="1">
                      <div id="dvSizeofadnacres" style="display: none">
                        Provide size of additional acres needed. 
                        </div>
                      <td colspan="2">  
                        <div id="dvSizeofadnacrestxtbox" style="display: none">
                     <input type="text" id="txtSizeofadnacres"/>
                            </div> 
                  </td>   
                  </td>
               </tr>
               <tr>
                  <td colspan="1">
                        <div id="dvRequirenew" style="display: none">
                       Require a new lease, license, and/or land use permit? 
                            </div>
                       <td colspan="2">  
                        <div id="dvRequirenewchk" style="display: none">
                      <input type="radio" id="chkYesrequirenew" name="requirenew" style="display:initial" />
                    Yes                                                                                                  
                   <input type="radio" id="chkNorequirenew" name="requirenew" style="display:initial" />
                   No                                                                                                      
                  <input type="radio" id="chkunkrequirenew" name="requirenew" style="display:initial" />
                  Unknown
                            </div> 
                  </td>  
                  </td>
               </tr>
               <tr>
                  <td colspan="1">
                       <div id="dvIncreaseofacreage" style="display: none">
                      Would the action Require an increase of acreage/amendment to an existing lease or license? 
                          </div>
                       <td colspan="2">  
                        <div id="dvIncreaseofacreagechk" style="display: none">
                      <input type="radio" id="chkYesincreaseofacreagechk" name="increaseofacreagechk" style="display:initial" />
                    Yes                                                                                                  
                   <input type="radio" id="chkNoincreaseofacreagechk" name="increaseofacreagechk" style="display:initial" />
                   No                                                                                                      
                  <input type="radio" id="chkunkincreaseofacreagechk" name="increaseofacreagechk" style="display:initial" />
                  Unknown
                            </div> 
                  </td>  
                  </td>
               </tr>
               <tr>
                  <td colspan="1">
                       <div id="dvRealestatepoint" style="display: none">
                     From a Realestate standpoint will the project replace or dispose of existing federal facilities? 
                            </div>
                       <td colspan="2">  
                        <div id="dvRealestatepointchk" style="display: none">
                      <input type="radio" id="chkYesrealestatepointchk" name="realestatepointchk" style="display:initial" />
                    Yes                                                                                                  
                   <input type="radio" id="chkNorealestatepointchk" name="realestatepointchk" style="display:initial" />
                   No                                                                                                      
                  <input type="radio" id="chkunkrealestatepointchk" name="realestatepointchk" style="display:initial" />
                  Unknown
                            </div> 
                  </td>  
                  </td>
               </tr>
               <tr>
                <td colspan="1">
                      <asp:Label ID="lblRequiredmessage6" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
               Will the project include procurement or leasing of temporary swing space off campus for staff or functions during the project?
             </td>                        
               <td colspan="2">                                                    
             <input type="radio" id="chkYesprocurmentorleasing" name="procurmentorleasing" style="display:initial" />
          Yes                                                                                                  
         <input type="radio" id="chkNoprocurmentorleasing" name="procurmentorleasing" style="display:initial" />
             No                                                                                                      
 <input type="radio" id="chkunkprocurmentorleasing" name="procurmentorleasing" style="display:initial" />
                         Unknown
                                                   </td>                                                                                                    
                                                   </tr>
               <tr>
                  <td colspan="1">
                        <asp:Label ID="lblReuiredmessage7" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                     Will any demolition be required as part of the project?
                  </td>
                      <td colspan="2">                                                    
                    <input type="radio" id="chkYesdemolition" name="demolition" style="display:initial" />
                    Yes                                                                                                  
                   <input type="radio" id="chkNodemolition" name="demolition" style="display:initial" />
                   No                                                                                                      
                  <input type="radio" id="chkunkdemolition" name="demolition" style="display:initial" />
                  Unknown
                  </td>   
               </tr>
               <tr>
                  <td colspan="1">
                      <div id="dvSqrfootagedemolition" style="display: none">
                       Provide square footage of demolition. 
                        </div>
                      <td colspan="2">  
                        <div id="dvSqrfootagedemolitiontxtbox" style="display: none">
                     <input type="text" id="txtSqrfootagedemolition" />
                            </div> 
                  </td>   
                  </td>
               </tr>
               <tr>

                <td colspan="1">
                      <asp:Label ID="lblRequiredmessage7" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
              Is the construction laydown footprint captured in the project area proposed footprint? 
             </td>                        
               <td colspan="2">                                                    
             <input type="radio" id="chkYesfootprintcaptured" name="footprintcaptured" style="display:initial" />
          Yes                                                                                                  
         <input type="radio" id="chkNofootprintcaptured" name="footprintcaptured" style="display:initial" />
             No                                                                                                      
 <input type="radio" id="chkunkfootprintcaptured" name="footprintcaptured" style="display:initial" />
                         Unknown
                                                   </td>                                                                                                    
                                                   </tr>
               <tr>
                <td colspan="1">
                      <asp:Label ID="lblRequiredmessage8" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
            Will a parking structure be needed? 
             </td>                        
               <td colspan="2">                                                    
             <input type="radio" id="chkYespkngstructure" name="pkngstructure" style="display:initial" />
          Yes                                                                                                  
         <input type="radio" id="chkNopkngstructure" name="pkngstructure" style="display:initial" />
             No                                                                                                      
 <input type="radio" id="chkunkpkngstructure" name="pkngstructure" style="display:initial" />
                         Unknown
                                                   </td>                                                                                                    
                                                   </tr>
               <tr>
                  <td colspan="1">
                      <div id="dvAdnsqftgoverallprojectscope" style="display: none">
Is the additional Sq footage and parking structure taken into consideration in the overall project scope?

                        </div>
                      <td colspan="2">   
                          <div id="dvChkadnsqftgoverallprojectscope" style="display: none">
             <input type="radio" id="chkYesAdnsqftgoverallprojectscope" name="adnsqftgoverallprojectscope" style="display:initial" />
          Yes                                                                                                  
         <input type="radio" id="chkNoAdnsqftgoverallprojectscope" name="adnsqftgoverallprojectscope" style="display:initial" />
             No                                                                                                      
 <input type="radio" id="chkunkAdnsqftgoverallprojectscope" name="adnsqftgoverallprojectscope" style="display:initial" />
                         Unknown
                              </div>
                                                   </td> 
                  </td>
               </tr>
               <tr>
                  <td colspan="1">
                      <div id="dvAppropriatesqfootage" style="display: none">
        What is the approximate Sq footage of the needed parking structure 
                        </div>
                      <td colspan="2">   
                          <div id="dvChkappropriatesqfootage" style="display: none">
             <input type="text" id="chkYesappropriatesqfootage" name="appropriatesqfootage" style="display:initial" />
                              </div>
                                                   </td> 
                  </td>
               </tr>
               <tr>
                  <td colspan="1">
                      <div id="dvProjectheight" style="display: none">
What is the project height of parking struture
                        </div>
                      <td colspan="2">   
                          <div id="dvtxtprojectheight" style="display: none">
             <input type="text" id="txtProjectheight" name="appropriatesqfootage" style="display:initial" />
                              </div>
                                                   </td> 
                  </td>
               </tr>
                   </div>
           </table>
            </div>
        </div>


        <!-- 4th menu -->
        <input type="radio" name="trg4" id="acc4" onclick="toggleconntent('content4')">
        <label for="acc4"><b>SITE GEOLOGY AND SOIL SUITABILITY</b></label>
        <div class="content" id="content4">
            <div class="inner">
            <table style="width: 100%">
                <div>
                  <tr>

                               <td style="width:80%">
                                     <asp:Label ID="lblReuiredmessage10" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                                 Does the site have a current Environmental Site Assessment (ESA) Phase 1 (within last 2 yrs.)
                                  </td>                        
                                   <td colspan="2">                                                    
                          <input type="radio" id="chkYesenvsiteassement" name="envsiteassement" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNoenvsiteassement" name="envsiteassement" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunkenvsiteassement" name="envsiteassement" style="display:initial" />
                                    Unknown
                               </td>                                                                                                    
                      </tr>
                  <tr>
                  <td colspan="1">
                        <div id="dvlnktoreport" style="display: none">
                      Please attach or provide link to report. 
                             </div>
                  </td>                                                                                           
                    <td colspan="2">  
                        <div id="dvTxtlnktoreport" style="display: none">
                    <input type="text" id="txtLnktoreport" name="lnktoreport" style="display:initial" />
                            </div> 
                  </td>   
                                                              
                                                
               </tr>
                  <tr>
                  <td colspan="1">
                        <div id="dvrecenvcondition" style="display: none">
Are there any Recognized Environmental Condition (REC) indicated in the Phase I ESA?
                             </div>
                  </td>                    
                                                                       
                    <td colspan="2">  
                        <div id="dvChkrecenvcondition" style="display: none">
                  <input type="radio" id="chkYesrecenvcondition" name="recenvcondition" style="display:initial" />
          Yes                                                                                                  
         <input type="radio" id="chkNorecenvcondition" name="recenvcondition" style="display:initial" />
             No                                                                                                      
 <input type="radio" id="chkunkrecenvcondition" name="recenvcondition" style="display:initial" />
                         Unknown
                              </div>
                          
                  </td>   
                                                              
                               
               </tr>
                  <tr>
                  <td colspan="1">
                        <div id="dvbriefdscpn" style="display: none">
                     Please provide brief description if known?
                             </div>
                  </td>                    
                                                                       
                    <td colspan="2">  
                        <div id="dvTxtbriefdscpn" style="display: none">
                    <input type="text" id="txtbriefdscpn" name="briefdscpn" style="display:initial" />
                            </div> 
                  </td>                                                                                                                 
               </tr>
                  <tr>
                    <td colspan="1">
                          <asp:Label ID="lblrequiredmessage10" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                        Have soil borings been conducted  to evaluate sub surface suitability for construction?

                    </td>
                      <td colspan="2">                                                    
                          <input type="radio" id="chkYessubsurfacesuitability" name="subsurfacesuitability" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNosubsurfacesuitability" name="subsurfacesuitability" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunksubsurfacesuitability" name="subsurfacesuitability" style="display:initial" />
                                    Unknown
                               </td>  
                </tr>
                  <tr>
                    <td colspan="1">
                         <div id="dvreportsoil" style="display: none">
                        Please attached or provide link to report 
                             </div>
                    </td>
                      <td colspan="2">
                           <div id="dvChkreportsoil" style="display: none">
  <input type="text" id="txtReportSoil" name="subsurfacesuitability" style="display:initial" />
                               </div>
                          </td>
                </tr>
                  <tr>
                    <td colspan="1">
                        <div id="dvhighgrndlevels" style="display: none">
                                                  If borings were done did it identify high groundwater levels? 
                            </div>
                    </td> 
                       <td colspan="2"> 
                            <div id="dvChkhighgrndlevels" style="display: none">
                          <input type="radio" id="chkYeshighgrndlevels" name="highgrndlevels" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNohighgrndlevels" name="highgrndlevels" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunkhighgrndlevels" name="highgrndlevels" style="display:initial" />
                                    Unknown
                                </div>
                               </td>  
                </tr>
                  <tr>
                    <td colspan="1">
                                        <div id="dveffectconstruction" style="display: none">
                                           Will this effect construction?
                                            </div>

                    </td>
                       <td colspan="2"> 
                            <div id="dvChkeffectconstruction" style="display: none">
                          <input type="radio" id="chkYeseffectconstruction" name="effectconstruction" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNoeffectconstruction" name="effectconstruction" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunkeffectconstruction" name="effectconstruction" style="display:initial" />
                                    Unknown
                                </div>
                               </td>  
                </tr>
                  <tr>
                    <td colspan="1">
                          <asp:Label ID="lblrequiredmessage11" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                        Where any known contaminants identified during soil borings or as part of the ESA Phase I that could impact construction or require mitigation prior to  or after construction? 

                    </td>
                       <td colspan="2"> 
                            <%--<div id="dvChkeffectconstruction" style="display: none">--%>
                          <input type="radio" id="chkYescontainmentssoil" name="containmentssoil" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNocontainmentssoil" name="containmentssoil" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunkcontainmentssoil" name="containmentssoil" style="display:initial" />
                                    Unknown
<%--                                </div>--%>
                               </td>  
                </tr>
                    </div>
                </table>
                  </div> 
            </div>
        
        <!-- 5th menu -->
        <input type="radio" name="trg5" id="acc5" onclick="toggleconntent('content5')">
        <label for="acc5"><b>HAZARDOUS MATERIAL</b></label>
        <div class="content" id="content5">
            <div class="inner">
        <table style="width: 100%">
            <tr>
                  <td style="width:80%">
                        <asp:Label ID="lblrequiredmessage12" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                       Is there any known contamination, munitions or hazardous materials onsite?

                    </td>
                 <td colspan="2"> 
                          <input type="radio" id="chkYeshazordousmtrl" name="hazordousmtrl" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNohazordousmtrl" name="hazordousmtrl" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunkhazordousmtrl" name="hazordousmtrl" style="display:initial" />
                                    Unknown
                               </td>  
                </tr>
            <tr>
                    <td colspan="1">
                          <asp:Label ID="lblrequiredmessage13" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                       Is there any documentation of the known limits of potential contamination or hazardous materials buried onsite?

                    </td>
                <td colspan="2"> 
                          <input type="radio" id="chkYesdcmntlimits" name="dcmntlimits" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNodcmntlimits" name="dcmntlimits" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunkdcmntlimits" name="dcmntlimits" style="display:initial" />
                                    Unknown
                               </td>  
                </tr>
            <tr>
                    <td colspan="1">
                          <asp:Label ID="lblrequiredmessage14" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                       As part of the site/building study has there been a full Asbestos (ACM) Lead Based Paint(LBP) analysis of the project area and effected buildings to determine the extent of potential LBP and Asbestos contamination?
                    </td>
                <td colspan="2"> 
                          <input type="radio" id="chkYesfullasbestos" name="fullasbestos" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNofullasbestos" name="fullasbestos" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunkfullasbestos" name="fullasbestos" style="display:initial" />
                                    Unknown
                               </td>  
                </tr>
            <tr>
                    <td colspan="1">
                          <asp:Label ID="lblrequiredmessage15" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                   Please provide copies of all previous LBP and ACM analysis reports for the site or effected buildings. 

                    </td>
                 <td colspan="2"> 
                          <input type="radio" id="chkYeslbpcopies" name="lbpcopies" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNolbpcopies" name="lbpcopies" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunklbpcopies" name="fullasbestos" style="display:initial" />
                                    Unknown
                               </td>  
                </tr>
            <tr>
                    <td colspan="1">
                          <asp:Label ID="lblrequiredmessage16" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                       Are  any known Polychlorinated biphenyls (PCBs) present in any of the buildings on the site that will be impacted as part of the project? (Current generators, elevators, other old oil containing machinery)

                    </td>
                 <td colspan="2"> 
                          <input type="radio" id="chkYespolychlorinatepiphenyls" name="polychlorinatepiphenyls" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNopolychlorinatepiphenyls" name="polychlorinatepiphenyls" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunkpolychlorinatepiphenyls" name="polychlorinatepiphenyls" style="display:initial" />
                                    Unknown
                               </td>  
                </tr>
       </table>
            </div>
        </div>
        <!-- 6th menu -->
        <input type="radio" name="trg6" id="acc6" onclick="toggleconntent('content6')">
        <label for="acc6"><b>HISTORICAL AND CULTURAL</b></label>
        <div class="content" id="content6">
            <div class="inner">
            <table style="width: 100%">
                <tr style="width:100%">
                    <td style="width:80%">
                            <asp:Label ID="lblRequiredmessage21" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                        Is the facility, building or VA campus 50 yrs. old or is it a National Cemetery? 
                        </td>
                    <td colspan="3">
                        <input type="radio" id="chkYesbldngfiftyyears" name="bldngfiftyyears" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNobldngfiftyyears" name="bldngfiftyyears" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunkbldngfiftyyears" name="bldngfiftyyears" style="display:initial" />
                                    Unknown
                    </td>
                      <td colspan="2"> 
                          
                               </td>  
                </tr>
                <tr>
                    <td>
                            <asp:Label ID="lblRequiredmessage23" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                        Has the facility, building, VA campus or National Cemetery or site been evaluated under the National Historic Preservation Act (NHPA) for listing on the National Register of Historic Places (NRHP)? 

                    </td>
                    <td colspan="2"> 
                          <input type="radio" id="chkYesnhpaevaluation" name="nhpaevaluation" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNonhpaevaluation" name="nhpaevaluation" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunknhpaevaluation" name="nhpaevaluation" style="display:initial" />
                                    Unknown
                               </td>  
                </tr>
                <tr>
                    <td>
                            <asp:Label ID="lblRequiredmessage17" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
Is the site listed on the Historic Register?

                    </td>
 <td colspan="2"> 
                          <input type="radio" id="chkYeslstedhistoricregister" name="lstedhistoricregister" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNolstedhistoricregister" name="lstedhistoricregister" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunklstedhistoricregister" name="lstedhistoricregister" style="display:initial" />
                                    Unknown
                               </td> 
                </tr>                 
                <tr>  
                    <td colspan="1">
                     <div id="dvhsitoricarcheolgical" style="display: none">
                       Are there any historic or archeological site reports available for the current project or for past projects at the site?
                      </div>
                        </td>
                    <td>
                    <div id="dvChkhsitoricarcheolgica" style="display: none">                                                   
                         <input type="radio" id="chkYeshsitoricarcheolgical" name="hsitoricarcheolgical" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNohsitoricarcheolgical" name="hsitoricarcheolgical" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunkhsitoricarcheolgical" name="hsitoricarcheolgical" style="display:initial" />
                                    Unknown
                                                    </div                                            
                                                </td>
                </tr>
                <tr>  
                    <td colspan="1">
                     <div id="dvlnktoattachpastreeports" style="display: none">
                     Please provide a link to the reports or attach past reports. 
                      </div>
                        </td>
                    <td>
                    <div id="dvChklnktoattachpastreeports" style="display: none">                                                   
                         <input type="radio" id="chkYeslnktoattachpastreeports" name="lnktoattachpastreeports" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNolnktoattachpastreeports" name="lnktoattachpastreeports" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunklnktoattachpastreeports" name="lnktoattachpastreeports" style="display:initial" />
                                    Unknown
                                                    </div                                            
                                                </td>
                </tr>
                <tr>  
                    <td colspan="1">
                     <div id="dvPreservationplan" style="display: none">
                    Is there a preservation plan for the property?
                      </div>
                        </td>
                    <td>
                    <div id="dvChkpreservationplan" style="display: none">                                                   
                         <input type="radio" id="chkYespreservationplan" name="preservationplan" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNopreservationplan" name="preservationplan" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunkpreservationplan" name="preservationplan" style="display:initial" />
                                    Unknown
                                                    </div                                            
                                                </td>
                </tr>
                <tr>  
                    <td colspan="1">
                     <div id="dvlnkpreservationplan" style="display: none">
                  Please provide a link to the preservation plan. 
                      </div>
                        </td>
                    <td>
                    <div id="dvChklnkpreservationplan" style="display: none">                                                   
                         <input type="radio" id="chkYeslnkpreservationplan" name="lnkpreservationplan" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNolnkpreservationplan" name="lnkpreservationplan" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunklnkpreservationplan" name="lnkpreservationplan" style="display:initial" />
                                    Unknown
                                                    </div                                            
                                                </td>
                </tr>
                <tr>
                    <td>
                            <asp:Label ID="lblRequiredmessage18" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
  Are there any existing NHPA agreements in effect for the property (see: achp.gov/va) or Native American Graves Protection and Repatriation Act (NAGPRA) Plans of Action or Agreements?

                    </td>
 <td colspan="2"> 
                          <input type="radio" id="chkYesexstnhpaagreement" name="exstnhpaagreement" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNoexstnhpaagreement" name="exstnhpaagreement" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunkexstnhpaagreement" name="exstnhpaagreement" style="display:initial" />
                                    Unknown
                               </td> 
                </tr> 
                <tr>  
                    <td colspan="1">
                     <div id="dvlnktoanyagreement" style="display: none">
                        Please provide a link to any agreements. 
                      </div>
                        </td>
                    <td>
                    <div id="dvChklnktoanyagreement" style="display: none">                                                   
                        <input type="text" id="Txtlnktoanyagreement" />                                                                                                                                                         
                                                    </div                                            
                                                </td>
                </tr>
                <tr>
                    <td>
                            <asp:Label ID="lblRequiredmessage19" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
   Does the facility have existing relationships with likely consulting parties (i.e. State Historic Preservation Office (SHPO), local government, Tribes)?
                    </td>
 <td colspan="2"> 
                          <input type="radio" id="chkYesexstrelnwithconsuparties" name="exstrelnwithconsuparties" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNoexstrelnwithconsuparties" name="exstrelnwithconsuparties" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunkexstrelnwithconsuparties" name="exstrelnwithconsuparties" style="display:initial" />
                                    Unknown
                               </td> 
                </tr> 
                <tr>
                    <td colspan="1">
                     <div id="dvlnktoannualrptsreuirement" style="display: none">
                      Are there any annual reports requirements?
                      </div>
                        </td>
                    <td>
                    <div id="dvChklnktoannualrptsreuirement" style="display: none">       
                        
                          <input type="radio" id="chkYeslnktoannualrptsreuirement" name="lnktoannualrptsreuirement" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNolnktoannualrptsreuirement" name="lnktoannualrptsreuirement" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunklnktoannualrptsreuirement" name="lnktoannualrptsreuirement" style="display:initial" />
                                    Unknown
                                                                            </div                                            
                                                </td>
                </tr>
                <tr>  
                    <td colspan="1">
                     <div id="dvlnktolatestannualreports" style="display: none">
                    if yes please provide latest annual report?
                      </div>
                        </td>
                    <td>
                    <div id="dvTxtlnktolatestannualreports" style="display: none">       
                        
                         <input type="text" id="Txtlnktolatestannualreports" />    

                                                                            </div                                            
                                                </td>
                </tr>
                </table>
            </div>
        </div>
         <!-- 7th menu -->
                <input type="radio" name="trg7" id="acc7" onclick="toggleconntent('content7')">
        <label for="acc7"><b>NATURAL RESOURCES</b></label>
        <div class="content" id="content7">
            <div class="inner">
            <table style="width: 100%">
                <tr style="width:100%">
                    <td style="width:80%">
                            <asp:Label ID="Label1" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                       Will the proposed action alter, destroy, or significantly impact environmentally sensitive areas (wetlands and/or existing fish or wildlife habitat, coastal zones, flood plains)
                        </td>
                    <td colspan="3">
                        <input type="radio" id="chkYesenvsensitive" name="envsensitive" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNoenvsensitive" name="envsensitive" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunkenvsensitive" name="envsensitive" style="display:initial" />
                                    Unknown
                    </td>
                      <td colspan="2"> 
                          
                               </td>  
                </tr>
                <tr>
                    <td>
                            <asp:Label ID="Label2" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                       Are there any known state or federal listed threatened or endangered species on this site?  
                    </td>
                    <td colspan="2"> 
                          <input type="radio" id="chkYesstateorfederalthreatened" name="stateorfederalthreatened" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNostateorfederalthreatened" name="stateorfederalthreatened" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkUnkstateorfederalthreatened" name="stateorfederalthreatened" style="display:initial" />
                                    Unknown
                               </td>  
                </tr>              
                <tr>  
                    <td colspan="1">
                     <div id="dvlnktostateorfederalthreatenedprevreport" style="display: none">
                      Are any previous reports available?
                      </div>
                        </td>
                    <td>
                    <div id="dvChklnktostateorfederalthreatenedprevreport" style="display: none">                                                   
                         <input type="radio" id="chkYesstateorfederalthreatenedprevreport" name="stateorfederalthreatenedprevreport" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNostateorfederalthreatenedprevreport" name="stateorfederalthreatenedprevreport" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunkstateorfederalthreatenedprevreport" name="stateorfederalthreatenedprevreport" style="display:initial" />
                                    Unknown
                                                    </div                                            
                                                </td>
                </tr>
                <tr>  
                    <td colspan="1">
                     <div id="dvLnktoattachesarpt" style="display: none">
                         Please provide link or attach ESA report

                      </div>
                        </td>
                    <td>
                    <div id="dvlnktoattachesarpt" style="display: none">                                                   
                        <input type="text" id="Txtlnktoattachesarpt" />
                                                    </div                                            
                                                </td>
                </tr>
                <tr style="width:100%">
                    <td style="width:80%">      
                            <asp:Label ID="Label3" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                      Does the Site fall within the FEMA 100 yr. Floodplain? 
</td>
                    <td colspan="3">
                        <input type="radio" id="chkYesfemafloodplain" name="femafloodplain" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNofemafloodplain" name="femafloodplain" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkunkfemafloodplain" name="femafloodplain" style="display:initial" />
                                    Unknown
                    </td>
                </tr>
                <tr>  
                    <td colspan="1">
                     <div id="dvpercentageinfloodplain" style="display: none">
                  How much of the project falls  within the  100 yr. floodplain?
                      </div>
                        </td>
                    <td>
                    <div id="dvlnktopercentageinfloodplain" style="display: none">                                                   
                        <input type="text" id="Txtpercentageinfloodplain" />
                                                    </div                                            
                                                </td>
                </tr>
                <tr>
                    <td>
                            <asp:Label ID="Label4" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                      Are there known or mapped wetlands on site?  
                    </td>
                    <td colspan="2">
                          <input type="radio" id="chkYesknownormappedwetlands" name="knownormappedwetlands" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNoknownormappedwetlands" name="knownormappedwetlands" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkUnkknownormappedwetlands" name="knownormappedwetlands" style="display:initial" />
                                    Unknown
                               </td>  
                </tr>
                <tr>  
                    <td colspan="1">
                     <div id="dvlnktowetlandimpacted" style="display: none">
                        Are wetland likely to be impacted as a result of the project? 
                      </div>
                        </td>
                    <td>
                    <div id="dvChkwetlandimpacted" style="display: none">                                                   
                         <input type="radio" id="chkYeswetlandimpacted" name="wetlandimpacted" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNowetlandimpacted" name="wetlandimpacted" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkUnkwetlandimpacted" name="wetlandimpacted" style="display:initial" />
                                    Unknown
                                                    </div                                            
                                                </td>
                </tr>
                <tr>  
                    <td colspan="1">
                     <div id="dvlnktoanticpatedwetlandspermit" style="display: none">
                      Is it anticipated that a Wetlands permit will be required at the State or Federal level for the project? 
                      </div>
                        </td>
                    <td>
                    <div id="dvChklnktoanticpatedwetlandspermit" style="display: none">                                                   
                         <input type="radio" id="chkYesanticpatedwetlandspermit" name="anticpatedwetlandspermit" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNoanticpatedwetlandspermit" name="anticpatedwetlandspermit" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkUnkanticpatedwetlandspermit" name="anticpatedwetlandspermit" style="display:initial" />
                                    Unknown
                                                    </div                                            
                                                </td>
                </tr>
                <tr>  
                    <td colspan="1">
                     <div id="dvlnktoexstwetlandpermitsoragreement" style="display: none">
                      Is there existing wetland permits or agreement for the development of this site?
                      </div>
                        </td>
                    <td>
                    <div id="dvChklnktoexstwetlandpermitsoragreement" style="display: none">                                                   
                         <input type="radio" id="chkYesexstwetlandpermitsoragreement" name="exstwetlandpermitsoragreement" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNoexstwetlandpermitsoragreement" name="exstwetlandpermitsoragreement" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkUnkexstwetlandpermitsoragreement" name="exstwetlandpermitsoragreement" style="display:initial" />
                                    Unknown
                                                    </div                                            
                                                </td>
                </tr>
                <tr>  
                    <td colspan="1">
                     <div id="dvlnktowetlandsexcitingpermits" style="display: none">
                           Please provide exciting permit or agreement.
                      </div>
                        </td>
                    <td>
                    <div id="dvChklnktowetlandsexcitingpermits" style="display: none">                                                   
                         <input type="text" id="chkYeswetlandsexcitingpermits" name="wetlandsexcitingpermits" style="display:initial" />
                                                    </div                                            
                                                </td>
                </tr>
                </table>
            </div>
        </div>
         <!-- 8th menu -->
                <input type="radio" name="trg8" id="acc8" onclick="toggleconntent('content8')">
        <label for="acc8"><b>STORMWATER AND COASTAL ZONE</b></label>
        <div class="content" id="content8">
            <div class="inner">
        <table style="width: 100%">
            <tr>
                  <td style="width:80%">
                          <asp:Label ID="Label5" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                    Are current Stormwater (SW) Facilities on site adequate to handle additional flow? 
                    </td>
                 <td colspan="2"> 
                          <input type="radio" id="chkYescurrentstormwateradequate" name="currentstormwateradequate" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNocurrentstormwateradequate" name="currentstormwateradequate" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkUnkcurrentstormwateradequate" name="currentstormwateradequate" style="display:initial" />
                                    Unknown
                               </td>  
                </tr>
            <tr>
                    <td colspan="1">
                            <asp:Label ID="Label6" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                    Will the site be able to handle the 24 hr. retention of SW associated with the change in impervious surface?
                    </td>
                <td colspan="2"> 
                          <input type="radio" id="chkYesretentionofsw" name="retentionofsw" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNoretentionofsw" name="retentionofsw" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkUnkretentionofsw" name="retentionofsw" style="display:initial" />
                                    Unknown
                               </td>  
                </tr>
            <tr>
                    <td colspan="1">
                            <asp:Label ID="Label7" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
              Does the project fall within 1000 ft of the Coastal Zone ( Coastline)or tidal waters? 
                    </td>
                <td colspan="2"> 
                          <input type="radio" id="chkYesfallcoastalzone" name="fallcoastalzone" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNofallcoastalzone" name="fallcoastalzone" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkUnkfallcoastalzone" name="fallcoastalzone" style="display:initial" />
                                    Unknown
                               </td>  
                </tr>
       </table>
            </div>
        </div>

         <!-- 9th menu -->
        <input type="radio" name="trg9" id="acc9" onclick="toggleconntent('content9')">
        <label for="acc9"><b>UTILITIES</b></label>
        <div class="content" id="content9">
            <div class="inner">
        <table style="width: 100%">
            <tr>
                  <td style="width:80%">
                          <asp:Label ID="Label8" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
       Are there sufficient utilities (with capacity) to support the proposed project on site? Only answer yes, if it is known that all utilities have sufficent capacity 
                    </td>
                 <td colspan="2"> 
                          <input type="radio" id="chkYessufficesntutilities" name="sufficesntutilities" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNosufficesntutilities" name="sufficesntutilities" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkUnksufficesntutilities" name="sufficesntutilities" style="display:initial" />
                                    Unknown
                               </td>  
                </tr>
            <tr>
                    <td colspan="1">
                            <asp:Label ID="Label9" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                   Please inidcate which utilities could require modifications or changes to support the project.
                        </br>
                        
                        
                        </td>
                <td colspan="2">
                          <input type="checkbox" id="chkElectrical" name="chkelectricalmodifications" style="display:initial" />
                                                    Eletrical
                    </br>
                    <input type="checkbox" id="chkSanitarysewer" name="chkSanitarysewer" style="display:initial" />
                          Sanitary Sewer
                    </br>
                     <input type="checkbox" id="chkStormsewer" name="chkStormsewer" style="display:initial" />
                          Storm Sewer
                    </br>
                      <input type="checkbox" id="chkSteam" name="chkSteam" style="display:initial" />
                        Steam
                    </br>
                     <input type="checkbox" id="chkPortablewater" name="chkPortablewater" style="display:initial" />
                         Portable Water
                    </br>
                     <input type="checkbox" id="chkChilledWater" name="chkChilledWater" style="display:initial" />
                         Chilled Water
                        </br>
                   
                     <input type="checkbox" id="chkNaturalgas" name="chkNaturalgas" style="display:initial" />
                       Natural Gas
                    </br>
                     <input type="checkbox" id="chkRelaimedwater" name="chkRelaimedwater" style="display:initial" />
                       Reclaimed Water Source(Irrigation)
                               </td>  
                </tr>      
       </table>
            </div>
        </div>
                 <!-- 10th menu -->
                <input type="radio" name="trg10" id="acc10" onclick="toggleconntent('content10')">
        <label for="acc10"><b>TRAFFIC</b></label>
        <div class="content" id="content10">
            <div class="inner">
        <table style="width: 100%">
            <tr>
                  <td style="width:80%">
                          <asp:Label ID="Label10" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                  Are there known traffic issues in the immediate area?
                    </td>
                 <td colspan="2"> 
                          <input type="radio" id="chkYestrafficissue" name="trafficissue" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNotrafficissue" name="trafficissue" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkUnktrafficissue" name="trafficissue" style="display:initial" />
                                    Unknown
                               </td>  
                </tr>
            <tr>
                    <td colspan="1">
                            <asp:Label ID="Label11" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                 Will the project impact traffic and site access during construction or during operation? 
                    </td>
                <td colspan="2"> 
                          <input type="radio" id="chkYesimpacttrafficsiteaccess" name="impacttrafficsiteaccess" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNoimpacttrafficsiteaccess" name="impacttrafficsiteaccess" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkUnkimpacttrafficsiteaccess" name="impacttrafficsiteaccess" style="display:initial" />
                                    Unknown
                               </td>  
                </tr>
              <tr>  
                    <td colspan="1">
                     <div id="dvlnktotrafficimpactsduringconstn" style="display: none">
                     Will traffic impacts be limited only during construction? 
                      </div>
                        </td>
                    <td>
                    <div id="dvChklnktotrafficimpactsduringconstn" style="display: none">                                                   
                         <input type="radio" id="chkYestrafficimpactsduringconstn" name="trafficimpactsduringconstn" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNotrafficimpactsduringconstn" name="trafficimpactsduringconstn" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkUnktrafficimpactsduringconstn" name="trafficimpactsduringconstn" style="display:initial" />
                                    Unknown
                                                    </div                                            
                                                </td>
                </tr>
             <tr>  
                    <td colspan="1">
                     <div id="dvlnktotrafficstudycompleted" style="display: none">
                       Has a traffic study been completed for after construction/ during operation of the facility and traffic Level of Service(LOS)
                      </div>
                        </td>
                    <td>
                    <div id="dvChklnktotrafficstudycompleted" style="display: none">                                                   
                         <input type="radio" id="chkYestrafficstudycompleted" name="trafficstudycompleted" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNotrafficstudycompleted" name="trafficstudycompleted" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkUnktrafficstudycompleted" name="trafficstudycompleted" style="display:initial" />
                                    Unknown
                                                    </div                                            
                                                </td>
                </tr>
            <tr>
                    <td colspan="1">
                            <asp:Label ID="Label12" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
             Is there mass transit in close proximity which could be utilized to alleviate traffic impacts? 
                    </td>
                <td colspan="2"> 
                          <input type="radio" id="chkYesmasstransitcloseproximity" name="masstransitcloseproximity" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNomasstransitcloseproximity" name="masstransitcloseproximity" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkUnkmasstransitcloseproximity" name="masstransitcloseproximity" style="display:initial" />
                                    Unknown
                               </td>  
                </tr>
       </table>
            </div>
        </div>
                <!-- 11th menu -->
                <input type="radio" name="trg11" id="acc11" onclick="toggleconntent('content11')">
        <label for="acc11"><b> NATIONAL ENVIRONMENTAL POLICY ACT (NEPA)  PREVIOUS COMPLETED DOCUMENTS (ENVIRONMENTAL ASSESSMENTS(EA), ENVIRONMENTAL IMPACT STATEMENTS (EIS))</b></label>
        <div class="content" id="content11">
            <div class="inner">
        <table style="width: 100%">
            <tr>
                  <td style="width:80%">
                          <asp:Label ID="Label13" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                  Has an previous NEPA EA or EIS  been completed for the project? 
                    </td>
                 <td colspan="2"> 
                          <input type="radio" id="chkYespreviousnepaeaoreis" name="previousnepaeaoreis" style="display:initial" />
                                                        Yes                                                                                                  
                          <input type="radio" id="chkNopreviousnepaeaoreis" name="previousnepaeaoreis" style="display:initial" />
                                       No                                                                                                      
                   <input type="radio" id="chkUnkpreviousnepaeaoreis" name="previousnepaeaoreis" style="display:initial" />
                                    Unknown
                               </td>  
                </tr>
             <tr>
                  <td colspan="1">
                        <div id="dvfinaleasignedfonsi" style="display: none">
                     Is there a Final EA and signed Finding of No Significant Impact (FONSI) for the project? 

                             </div>
                  </td>
                    
                                                                       
                    <td colspan="2">  
                        <div id="dvChkfinaleasignedfonsi" style="display: none">
                    <input type="radio" id="chkYesfinaleasignedfonsi" name="finaleasignedfonsi" style="display:initial" />
                    Yes                                                                                                  
                   <input type="radio" id="chkNorfinaleasignedfonsi" name="finaleasignedfonsi" style="display:initial" />
                   No                                                                                                      
                  <input type="radio" id="chkUnkfinaleasignedfonsi" name="finaleasignedfonsi" style="display:initial" />
                  Unknown
                            </div> 
                  </td>                                                                                                                
               </tr>
             <tr>                                                 
                   <td colspan="1">
                                                    <div id="dvPLnkpreviousnepaeaoreis" style="display: none">
                                                     Please provide link or attach copy of previous NEPA EA or EIS and signed FONSI. 
                                                        </div>
                                                </td>
                                                <td>
                                                   <div id="dvpreviousnepaeaoreis" style="display: none">                                                   
                                                     <input type="text" id="txtpreviousnepaeaoreis" />
                                                    </div                                            
                                                </td>
                  </tr>

                 <tr>
                  <td colspan="1">
                     
                        <div id="dvprevcomplnepadocnavailable">
                                 <asp:Label ID="Label14" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                  Does the site have any previously completed NEPA documents for past projects that are available? (This can help to frame the potential resource areas or concern) 
                             </div>
                  </td>
                    
                                                                       
                    <td colspan="2">  
                        <div id="dvChkprevcomplnepadocnavailable">
                    <input type="radio" id="chkYesprevcomplnepadocnavailable" name="prevcomplnepadocnavailable" style="display:initial" />
                    Yes                                                                                                  
                   <input type="radio" id="chkNoprevcomplnepadocnavailable" name="prevcomplnepadocnavailable" style="display:initial" />
                   No                                                                                                      
                  <input type="radio" id="chkUnkprevcomplnepadocnavailable" name="prevcomplnepadocnavailable" style="display:initial" />
                  Unknown
                            </div> 
                  </td>                                                                                                                
               </tr>  
                  <tr>                                
                   <td colspan="1">
                                                    <div id="dvLnksitepocpastnepadocn" style="display: none">
                                         Please provide site POC for past NEPA documentation  or attach past NEPA documentation 

                                                        </div>
                                                </td>
                                                <td>
                                                   <div id="dvTxtlnksitepocpastnepadocn" style="display: none">                                                   
                                                     <input type="text" id="txtLnksitepocpastnepadocn" />
                                                    </div                                            
                                                </td>
                 </tr>
            <tr>
                  <td colspan="1">
                        <div>
                            <asp:Label ID="Label15" runat="server" Text="*" ForeColor="#ff0000" Font-Bold="true"></asp:Label>
                 Are there other projects underway or planned for the near term at the property (Minors)? 
                             </div>
                  </td>
                    
                                                                       
                    <td colspan="2">  
                        <div id="dvChkotherprojectunderwayorplanned">
                    <input type="radio" id="chkYesotherprojectunderwayorplanned" name="otherprojectunderwayorplanned" style="display:initial" />
                    Yes                                                                                                  
                   <input type="radio" id="chkNootherprojectunderwayorplanned" name="otherprojectunderwayorplanned" style="display:initial" />
                   No                                                                                                      
                  <input type="radio" id="chkUnkotherprojectunderwayorplanned" name="otherprojectunderwayorplanned" style="display:initial" />
                  Unknown
                            </div> 
                  </td>                                                                                                                
               </tr>  
            
       </table>
            </div>
        </div>
          <!-- 12th menu -->
        <input type="radio" name="trg12" id="acc12" onclick="toggleconntent('content12')">
        <label for="acc12"><b> PHYSICAL SECURITY</b></label>
        <div class="content" id="content12">
            <div class="inner">
        <table style="width: 100%">
            <tr>
                  <td style="width:80%">
                 Will the proposed impacts Physical Security requirements that may require other actions? What are those potential actions?</br></br>
                      <textarea id="TextArea1" cols="20" rows="5" style="width:80%"></textarea>  </br></br>
                    </td>
                </tr>
             <tr>
                  <td style="width:80%">
                 Will the proposed potentially impact Physical Security requirements require and cause other actions? What are those potential actions?</br></br>
                       <textarea id="TextArea2" cols="20" rows="5" style="width:80%"></textarea> 
                    </td>
                </tr>
       </table>
            </div>
        </div>
      </br>
          <asp:Label ID="lblAssignTo" runat="server"  Text="Assign To :" Font-Bold="true"></asp:Label>
         
            <asp:DropDownList ID="ddlAssignTo" runat="server" DataSourceID="sdsrcEnvironmentalEngineer"
                DataTextField="FullName" DataValueField="personnel_pk" 
                   AppendDataBoundItems="True" Height="21px" Width="201px">
                <asp:ListItem Text="-Select-" Value=""></asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsrcEnvironmentalEngineer" runat="server" ConnectionString="<%$ ConnectionStrings:MainConn %>" 
                   SelectCommand="SELECT personnel_pk, firstName + ' ' + lastName as FullName FROM Personnel
                                    WHERE userGroup in (210, 220) AND deleted=0 ORDER BY FullName"></asp:SqlDataSource>
          </br>
          </br>
         </div>
      

        <div style="text-align:center">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit for Assignment" Width="100px"  style="width: 25%; padding-top: 10px; padding-bottom: 10px;" OnClick="btnSubmit_Click" OnClientClick="if (!confirm('This will assign the project for Initial Response to an engineer. Please OK to continue')) return false;"/>
        </div>
    <script type="text/javascript">
    function toggleconntent(menu1) {
        $('#' + menu1).toggle();
    }

    </script>
</asp:Content>

