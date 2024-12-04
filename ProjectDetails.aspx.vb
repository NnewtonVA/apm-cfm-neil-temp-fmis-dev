Imports System.Data.SqlClient
Imports System.Net.Mail
Imports System.Runtime.CompilerServices
Imports System.Windows.Inputd
Imports CFMISNew.CFMIS.Services
Imports Microsoft.Ajax.Utilities
Imports Microsoft.ReportingServices.RdlExpressions.ExpressionHostObjectModel
Imports System.Drawing
Public Class ProjectDetails
    Inherits System.Web.UI.Page

    Dim prevVal As String
    Dim varProjNum As String
    Dim email As String
    Dim EmailFrom As String
    Dim intEmailLenght As Integer
    Dim varId As String

    Public tr As Long
    Public Property ProjectHealthColor As Object

    ''' <summary>
    ''' The VA Logo at the top will be hidden for this page.
    ''' </summary>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Neil Sustainability 
    '    AddHandler ddSustCoord.SelectedIndexChanged, AddressOf ddSustCoord_OnSelectedIndexChanged
        'AddHandler btnSaveLeed.Click, AddressOf btnSaveLEED_Click"
        'Dim ddsusttest As String
        'AddHandler btnSaveGenInfo.Click, AddressOf btnSaveGenInfo_Click
        'ddsusttest = ddSustCoord.SelectedValue.ToString
        'Neil Sustainability-end

        'get the project id to pass it to open the factsheet details page
        varId = Convert.ToString(Request.QueryString("project_pk"))
        hlFactsheetPage.NavigateUrl = "FSDetails.aspx?project_pk=" + varId
        If Not Page.IsPostBack Then
            Pageloadsubmittedrecords()
            GetByUserGroupManagerRoles()
            'Neil Sustainability
            'Neil Sustainability
            If DataExistsForPhase() Then
                Session("CurrState") = "DataExists"
                Session("BldgNbr") = "1"
                SetPanels()
                If SustainabilityDataExists() Then
                    GetDataAllPanels()
                    'bring back this proc below when enabling
                    'and disabling is brought back.
                    'SetControlsEnabledDisabled()
                Else
                    ClearAllScreenFields()
                    GetNumberOfBuildings()
                    GetPhaseCoordinator()										  										 
                End If
            Else
                Session("BldgNbr") = "1"
                Session("CurrState") = "NbrOfBuildings"
                SetPanels()
                ClearAllScreenFields()
            End If
        End If

        Dim menu As ContentPlaceHolder = CType(Master.FindControl("cphMainMenu"), ContentPlaceHolder)
        menu.Visible = False

        Session("EnvSchedCount") = GetprojectEnvironmentScheduleCount()

        'to get the project number and show it in the page title in the browser tab
        varProjNum = CType(fvAllTabInfo.FindControl("lblShowProjCode"), Label).Text
        'Neil Sustainability
        Session("ProjCode") = varProjNum
        'Neil Sustainability end
        Me.Page.Title = varProjNum

        'to get the logged on user
        Dim Logon As String
        Logon = Request.LogonUserIdentity.Name
        Dim nIndex As Integer = Logon.IndexOf("\")
        Logon = Logon.Substring(nIndex + 1)
        lblUserNm.Text = Logon

        ' to get groupid if it's nothing
        If Session("GroupID") Is Nothing Then
            Dim authenticationservice As New AuthenticationService()
            '            Dim ugResult As String = GetUserGroup()
            Dim ugResult As String = authenticationservice.GetUserGroup()
            authenticationservice.Dispose()
        End If

        'get the project id to pass it to open the factsheet details page
        varId = Convert.ToString(Request.QueryString("project_pk"))
        hlFactsheetPage.NavigateUrl = "FSDetails.aspx?project_pk=" + varId

        Dim varTab As String = Convert.ToString(Request.QueryString("tab"))
        If varTab = "3" Then
            tcProjectDetails.ActiveTab = tpFunding
        ElseIf varTab = "2" Then
            tcProjectDetails.ActiveTab = tpCostFunding
        ElseIf varTab = "1" Then
            tcProjectDetails.ActiveTab = tpScopeStatusComment
        ElseIf varTab = "4" Then
            tcProjectDetails.ActiveTab = tpSchedule
        End If

        'if the region is Cemetery, then the NCA label and dropdown list will be visible.
        Dim varRegion As DropDownList = CType(fvMainInfo.FindControl("ddlEditRegion"), DropDownList)
        Dim varDistrictLabel As Label = CType(fvMainInfo.FindControl("lblNcaDistrict"), Label)
        Dim ddlNcaDistrict As DropDownList = CType(fvMainInfo.FindControl("ddlNcaDistrict"), DropDownList)
        If varRegion.SelectedValue = "Cemetery" Then
            varDistrictLabel.Visible = True
            ddlNcaDistrict.Visible = True
        Else
            varDistrictLabel.Visible = False
            ddlNcaDistrict.Visible = False
        End If

        'check if a project is a main or sub project
        Dim varSubProjFlag As CheckBox = CType(fvMainInfo.FindControl("cbSubProjectFlag"), CheckBox)

        'check if the project is active based on status. show the view vCostFms for active project
        'or show the view vCostCfmis for inactive project in the cost tab.
        Dim varStatus As String = CType(fvAllTabInfo.FindControl("lblStatus"), Label).Text
        If varStatus = "Active" Then
            mvCost.SetActiveView(vCostFms)
        Else
            mvCost.SetActiveView(vCostCfmis)
        End If

        'get the project type label and dropdownlist as they will not be visible in sub project
        Dim varPrjTp As Label = CType(fvMainInfo.FindControl("lblShowProjTp"), Label)
        Dim varPrjTypeList As DropDownList = CType(fvMainInfo.FindControl("ddlType"), DropDownList)

        'visibility of different section will be different based on if a project is main or sub
        If varSubProjFlag.Checked Then
            lblMainInfoHdg.Text = "Details Information Of the Sub Project"
            btnAddSubProj.Visible = False
            gvSubProj.Visible = True
            hlFactsheetPage.Visible = False
            fvCost.Visible = False
            fvAddCost.Visible = False
            fvSubProjCost.Visible = True
            Funding.Visible = False
            tcProjectDetails.Tabs(3).Visible = False
            mvCost.Visible = False
            varPrjTp.Visible = False
            varPrjTypeList.Visible = False
        Else
            lblMainInfoHdg.Text = "Details Information Of the Main Project"
            btnAddSubProj.Visible = True
            gvSubProj.Visible = True
            varPrjTp.Visible = True
            varPrjTypeList.Visible = True
            If Not Page.IsPostBack Then
                fvCost.DataBind()
            End If
            If fvCost.DataItemCount > 0 Then
                mvCostView.SetActiveView(vUpdt)
            Else
                mvCostView.SetActiveView(vAdd)
            End If

            fvSubProjCost.Visible = False
            Funding.Visible = True
            If Session("GroupID") < 500 Then
                btnAddFunding.Visible = False
                gvFunding.Columns(11).Visible = False
                gvFunding.Columns(12).Visible = False
            End If

            'the link Go To Factsheet page will be visible for active main projects only
            If varStatus = "Active" Then
                hlFactsheetPage.Visible = True
            Else
                hlFactsheetPage.Visible = False
            End If

        End If

        If Not Page.IsPostBack Then
            GetSchedule()
            If Session("blnAddFundingClick") = "1" Then
                tcProjectDetails.ActiveTabIndex = 3
            Else
                tcProjectDetails.ActiveTabIndex = 0
            End If
            Session("blnAddFundingClick") = ""

        End If

        'Show label with last update date for FMS
        Dim vardate As String
        Try
            Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
            Using conn As New SqlConnection(ConnStr)
                Dim command As New SqlCommand
                command.Connection = conn
                conn.Open()
                command.CommandText = "Select top(1) Convert(VarChar(10),updatedon, 101) As Updated from vw_SAS2  order by updatedon desc"
                command.CommandType = CommandType.Text

                Dim reader As SqlDataReader = command.ExecuteReader()
                reader.Read()
                vardate = reader("Updated").ToString
                reader.Close()
                conn.Close()
                lblDataRefreshOn.Text = "Last updated On: " & vardate
            End Using
        Catch ex As Exception

        Finally

        End Try
        'user with read only access
        If Session("GroupID") < 200 Then
            btnAddSubProj.Visible = False
            btnEditProj.Visible = False
            btnAddPersonnel.Visible = False
            btnAddCostComment.Visible = False
            btnAddFunding.Visible = False
            btnUpdateSchedule.Visible = False
            gvCurrentPersonnel.Columns(6).Visible = False
            gvFunding.Columns(11).Visible = False
            gvFunding.Columns(12).Visible = False
            fvLatestComment.Visible = False
            fvAddCost.Visible = False


        End If

        ' load POCs
        If Not String.IsNullOrEmpty(Request.QueryString("project_pk")) Then
            If Not Page.IsPostBack Then
                BindPocGrid(varId)
            End If
        Else
            'when no project id is there, means a new record
            If Not Page.IsPostBack Then
                LoadProjectPocGrid(0)
            End If
        End If

        If Not Page.IsPostBack Then
            If GetProjectPOCCount() > 0 Or Session("btnAddPOCClick") = 1 Then
                gvPOC.Visible = True
                Session("btnAddPOCClick") = 0
            Else
                gvPOC.Visible = False
                Session("btnAddPOCClick") = 0
            End If
        End If
    End Sub
    'Neil Sustainability
    Protected Function SustainabilityDataExists() As Boolean
        Dim phaseID As Integer = Convert.ToString(Request.QueryString("project_pk"))

        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))


        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        cmd.CommandText = "GetSustainabilityGeneralInfo"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add(New SqlParameter("@Project_FK", strProjId))
        cmd.Parameters.Add(New SqlParameter("@BuildingNo", Convert.ToInt32(Session("BldgNbr"))))
        cmd.Parameters.Add(New SqlParameter("@User", "User"))
        cmd.Connection = conn
        If conn.State = ConnectionState.Closed Then
            conn.Open()
        End If
        Dim adp As New SqlDataAdapter

        adp.SelectCommand = cmd
        Dim ds As New DataSet
        adp.Fill(ds)

        If ds.Tables.Count = 0 Then
            Return False
        Else
            Return True
        End If
    End Function
    'Neil Sustainability
    Protected Sub SetControlsEnabledDisabled()
        'This code reacts to clicks of controls using Javascripts
        'to disable certain other controls.Since this disabling
        'isn't saved in the database we must run the same javscript
        'functions so the disabling is done when re-entering the phase
        'WON'T WORK multiple ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "handleleedrequired()", True)
        'the js called above will disable all of the leed controls
        ';if the first question is no. so if that questions is no we don't
        'run the next js which depends on those controls to be enabled
        'If rdoLEEDRequired.SelectedValue <> "No" Then
        'WON'T WORK mutiples ClientScript.RegisterStartupScript(Me.GetType(), "myScript1", "handleleedregistered()", True)
        'End If
        'Another JS function to be executed at sust start
        'WON'T WORK multiples ClientScript.RegisterStartupScript(Me.GetType(), "myScript2", "handleashraefinal()", True)
        'PICKCoord
        If rdoLEEDRequired.SelectedValue = "No" Then
            rdRegisteredOnline.Enabled = False
            rdRegisteredOnline.ClearSelection()
            txtLeedRegistration.Enabled = False
            txtLeedRegistration.Text = String.Empty
            rdoProjectedLeedSilver.Enabled = False
            rdoProjectedLeedSilver.ClearSelection()
            rdoLeedWaiver.Enabled = False
            rdoLeedWaiver.ClearSelection()
            rdoCertStatus.Enabled = False
            rdoCertStatus.ClearSelection()
        Else
            rdRegisteredOnline.Enabled = True
            txtLeedRegistration.Enabled = rdRegisteredOnline.SelectedValue = "Yes"
            rdoProjectedLeedSilver.Enabled = True
            rdoLeedWaiver.Enabled = True
            rdoCertStatus.Enabled = True
        End If
        If rdRegisteredOnline.Enabled = True And rdRegisteredOnline.SelectedValue = "Yes" Then
            txtLeedRegistration.Enabled = True
        Else
            txtLeedRegistration.Enabled = False
        End If

        If chkFinal.Enabled = True And chkFinal.Checked = False Then
            txtDateDesignComplete.Enabled = False
        Else
            txtDateDesignComplete.Enabled = True
        End If

    End Sub
    'Neil Sustainability
    Protected Sub rdoLEEDRequired_OnSelectedIndexChanged(sender As Object, e As EventArgs)
        'This code was replaced by JS code to prevent postback
        'EnableDisableControlsRequired()
        'Me.ClientScript.RegisterStartupScript(Me.GetType(),
        '                                "navigate",
        '                                "window.onload = function() {window.location.hash='#LeedBottom';}",
        '                                 True)
        ' ClientScript.RegisterStartupScript(Me.GetEnableDisableRegisterOnline()Type(), "hash", "location.hash = 'LeedBottom';", True)
        'Me.ClientScript.RegisterStartupScript(Me.GetType(),
        '                                     "navigate",
        '                                     "$(function() { $.scrollTo('#LeedBottom'); });",
        '                                      True)
        'Response.Redirect("ProjectDetails.aspx" + "#LeedBottom'", False)
        '        document.getElementById('MyID').scrollIntoView(true);
        '
        'Response.Redirect("ProjectDetails.aspx" + "#LeedBottom", False)
        'rdoCertStatus.Focus()
        'Page.MaintainScrollPositionOnPostBack = False
        'Page.ClientScript.RegisterStartupScript(Me.GetType(), "hash", "location.hash = '#LeedBottom';", True)

    End Sub
    'Neil Sustainability
    Protected Sub rdRegisteredOnline_OnSelectedIndexChanged(sender As Object, e As EventArgs)
        'This will be used when disabling is fully implemented
        'As of now there are problems with disabling with JS.
        'EnableDisableRegisterOnline()
    End Sub
    'Neil Sustainabilty
    Sub EnableDisableControlsRequired()
        Dim leedRequire As Boolean = rdoLEEDRequired.SelectedValue = "No"
        rdRegisteredOnline.Enabled = Not leedRequire
        rdRegisteredOnline.ForeColor = IIf(leedRequire, Color.DarkCyan, Color.Black)
        rdRegisteredOnline.ClearSelection()

        ''If rdoLeedRequired is not no wnd the other leed controls are not enabled
        ''it means that the last click on rdoleedRequired was no and all the other
        ''leed controls were disabled and cleared. Now these same previously
        ''disabled controls will be enabled and set to default values
        'If txtLeedRegistration.Enabled = False Then
        '    'set leed controls to default values
        '    SetLeedstoDefault()
        'End If

        txtLeedRegistration.Enabled = Not leedRequire
        txtLeedRegistration.Text = String.Empty
        txtLeedRegistration.BackColor = IIf(leedRequire, Color.LightCyan, Color.White)
        rdoProjectedLeedSilver.Enabled = Not leedRequire
        rdoProjectedLeedSilver.ForeColor = IIf(leedRequire, Color.DarkCyan, Color.Black)

        rdoLeedWaiver.Enabled = Not leedRequire
        rdoLeedWaiver.ForeColor = IIf(leedRequire, Color.DarkCyan, Color.Black)

        rdoCertStatus.Enabled = Not leedRequire
        rdoCertStatus.ForeColor = IIf(leedRequire, Color.DarkCyan, Color.Black)

        If leedRequire Then 'If no then all leed cntrls disabled and cleared
            rdoProjectedLeedSilver.ClearSelection()
            rdoLeedWaiver.ClearSelection()
            rdoCertStatus.ClearSelection()
        Else
            rdRegisteredOnline.SelectedValue = "Unknown"
            txtLeedRegistration.Text = String.Empty
            rdoProjectedLeedSilver.SelectedValue = "Unknown"
            rdoLeedWaiver.SelectedValue = "Unknown"
            rdoCertStatus.SelectedValue = "Not Registered"
        End If









    End Sub
    'Neil Sustainability
    Protected Sub EnableDisableRegisterOnline()
        Dim leedRegisteredOnline As Boolean = rdRegisteredOnline.SelectedValue = "No"


        txtLeedRegistration.Enabled = Not leedRegisteredOnline
        txtLeedRegistration.BackColor = IIf(leedRegisteredOnline, Color.LightCyan, Color.White)
        txtLeedRegistration.Text = String.Empty

        ''If buildingRegisteredLeedOnLine Is Not no Then LeedRegistrationno Number Is Not enabled
        ''it means that the last click on buildingRegisteredLeedOnLine was no and leedRegistration number was
        ''disabled and now LeedRegistration number will be enabled and set to empty
        'If txtLeedRegistration.Enabled = False Then
        '    'set leed controls to default values
        '    SetLeedstoDefault()
        'End If

    End Sub
    Private Sub GetProjectCode()
        Dim phaseID As Integer = Convert.ToString(Request.QueryString("project_pk"))
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        cmd.CommandText = "getProjectCode"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add(New SqlParameter("@Phase_FK", phaseID))
        cmd.Connection = conn
        If conn.State = ConnectionState.Closed Then
            conn.Open()
        End If
        Dim adp As New SqlDataAdapter

        adp.SelectCommand = cmd
        Dim ds As New DataSet
        adp.Fill(ds)
        Dim projectCode As Integer = ds.Tables(0).Rows(0)("projectCode")
    End Sub
    'Neil Sustainability
    Private Function DataExistsForPhase()
        Dim phaseID As Integer = Convert.ToString(Request.QueryString("project_pk"))

        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        cmd.CommandText = "getSustainabilityNumberOfBldgs"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add(New SqlParameter("@Phase_FK", phaseID))
        'cmd.Parameters.Add(New SqlParameter("@BuildingNo", Convert.ToInt32(Session("BldgNbr"))))
        cmd.Parameters.Add(New SqlParameter("@User", "User"))
        cmd.Connection = conn
        If conn.State = ConnectionState.Closed Then
            conn.Open()
        End If
        Dim adp As New SqlDataAdapter

        adp.SelectCommand = cmd
        Dim ds As New DataSet
        adp.Fill(ds)
        Dim NbrBuildings As Integer = ds.Tables(0).Rows(0)("NbrOfBuildings")
        If NbrBuildings <> -99 Then
            Return True
        Else
            'ddSustCoord.Items.FindByValue("0").Selected = True
            Return False

        End If
        'Dim NbrBuildings As Integer = ds.Tables(0).Rows(0)("NbrOfBuildings")
    End Function
    'Neil Sustainability
    Private Function DataExistsForPhaseAndBuilding()
        Dim phaseID As Integer = Convert.ToString(Request.QueryString("project_pk"))

        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))


        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        cmd.CommandText = "GetSustainabilityGeneralInfo"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add(New SqlParameter("@Project_FK", strProjId))
        cmd.Parameters.Add(New SqlParameter("@BuildingNo", Convert.ToInt32(Session("BldgNbr"))))
        cmd.Parameters.Add(New SqlParameter("@User", "User"))
        cmd.Connection = conn
        If conn.State = ConnectionState.Closed Then
            conn.Open()
        End If
        Dim adp As New SqlDataAdapter

        adp.SelectCommand = cmd
        Dim ds As New DataSet
        adp.Fill(ds)

        If ds.Tables.Count = 0 Then
            Return False
        Else
            Return True
        End If
    End Function
    'Neil Sustainability
    Private Sub SetPanels()
        Dim a As Int32 = 10

        If Session("CurrState") = "NbrOfBuildings" Then
            PnlNumberOfBuildings.Visible = True
            PnlGeneralInfo.Visible = False
            PnlLeeds.Visible = False
            PnlNetZero.Visible = False
            PnlASHRAE.Visible = False
        Else
            PnlNumberOfBuildings.Visible = True
            PnlGeneralInfo.Visible = True
            PnlLeeds.Visible = True
            PnlNetZero.Visible = True
            PnlASHRAE.Visible = True
            'ClearAllScreenFields()
            GetSustainabilityGenInfo()
        End If
        'ElseIf Session("CurrState") = "LEED" Then
        '    PnlNumberOfBuildings.Visible = True
        '    PnlGeneralInfo.Visible = True
        '    PnlLeeds.Visible = True
        '    PnlNetZero.Visible = False
        '    PnlASHRAE.Visible = False
        '    GetNumberOfBuildings()
        '    GetSustainabilityGenInfo()
        '    'GetSustainabilityLEED()

        'ElseIf Session("CurrState") = "NETZERO" Then
        '    PnlNumberOfBuildings.Visible = True
        '    PnlGeneralInfo.Visible = True
        '    PnlLeeds.Visible = True
        '    PnlNetZero.Visible = True
        '    PnlASHRAE.Visible = False
        '    GetSustainabilityLEED()
        '    GetNumberOfBuildings()
        '    GetSustainabilityGenInfo()
        'ElseIf Session("CurrState") = "ASHRAE" Then
        '    PnlNumberOfBuildings.Visible = True
        '    PnlGeneralInfo.Visible = True
        '    PnlLeeds.Visible = True
        '    PnlNetZero.Visible = True
        '    PnlASHRAE.Visible = True
        '    GetSustainabilityASHRAE()
        '    'GetSustainabilityLEED()
        '    GetNumberOfBuildings()
        '    GetSustainabilityGenInfo()
        'ElseIf Session("CurrState") = "DataExists" Then
        '    'GetDataAllPanels()
        '    GetNumberOfBuildings()
        'End If
        Dim strLoggedUser As String
        strLoggedUser = String.Empty
        Try
            'Neil workaround Bandaid before new machine
            Dim uname As String = Context.User.Identity.Name
            strLoggedUser = uname.Substring(uname.LastIndexOf("\"))
        Catch
            strLoggedUser = "\OITMOUNewtoN"
        End Try
        'Neil
        Dim validUsersSust As String() = {"\vacozelenk", "\vacosymanj", "\vacolarsoj", "\oitmounewtoN", "\vhantxTorraL", "\vacodibabd", "\vacobelanr"}
        'Dim validUsersSust As String() = {"\vacozelenk", "\vacosymanj", "\vacolarsoj", "\vhantxTorraL"}
        For Each User As String In validUsersSust
            If strLoggedUser.ToUpper = User.ToUpper Then
                EnableSustPanels()
                'If ProjectNotPhase() Then
                '    PnlNumberOfBuildings.Enabled = False
                'Else
                PnlNumberOfBuildings.Enabled = True
                GetNumberOfBuildings()
                ' End If
                Return
            End If
        Next

        'DisableSustPanels()
    End Sub
    'Neil sustainability
    Private Function ProjectNotPhase()
        'If Session("ProjCode").ToString.Length = 7 Then
        '    Return True
        'Else
        '    Return False
        'End If
        Dim varSubProjFlag As CheckBox = CType(fvMainInfo.FindControl("cbSubProjectFlag"), CheckBox)
        If varSubProjFlag.Checked = True Then
            Return False
        Else
            Return True
        End If

    End Function
    'Neil Sustainability
    Private Sub DisableSustPanels()
        PnlNumberOfBuildings.Enabled = False
        PnlGeneralInfo.Enabled = False
        PnlGeneralInfo.Enabled = False
        PnlLeeds.Enabled = False
        PnlNetZero.Enabled = False


    End Sub
    'Neil Sustainability
    Private Sub EnableSustPanels()
        PnlNumberOfBuildings.Enabled = True
        PnlGeneralInfo.Enabled = True
        PnlGeneralInfo.Enabled = True
        PnlLeeds.Enabled = True
        PnlNetZero.Enabled = True

    End Sub
    'Neil Sustainability
    Private Sub GetNumberOfBuildings()
        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))


        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        cmd.CommandText = "getSustainabilityNumberOfBldgs"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add(New SqlParameter("@Phase_FK", strProjId))
        'cmd.Parameters.Add(New SqlParameter("@BuildingNo", Convert.ToInt32(Session("BldgNbr"))))
        cmd.Parameters.Add(New SqlParameter("@User", "User"))
        cmd.Connection = conn
        If conn.State = ConnectionState.Closed Then
            conn.Open()
        End If
        Dim adp As New SqlDataAdapter

        adp.SelectCommand = cmd
        Dim ds As New DataSet
        adp.Fill(ds)

        If ds.Tables.Count = 0 Or ds.Tables(0).Rows(0)("NbrOfBuildings") = -99 Then
            'No data for this phase id and current building number
            Return
        End If
        Dim NbrBuildings As Integer = ds.Tables(0).Rows(0)("NbrOfBuildings")
        Session("BldgsInPhase") = NbrBuildings
        If NbrBuildings <> -99 Then
            ddSustCoord.Items.FindByValue(NbrBuildings.ToString).Selected = True
            ddSustCoord.SelectedValue = ds.Tables(0).Rows(0)("NbrOfBuildings").ToString																					   
            'Neil-Once they pick a number of buildings disable the number of buildings dropdown
            ddSustCoord.Enabled = False
        Else
            'ddSustCoord.Items.FindByValue("0").Selected = True
            ddSustCoord.SelectedValue = "O"
        End If
        If conn.State = ConnectionState.Open Then
            conn.Close()
        End If
        adp.Dispose()

    End Sub						
    'Neil Sustainability
    Private Function GetPhaseCoordinator()

        Dim uname As String = Context.User.Identity.Name

        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))


        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString

        Dim cmdCoord As New SqlCommand
        cmdCoord.CommandText = "getSustainabilityPhaseCoordinators"
        cmdCoord.CommandType = CommandType.StoredProcedure
        cmdCoord.Parameters.Add(New SqlParameter("@Phase_FK", strProjId))
        cmdCoord.Parameters.Add(New SqlParameter("@User", uname))
        cmdCoord.Connection = conn
        If conn.State = ConnectionState.Closed Then
            conn.Open()
        End If
        Dim adp As New SqlDataAdapter

        adp.SelectCommand = cmdCoord
        Dim ds As New DataSet
        adp.Fill(ds)

        If ds.Tables(0).Rows.Count = 0 Then
            'No data for this phase and coordinator
            Return 0
        End If
        'Return ds.Tables(0).Rows(0)("Personnel_FK")
        If ds.Tables(0).Rows(0)("Personnel_FK").ToString <> "" Then
            ddChooseSustCoord.SelectedValue = ds.Tables(0).Rows(0)("Personnel_FK").ToString
        Else
            ddChooseSustCoord.SelectedValue = "0"
        End If

        If conn.State = ConnectionState.Open Then
            conn.Close()
        End If
        adp.Dispose()
        SetCoordEnableDisable()


    End Function
    'Neil Sustainability
    Private Sub SetCoordEnableDisable()
        Dim uname As String = Context.User.Identity.Name
        Dim strLoggedUser = uname.Substring(uname.LastIndexOf("\") + 1)
        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))


        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString

        Dim cmdCoord As New SqlCommand
        cmdCoord.CommandText = "IsUserSustainabilityDir"
        cmdCoord.CommandType = CommandType.StoredProcedure
        cmdCoord.Parameters.Add(New SqlParameter("@username", strLoggedUser))

        cmdCoord.Connection = conn
        If conn.State = ConnectionState.Closed Then
            conn.Open()
        End If
        Dim adp As New SqlDataAdapter

        adp.SelectCommand = cmdCoord
        Dim ds As New DataSet
        adp.Fill(ds)

        If ds.Tables(0).Rows.Count = 0 Then
            'No data for this phase and coordinator
            Return
        End If
        'Return ds.Tables(0).Rows(0)("Personnel_FK")
        'Neilfix
        'ThisLiteral line of code needs to go back in but since the Richard version is not working to enable this while my version is we will make it so the choose sust dd is always visiable all the time
        'ddChooseSustCoord.Enabled = ds.Tables(0).Rows(0)("Result") = 1
        ddChooseSustCoord.Enabled = True
        If conn.State = ConnectionState.Open Then
            conn.Close()
        End If
        adp.Dispose()



    End Sub
    'Neil Sustainability
    Private Sub GetSustainabilityGenInfo()
        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))


        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        cmd.CommandText = "GetSustainabilityGeneralInfo"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add(New SqlParameter("@Project_FK", strProjId))
        cmd.Parameters.Add(New SqlParameter("@BuildingNo", Convert.ToInt32(Session("BldgNbr"))))
        cmd.Parameters.Add(New SqlParameter("@User", "User"))
        cmd.Connection = conn
        If conn.State = ConnectionState.Closed Then
            conn.Open()
        End If
        Dim adp As New SqlDataAdapter

        adp.SelectCommand = cmd
        Dim ds As New DataSet
        adp.Fill(ds)

        If ds.Tables.Count = 0 Then
            txtSqFtConst.Text = 0
            txtSqFtRenovation.Text = 0
            Return
        End If
        Dim b As Integer
        If ds.Tables(0).Rows.Count > 0 Then
            txtBuildingName.Text = ds.Tables(0).Rows(0)("buildingName").ToString
            txtBldgDesc.Text = ds.Tables(0).Rows(0)("BuildingDescription").ToString

            'Dim a As String

            If Int32.TryParse(ds.Tables(0).Rows(0)("SquareFootageConstructionWork").ToString, b) Then
                If ds.Tables(0).Rows(0)("SquareFootageConstructionWork").ToString <> 0 Then
                    txtSqFtConst.Text = (Convert.ToInt64(ds.Tables(0).Rows(0)("SquareFootageConstructionWork")).ToString("N0"))
                Else
                    txtSqFtConst.Text = "0"
                End If
            Else
                txtSqFtConst.Text = "0"
            End If
            If Int32.TryParse(ds.Tables(0).Rows(0)("SquareFootageRenovationWork").ToString, b) Then
                If ds.Tables(0).Rows(0)("SquareFootageRenovationWork").ToString <> 0 Then
                    txtSqFtRenovation.Text = (Convert.ToUInt64(ds.Tables(0).Rows(0)("SquareFootageRenovationWork")).ToString("N0"))
                Else
                    txtSqFtRenovation.Text = "0"
                End If
            Else
                txtSqFtRenovation.Text = "0"
            End If
            txtSqFtAll.Text = (Convert.ToInt64(ds.Tables(0).Rows(0)("SquareFootageConstructionWork").ToString) + Convert.ToInt64(ds.Tables(0).Rows(0)("SquareFootageRenovationWork")).ToString("N0"))
            'If Int32.TryParse(ds.Tables(0).Rows(0)("SquareFootageAllWork").ToString, b) Then
            '    If ds.Tables(0).Rows(0)("SquareFootageAllWork").ToString <> 0 Then
            '        txtSqFtAll.Text = Convert.ToUInt32(ds.Tables(0).Rows(0)("SquareFootageAllWork").ToString) '.ToString("##,###.00")
            '    Else
            '        txtSqFtAll.Text = ""
            '    End If
            'Else
            '    txtSqFtAll.Text = ""
            'End If

            'txtSqFtAll.Text = ds.Tables(0).Rows(0)("SquareFootageAllWork")
            If ds.Tables(0).Rows(0)("DateBuildingDesignStarted") Is DBNull.Value Then
                txtDateDesignStarted.Text = ""
            Else
                txtDateDesignStarted.Text = CDate(ds.Tables(0).Rows(0)("DateBuildingDesignStarted")).ToString("yyyy-MM-dd")
                'txtDateDesignStarted.Text = CDate(ds.Tables(0).Rows(0)("DateBuildingDesignStarted")).ToString '. ', System.Globalization.CultureInfo.InvariantCulture)
            End If

            'Command.Parameters.AddWithValue("@SquareFootageRenovationWork", DbNullOrStringValue(Convert.ToDecimal(b)))
            'Else
            '        'Command.Parameters.AddWithValue("@SquareFootageRenovationWork", DbNullOrStringValue("0.00"))
            '        txtSqFtConst.Text = ""
        End If

        'If Int32.TryParse(ds.Tables(0).Rows(0)("SquareFootageRenovationWork").ToString, b) Then
        'If ds.Tables(0).Rows(0)("SquareFootageConstructionWork").ToString <> "0.0000" Then
        'txtSqFtRenovation.Text = Convert.ToInt32(ds.Tables(0).Rows(0)("SquareFootageRenovationWork").ToString) '.ToString("##,###.00")
        'Else
        'txtSqFtRenovation.Text = ""
        '    End If
        ''    'Command.Parameters.AddWithValue("@SquareFootageRenovationWork", DbNullOrStringValue(Convert.ToDecimal(b)))
        'Else
        '    'Command.Parameters.AddWithValue("@SquareFootageRenovationWork", DbNullOrStringValue("0.00"))
        '    txtSqFtRenovation.Text = ""
        '    End If

        '    If Decimal.TryParse(ds.Tables(0).Rows(0)("SquareFootageAllWork").ToString, b) Then
        '    'If ds.Tables(0).Rows(0)("SquareFootageAllWork").ToString <> "0.0000" Then
        '    txtSqFtAll.Text = Convert.ToInt32(ds.Tables(0).Rows(0)("SquareFootageAllWork").ToString)
        '    ' b '.ToString("##,###.00")
        'Else
        '    txtSqFtAll.Text = ""
        'End If
        'Command.Parameters.AddWithValue("@SquareFootageRenovationWork", DbNullOrStringValue(Convert.ToDecimal(b)))
        'Else
        '        'Command.Parameters.AddWithValue("@SquareFootageRenovationWork", DbNullOrStringValue("0.00"))
        '        txtSqFtAll.Text = ""
        '    End If

        'txtSqFtConst.Text = ds.Tables(0).Rows(0)("SquareFootageConstructionWork")
        'txtSqFtRenovation.Text = ds.Tables(0).Rows(0)("SquareFootageRenovationWork")
        'txtSqFtAll.Text = ds.Tables(0).Rows(0)("SquareFootageAllWork")
        'If ds.Tables(0).Rows(0)("DateBuildingDesignStarted") Is DBNull.Value Then
        '        txtDateDesignStarted.Text = ""
        '    Else
        '        txtDateDesignStarted.Text = CDate(ds.Tables(0).Rows(0)("DateBuildingDesignStarted")).ToString("yyyy-MM-dd")
        '        'txtDateDesignStarted.Text = CDate(ds.Tables(0).Rows(0)("DateBuildingDesignStarted")).ToString '. ', System.Globalization.CultureInfo.InvariantCulture)
        '    End If
        'Dim dt As String = DateTime.Parse(ds.Tables(0).Rows(0)("DateBuildingDesignStarted")).ToString("MM/dd/yyyy")

        'Dim theDate As DateTime = DateTime.ParseExact(ds.Tables(0).Rows(0)("DateBuildingDesignStarted"), "dd'/'MM'/'yyyy", System.Globalization.CultureInfo.InvariantCulture)
        'Dim dateToInsert As String = theDate.ToString("dd-MM-yyyy")
        'txtDateDesignStarted.Text = Convert.ToDateTime(ds.Tables(0).Rows(0)("DateBuildingDesignStarted").ToString("MM/DD/YYYY")))
        'txtDateDesignStarted.Text = dateToInsert
        'End If
    End Sub
    'Neil sustainability
    Protected Sub addSqFt()
        If txtSqFtConst.Text = String.Empty Then
            txtSqFtConst.Text = 0
        End If
        If txtSqFtRenovation.Text = String.Empty Then
            txtSqFtRenovation.Text = 0
        End If
        txtSqFtAll.Text = (Convert.ToInt64(txtSqFtConst.Text.Replace(",", "") + Convert.ToInt64(txtSqFtRenovation.Text.Replace(",", "")).ToString))
    End Sub
    'Neil SustainabilityToString("MM/dd/yyyy")
    Private Sub GetSustainabilityLEED()
        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))


        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        cmd.CommandText = "GetSustainabilityLEED"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add(New SqlParameter("@Project_FK", strProjId))
        cmd.Parameters.Add(New SqlParameter("@BuildingNo", Convert.ToInt32(Session("BldgNbr"))))
        'cmd.Parameters.Add(New SqlParameter("@User", "User"))
        cmd.Connection = conn
        If conn.State = ConnectionState.Closed Then
            conn.Open()
        End If
        Dim adp As New SqlDataAdapter
        'Dim cname As String
        'For Each ctrl As Control In LEEDRequired.Controls
        '    cname = ctrl.ID.ToString
        'Next


        adp.SelectCommand = cmd
        Dim ds As New DataSet
        adp.Fill(ds)

        If ds.Tables.Count = 0 Then
            Return
        End If
        If ds.Tables(0).Rows.Count > 0 Then
            If ds.Tables(0).Rows(0)("LEEDCertificationRequirement").ToString <> "" Then
                rdoLEEDRequired.SelectedValue = ds.Tables(0).Rows(0)("LEEDCertificationRequirement").ToString
            End If
            If ds.Tables(0).Rows(0)("buildingRegisteredLEEDOnline").ToString <> "" Then
                rdRegisteredOnline.SelectedValue = ds.Tables(0).Rows(0)("buildingRegisteredLEEDOnline").ToString
            End If
            txtLeedRegistration.Text = ds.Tables(0).Rows(0)("LEEDRegistrationNo").ToString
            txtLeedRegistration.Enabled = rdRegisteredOnline.SelectedValue = "Yes"

            If ds.Tables(0).Rows(0)("LEEDCertificationRequirement").ToString <> "Yes" Then
                rdRegisteredOnline.Enabled = False
                txtLeedRegistration.Enabled = False
                rdoProjectedLeedSilver.Enabled = False
                ddCurrProjected.Enabled = False
                rdoLeedWaiver.Enabled = False
                rdoCertStatus.Enabled = False
                txtDateCertifed.Enabled = False
                ddLEEDCertLevelAcheived.Enabled = False
            Else
                rdRegisteredOnline.Enabled = True
                txtLeedRegistration.Enabled = rdRegisteredOnline.SelectedValue = "Yes"
                rdoProjectedLeedSilver.Enabled = True
                ddCurrProjected.Enabled = True
                rdoLeedWaiver.Enabled = True
                rdoCertStatus.Enabled = True
                txtDateCertifed.Enabled = rdoCertStatus.SelectedValue = "Certified"
                ddLEEDCertLevelAcheived.Enabled = rdoCertStatus.SelectedValue = "Certified"
                If ds.Tables(0).Rows(0)("isProjectedMinLEEDsilverCert").ToString <> "" Then
                    rdoProjectedLeedSilver.SelectedValue = ds.Tables(0).Rows(0)("isProjectedMinLEEDsilverCert").ToString
                    If rdoProjectedLeedSilver.SelectedValue <> "No" Then
                        rdoLeedWaiver.Enabled = False
                    Else
                        rdoLeedWaiver.Enabled = True
                    End If
                End If
            End If
            If ds.Tables(0).Rows(0)("LeedLevelProjectingToAcheive").ToString <> "" Then
                ddCurrProjected.SelectedValue = ds.Tables(0).Rows(0)("LeedLevelProjectingToAcheive").ToString
            End If
        If ds.Tables(0).Rows(0)("LeedWaiver").ToString <> "" Then
                rdoLeedWaiver.SelectedValue = ds.Tables(0).Rows(0)("LeedWaiver").ToString
            End If
            If ds.Tables(0).Rows(0)("LEEDcertStatus").ToString <> "" Then
                rdoCertStatus.SelectedValue = ds.Tables(0).Rows(0)("LEEDcertStatus").ToString
            End If
            If ds.Tables(0).Rows(0)("LEEDCertLevelAcheived").ToString <> "" Then
                ddLEEDCertLevelAcheived.SelectedValue = ds.Tables(0).Rows(0)("LEEDCertLevelAcheived").ToString
            End If
            ' If ds.Tables(0).Rows(0)("LEEDDateCertified").ToString <> "" Then
            'CDate(ds.Tables(0).Rows(0)("DateBuildingDesignStarted")).ToString("yyyy-MM-dd")
            If ds.Tables(0).Rows(0)("LEEDDateCertified").ToString <> "" Then
                txtDateCertifed.Text = CDate(ds.Tables(0).Rows(0)("LEEDDateCertified")).ToString("yyyy-MM-dd")
            Else
                txtDateCertifed.Text = String.Empty
                'End If
            End If
            txtDateCertifed.Enabled = rdoLEEDRequired.SelectedValue = "Yes" And rdoCertStatus.SelectedValue = "Certified"
            ddLEEDCertLevelAcheived.Enabled = rdoLEEDRequired.SelectedValue = "Yes" And rdoCertStatus.SelectedValue = "Certified"
        End If
    End Sub
    'Neil Sustainab
    Private Sub GetSustainabilityNetZero()
        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))


        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        cmd.CommandText = "GetSustainabilityNetZero"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add(New SqlParameter("@Project_FK", strProjId))
        cmd.Parameters.Add(New SqlParameter("@BuildingNo", Convert.ToInt32(Session("BldgNbr"))))
        'cmd.Parameters.Add(New SqlParameter("@User", "User"))
        cmd.Connection = conn
        If conn.State = ConnectionState.Closed Then
            conn.Open()
        End If
        Dim adp As New SqlDataAdapter
        'Dim cname As String
        'For Each ctrl As Control In LEEDRequired.Controls
        '    cname = ctrl.ID.ToString
        'Next


        adp.SelectCommand = cmd
        Dim ds As New DataSet
        adp.Fill(ds)

        If ds.Tables.Count = 0 Then
            Return
        End If
        If ds.Tables(0).Rows.Count > 0 Then
            If ds.Tables(0).Rows(0)("NetZApplicable").ToString <> String.Empty Then
                rdoNetZApplicable.SelectedValue = ds.Tables(0).Rows(0)("NetZApplicable").ToString
            End If
            If ds.Tables(0).Rows(0)("NetZeroApplicableNoExplain").ToString <> String.Empty Then
                txtNetZeroApplicableNoExplain.Text = ds.Tables(0).Rows(0)("NetZeroApplicableNoExplain").ToString
            Else
                txtNetZeroApplicableNoExplain.Text = String.Empty
            End If
            txtNetZeroApplicableNoExplain.Enabled = rdoNetZApplicable.SelectedValue = "No"
            If ds.Tables(0).Rows(0)("NetZ100PercentUtilize").ToString <> String.Empty Then
                rdonet100percentutilize.SelectedValue = ds.Tables(0).Rows(0)("NetZ100PercentUtilize").ToString
            End If
            'If ds.Tables(0).Rows(0)("NetZero100PerCentNo").ToString <> String.Empty Then
            '    txtNetZero100PerCentNo.Text = ds.Tables(0).Rows(0)("NetZero100PerCentNo").ToString
            'End If
            'If txtNarrative.Text <> String.Empty Then
            '    txtNarrative.Text = ds.Tables(0).Rows(0)("NetZStategy").ToString
            'End If
            If ds.Tables(0).Rows(0)("NetZStategy").ToString <> String.Empty Then
                txtNarrative.Text = ds.Tables(0).Rows(0)("NetZStategy").ToString
            Else
                txtNarrative.Text = String.Empty
            End If
        End If
    End Sub
    'Neil Sustainab
    Private Sub GetSustainabilityASHRAE()
        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))


        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        cmd.CommandText = "GetSustainabilityASHRAE"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add(New SqlParameter("@Project_FK", strProjId))
        cmd.Parameters.Add(New SqlParameter("@BuildingNo", Convert.ToInt32(Session("BldgNbr"))))
        'cmd.Parameters.Add(New SqlParameter("@User", "User"))
        cmd.Connection = conn
        If conn.State = ConnectionState.Closed Then
            conn.Open()
        End If
        Dim adp As New SqlDataAdapter
        'Dim cname As String
        'For Each ctrl As Control In LEEDRequired.Controls
        '    cname = ctrl.ID.ToString
        'Next


        adp.SelectCommand = cmd
        Dim ds As New DataSet
        adp.Fill(ds)

        If ds.Tables.Count = 0 Then
            Return
        End If
        If ds.Tables(0).Rows.Count > 0 Then
            If ds.Tables(0).Rows(0)("ASHRAEversion").ToString <> String.Empty Then
                ddASHRAEVersion.SelectedValue = ds.Tables(0).Rows(0)("ASHRAEversion").ToString
            End If
            If ds.Tables(0).Rows(0)("isASHRAE30Percent").ToString <> String.Empty Then
                rdoASHRAE30PerCent.SelectedValue = ds.Tables(0).Rows(0)("isASHRAE30Percent").ToString
            End If
            If rdoASHRAE30PerCent.SelectedValue <> "No" Then
                txtExceedsBaseline.Enabled = False
            Else
                txtExceedsBaseline.Enabled = True
            End If			  
            If ds.Tables(0).Rows(0)("Not30PerCentBetterExplanation").ToString <> String.Empty Then
                txtNot30PerCentBetterExplanation.Text = ds.Tables(0).Rows(0)("Not30PerCentBetterExplanation").ToString
            Else
                txtNot30PerCentBetterExplanation.Text = String.Empty
            End If
            'Disabling is handled by Java Script to avoid a postback re-draw of screens. Code does not recognize these disables
            'so when the screens first appear the JS which disables is not executed yet. So it is done here for new appearing screens,
            txtNot30PerCentBetterExplanation.Enabled = rdoASHRAE30PerCent.SelectedValue = "No"
            'If txtNarrative.Text <> String.Empty Then
            '    txtNarrative.Text = ds.Tables(0).Rows(0)("NetZStategy").ToString
            'End If
            If ds.Tables(0).Rows(0)("percentageEnergyEficent").ToString <> String.Empty Then
                txtExceedsBaseline.Text = ds.Tables(0).Rows(0)("percentageEnergyEficent").ToString
            Else
                txtExceedsBaseline.Text = String.Empty
            End If
            txtExceedsBaseline.Enabled = rdoASHRAE30PerCent.SelectedValue = "Yes"
            If ds.Tables(0).Rows(0)("isDesignCostEffective").ToString <> String.Empty And rdoASHRAE30PerCent.SelectedValue = "No" Then
                rdoCostEffective.SelectedValue = ds.Tables(0).Rows(0)("isDesignCostEffective").ToString
            End If
            rdoCostEffective.Enabled = rdoASHRAE30PerCent.SelectedValue = "No"
            If ds.Tables(0).Rows(0)("AshraeNotCostEffectiveExplain").ToString <> String.Empty And rdoASHRAE30PerCent.SelectedValue = "No" And rdoCostEffective.SelectedValue = "No" Then
                txtDesignNotCostEffective.Text = ds.Tables(0).Rows(0)("AshraeNotCostEffectiveExplain").ToString
            Else
                txtDesignNotCostEffective.Text = String.Empty
            End If
            'rdoASHRAE30PerCent.Enabled = rdoCostEffective.SelectedValue = "No"
            txtDesignNotCostEffective.Enabled = rdoASHRAE30PerCent.SelectedValue = "No" And rdoCostEffective.SelectedValue = "No"
            'If ds.Tables(0).Rows(0)("energyEfficentIsComplete").ToString <> String.Empty Then
            '    chkFinal.Checked = ds.Tables(0).Rows(0)("energyEfficentIsComplete").ToString
            'End If
            If ds.Tables(0).Rows(0)("ashraeFinal").ToString <> String.Empty Then
                chkFinal.Checked = ds.Tables(0).Rows(0)("ashraeFinal").ToString
            End If
            If ds.Tables(0).Rows(0)("DateDesignCompleted").ToString <> String.Empty Then
                txtDateDesignComplete.Text = CDate(ds.Tables(0).Rows(0)("DateDesignCompleted")).ToString("yyyy-MM-dd")
            Else
                txtDateDesignComplete.Text = String.Empty
            End If
            'Neil find out if they want the date design completed in ashrae

        End If
    End Sub

    'Neil Sustainability
    Protected Sub ddSustCoord_OnSelectedIndexChanged(sender As Object, e As EventArgs)
        Dim dd As DropDownList = CType(sender, DropDownList)
        Dim valstring = dd.SelectedValue
 '      Dim uname As String = Context.User.Identity.Name
        'Neil Bandaid
        Dim strLoggedUser As String = String.Empty
        Try
            Dim uname As String = Context.User.Identity.Name
            'Neil Bandaid

            'Try
            strLoggedUser = uname.Substring(uname.LastIndexOf("\") + 1)
            If strLoggedUser = String.Empty Then
                strLoggedUser = "\OITMOUNewtoN"
            End If
        Catch ex As Exception
            ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('Exception Message:  '+ ex.Message)", True)
        End Try				 																												   			   
        'Neil
        If valstring = "O" Then
            ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('Please choose a number for the # of buildings-please try again - no data saved.')", True)
            ddSustCoord.ClearSelection()
            GetNumberOfBuildings()
            Return
        End If



        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim phaseID As Decimal = Convert.ToDecimal(Request.QueryString("project_pk"))


            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "addSustainabilityNumberOfBldgs"
            command.CommandType = CommandType.StoredProcedure

            command.Parameters.AddWithValue("@Phase_FK", DbNullOrStringValue(Convert.ToDecimal(phaseID)))
            command.Parameters.AddWithValue("@NbrOfBuildings", DbNullOrStringValue(Convert.ToDecimal(Convert.ToInt32(valstring))))
            command.Parameters.AddWithValue("@User", DbNullOrStringValue(strLoggedUser))

            'command.Parameters.AddWithValue("@Project_FK", DbNullOrStringValue(Convert.ToDecimal(phaseID)))
            'command.Parameters.AddWithValue("@BuildingNo", DbNullOrStringValue(Convert.ToDecimal(Session("BldgNbr"))))
            'command.Parameters.AddWithValue("@BuildingDescription", DbNullOrStringValue(txtBldgDesc.Text))
            'command.Parameters.AddWithValue("@SquareFootageConstructionWork", DbNullOrStringValue(txtSqFtConst.Text))
            'command.Parameters.AddWithValue("@SquareFootageRenovationWork", DbNullOrStringValue(txtSqFtRenovation.Text))
            'command.Parameters.AddWithValue("@SquareFootageAllWork", DbNullOrStringValue(txtSqFtAll.Text))
            'command.Parameters.AddWithValue("@DateBuildingDesignStarted", DbNullOrStringValue(txtDateDesignStarted.Text))
            'command.Parameters.AddWithValue("@BuildingName", DbNullOrStringValue(txtB.Text))
            'command.Parameters.AddWithValue("@User", DbNullOrStringValue("User"))
            'command.Parameters("@ShowErrorMsg").Direction = ParameterDirection.Output


            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()
            Session("NumberOfBuildings") = valstring
            Session("CurrState") = "ALLPANELS"
            SetPanels()
            'lblError.Text = command.Parameters("@ShowErrorMsg").Value.ToString(
        End Using
        'Neil-Once they pick a number of buildings disable the number of buildings dropdown
        ddSustCoord.Enabled = False

    End Sub
    'Neil Sustainability
    Protected Sub SaveAllPanels()
        If ValidateAll() Then
            'errors found in one or more panels
            Return
        End If
        'ClearAllScreenFields()
        SavePhase()
        GetSustainabilityPhase()				   								
        SaveGenInfo()
        GetSustainabilityGenInfo()
        SaveLeeds()
        GetSustainabilityLEED()
        SaveNetZero()
        GetSustainabilityNetZero()
        SaveASHRAE()
        GetSustainabilityASHRAE()
    End Sub
    'Neil Sustainability
    Protected Sub btnSaveGenInfo_Click(sender As Object, e As EventArgs)

        SaveAllPanels()


    End Sub
    'Neil Sustainability
    Protected Function ValidateAll() As Boolean
        Dim Errors As Boolean = False
        'GenInfo Validation

        'If UCase(Session("CurrState")).ToString = "GENINFO" Then
        If PnlGeneralInfo.Visible Then
            If (txtSqFtConst.Text.Length > 0 AndAlso Replace(txtSqFtConst.Text, ",", "").Length > 9) Then
                ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('Sq Ft of construction allows only 9 characters-save cancelled')", True)
                Return True
            End If
            If (txtSqFtRenovation.Text.Length > 0 AndAlso Replace(txtSqFtRenovation.Text, ",", "").Length > 9) Then
                ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('Sq Ft of renovation allows only 9 characters-save cancelled')", True)
                Return True
            End If
            If txtBuildingName.Text.Length = 0 Then
                ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('Please enter a building name-save cancelled.')", True)
                Return True
            End If
            If txtDateDesignStarted.Text.Length = 0 Then
                ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('Please enter a design start date (This will determine certification type)-save cancelled.')", True)
                Return True
            End If
            If txtSqFtConst.Text = String.Empty Or ConvertToInteger(txtSqFtConst.Text) < 0 Then
                ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('Please enter zero or higher for Construction square feet.')", True)
                txtSqFtConst.Text = 0
                Return True
            End If
            If txtSqFtRenovation.Text = String.Empty Or ConvertToInteger(txtSqFtRenovation.Text) < 0 Then
                ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('Please enter zero or higher for Renovation square feet.')", True)
                txtSqFtRenovation.Text = 0
                Return True
            End If
        End If
        'Dim States2 As String() = {"NETZERO", "ASHRAE", "DataExists"}
        'If Session("Currstate").ToString = "LEED" Then
        If PnlLeeds.Visible Then
            'LEED validation
            If txtLeedRegistration.Enabled = True Then
                If txtLeedRegistration.Text.Length > 12 Then
                    ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('Leed Registration Number allows no more than 12 numbers')", True)
                    Return True
                End If
            End If
        End If
        'ASHRAE validation
        'If Session("Currstate").ToString = "ASHRAE" Then
        If PnlASHRAE.Visible Then
            'If ddASHRAEVersion.SelectedValue = "0" Then
            '    ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('Please choose an ASHRAE version-save cancelled')", True)
            '    Return True
            'End If
        End If
    End Function
    'Neil Sustainability
    Private Sub SavePhase()
        If ddSustCoord.SelectedValue = "0" Then
            ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('Please enter a number of buildings-save cancelled')", True)
            '    Return
        End If
        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim phaseID As Decimal = Convert.ToDecimal(Request.QueryString("project_pk"))

            Dim uname As String
            Dim strLoggedUser As String
            Try
                uname = Context.User.Identity.Name
                strLoggedUser = uname.Substring(uname.LastIndexOf("\") + 1)
            Catch ex As Exception
                ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('Exception Message:  '+ ex.Message)", True)
            End Try



            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "addSustainabilityNumberOfBldgs"
            command.CommandType = CommandType.StoredProcedure

            command.Parameters.AddWithValue("@Phase_FK", DbNullOrStringValue(Convert.ToDecimal(phaseID)))
            command.Parameters.AddWithValue("@NbrOfBuildings", DbNullOrStringValue(Convert.ToDecimal(Convert.ToInt32(ddSustCoord.SelectedValue))))
            command.Parameters.AddWithValue("@User", DbNullOrStringValue(strLoggedUser))



            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()
            Session("NumberOfBuildings") = ddSustCoord.SelectedValue


            Dim command2 As New SqlCommand
            command2.Connection = conn
            command2.CommandText = "addSustainabilityCoord"
            command2.CommandType = CommandType.StoredProcedure

            command2.Parameters.AddWithValue("@Phase_FK", DbNullOrStringValue(Convert.ToDecimal(phaseID)))
            If ddChooseSustCoord.SelectedValue <> "0" Then
                command2.Parameters.AddWithValue("@Personnel_Fk", DbNullOrStringValue(Convert.ToDecimal(Convert.ToInt32(ddChooseSustCoord.SelectedValue))))
            Else
                command2.Parameters.AddWithValue("@Personnel_Fk", DBNull.Value)
            End If
            command2.Parameters.AddWithValue("@User", DbNullOrStringValue(strLoggedUser))



            conn.Open()
            command2.ExecuteNonQuery()
            conn.Close()
            Session("Coordinator_FK") = ddChooseSustCoord.SelectedValue
        End Using
    End Sub						
    'Neil Sustainability
    Private Sub SaveGenInfo()
        'If txtSqFtConst.Text.Length > 9 Then
        '    ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('Sq Ft of construction allows only 9 characters-save cancelled')", True)
        '    Return
        'End If
        'If txtSqFtRenovation.Text.Length > 9 Then
        '    ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('Sq Ft of renovation allows only 9 characters-save cancelled')", True)
        '    Return
        'End If
        'If txtSqFtAll.Text.Length > 9 Then
        '    ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('Sq Ft of all work allows only 9 characters-save cancelled')", True)
        '    Return
        'End If
        'If txtBuildingName.Text.Length = 0 Then
        '    ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('Please enter a building name-save cancelled.')", True)
        '    Return
        'End If
        'If txtDateDesignStarted.Text.Length = 0 Then
        '    ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('Please enter a design start date (This will determine certification type)-save cancelled.')", True)
        '    Return
        'End If
        Dim strProjNum As String = Convert.ToDecimal(Request.QueryString("project_pk"))
        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim phaseID As Decimal = Convert.ToDecimal(Request.QueryString("project_pk"))
            Dim uname As String = Context.User.Identity.Name
            Dim strLoggedUser As String = uname.Substring(uname.LastIndexOf("\") + 1)

            Dim command As New SqlCommand
            command.Connection = conn
            'command.CommandText = "addSustainabilityGeneralInfo"
            command.CommandText = "addSustainabilityGeneralInfo"
            command.CommandType = CommandType.StoredProcedure

            command.Parameters.AddWithValue("@Project_FK", DbNullOrStringValue(Convert.ToInt32(phaseID)))
            command.Parameters.AddWithValue("@BuildingNo", DbNullOrStringValue(Convert.ToInt32(Session("BldgNbr"))))
            command.Parameters.AddWithValue("@BuildingDescription", DbNullOrStringValue(txtBldgDesc.Text))
            'Dim a As String
            'Dim b As Decimal
            'If Decimal.TryParse(txtSqFtConst.Text, b) Then
            '    txtSqFtConst.Text = b.ToString("##,###.00")))),
            'Else
            If txtSqFtConst.Text = "0" Or txtSqFtConst.Text = String.Empty Then
                command.Parameters.AddWithValue("@SquareFootageConstructionWork", DbNullOrStringValue(0))
            Else
                command.Parameters.AddWithValue("@SquareFootageConstructionWork", DbNullOrStringValue(Convert.ToInt32(txtSqFtConst.Text.Replace(",", ""))))
            End If
            If txtSqFtRenovation.Text = "0" Or txtSqFtRenovation.Text = String.Empty Then
                command.Parameters.AddWithValue("@SquareFootageRenovationWork", DbNullOrStringValue(0))
            Else
                command.Parameters.AddWithValue("@SquareFootageRenovationWork", DbNullOrStringValue(Convert.ToInt32(txtSqFtRenovation.Text.Replace(",", ""))))
            End If
            Dim sqftConst As Integer
            Dim sqftRenovation As Integer
            Dim sqftAll As Integer
            If txtSqFtConst.Text = String.Empty Then
                sqftConst = 0
            Else
                sqftConst = Convert.ToInt32(txtSqFtConst.Text.Replace(",", ""))
            End If
            If txtSqFtRenovation.Text = String.Empty Then
                sqftRenovation = 0
            Else
                sqftRenovation = Convert.ToInt32(txtSqFtRenovation.Text.Replace(",", ""))
            End If
            sqftAll = sqftConst + sqftRenovation
            ' If txtSqFtAll.Text = String.Empty Then
            ' command.Parameters.AddWithValue("@SquareFootageAllWork", DbNullOrStringValue(0))
            ' Else
            command.Parameters.AddWithValue("@SquareFootageAllWork", DbNullOrStringValue(sqftAll.ToString))
            ' End If

            'If Decimal.TryParse(txtSqFtRenovation.Text, b) Then
            '    txtSqFtRenovation.Text = b.ToString("##,###.00")
            'command.Parameters.AddWithValue("@SquareFootageRenovationWork", DbNullOrStringValue(Convert.ToInt32(txtSqFtRenovation.Text)))
            'Else
            'command.Parameters.AddWithValue("@SquareFootageRenovationWork", DbNullOrStringValue("0.00"))
            '    txtSqFtRenovation.Text = ""
            'End If

            'If Decimal.TryParse(txtSqFtAll.Text, b) Then
            '    txtSqFtAll.Text = b.ToString("##,###.00")
            'command.Parameters.AddWithValue("@SquareFootageAllWork", DbNullOrStringValue(Convert.ToInt32(txtSqFtAll.Text)))
            'Else
            'command.Parameters.AddWithValue("@SquareFootageAllWork", DbNullOrStringValue("0.00"))
            '    txtSqFtAll.Text = ""
            'End If
            'command.Parameters.AddWithValue("@SquareFootageRenovationWork", DbNullOrStringValue(Convert.ToDecimal(txtSqFtRenovation.Text)))
            'command.Parameters.AddWithValue("@DateBuildingDesignStarted", DbNullOrStringValue(CDate(txtDateDesignStarted.Text.ToString))
            command.Parameters.AddWithValue("@DateBuildingDesignStarted", DbNullOrStringValue(txtDateDesignStarted.Text))
            ' CDate(ds.Tables(0).Rows(0)("DateBuildingDesignStarted")).ToString("yyyy-MM-dd")
            command.Parameters.AddWithValue("@BuildingName", DbNullOrStringValue(txtBuildingName.Text))
            command.Parameters.AddWithValue("@User", DbNullOrStringValue(strLoggedUser))
            'command.Parameters("@ShowErrorMsg").Direction = ParameterDirection.Output
            addSqFt()
            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()
            'First entrance into a phase/building requires saving
            'panel by panel due to the start date determining
            'which panels will be visible. DataExists allows
            'all panels to show and all panels to be saved.
            If Session("CurrState") <> "DataExists" Then
                Session("CurrState") = "LEED"
            End If
            SetPanels()
            'lblError.Text = command.Parameters("@ShowErrorMsg").Value.ToString(
        End Using
    End Sub
    'Neil Sustainability
    Protected Sub btnSaveLEED_Click(ender As Object, e As EventArgs)
        SaveAllPanels()
    End Sub
    'Neil Sustainability
    Private Sub SaveLeeds()
        Dim strProjNum As String = Convert.ToDecimal(Request.QueryString("project_pk"))
        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim phaseID As Decimal = Convert.ToDecimal(Request.QueryString("project_pk"))
            Dim uname As String = Context.User.Identity.Name
            Dim strLoggedUser As String = uname.Substring(uname.LastIndexOf("\") + 1)
            Dim command As New SqlCommand
            command.Connection = conn
            'command.CommandText = "addSustainabilityLEED"
            command.CommandText = "[dbo].[addSustainabilityLEED]"
            command.CommandType = CommandType.StoredProcedure

            '   @Project_FK int, 
            '   @BuildingNo int,
            '@LEEDCertificationRequirement Varchar(15),
            '@buildingRegisteredLEEDOnline Varchar(15),
            'LEEDRegistrationNo@ Varchar(50),
            '@isProjectedMinLEEDsilverCert Varchar(20),
            '@LeedWaiver varchar(20),

            '@User Varchar(50)

            command.Parameters.AddWithValue("@Project_FK", DbNullOrStringValue(Convert.ToDecimal(phaseID)))
            command.Parameters.AddWithValue("@BuildingNo", DbNullOrStringValue(Convert.ToDecimal(Session("BldgNbr"))))
            'If leeds required is set to know all the other leeds control are disabled-see rdoLEEDRequired click event
            command.Parameters.AddWithValue("@LEEDCertificationRequirement", DbNullOrStringValue(rdoLEEDRequired.SelectedValue.ToString()))
            'If leeds required is set to know all the other leeds control are disabled-see rdoLEEDRequired click event
            If rdoLEEDRequired.SelectedValue <> "Yes" Then
                command.Parameters.AddWithValue("@buildingRegisteredLEEDOnline", DBNull.Value)
				
																																				  
				  
													  
															
																																						  
						  
					  
																															  
				
                command.Parameters.AddWithValue("@LEEDRegistrationNo", DBNull.Value)
				  
														  
                command.Parameters.AddWithValue("@isProjectedMinLEEDsilverCert", DBNull.Value)
				
                command.Parameters.AddWithValue("@LeedLevelProjectingToAcheive", DBNull.Value)
				  

												 
                command.Parameters.AddWithValue("@LeedWaiver", DBNull.Value)
				
																														   
				  

												 
                command.Parameters.AddWithValue("@LEEDcertStatus", DBNull.Value)
                command.Parameters.AddWithValue("@LEEDDateCertified", DBNull.Value)
                command.Parameters.AddWithValue("@LEEDCertLevelAcheived", DBNull.Value)
            Else
                command.Parameters.AddWithValue("@buildingRegisteredLEEDOnline", DbNullOrStringValue(rdRegisteredOnline.SelectedValue.ToString()))
                command.Parameters.AddWithValue("@LEEDRegistrationNo", DbNullOrStringValue(txtLeedRegistration.Text.ToString))
                command.Parameters.AddWithValue("@isProjectedMinLEEDsilverCert", DbNullOrStringValue(rdoProjectedLeedSilver.SelectedValue.ToString()))
                If ddCurrProjected.SelectedValue = "0" Then
                    command.Parameters.AddWithValue("@LeedLevelProjectingToAcheive", DBNull.Value)
                Else
                    command.Parameters.AddWithValue("@LeedLevelProjectingToAcheive", DbNullOrStringValue(ddCurrProjected.SelectedValue.ToString()))
                End If

                If rdoProjectedLeedSilver.SelectedValue = "No" And rdoLEEDRequired.SelectedValue = "Yes" Then
                    command.Parameters.AddWithValue("@LeedWaiver", DbNullOrStringValue(rdoLeedWaiver.SelectedValue.ToString()))
                Else
                    command.Parameters.AddWithValue("@LeedWaiver", DBNull.Value)
                End If

                command.Parameters.AddWithValue("@LEEDcertStatus", DbNullOrStringValue(rdoCertStatus.SelectedValue.ToString()))
				  

                    If rdoCertStatus.SelectedValue = "Certified" Then
                        command.Parameters.AddWithValue("@LEEDDateCertified", DbNullOrStringValue(txtDateCertifed.Text.ToString()))
                        If ddLEEDCertLevelAcheived.SelectedValue = "0" Then
                            command.Parameters.AddWithValue("@LEEDCertLevelAcheived", DBNull.Value)
                        Else
                            command.Parameters.AddWithValue("@LEEDCertLevelAcheived", DbNullOrStringValue(ddLEEDCertLevelAcheived.SelectedValue.ToString()))
                        End If
                    Else
                        command.Parameters.AddWithValue("@LEEDDateCertified", DBNull.Value)
                        command.Parameters.AddWithValue("@LEEDCertLevelAcheived", DBNull.Value)
                    End If
                    'command.Parameters.AddWithValue("@LEEDDateCertified", DbNullOrStringValue(txtDateCertifed.ToString()))
                    'command.Parameters.AddWithValue("@LEEDCertLevelAcheived", DbNullOrStringValue(ddLEEDCertLevelAcheived.SelectedValue.ToString()))
                End If
                'If rdoLEEDRequired.SelectedValue = "Yes" Then
                '    If rdoProjectedLeedSilver.SelectMethod = "No" Then
                '        command.Parameters.AddWithValue("@LeedWaiver", DbNullOrStringValue(rdoLeedWaiver.SelectedValue.ToString()))
                '    Else
                '        command.Parameters.AddWithValue("@LeedWaiver", DBNull.Value)
                '    End IfF
                'End If
                'If rdoCertStatus.SelectedValue = "Certified" And rdoLEEDRequired.SelectedValue = "Yes" Then
                '    command.Parameters.AddWithValue("@LEEDDateCertified", DbNullOrStringValue(DbNullOrStringValue(txtDateCertifed.ToString())))
                '    command.Parameters.AddWithValue("@LEEDCertLevelAcheivFed", DbNullOrStringValue(ddLEEDCertLevelAcheived.SelectedValue.ToString()))
                'Else
                '    command.Parameters.AddWithValue("@LEEDDateCertified", DBNull.Value)
                '    command.Parameters.AddWithValue("@LEEDCertLevelAcheived", DBNull.Value)
                'End If
                If txtLeedRegistration.Text.Length > 12 Then
                ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('Leed Registration Number allows no more than 12 numbers')", True)
                Return
            End If

														   
																					   
				
																																				
				  



            command.Parameters.AddWithValue("@User", DbNullOrStringValue(strLoggedUser))



            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()
            GetSustainabilityLEED()
            'First entrance into a phase/building requires saving'@LEEDCertLevelAcheived
            'panel by panel due to the start date determining
            'which panels will be visible. DataExists allows
            'all panels to show and all panels to be saved.
            If Session("CurrState") <> "DataExists" Then
                Session("CurrState") = "NETZERO"
            End If
            SetPanels()
            'lblError.Text = command.Parameters("@ShowErrorMsg").Value.ToString(
        End Using
    End Sub
    'Neil Sustainability
    Protected Sub btnSaveASHRAE_Click(sender As Object, e As EventArgs)

        SaveAllPanels()

    End Sub
    'Neil Sustainability
    Private Sub SaveASHRAE()

        'If ddASHRAEVersion.SelectedValue = "0" Then
        '    ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('Please choose an ASHRAE version-save cancelled')", True)
        '    Return
        'End If
        Dim strProjNum As String = Convert.ToDecimal(Request.QueryString("project_pk"))
        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim phaseID As Decimal = Convert.ToDecimal(Request.QueryString("project_pk"))
            'Neil Bandid
            'Dim uname As String = Context.User.Identity.Name
            'Dim strLoggedUser As String = uname.Substring(uname.LastIndexOf("\") + 1)
            Dim strLoggedUser As String = "\OITMOUNEWTON"
            Dim command As New SqlCommand
            command.Connection = conn
            'command.CommandText = "addSustainabilityLEED"
            command.CommandText = "addSustainabilityASHRAE"
            command.CommandType = CommandType.StoredProcedure

            '   @Project_FK int, 
            '   @BuildingNo int,
            '@LEEDCertificationRequirement Varchar(15),
            '@buildingRegisteredLEEDOnline Varchar(15),
            'LEEDRegistrationNo@ Varchar(50),
            '@isProjectedMinLEEDsilverCert Varchar(20),
            '@LeedWaiver varchar(20),
            '@txtDesignNotCostEffective varchar(50),
            '@User Varchar(50)
            command.Parameters.AddWithValue("@Project_FK", DbNullOrStringValue(Convert.ToDecimal(phaseID)))
            command.Parameters.AddWithValue("@BuildingNo", DbNullOrStringValue(Session("BldgNbr")))
            command.Parameters.AddWithValue("@ASHRAEversion", DbNullOrStringValue(ddASHRAEVersion.SelectedValue.ToString))
            command.Parameters.AddWithValue("@isASHRAE30Percent", DbNullOrStringValue(rdoASHRAE30PerCent.SelectedValue.ToString()))

            If rdoASHRAE30PerCent.SelectedValue = "No" Then
                command.Parameters.AddWithValue("@Not30PerCentBetterExplanation", DbNullOrStringValue(txtNot30PerCentBetterExplanation.Text))
            Else
                command.Parameters.AddWithValue("@Not30PerCentBetterExplanation", DBNull.Value)
            End If
            txtExceedsBaseline.Enabled = rdoASHRAE30PerCent.SelectedValue = "Yes"
            If rdoASHRAE30PerCent.SelectedValue = "Yes" Then
                command.Parameters.AddWithValue("@percentageEnergyEficent", DbNullOrStringValue(txtExceedsBaseline.Text.ToString()))
            Else
                txtExceedsBaseline.Text = String.Empty
                command.Parameters.AddWithValue("@percentageEnergyEficent", DBNull.Value)
            End If
            ' If rdoCostEffective.SelectedValue = "No" Then
            If rdoASHRAE30PerCent.SelectedValue = "No" Then
                command.Parameters.AddWithValue("@isDesignCostEffective", DbNullOrStringValue(rdoCostEffective.SelectedValue.ToString()))
            Else
                command.Parameters.AddWithValue("@isDesignCostEffective", DBNull.Value)
            End If

            If rdoCostEffective.SelectedValue = "No" And rdoASHRAE30PerCent.SelectedValue = "No" Then
                command.Parameters.AddWithValue("@AshraeNotCostEffectiveExplain", DbNullOrStringValue(txtDesignNotCostEffective.Text.ToString))
            Else
                command.Parameters.AddWithValue("@AshraeNotCostEffectiveExplain", DBNull.Value)
            End If
            command.Parameters.AddWithValue("@ashraeFinal", DbNullOrStringValue(chkFinal.Checked.ToString()))
            If txtDateDesignComplete.Enabled = True Then
                command.Parameters.AddWithValue("@DateDesignCompleted", DbNullOrStringValue(txtDateDesignComplete.Text))
            Else
                command.Parameters.AddWithValue("@DateDesignCompleted", DBNull.Value)
            End If
            command.Parameters.AddWithValue("@User", DbNullOrStringValue(strLoggedUser))
            'command.Parameters("@ShowErrorMsg").Direction = ParameterDirection.Output


            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()
            GetSustainabilityASHRAE()
            'First entrance into a phase/building requires saving
            'panel by panel due to the start date determining
            'which panels will be visible. DataExists allows
            'all panels to show and all panels to be saved.
            If Session("CurrState") <> "DataExists" Then
                Session("CurrState") = "DataExists"
            End If
            SetPanels()
        End Using
    End Sub
    'Neil Sustainability

    Protected Sub btnNext_Click(sender As Object, e As EventArgs)
        Dim strProjNum As String = Convert.ToDecimal(Request.QueryString("project_pk"))
        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString

        GetNumberOfBuildings()
        If (Convert.ToInt32(Session("BldgNbr")) + 1 >
            Convert.ToInt32(Session("BldgsInPhase"))) Then
            ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('You are already on the last building in this phase')", True)
            Return
        End If

        'Check if the user has changd data on visible screens before move to 
        'next building
        'If ScreenDataChanged() Then

        'End If



        'Check if the are moving to new building with no save for current building
        'If Not DataExistsForPhaseAndBuilding() Or txtBuildingName.Text.Length = 0 Or txtDateDesignStarted.Text.Length = 0 Then
        If txtBuildingName.Text.Length = 0 Or txtDateDesignStarted.Text.Length = 0 Then
            'Dim msg As String
            'msg = "Buidling " + Session("BldgNbr") + " has no data saved. We have left you in this building. Please enter data"
            ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('You are trying to leave building " + Session("BldgNbr").ToString + " for which no data will be saved. Please enter, at least, Building Name and Design Start Date for this building and click SAVE for all changed panels-we are not moving to next building.')", True)
            Return
        Else
            'If PnlGeneralInfo.Visible = True Then
            '    SaveGenInfo()
            'End If
            'If PnlLeeds.Visible = True Then
            '    SaveLeeds()
            '    'ClientScript.RegisterStartupScript(Me.GetType(), "Message", "if(confirm('Sorry, but there is already a Primary Stakeholder assigned to this ticket. Would you like to replace the existing data?')){alert('OK');}else{alert('cancel');}", False)
            '    'GetConfirmValue("You are leaving this building. Do you want to save your data before you move to the next building?")
            'End If
            'If PnlNetZero.Visible = True Then
            '    SaveNetZero()
            'End If
        End If

        ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('You are moving to the next building. Any screen data modified since the last save will be lost.')", True)


        Session("BldgNbr") = Convert.ToInt32(Session("BldgNbr")) + 1

        If DataExistsForPhaseAndBuilding() Then
            Session("CurrState") = "DataExists"
            ' Session("BldgNbr") = "1"
            SetPanels()
            GetDataAllPanels()
        Else
            'Session("BldgNbr") = "1"
            ClearAllScreenFields()
            Session("CurrState") = "GenInfo"
            SetPanels()
        End If


        'Session("BldgNbr") = Convert.ToInt32(Session("BldgNbr")) + 1
        'Session("CurrState") = "GenInfo"
        'SetPanels()
        'GetDataAllPanels()



        'Using conn As New SqlConnection(ConnStr)
        '    Dim phaseID As Decimal = Convert.ToDecimal(Request.QueryString("project_pk"))
        '    Dim command As New SqlCommand
        '    command.Connection = conn
        '    command.CommandText = "addSustainabilityNetZero"
        '    command.CommandType = CommandType.StoredProcedure



        '    command.Parameters.AddWithValue("@Project_FK", DbNullOrStringValue(Convert.ToDecimal(phaseID)))
        '    command.Parameters.AddWithValue("@BuildingNo", DbNullOrStringValue(Convert.ToDecimal(Session("BldgNbr"))))
        '    command.Parameters.AddWithValue("@NetZApplicable", DbNullOrStringValue(rdoNetZApplicable.SelectedItem.Value.ToString()))
        '    command.Parameters.AddWithValue("@NetZ100PercentUtilize", DbNullOrStringValue(rdoNet100PercentUtilize.SelectedItem.ToString()))
        '    command.Parameters.AddWithValue("@NetZStrategy", DbNullOrStringValue(txtNarrative.Text.ToString()))
        '    command.Parameters.AddWithValue("@User", DbNullOrStringValue("User"))
        '    'command.Parameters("@ShowErrorMsg").Direction = ParameterDirection.Output


        '    conn.Open()
        '    command.ExecuteNonQuery()
        '    conn.Close()
        '    GetSustainabiSlityNetZero()
        '    Session("CurrState") = "ENDPanels"
        '    ' SetPanels()
        '    'lblError.Text = command.Parameters("@ShowErrorMsg").Value.ToString(
        'End Using
    End Sub
    'Neil Sustainability
    Private Function GetConfirmValue(confirmPrompt As String)
        Dim sb As New System.Text.StringBuilder()
        sb.Append("<script type = 'text/javascript'>")
        sb.Append("window.onload=function(){")
        sb.Append("var confirm_value = document.createElement(""INPUT"");")
        sb.Append("confirm_value.type = ""hidden"";")
        sb.Append("confirm_value.name = ""confirm_value"";")
        sb.Append("if (confirm("" " & confirmPrompt & " "")) {")
        sb.Append("confirm_value.value = ""Yes"";")
        sb.Append("} else {")
        sb.Append("confirm_value.value = ""No"";")
        sb.Append("}")
        sb.Append("document.forms[0].appendChild(confirm_value);")
        sb.Append("};")
        sb.Append("</script>")
        ClientScript.RegisterClientScriptBlock(Me.GetType(), "alert", sb.ToString())
        Return confirm_value
    End Function

    'Neil Sustainability
    Private Function ScreenDataChanged()
        If PnlGeneralInfo.Visible = True Then
            GenerealInfoScreenDataChanged()

        End If
    End Function
    'Neil Sustainability
    Private Function GenerealInfoScreenDataChanged()
        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))

        If txtBuildingName.Text.Length > 0 Then
            ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('You are trying to leave building " + Session("BldgNbr") + " for which no data has been saved. Please enter, at least, general infomation data for this building-we are not moving to next building.')", True)
            Return False
        End If

        Dim buildingName As String = txtBuildingName.Text
        Dim buildingDesc As String = txtBldgDesc.Text
        Dim sqFTConst As Integer = Convert.ToInt32(txtSqFtConst.Text)
        Dim sqFTRenovation As Integer = Convert.ToInt32(txtSqFtRenovation.Text)
        Dim sqFTAll As Integer = Convert.ToInt32(txtSqFtAll.Text)
        Dim buildingDesignStartDat As String = txtDateDesignStarted.Text
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        cmd.CommandText = "GetSustainabilityGeneralInfo"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add(New SqlParameter("@Project_FK", strProjId))
        cmd.Parameters.Add(New SqlParameter("@BuildingNo", Convert.ToInt32(Session("BldgNbr"))))
        cmd.Parameters.Add(New SqlParameter("@User", "User"))
        cmd.Connection = conn
        If conn.State = ConnectionState.Closed Then
            conn.Open()
        End If
        Dim adp As New SqlDataAdapter

        adp.SelectCommand = cmd
        Dim ds As New DataSet
        adp.Fill(ds)

        If ds.Tables.Count = 0 Then
            'Return
        End If
        Dim b As Integer
        If ds.Tables(0).Rows.Count > 0 Then
            txtBuildingName.Text = ds.Tables(0).Rows(0)("buildingName").ToString
            txtBldgDesc.Text = ds.Tables(0).Rows(0)("BuildingDescription").ToString

            'Dim a As String

            If Int32.TryParse(ds.Tables(0).Rows(0)("SquareFootageConstructionWork").ToString, b) Then
                If ds.Tables(0).Rows(0)("SquareFootageConstructionWork").ToString <> 0 Then
                    txtSqFtConst.Text = Convert.ToUInt32(ds.Tables(0).Rows(0)("SquareFootageConstructionWork").ToString) '.ToString("##,###.00")
                Else
                    txtSqFtConst.Text = ""
                End If
            Else
                txtSqFtConst.Text = ""
            End If
            If Int32.TryParse(ds.Tables(0).Rows(0)("SquareFootageRenovationWork").ToString, b) Then
                If ds.Tables(0).Rows(0)("SquareFootageRenovationWork").ToString <> 0 Then
                    txtSqFtRenovation.Text = Convert.ToUInt32(ds.Tables(0).Rows(0)("SquareFootageRenovationWork").ToString) '.ToString("##,###.00")
                Else
                    txtSqFtRenovation.Text = ""
                End If
            Else
                txtSqFtRenovation.Text = ""
            End If
            If Int32.TryParse(ds.Tables(0).Rows(0)("SquareFootageAllWork").ToString, b) Then
                If ds.Tables(0).Rows(0)("SquareFootageAllWork").ToString <> 0 Then
                    txtSqFtAll.Text = Convert.ToUInt64(ds.Tables(0).Rows(0)("SquareFootageAllWork").ToString) '.ToString("##,###.00")
                Else
                    txtSqFtAll.Text = ""
                End If
            Else
                txtSqFtAll.Text = ""
            End If

            'txtSqFtAll.Text = ds.Tables(0).Rows(0)("SquareFootageAllWork")
            If ds.Tables(0).Rows(0)("DateBuildingDesignStarted") Is DBNull.Value Then
                txtDateDesignStarted.Text = ""
            Else
                txtDateDesignStarted.Text = CDate(ds.Tables(0).Rows(0)("DateBuildingDesignStarted")).ToString("yyyy-MM-dd")
                'txtDateDesignStarted.Text = CDate(ds.Tables(0).Rows(0)("DateBuildingDesignStarted")).ToString '. ', System.Globalization.CultureInfo.InvariantCulture)
            End If
        End If

    End Function
    'Neil Sustainability
    Protected Sub btnPrev_Click(sender As Object, e As EventArgs)
        Dim strProjNum As String = Convert.ToDecimal(Request.QueryString("project_pk"))
        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString


        If ((Convert.ToInt32(Session("BldgNbr")) - 1) = 0) Then
            ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('You are already on the first building in this phase')", True)
            Return
        End If

        'Check if the are moving to new building with no save for current building
        'If Not DataExistsForPhaseAndBuilding() Then
        If txtBuildingName.Text.Length = 0 Or txtDateDesignStarted.Text.Length = 0 Then
            'Dim msg As String
            'msg = "Buidling " + Session("BldgNbr") + " has no data saved. We have left you in this building. Please enter data"
            ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('You are trying to leave building " + Session("BldgNbr").ToString + " for which no data will be saved. Please enter, at least, Building Name and Design Start Date for this building and click SAVE for all changed panels-we are not moving to the previous building.')", True)
            Return
        Else
            'If PnlGeneralInfo.Visible = True Then
            '    SaveGenInfo()
            'End If
            'If PnlLeeds.Visible = True Then
            '    SaveLeeds()
            '    'ClientScript.RegisterStartupScript(Me.GetType(), "Message", "if(confirm('Sorry, but there is already a Primary Stakeholder assigned to this ticket. Would you like to replace the existing data?')){alert('OK');}else{alert('cancel');}", False)
            '    'GetConfirmValue("You are leaving this building. Do you want to save your data before you move to the next building?")
            'End If
            'If PnlNetZero.Visible = True Then
            '    SaveNetZero()
            'End If
        End If

        ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('You are moving to the previous building. Any screen data modified since the last save will be lost.')", True)

        Session("BldgNbr") = Convert.ToInt32(Session("BldgNbr")) - 1
        'Session("CurrState") = "GenInfo"
        'SetPanels()
        'GetDataAllPanels()

        If DataExistsForPhaseAndBuilding() Then
            Session("CurrState") = "DataExists"
            ' Session("BldgNbr") = "1"
            SetPanels()
            GetDataAllPanels()
        Else
            'Session("BldgNbr") = "1"
            Session("CurrState") = "GenInfo"
            SetPanels()
        End If

        'Using conn As New SqlConnection(ConnStr)
        '    Dim phaseID As Decimal = Convert.ToDecimal(Request.QueryString("project_pk"))
        '    Dim command As New SqlCommand
        '    command.Connection = conn
        '    command.CommandText = "addSustainabilityNetZero"
        '    command.CommandType = CommandType.StoredProcedure



        '    command.Parameters.AddWithValue("@Project_FK", DbNullOrStringValue(Convert.ToDecimal(phaseID)))
        '    command.Parameters.AddWithValue("@BuildingNo", DbNullOrStringValue(Convert.ToDecimal(Session("BldgNbr"))))
        '    command.Parameters.AddWithValue("@NetZApplicable", DbNullOrStringValue(rdoNetZApplicable.SelectedItem.Value.ToString()))
        '    command.Parameters.AddWithValue("@NetZ100PercentUtilize", DbNullOrStringValue(rdoNet100PercentUtilize.SelectedItem.Value.ToString()))
        '    command.Parameters.AddWithValue("@NetZStrategy", DbNullOrStringValue(txtNarrative.Text.ToString()))
        '    command.Parameters.AddWithValue("@User", DbNullOrStringValue("User"))
        '    'command.Parameters("@ShowErrorMsg").Direction = ParameterDirection.Output


        '    conn.Open()
        '    command.ExecuteNonQuery()
        '    conn.Close()
        '    GetSustainabilityNetZero()
        '    Session("CurrState") = "ENDPanels"
        '    ' SetPanels()
        '    'lblError.Text = command.Parameters("@ShowErrorMsg").Value.ToString(
        'End Using
    End Sub
    'Neil Sustainability
    Private Sub GetDataAllPanels()

        GetNumberOfBuildings()
        GetPhaseCoordinator()							 
        GetSustainabilityGenInfo()
        GetSustainabilityLEED()
        GetSustainabilityNetZero()
        GetSustainabilityASHRAE()

    End Sub
    'Neil Sustainability
    Private Sub ClearAllScreenFields()
        'Number of building for phase
        'ddSustCoord.SelectedValue = "O"
        ddSustCoord.ClearSelection()
        'General info
        txtBuildingName.Text = String.Empty
        txtBldgDesc.Text = String.Empty
        txtSqFtConst.Text = "0"
        txtSqFtRenovation.Text = "0"
        txtSqFtAll.Text = String.Empty
        txtDateDesignStarted.Text = String.Empty
        'LEED
        rdoLEEDRequired.SelectedValue = "Unknown"
        rdRegisteredOnline.SelectedValue = "Unknown"
        txtLeedRegistration.Text = String.Empty
        rdoProjectedLeedSilver.SelectedValue = "Unknown"
        rdoLeedWaiver.SelectedValue = "Unknown"
        rdoCertStatus.SelectedValue = "Not Registered"
        txtDateCertifed.Text = String.Empty
        ddLEEDCertLevelAcheived.SelectedValue = "0"

        'Net Zero
        rdoNetZApplicable.SelectedValue = "Unknown"
        rdonet100percentutilize.SelectedValue = "Unknown"
        ddLEEDCertLevelAcheived.SelectedValue = "0"
        txtNetZeroApplicableNoExplain.Text = String.Empty
        txtNarrative.Text = String.Empty
        'If rdol Then
        'txtNarrative.Text = String.Empty'
        'ASHRAE
        ddASHRAEVersion.SelectedValue = "0"
        rdoASHRAE30PerCent.SelectedValue = "Unknown"
        txtExceedsBaseline.Text = String.Empty
        rdoCostEffective.SelectedValue = "No"
        chkFinal.Checked = False
        txtDateDesignComplete.Text = String.Empty
        txtNot30PerCentBetterExplanation.Text = String.Empty
        txtDesignNotCostEffective.Text = String.Empty

    End Sub
    'Neil Sustainability
    Protected Sub SetLeedstoDefault()
        'General info
        rdoLEEDRequired.SelectedValue = "Unknown"
        rdRegisteredOnline.SelectedValue = "Unknown"
        txtLeedRegistration.Text = String.Empty
        rdoProjectedLeedSilver.SelectedValue = "Unknown"
        rdoLeedWaiver.SelectedValue = "Unknown"
        rdoCertStatus.SelectedValue = "Not Registered"
    End Sub

    'Neil SaveASHRAE()
    Protected Sub btnSaveNetZero_Click(sender As Object, e As EventArgs)

        SaveAllPanels()

    End Sub
    'Neil Sustainability
    Private Sub SaveNetZero()
        Dim strProjNum As String = Convert.ToDecimal(Request.QueryString("project_pk"))
        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim phaseID As Decimal = Convert.ToDecimal(Request.QueryString("project_pk"))
            Dim uname As String = Context.User.Identity.Name
            Dim strLoggedUser As String = uname.Substring(uname.LastIndexOf("\") + 1)
            Dim command As New SqlCommand
            command.Connection = conn
            'command.CommandText = "addSustainabilityNetZero"
            command.CommandText = "addSustainabilityNetZero"
            command.CommandType = CommandType.StoredProcedure



            command.Parameters.AddWithValue("@Project_FK", DbNullOrStringValue(Convert.ToDecimal(phaseID)))
            command.Parameters.AddWithValue("@BuildingNo", DbNullOrStringValue(Convert.ToDecimal(Session("BldgNbr"))))
            command.Parameters.AddWithValue("@NetZApplicable", DbNullOrStringValue(rdoNetZApplicable.SelectedValue.ToString()))
            If rdoNetZApplicable.SelectedValue = "No" Then
                command.Parameters.AddWithValue("@NetZeroApplicableNoExplain", DbNullOrStringValue(txtNetZeroApplicableNoExplain.Text.ToString()))
            Else
                command.Parameters.AddWithValue("@NetZeroApplicableNoExplain", DBNull.Value)
            End If
            command.Parameters.AddWithValue("@NetZ100PercentUtilize", DbNullOrStringValue(rdonet100percentutilize.SelectedValue.ToString()))
            'command.Parameters.AddWithValue("@NetZero100PerCentNo", DbNullOrStringValue(txtNetZero100PerCentNo.Text.ToString()))
            command.Parameters.AddWithValue("@NetZStrategy", DbNullOrStringValue(txtNarrative.Text.ToString()))
            command.Parameters.AddWithValue("@User", DbNullOrStringValue(strLoggedUser))
            'command.Parameters("@ShowErrorMsg").Direction = ParameterDirection.Output


            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()
            GetSustainabilityNetZero()
            'First entrance into a phase/building requires saving
            'panel by panel due to the start date determining
            'which panels will be visible. DataExists allows
            'all panels to show and all panels to be saved.
            If Session("CurrState") <> "DataExists" Then
                Session("CurrState") = "ASHRAE"
            End If
            SetPanels()
            'lblError.Text = command.Parameters("@ShowErrorMsg").Value.ToString(
        End Using
    End Sub
    Protected Function RefreshGetRiskType() As String
        Dim strProjNum As String = Convert.ToString(Request.QueryString("project_pk"))

        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand()
        conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        cmd.Connection = conn
        cmd.CommandText = "GetRiskType"
        cmd.CommandType = System.Data.CommandType.StoredProcedure
        cmd.Parameters.Add("@project_pk", SqlDbType.Int).Value = strProjNum
        cmd.Parameters.Add("@Result", SqlDbType.VarChar, 5)
        cmd.Parameters("@Result").Direction = ParameterDirection.Output
        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()

        Return cmd.Parameters("@Result").Value.ToString()

    End Function


    ''' <summary>
    ''' Clicking the Add Sub Project button will open the Add Sub Project page.
    ''' </summary> 
    Protected Sub btnAddSubProj_Click(sender As Object, e As EventArgs) Handles btnAddSubProj.Click
        Dim varProjId As String = CType(fvMainInfo.FindControl("lblProjId"), Label).Text

        Response.Redirect("~/AddSubProject.aspx?project_pk=" + varProjId)
    End Sub
    ''' <summary>
    ''' This is to populate the schedulet repeater.
    ''' </summary> 
    Private Sub GetSchedule()
        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim varSubProjFlag As CheckBox = CType(fvMainInfo.FindControl("cbSubProjectFlag"), CheckBox)
        Dim IsSubProj As Integer
        If varSubProjFlag.Checked Then
            IsSubProj = 1
        Else
            IsSubProj = 0
        End If

        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        cmd.CommandText = "GetSchedule"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add(New SqlParameter("@ProjectId", strProjId))
        cmd.Parameters.Add(New SqlParameter("@SubProjFlag", IsSubProj))
        cmd.Connection = conn
        If conn.State = ConnectionState.Closed Then
            conn.Open()
        End If
        Dim adp As New SqlDataAdapter

        adp.SelectCommand = cmd
        Dim ds As New DataSet
        adp.Fill(ds)
        If conn.State = ConnectionState.Open Then
            conn.Close()
        End If
        adp.Dispose()

        rptSchedule.DataSource = ds
        rptSchedule.DataBind()

    End Sub



    ''' <summary>
    ''' The repeater will not show same stage name on each row.
    ''' The stage label will have a grey background color for the stages that are relevant to factsheet.
    ''' </summary> 
    Protected Sub rptSchedule_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
        Dim lblID As Label = DirectCast(e.Item.FindControl("lblStage"), Label)
        Dim txtActualDt As TextBox = DirectCast(e.Item.FindControl("txtActual"), TextBox)
        'Dim cbIsActualProspectus As CheckBox = DirectCast(e.Item.FindControl("cbIsActualProspectus"), CheckBox)
        Dim cvFutureActual As CompareValidator = DirectCast(e.Item.FindControl("cvFutureActual"), CompareValidator)
        cvFutureActual.ValueToCompare = DateTime.Now.ToShortDateString()


        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then

            If prevVal <> lblID.Text Then
                'Found new ID                
                prevVal = lblID.Text
            Else
                If prevVal = lblID.Text Then
                    'Hide your controls here.                        
                    DirectCast(e.Item.FindControl("lblStage"), Label).Visible = False
                End If
            End If

            If Session("EnvSchedCount") = 0 And lblID.Text.Trim() = "Environmental" Then
                DirectCast(e.Item.FindControl("lblStage"), Label).Visible = False
            End If

        End If

        cvFutureActual.Enabled = True
        ' Environmental 
        If lblID.Text.Trim() = "Environmental" Then
            Dim lblschedule As Label = DirectCast(e.Item.FindControl("lblSchedule"), Label)
            Dim txtprospectus As TextBox = DirectCast(e.Item.FindControl("txtProspectus"), TextBox)
            Dim txtoriginal As TextBox = DirectCast(e.Item.FindControl("txtOriginal"), TextBox)
            Dim txtrevised As TextBox = DirectCast(e.Item.FindControl("txtRevised"), TextBox)
            Dim txtactual As TextBox = DirectCast(e.Item.FindControl("txtActual"), TextBox)

            If txtprospectus.Text.Trim() = "" And txtoriginal.Text.Trim() = "" And txtrevised.Text.Trim() = "" And txtactual.Text.Trim() = "" Then
                txtprospectus.Attributes.Add("style", "display: none;")
                txtoriginal.Attributes.Add("style", "display:none;")
                txtrevised.Attributes.Add("style", "display:none;")
                txtactual.Attributes.Add("style", "display:none;")
                lblschedule.Attributes.Add("style", "display:none;")
            Else
                DirectCast(e.Item.FindControl("txtProspectus"), TextBox).Enabled = False
                DirectCast(e.Item.FindControl("txtOriginal"), TextBox).Enabled = False
                DirectCast(e.Item.FindControl("txtRevised"), TextBox).Enabled = False
                DirectCast(e.Item.FindControl("txtActual"), TextBox).Enabled = False
            End If

            cvFutureActual.Enabled = False
        End If
        ' end

        'setting the grey background color for the milestones that are needed for factsheet review
        Dim lblMilestone As Label = DirectCast(e.Item.FindControl("lblSchedule"), Label)

        Dim isshowinFactsheet As Boolean
        isshowinFactsheet = (DirectCast(e.Item.FindControl("hdnshowinFactsheet"), HiddenField)).Value
        If isshowinFactsheet Then
            lblMilestone.Attributes.Add("style", "background-color:#DDDDDD;")
        End If

        'The Actual date will be disabled for general users if there is a date in the text box 
        If Session("GroupID") <= 200 Then
            If txtActualDt.Text = "" Then
                txtActualDt.Enabled = True
            Else
                txtActualDt.Enabled = False
            End If
        End If

        'If (cbIsActualProspectus.Checked = False And txtActualDt.Text <> "") Then
        '    If Session("GroupID") <= 200 Then
        '        txtActualDt.Enabled = False
        '    Else
        '        txtActualDt.Enabled = True
        '    End If
        'End If
        'If (cbIsActualProspectus.Checked = False) Then
        '    cvActual.Enabled = False
        'End If
    End Sub

    ''' <summary>
    ''' This is a method to delete schedule by project id when there is update.
    ''' </summary> 
    Private Sub DeleteSchedule()
        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim strUser As String
        strUser = lblUserNm.Text

        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        '  cmd.CommandText = "ScheduleDelete"
        cmd.CommandText = "ScheduleDeleteAndTrackChanges"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = conn
        cmd.Parameters.Add(New SqlParameter("@ProjectId", strProjId))
        cmd.Parameters.Add(New SqlParameter("@Username", strUser))

        If (conn.State = ConnectionState.Closed) Then
            conn.Open()
        End If
        cmd.ExecuteNonQuery()
        If (conn.State = ConnectionState.Open) Then
            conn.Close()
        End If

    End Sub
    ''' <summary>
    ''' Clicking the update schedule button will run the SP ScheduleAddUpdate to insert data into Schedule table
    ''' </summary> 
    Protected Sub btnUpdateSchedule_Click(sender As Object, e As EventArgs) Handles btnUpdateSchedule.Click

        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim intMilestoneId As Integer
        Dim strProspectus As String
        Dim strOriginal As String
        Dim strRevised As String
        Dim strActual As String
        Dim strUser As String
        Dim IsProjectSchedsDeletedFromTempTable As Boolean = False
        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand

        Try

            conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
            cmd.Connection = conn
            conn.Open()
            For Each item As RepeaterItem In rptSchedule.Items
                If (item.ItemType = ListItemType.Item Or item.ItemType = ListItemType.AlternatingItem) Then

                    ' exclude environmental milestones
                    If (DirectCast(item.FindControl("hdnenvironmentalMilestone"), HiddenField)).Value = "False" Then
                        intMilestoneId = Convert.ToInt32((DirectCast(item.FindControl("hdnMilestoneId"), HiddenField)).Value)
                        strProspectus = Convert.ToString(DirectCast(item.FindControl("txtProspectus"), TextBox).Text)
                        strOriginal = DirectCast(item.FindControl("txtOriginal"), TextBox).Text
                        strRevised = DirectCast(item.FindControl("txtRevised"), TextBox).Text
                        strActual = DirectCast(item.FindControl("txtActual"), TextBox).Text
                        strUser = lblUserNm.Text

                        ' check if deleting schedules pertaining to this project from temporary table has already been executed
                        If IsProjectSchedsDeletedFromTempTable = False Then
                            DeleteProjectFromTempTablePD(strProjId)
                            IsProjectSchedsDeletedFromTempTable = True
                        End If

                        '          cmd = New SqlCommand("ScheduleAddUpdate", conn)
                        cmd = New SqlCommand("ScheduleAddUpdateToTempTable", conn)
                        cmd.CommandType = CommandType.StoredProcedure

                        cmd.Parameters.AddWithValue("@ProjectId", strProjId)
                        cmd.Parameters.AddWithValue("@MilestoneId", intMilestoneId)
                        cmd.Parameters.AddWithValue("@Prospectus", IIf(String.IsNullOrEmpty(strProspectus), DBNull.Value, strProspectus))
                        cmd.Parameters.AddWithValue("@Original", IIf(String.IsNullOrEmpty(strOriginal), DBNull.Value, strOriginal))
                        cmd.Parameters.AddWithValue("@Revised", IIf(String.IsNullOrEmpty(strRevised), DBNull.Value, strRevised))
                        cmd.Parameters.AddWithValue("@Actual", IIf(String.IsNullOrEmpty(strActual), DBNull.Value, strActual))
                        cmd.Parameters.AddWithValue("@User", strUser)
                        cmd.Parameters.Add("@Result", SqlDbType.VarChar, 100)
                        cmd.Parameters("@Result").Direction = ParameterDirection.Output
                        cmd.ExecuteNonQuery()
                    End If
                End If

            Next

            DeletePreviousScheduleAndSaveNewSchedulePD()
            conn.Close()

            lblScheduleUpdtMsg.Text = "Schedule updated"

        Catch ex As Exception
            lblScheduleUpdtMsg.Text = "Unable to update Schedule due to error(s)!"
        End Try

    End Sub


    ''' <summary>
    ''' This is a method to delete old schedule from schedule table, keep track this delete activity on schedulehistory table and save the new schedule into schedule table.
    ''' </summary> 
    Private Sub DeletePreviousScheduleAndSaveNewSchedulePD()
        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim strUser As String
        strUser = lblUserNm.Text

        Dim conndps As New SqlConnection()
        conndps.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmdps As New SqlCommand
        '  cmd.CommandText = "ScheduleDelete"
        cmdps.CommandText = "ScheduleDeletePreviousScheduleAndSaveNewSchedule"
        cmdps.CommandType = CommandType.StoredProcedure
        cmdps.Connection = conndps
        cmdps.Parameters.Add(New SqlParameter("@ProjectId", strProjId))
        cmdps.Parameters.Add(New SqlParameter("@Username", strUser))

        If (conndps.State = ConnectionState.Closed) Then
            conndps.Open()
        End If
        cmdps.ExecuteNonQuery()
        If (conndps.State = ConnectionState.Open) Then
            conndps.Close()
        End If

    End Sub

    ''' <summary>
    ''' This is a method to delete project schedules from temp schedule table prior to populating the table with the updated ones.
    ''' </summary> 
    Private Sub DeleteProjectFromTempTablePD(strProjId As String)
        Dim strUser As String
        strUser = lblUserNm.Text

        Dim conndpf As New SqlConnection()
        conndpf.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmddpf As New SqlCommand
        '  cmd.CommandText = "ScheduleDelete"
        cmddpf.CommandText = "ScheduleDeleteProjectFromTempTable"
        cmddpf.CommandType = CommandType.StoredProcedure
        cmddpf.Connection = conndpf
        cmddpf.Parameters.Add(New SqlParameter("@ProjectId", strProjId))
        cmddpf.Parameters.Add(New SqlParameter("@Username", strUser))

        If (conndpf.State = ConnectionState.Closed) Then
            conndpf.Open()
        End If
        cmddpf.ExecuteNonQuery()
        If (conndpf.State = ConnectionState.Open) Then
            conndpf.Close()
        End If

    End Sub


    ''' <summary>
    ''' The formview for scope will be in the edit mode when the page loads if there is any
    ''' entry there. Othetwise it will be in the insert mode. It will be in read only mode for
    ''' user with Reader access.
    ''' </summary>
    Protected Sub fvEditScope_DataBound(sender As Object, e As EventArgs)
        If Session("GroupID") >= 200 Then
            If fvEditScope.DataItemCount = 0 Then
                fvEditScope.ChangeMode(FormViewMode.Insert)
            Else
                fvEditScope.ChangeMode(FormViewMode.Edit)
            End If
        Else
            fvEditScope.ChangeMode(FormViewMode.ReadOnly)
        End If

        Dim txtScope As TextBox = DirectCast(fvEditScope.FindControl("txtScope"), TextBox)
        Dim txtAddScope As TextBox = DirectCast(fvEditScope.FindControl("txtAddScope"), TextBox)
        Dim lblEditScpHdng As Label = DirectCast(fvEditScope.FindControl("lblEditScpHdng"), Label)
        Dim lblAddScpHdng As Label = DirectCast(fvEditScope.FindControl("lblAddScpHdng"), Label)

        Dim btnUpdtScope As Button = DirectCast(fvEditScope.FindControl("btnUpdtScope"), Button)
        Dim btnCnclEditScope As Button = DirectCast(fvEditScope.FindControl("btnCnclEditScope"), Button)

        If Not txtScope Is Nothing And Session("GroupID") < 320 Then
            txtScope.Enabled = False
            txtScope.BackColor = Drawing.Color.White
            txtScope.ForeColor = Drawing.Color.Blue
            txtScope.Style.Add("font-weight", "bolder")

            btnUpdtScope.Enabled = False
            btnCnclEditScope.Enabled = False
        End If

        Dim varSubProjFlag As CheckBox = CType(fvMainInfo.FindControl("cbSubProjectFlag"), CheckBox)
        If varSubProjFlag.Checked Then
            '    maxLength = "350"
            If Not lblEditScpHdng Is Nothing Then lblEditScpHdng.Text = lblEditScpHdng.Text + " (limit up to 350 chars)"
            If Not lblAddScpHdng Is Nothing Then lblAddScpHdng.Text = lblAddScpHdng.Text + " (limit up to 350 chars)"
        Else
            If Not lblEditScpHdng Is Nothing Then lblEditScpHdng.Text = lblEditScpHdng.Text + " (limit up to 675 chars)"
            If Not lblAddScpHdng Is Nothing Then lblAddScpHdng.Text = lblAddScpHdng.Text + " (limit up to 675 chars)"
        End If

        '       If Not txtScope Is Nothing Then txtScope.Attributes.Add("MaxLength", maxLength)
        '       If Not txtAddScope Is Nothing Then txtAddScope.Attributes.Add("MaxLength", maxLength)

    End Sub

    ''' <summary>
    ''' Updating scope by running the UpdateScope stored procedure.
    ''' </summary>
    Protected Sub btnUpdtScope_Click(sender As Object, e As EventArgs)
        Dim strEditScope As String = DirectCast(fvEditScope.FindControl("txtScope"), TextBox).Text
        Dim strCommentId As String = DirectCast(fvEditScope.FindControl("lblScopeId"), Label).Text
        Dim strProjID As String = DirectCast(fvEditScope.FindControl("lblProjNo"), Label).Text
        Dim struser As String = lblUserNm.Text

        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand()
        conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        cmd.Connection = conn
        cmd.CommandText = "UpdateScope"
        cmd.CommandType = System.Data.CommandType.StoredProcedure
        cmd.Parameters.Add("@Comment_PK", SqlDbType.Int).Value = strCommentId
        cmd.Parameters.Add("@project_FK", SqlDbType.Int).Value = strProjID
        cmd.Parameters.Add("@Comment", SqlDbType.Text).Value = strEditScope
        cmd.Parameters.Add("@username", SqlDbType.Text).Value = struser
        cmd.Parameters.Add("@Result", SqlDbType.VarChar, 100)
        cmd.Parameters("@Result").Direction = ParameterDirection.Output
        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()

        ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Message", "SaveAlertMsg('Saving Scope Information!');", True)

        fvEditScope.DataBind()
        lblUpdtMsg.Text = cmd.Parameters("@Result").Value.ToString()
        'Response.Redirect("~/ProjectDetails.aspx?tab=1&project_pk=" + strProjID)
    End Sub

    ''' <summary>
    ''' Adding scope by running the AddScope stored procedure.
    ''' </summary>
    Protected Sub btnAddNewScope_Click(sender As Object, e As EventArgs)
        Dim strNewScope As String = DirectCast(fvEditScope.FindControl("txtAddScope"), TextBox).Text
        Dim strProjNum As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text

        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand()
        conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        cmd.Connection = conn
        cmd.CommandText = "AddScope"
        cmd.CommandType = System.Data.CommandType.StoredProcedure
        cmd.Parameters.Add("@project_pk", SqlDbType.Int).Value = strProjNum
        cmd.Parameters.Add("@Comment", SqlDbType.Text).Value = strNewScope
        cmd.Parameters.Add("@CommentType", SqlDbType.Int).Value = 2
        cmd.Parameters.Add("@username", SqlDbType.Text).Value = struser
        cmd.Parameters.Add("@Result", SqlDbType.VarChar, 100)
        cmd.Parameters("@Result").Direction = ParameterDirection.Output
        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()

        ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Message", "SaveAlertMsg('Saving Scope Information!');", True)
        fvEditScope.DataBind()
        fvEditScope.ChangeMode(FormViewMode.Edit)
        lblUpdtMsg.Text = cmd.Parameters("@Result").Value.ToString()
        'Response.Redirect("~/ProjectDetails.aspx?tab=1&project_pk=" + strProjNum)
    End Sub

    ''' <summary>
    ''' Clicking Cancel button in editing scope will delete the edit
    ''' </summary>
    Protected Sub btnCnclEditScope_Click(sender As Object, e As EventArgs)
        fvEditScope.DataBind()
    End Sub

    ''' <summary>
    ''' Clicking Cancel button in adding scope will clean the entry.
    ''' </summary>
    Protected Sub btnCnclAddScope_Click(sender As Object, e As EventArgs)
        fvEditScope.DataBind()
    End Sub

    ''' <summary>
    ''' The formview for status will be in the edit mode when the page loads if there is any
    ''' entry there. Othetwise it will be in the insert mode. It will be in read only mode for
    ''' user with Reader access.
    ''' </summary>
    Protected Sub fvAddEditStatus_DataBound(sender As Object, e As EventArgs)
        If Session("GroupID") >= 200 Then
            If fvAddEditStatus.DataItemCount = 0 Then
                fvAddEditStatus.ChangeMode(FormViewMode.Insert)
            Else
                fvAddEditStatus.ChangeMode(FormViewMode.Edit)
            End If
        Else
            fvAddEditStatus.ChangeMode(FormViewMode.ReadOnly)
        End If
    End Sub
    ''' <summary>
    ''' Clicking Cancel button in adding Status will clean the entry.
    ''' </summary>
    Protected Sub btnCnclAddStatus_Click(sender As Object, e As EventArgs)
        fvAddEditStatus.DataBind()
    End Sub
    ''' <summary>
    ''' Clicking Cancel button in editing status will clean the entry.
    ''' </summary>
    Protected Sub btnCnclEditStatus_Click(sender As Object, e As EventArgs)
        fvAddEditStatus.DataBind()
    End Sub
    ''' <summary>
    ''' Clicking Save button in editing status will run the UpdateStatus stored procedure.
    ''' </summary>
    Protected Sub btnEditStatus_Click(sender As Object, e As EventArgs)
        Dim strEditStatus As String = DirectCast(fvAddEditStatus.FindControl("txtEditStatus"), TextBox).Text
        Dim ddlStageEdit As DropDownList = DirectCast(fvAddEditStatus.FindControl("ddlEditStage"), DropDownList)
        Dim strStatusID As String = DirectCast(fvAddEditStatus.FindControl("lblStatusID"), Label).Text
        Dim strProjectId As String = DirectCast(fvAddEditStatus.FindControl("lblProjId"), Label).Text
        Dim struser As String = lblUserNm.Text

        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand()
        conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        cmd.Connection = conn
        cmd.CommandText = "UpdateStatus"
        cmd.CommandType = System.Data.CommandType.StoredProcedure
        cmd.Parameters.Add("@Comment_PK", SqlDbType.Int).Value = strStatusID
        cmd.Parameters.Add("@project_FK", SqlDbType.Int).Value = strProjectId
        cmd.Parameters.Add("@StageType", SqlDbType.Int).Value = ddlStageEdit.SelectedValue
        cmd.Parameters.Add("@Comment", SqlDbType.Text).Value = strEditStatus
        cmd.Parameters.Add("@username", SqlDbType.Text).Value = struser
        cmd.Parameters.Add("@Result", SqlDbType.VarChar, 100)
        cmd.Parameters("@Result").Direction = ParameterDirection.Output
        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()

        ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Message", "SaveAlertMsg('Saving Current Status Information!');", True)
        fvAddEditStatus.DataBind()
        lblUpdtMsg.Text = cmd.Parameters("@Result").Value.ToString()
        'Response.Redirect("~/ProjectDetails.aspx?tab=1&project_pk=" + strProjectId)
    End Sub
    ''' <summary>
    ''' Clicking Save button in adding status form will run the AddStatus stored procedure.
    ''' </summary>
    Protected Sub btnAddStatus_Click(sender As Object, e As EventArgs)

        Dim strNewStatus As String = DirectCast(fvAddEditStatus.FindControl("txtAddStatus"), TextBox).Text
        'Dim ddlStage As DropDownList = DirectCast(fvAddEditStatus.FindControl("ddlStage"), DropDownList)
        Dim strStageType As String = CType(fvAddEditStatus.FindControl("ddlStage"), DropDownList).Text
        Dim strProjNum As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text

        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand()
        conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        cmd.Connection = conn
        cmd.CommandText = "AddStatus"
        cmd.CommandType = System.Data.CommandType.StoredProcedure
        cmd.Parameters.Add("@project_pk", SqlDbType.Int).Value = strProjNum
        cmd.Parameters.Add("@StageType", SqlDbType.Int).Value = strStageType
        cmd.Parameters.Add("@Comment", SqlDbType.Text).Value = strNewStatus
        cmd.Parameters.Add("@CommentType", SqlDbType.Int).Value = 3
        cmd.Parameters.Add("@username", SqlDbType.Text).Value = struser
        cmd.Parameters.Add("@Result", SqlDbType.VarChar, 100)
        cmd.Parameters("@Result").Direction = ParameterDirection.Output
        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()

        ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Message", "SaveAlertMsg('Saving Current Status Information!');", True)
        fvAddEditStatus.DataBind()
        fvAddEditStatus.ChangeMode(FormViewMode.Edit)
        lblUpdtMsg.Text = cmd.Parameters("@Result").Value.ToString()
        'Response.Redirect("~/ProjectDetails.aspx?tab=1&project_pk=" + strProjNum)
    End Sub
    ''' <summary>
    ''' The formview for comments will be in the edit mode when the page loads if there is any
    ''' entry there. Othetwise it will be in the insert mode. It will be in read only mode for
    ''' user with Reader access.
    ''' </summary>
    Protected Sub fvAddEditWkCom_DataBound(sender As Object, e As EventArgs)
        If Session("GroupID") >= 200 Then
            If fvAddEditWkCom.DataItemCount = 0 Then
                fvAddEditWkCom.ChangeMode(FormViewMode.Insert)
            Else
                fvAddEditWkCom.ChangeMode(FormViewMode.Edit)
            End If
        Else
            fvAddEditWkCom.ChangeMode(FormViewMode.ReadOnly)
        End If

        Dim txtEdtProjCom As TextBox = DirectCast(fvAddEditWkCom.FindControl("txtEdtProjCom"), TextBox)
        Dim txtAddWkComNote As TextBox = DirectCast(fvAddEditWkCom.FindControl("txtAddWkComNote"), TextBox)

        '   If Not txtEdtProjCom Is Nothing Then txtEdtProjCom.Attributes.Add("MaxLength", "675")
        '   If Not txtAddWkComNote Is Nothing Then txtAddWkComNote.Attributes.Add("MaxLength", "675")

    End Sub


    ''' <summary>
    ''' The formview for comments will be in the edit mode when the page loads if there is any
    ''' entry there. Othetwise it will be in the insert mode. It will be in read only mode for
    ''' user with Reader access.
    ''' </summary>
    Protected Sub fvAddEditExternalWkCom_DataBound(sender As Object, e As EventArgs)
        If Session("GroupID") >= 200 Then
            If fvAddEditExternalWkCom.DataItemCount = 0 Then
                fvAddEditExternalWkCom.ChangeMode(FormViewMode.Insert)
            Else
                fvAddEditExternalWkCom.ChangeMode(FormViewMode.Edit)
            End If
        Else
            fvAddEditExternalWkCom.ChangeMode(FormViewMode.ReadOnly)
        End If

        Dim txtEdtExternalProjCom As TextBox = DirectCast(fvAddEditExternalWkCom.FindControl("txtEdtExternalProjCom"), TextBox)
        Dim txtAddExternalWkComNote As TextBox = DirectCast(fvAddEditExternalWkCom.FindControl("txtAddExternalWkComNote"), TextBox)

        If Not txtEdtExternalProjCom Is Nothing Then
            'Dim lblEdtCreatedDate As Label = DirectCast(fvAddEditExternalWkCom.FindControl("lblEdtCreatedDate"), Label)
            'If Not lblEdtCreatedDate Is Nothing Then
            '    If (lblEdtCreatedDate.Text.ToString = "") Or (lblEdtCreatedDate.Text.ToString <> "" AndAlso Convert.ToDateTime(lblEdtCreatedDate.Text.ToString) >= Convert.ToDateTime("11/08/2020")) Then
            If txtEdtExternalProjCom.Text.Length <= 675 Then
                '    txtEdtExternalProjCom.Attributes.Add("MaxLength", "675")
                txtEdtExternalProjCom.Attributes.Add("onKeyPress", "return (this.value.length <= 675);")
                txtEdtExternalProjCom.Attributes.Add("onchange", "validateLength(this);")
                txtEdtExternalProjCom.Attributes.Add("onkeyup", "validateLength(this);")
                txtEdtExternalProjCom.Attributes.Add("onpaste", "validateLength(this);")
            End If
            'End If
        End If
        If Not txtAddExternalWkComNote Is Nothing Then
            '   txtAddExternalWkComNote.Attributes.Add("MaxLength", "675")
            txtAddExternalWkComNote.Attributes.Add("onKeyPress", "return (this.value.length <= 675);")
            txtAddExternalWkComNote.Attributes.Add("onchange", "validateLength(this);")
            txtAddExternalWkComNote.Attributes.Add("onkeyup", "validateLength(this);")
            txtAddExternalWkComNote.Attributes.Add("onpaste", "validateLength(this);")
        End If

        Dim riskTypeSelected As String
        riskTypeSelected = RefreshGetRiskType()

        Dim varAddRiskType As DropDownList = CType(fvAddEditExternalWkCom.FindControl("ddlAddRiskType"), DropDownList)
        Dim varEditRiskType As DropDownList = CType(fvAddEditExternalWkCom.FindControl("ddlEditRiskType"), DropDownList)
        Dim varProjectHealthColor As HtmlImage = CType(fvMainInfo.FindControl("ProjectHealthColor"), HtmlImage)

        If Not varAddRiskType Is Nothing Then
            varAddRiskType.SelectedValue = riskTypeSelected
        ElseIf Not varEditRiskType Is Nothing Then
            varEditRiskType.SelectedValue = riskTypeSelected
        End If

        Select Case riskTypeSelected
            Case "1"
                varProjectHealthColor.Src = "Images/projectHealthColorRed.png"
            Case "2"
                varProjectHealthColor.Src = "Images/projectHealthColorYellow.png"
            Case "3"
                varProjectHealthColor.Src = "Images/projectHealthColorGreen.png"
        End Select

    End Sub


    ''' <summary>
    ''' The formview for comments will be in the edit mode when the page loads if there is any
    ''' entry there. Othetwise it will be in the insert mode. It will be in read only mode for
    ''' user with Reader access.
    ''' </summary>
    Protected Sub fvAddEditEnvironmentalNotes_DataBound(sender As Object, e As EventArgs)

        Dim txtEdtEnvironmentalNotes As TextBox = DirectCast(fvAddEditEnvironmentalNotes.FindControl("txtEdtEnvironmentalNotes"), TextBox)
        Dim txtAddEnvironmentalNotes As TextBox = DirectCast(fvAddEditEnvironmentalNotes.FindControl("txtAddEnvironmentalNotes"), TextBox)

        '        If Session("GroupID") >= 200 Then
        If fvAddEditEnvironmentalNotes.DataItemCount = 0 Then
            fvAddEditEnvironmentalNotes.ChangeMode(FormViewMode.Insert)
            txtAddEnvironmentalNotes.Enabled = False
            txtAddEnvironmentalNotes.BackColor = Drawing.Color.White
            txtAddEnvironmentalNotes.ForeColor = Drawing.Color.Blue
            txtAddEnvironmentalNotes.Style.Add("font-weight", "bolder")
            txtAddEnvironmentalNotes.Attributes.Add("readonly", "readonly")

        Else
            fvAddEditEnvironmentalNotes.ChangeMode(FormViewMode.Edit)
            txtEdtEnvironmentalNotes.Enabled = False
            txtEdtEnvironmentalNotes.BackColor = Drawing.Color.White
            txtEdtEnvironmentalNotes.ForeColor = Drawing.Color.Blue
            txtEdtEnvironmentalNotes.Style.Add("font-weight", "bolder")

        End If
        '       Else
        '       fvAddEditEnvironmentalNotes.ChangeMode(FormViewMode.ReadOnly)
        '       End If

        'fvAddEditEnvironmentalNotes.ChangeMode(FormViewMode.ReadOnly)

    End Sub


    ''' <summary>
    ''' Clicking Cancel button in editing weekly comment will return to the default mode
    ''' </summary>
    Protected Sub btnCnclEdtWkCom_Click(sender As Object, e As EventArgs)
        fvAddEditWkCom.DataBind()
    End Sub

    ''' <summary>
    ''' Clicking Cancel button in editing weekly comment will return to the default mode
    ''' </summary>
    Protected Sub btnCnclEdtExternalWkCom_Click(sender As Object, e As EventArgs)
        fvAddEditExternalWkCom.DataBind()
    End Sub

    ''' <summary>
    ''' Clicking Cancel button in adding weekly comment form will make the form clear.
    ''' </summary> 
    Protected Sub btnCnclAddWkCom_Click(sender As Object, e As EventArgs)
        fvAddEditWkCom.DataBind()
    End Sub

    ''' <summary>
    ''' Clicking Cancel button in adding weekly comment form will make the form clear.
    ''' </summary> 
    Protected Sub btnCnclAddExternalWkCom_Click(sender As Object, e As EventArgs)
        fvAddEditExternalWkCom.DataBind()
    End Sub


    ''' <summary>
    ''' Clicking Save button in editing weekly comment will run the SP UpdateProjectComment
    ''' </summary>
    Protected Sub btnUpdtWkCom_Click(sender As Object, e As EventArgs)
        Dim strComment As String = DirectCast(fvAddEditWkCom.FindControl("txtEdtProjCom"), TextBox).Text
        Dim strCommentId As String = DirectCast(fvAddEditWkCom.FindControl("lblEdtComPk"), Label).Text
        Dim strProjID As String = DirectCast(fvAddEditWkCom.FindControl("lblEdtProjId"), Label).Text
        Dim struser As String = lblUserNm.Text

        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand()
        conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        cmd.Connection = conn
        cmd.CommandText = "UpdateProjectComment"
        cmd.CommandType = System.Data.CommandType.StoredProcedure
        cmd.Parameters.Add("@Comment_PK", SqlDbType.Int).Value = strCommentId
        cmd.Parameters.Add("@project_FK", SqlDbType.Int).Value = strProjID
        cmd.Parameters.Add("@Comment", SqlDbType.Text).Value = strComment
        '        cmd.Parameters.Add("@RiskType", SqlDbType.Int).Value = vbNull
        cmd.Parameters.Add("@username", SqlDbType.Text).Value = struser
        cmd.Parameters.Add("@Result", SqlDbType.VarChar, 100)
        cmd.Parameters("@Result").Direction = ParameterDirection.Output
        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()

        ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Message", "SaveAlertMsg('Saving Comment Information!');", True)

        fvAddEditWkCom.DataBind()
        lblUpdtMsg.Text = cmd.Parameters("@Result").Value.ToString()
        'Response.Redirect("~/ProjectDetails.aspx?tab=1&project_pk=" + strProjID)

    End Sub


    ''' <summary>
    ''' Clicking Save button in editing weekly comment will run the SP UpdateLeadershipHighlights
    ''' </summary>
    Protected Sub btnUpdtExternalWkCom_Click(sender As Object, e As EventArgs)
        Dim strExternalComment As String = DirectCast(fvAddEditExternalWkCom.FindControl("txtEdtExternalProjCom"), TextBox).Text
        Dim strCommentId As String = DirectCast(fvAddEditExternalWkCom.FindControl("lblEdtExternalComPk"), Label).Text
        Dim ddlEditRiskType As DropDownList = DirectCast(fvAddEditExternalWkCom.FindControl("ddlEditRiskType"), DropDownList)
        Dim strProjID As String = DirectCast(fvAddEditExternalWkCom.FindControl("lblEdtExternalProjId"), Label).Text
        Dim struser As String = lblUserNm.Text

        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand()
        conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        cmd.Connection = conn
        cmd.CommandText = "UpdateLeadershipHighlights"
        cmd.CommandType = System.Data.CommandType.StoredProcedure
        cmd.Parameters.Add("@Comment_PK", SqlDbType.Int).Value = strCommentId
        cmd.Parameters.Add("@project_FK", SqlDbType.Int).Value = strProjID
        cmd.Parameters.Add("@Comment", SqlDbType.Text).Value = strExternalComment
        cmd.Parameters.Add("@RiskType", SqlDbType.Int).Value = ddlEditRiskType.SelectedValue
        cmd.Parameters.Add("@username", SqlDbType.Text).Value = struser
        cmd.Parameters.Add("@Result", SqlDbType.VarChar, 100)
        cmd.Parameters("@Result").Direction = ParameterDirection.Output
        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()

        ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Message", "SaveAlertMsg('Saving Project Health and/or Leadership Highlights Information!');", True)

        fvAddEditExternalWkCom.DataBind()
        lblUpdtMsg.Text = cmd.Parameters("@Result").Value.ToString()
        'Response.Redirect("~/ProjectDetails.aspx?tab=1&project_pk=" + strProjID)

    End Sub


    ''' <summary>
    '''Clicking Save button in adding weekly comment form will run the SP AddProjectComment
    ''' </summary>
    Protected Sub btnAddNewWkCom_Click(sender As Object, e As EventArgs)
        Dim strNewComment As String = DirectCast(fvAddEditWkCom.FindControl("txtAddWkComNote"), TextBox).Text
        Dim strProjNum As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text

        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand()
        conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        cmd.Connection = conn
        cmd.CommandText = "AddProjectComment"
        cmd.CommandType = System.Data.CommandType.StoredProcedure
        cmd.Parameters.Add("@project_pk", SqlDbType.Int).Value = strProjNum
        cmd.Parameters.Add("@Comment", SqlDbType.Text).Value = strNewComment
        cmd.Parameters.Add("@CommentType", SqlDbType.Int).Value = 1
        '       cmd.Parameters.Add("@RiskType", SqlDbType.Int).Value = vbNull
        cmd.Parameters.Add("@username", SqlDbType.Text).Value = struser
        cmd.Parameters.Add("@Result", SqlDbType.VarChar, 100)
        cmd.Parameters("@Result").Direction = ParameterDirection.Output
        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()

        ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Message", "SaveAlertMsg('Saving Comment Information!');", True)

        fvAddEditWkCom.DataBind()
        fvAddEditWkCom.ChangeMode(FormViewMode.Edit)
        lblUpdtMsg.Text = cmd.Parameters("@Result").Value.ToString()
        'Response.Redirect("~/ProjectDetails.aspx?tab=1&project_pk=" + strProjNum)
    End Sub


    ''' <summary>
    '''Clicking Save button in adding weekly comment form will run the SP AddLeadershipHighlights
    ''' </summary>
    Protected Sub btnAddNewExternalWkCom_Click(sender As Object, e As EventArgs)
        Dim strNewExternalComment As String = DirectCast(fvAddEditExternalWkCom.FindControl("txtAddExternalWkComNote"), TextBox).Text
        Dim ddlAddRiskType As DropDownList = DirectCast(fvAddEditExternalWkCom.FindControl("ddlAddRiskType"), DropDownList)
        Dim strProjNum As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text

        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand()
        conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        cmd.Connection = conn
        cmd.CommandText = "AddLeadershipHighlights"
        cmd.CommandType = System.Data.CommandType.StoredProcedure
        cmd.Parameters.Add("@project_pk", SqlDbType.Int).Value = strProjNum
        cmd.Parameters.Add("@Comment", SqlDbType.Text).Value = strNewExternalComment
        cmd.Parameters.Add("@CommentType", SqlDbType.Int).Value = 5
        cmd.Parameters.Add("@RiskType", SqlDbType.Int).Value = ddlAddRiskType.SelectedValue
        cmd.Parameters.Add("@username", SqlDbType.Text).Value = struser
        cmd.Parameters.Add("@Result", SqlDbType.VarChar, 100)
        cmd.Parameters("@Result").Direction = ParameterDirection.Output
        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()

        ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Message", "SaveAlertMsg('Saving Project Health and/or Leadership Highlights Information!');", True)

        fvAddEditExternalWkCom.DataBind()
        fvAddEditExternalWkCom.ChangeMode(FormViewMode.Edit)
        lblUpdtMsg.Text = cmd.Parameters("@Result").Value.ToString()

    End Sub


    ''' <summary>
    ''' This function is to insert null in the database in case the text box is empty.
    ''' </summary>
    Public Function DbNullOrStringValue(ByVal value As String) As Object
        If String.IsNullOrEmpty(value) Then
            Return DBNull.Value
        Else
            Return value
        End If
    End Function
    ''' <summary>
    '''Clicking Save Update button in projrct detail form will run the SP UpdateProject. See the comments in the
    ''' stored procedure to get the Cost update information.
    ''' </summary>
    Protected Sub btnEditProj_Click(sender As Object, e As EventArgs) Handles btnEditProj.Click
        Dim strProjDesc As String = CType(fvMainInfo.FindControl("txtProjDesc"), TextBox).Text
        Dim strProjStatus As String = CType(fvMainInfo.FindControl("ddlStatus"), DropDownList).Text
        Dim strProjType As String = CType(fvMainInfo.FindControl("ddlType"), DropDownList).Text
        Dim strProjCat As String = CType(fvMainInfo.FindControl("ddlCategory"), DropDownList).Text
        Dim strProjSubCat As String = CType(fvMainInfo.FindControl("ddlSubCategory"), DropDownList).Text
        Dim strDelivery As String = CType(fvMainInfo.FindControl("ddlDeliveryM"), DropDownList).Text
        Dim strProgYr As String = CType(fvMainInfo.FindControl("txtProgYr"), TextBox).Text
        Dim strlastCPRMP As String = CType(fvMainInfo.FindControl("txtlastCPRMP"), TextBox).Text
        Dim strnextCPRMP As String = CType(fvMainInfo.FindControl("txtnextCPRMP"), TextBox).Text
        Dim strRegion As String = CType(fvMainInfo.FindControl("ddlEditRegion"), DropDownList).Text
        Dim strProjNum As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text
        Dim varNcaDistrict As String = CType(fvMainInfo.FindControl("ddlNcaDistrict"), DropDownList).Text
        Dim strDesignFund As String = CType(fvMainInfo.FindControl("txtDesignFund"), TextBox).Text
        Dim strConstrucFund As String = CType(fvMainInfo.FindControl("txtConstructionFund"), TextBox).Text
        'Dim strDistReq As String = CType(fvMainInfo.FindControl("lblDistrictReq"), Label).Text
        Dim AvaiableFund As Label = DirectCast(fvFmsCost.FindControl("lblAvailableFnd"), Label)
        Dim TotalExpenditure As Label = DirectCast(fvFmsCost.FindControl("lblTotalExpnd"), Label)
        Dim TotalObligation As Label = DirectCast(fvFmsCost.FindControl("lblTotalOblig"), Label)
        Dim strExecDesignAgentID As String = CType(fvMainInfo.FindControl("ddlEditDesignAgent"), DropDownList).Text
        Dim strExecConstructionAgentID As String = CType(fvMainInfo.FindControl("ddlEditConstructionAgent"), DropDownList).Text

        Dim strAvailableFund, strTotalObligation, strTotalExpenditure As Double
        Try
            'If strAvailableFund <> Nothing And strTotalObligation <> Nothing And strTotalExpenditure <> Nothing Then
            If AvaiableFund IsNot Nothing Then Double.TryParse(AvaiableFund.Text.Replace("$", "").Replace(",", ""), strAvailableFund)
            If TotalObligation IsNot Nothing Then Double.TryParse(TotalObligation.Text.Replace("$", "").Replace(",", ""), strTotalObligation)
            If TotalExpenditure IsNot Nothing Then Double.TryParse(TotalExpenditure.Text.Replace("$", "").Replace(",", ""), strTotalExpenditure)
            'End If
        Catch ex As Exception

        Finally

        End Try
        If strRegion = "Cemetery" And varNcaDistrict = "" Then
            lblDistrictReq.Text = "District is required for Cemetery"
            Exit Sub
        End If
        If strRegion <> "Cemetery" Then
            varNcaDistrict = ""
        End If

        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "UpdateProject"
            command.CommandType = CommandType.StoredProcedure

            command.Parameters.AddWithValue("@ProjectId", DbNullOrStringValue(strProjNum))
            command.Parameters.AddWithValue("@projectDesc", DbNullOrStringValue(strProjDesc))
            command.Parameters.AddWithValue("@programYr", DbNullOrStringValue(strProgYr))
            command.Parameters.AddWithValue("@lastCPRMP", DbNullOrStringValue(strlastCPRMP))
            command.Parameters.AddWithValue("@nextCPRMP", DbNullOrStringValue(strnextCPRMP))
            command.Parameters.AddWithValue("@UserName", DbNullOrStringValue(struser))
            command.Parameters.AddWithValue("@status", SqlDbType.Int).Value = strProjStatus
            command.Parameters.AddWithValue("@DelivaryMethod", SqlDbType.Int).Value = strDelivery
            command.Parameters.AddWithValue("@ProgCat", SqlDbType.Int).Value = strProjCat
            command.Parameters.AddWithValue("@ProgSubCat", SqlDbType.Int).Value = strProjSubCat
            command.Parameters.AddWithValue("@projType", SqlDbType.Int).Value = strProjType
            command.Parameters.AddWithValue("@Region", SqlDbType.VarChar).Value = strRegion
            command.Parameters.AddWithValue("@NcaDistrict", DbNullOrStringValue(varNcaDistrict))
            command.Parameters.AddWithValue("@DesignFund", DbNullOrStringValue(strDesignFund))
            command.Parameters.AddWithValue("@ConstrucFund", DbNullOrStringValue(strConstrucFund))
            command.Parameters.AddWithValue("@AvailableFund", SqlDbType.Money).Value = strAvailableFund
            command.Parameters.AddWithValue("@TotalObligation", SqlDbType.Money).Value = strTotalObligation
            command.Parameters.AddWithValue("@TotalExpenditure", SqlDbType.Money).Value = strTotalExpenditure
            command.Parameters.AddWithValue("@ExecDesignAgentID", SqlDbType.VarChar).Value = strExecDesignAgentID
            command.Parameters.AddWithValue("@ExecConstructionAgentID", SqlDbType.VarChar).Value = strExecConstructionAgentID

            command.Parameters.Add("@Result", SqlDbType.VarChar, 100)
            command.Parameters("@Result").Direction = ParameterDirection.Output

            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()

            lblUpdtProj.Text = command.Parameters("@Result").Value.ToString()
        End Using
        fvMainInfo.DataBind()
        fvFmsCost.DataBind()
        fvCfmisCost.DataBind()
        Dim pageUrl As String = "ProjectDetails.aspx?project_pk=" + varId ' + "&tab=0"
        Response.Redirect(pageUrl)

    End Sub
    ''' <summary>
    ''' Selecting a role from Manager Role dropdown list will populate the personnel dropdown list for that role.
    ''' </summary>
    Protected Sub ddlManagerRoles_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlManagerRoles.SelectedIndexChanged
        Dim varRoleId As Integer = ddlManagerRoles.SelectedValue

        If ddlPersonnel.Items.Count = 0 Then
            Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
            Using conn As New SqlConnection(ConnStr)
                Dim command As New SqlCommand
                command.Connection = conn
                conn.Open()
                command.CommandText = "GetByProjectPersonnel"
                command.CommandType = CommandType.StoredProcedure

                Dim reader As SqlDataReader = command.ExecuteReader()

                ddlPersonnel.DataSource = reader
                ddlPersonnel.DataTextField = "FullName"
                ddlPersonnel.DataValueField = "personnel_pk"
                ddlPersonnel.DataBind()
                ddlPersonnel.Items.Insert(0, New ListItem("-Select-"))

                conn.Close()
            End Using

        Else
            ddlPersonnel.SelectedIndex = 0
        End If

        If ddlManagerRoles.SelectedValue <> "0" Then
            ddlPersonnel.Visible = True
        Else
            ddlPersonnel.Visible = False
        End If

        ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Message", "showPOCgridrows();", True)
    End Sub
    'Neil 

    ''' <summary>
    ''' Clicking the Add Personnel button will run the AddPersonnelInProject SP
    ''' </summary>
    Protected Sub btnAddPersonnel_Click(sender As Object, e As EventArgs) Handles btnAddPersonnel.Click
        Dim strProjNum As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim strPersonnelId As String = ddlPersonnel.SelectedValue.ToString
        Dim strRoleId As String = ddlManagerRoles.SelectedValue.ToString

        If ddlManagerRoles.SelectedValue = "0" Then
            lblErrorRole.Text = "Select a Role"
            Exit Sub
        End If

        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "AddPersonnelInProject"
            command.CommandType = CommandType.StoredProcedure

            command.Parameters.AddWithValue("@ProjectId", DbNullOrStringValue(strProjNum))
            command.Parameters.AddWithValue("@PersonnelId", DbNullOrStringValue(strPersonnelId))
            command.Parameters.AddWithValue("@RoleId", DbNullOrStringValue(strRoleId))
            command.Parameters.Add("@Result", SqlDbType.VarChar, 100)
            command.Parameters("@Result").Direction = ParameterDirection.Output

            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()

            If command.Parameters("@Result").Value.ToString = "Added" Then
                ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Message", "SaveAlertMsg('Saving Personnel Information!');", True)
            ElseIf command.Parameters("@Result").Value.ToString = "Duplicate" Then
                ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Message", "ErrorAlertMsg('You are not allowed to add duplicate personnel with same role information into the project!');", True)
            Else
                ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Message", "ErrorAlertMsg('You are not allowed to add more than one(1) Environmental Engineer role information into the project!');", True)
            End If

        End Using

        gvCurrentPersonnel.DataBind()

        ddlManagerRoles.SelectedIndex = 0
        ddlPersonnel.Visible = False

    End Sub
    ''' <summary>
    ''' Clicking the Remove from List button will run the RemovePersonnelfromProject SP to make the
    ''' deleted column checked in ProjectPersonnel table and will not show in the application but will have
    ''' the history of the personnel for a project.
    ''' </summary>
    Protected Sub btnDelete_Click(sender As Object, e As EventArgs)
        Dim btn As Button = DirectCast(sender, Button)
        Dim GrdRow As GridViewRow = DirectCast(btn.Parent.Parent, GridViewRow)

        Dim lblProjPerson As Label = DirectCast(GrdRow.Cells(0).FindControl("lblProjPersonId"), Label)

        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "RemovePersonnelfromProject"
            command.CommandType = Data.CommandType.StoredProcedure

            command.Parameters.AddWithValue("@ProjectPersonalId", SqlDbType.Int).Value = lblProjPerson.Text

            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()
        End Using
        ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Message", "showPOCgridrows();", True)
        gvCurrentPersonnel.DataBind()

    End Sub

    'Protected Sub tcProjectDetails_ActiveTabChanged(sender As Object, e As EventArgs)
    '    If tcProjectDetails.ActiveTabIndex <> 1 Then
    '        lblUpdtMsg.Text = String.Empty
    '    End If
    'End Sub

    ''' <summary>
    ''' fvCost will be visible when cost information has already been entered. The PowerUserAdmin
    ''' group will be able to update the TEC and the Initial Cost fields. These fields will be non editable for
    ''' general users.
    ''' </summary>
    Protected Sub fvCost_DataBound(ByVal sender As Object, ByVal e As EventArgs)
        Dim varGroup As Integer = Session("GroupID")
        Dim EditInitialCost As TextBox = CType(fvCost.FindControl("txtInitialCost"), TextBox)
        Dim EditTec As TextBox = CType(fvCost.FindControl("txtTotalEstCost"), TextBox)
        If fvCost.DataItemCount = 0 Then
            fvCost.Visible = False
            Exit Sub
        Else
            If varGroup < 500 And varGroup >= 200 Then
                EditInitialCost.Enabled = False
                EditTec.Enabled = False
            ElseIf varGroup >= 500 Then
                EditInitialCost.Enabled = True
                EditTec.Enabled = True
            ElseIf varGroup < 200 Then
                fvCost.ChangeMode(FormViewMode.ReadOnly)
            End If
            fvAddCost.Visible = False
        End If
    End Sub
    ''' <summary>
    ''' Clicking the Save button in updating main project cost will run the UpdateCostMainProject SP. 
    ''' </summary>
    Protected Sub btnEditCostEst_Click(sender As Object, e As EventArgs)
        Dim TotalEstCost As TextBox = DirectCast(fvCost.FindControl("txtTotalEstCost"), TextBox)
        Dim CurrentEstimated As TextBox = DirectCast(fvCost.FindControl("txtCurrentEstCost"), TextBox)
        Dim Approved As TextBox = DirectCast(fvCost.FindControl("txtApproved"), TextBox)
        Dim InitialCost As TextBox = DirectCast(fvCost.FindControl("txtInitialCost"), TextBox)
        Dim USACEinitialAwardAmn As TextBox = DirectCast(fvCost.FindControl("txtUSACEinitialAwardAmn"), TextBox)
        Dim USACEcontingencies As TextBox = DirectCast(fvCost.FindControl("txtUSACEcontingencies"), TextBox)
        Dim strUser As String = lblUserNm.Text
        Dim strCostId As String = DirectCast(fvCost.FindControl("lblCostId"), Label).Text

        Dim strTotalEstCost, strCurrentEstimated, strApproved, strInitialCost, strUSACEinitialAward, strUSACEcontingencies As Double

        Double.TryParse(TotalEstCost.Text.Replace("$", "").Replace(",", ""), strTotalEstCost)
        Double.TryParse(CurrentEstimated.Text.Replace("$", "").Replace(",", ""), strCurrentEstimated)
        Double.TryParse(Approved.Text.Replace("$", "").Replace(",", ""), strApproved)
        Double.TryParse(InitialCost.Text.Replace("$", "").Replace(",", ""), strInitialCost)
        Double.TryParse(USACEinitialAwardAmn.Text.Replace("$", "").Replace(",", ""), strUSACEinitialAward)
        Double.TryParse(USACEcontingencies.Text.Replace("$", "").Replace(",", ""), strUSACEcontingencies)

        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand
            com.Connection = conn
            com.CommandType = CommandType.StoredProcedure
            com.CommandText = "UpdateCostMainProject"

            com.Parameters.AddWithValue("@CostEstimatePK", SqlDbType.Int).Value = strCostId
            com.Parameters.AddWithValue("@TotalEstimatedCost", SqlDbType.Money).Value = strTotalEstCost
            com.Parameters.AddWithValue("@Approved", SqlDbType.Money).Value = strApproved
            com.Parameters.AddWithValue("@CurrentEstimatedCost", SqlDbType.Money).Value = strCurrentEstimated
            com.Parameters.AddWithValue("@InitialCost", SqlDbType.Money).Value = strInitialCost
            com.Parameters.AddWithValue("@UsaceInitialAwAmt", SqlDbType.VarChar).Value = strUSACEinitialAward
            com.Parameters.AddWithValue("@UsaceContingencies", SqlDbType.VarChar).Value = strUSACEcontingencies
            com.Parameters.AddWithValue("@username", SqlDbType.VarChar).Value = strUser
            com.Parameters.Add("@Result", SqlDbType.VarChar, 1000)
            com.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
            lblUpdtCostMsg.Text = com.Parameters("@Result").Value.ToString
        End Using
        fvCost.DataBind()

    End Sub
    ''' <summary>
    ''' fvAddCost will be visible when cost information has no data. The PowerUserAdmin
    ''' group will be able to enter value for all the fields including TEC and the Initial Cost fields. 
    ''' These fields will be disabled for general users.
    ''' </summary>
    Protected Sub fvAddCost_DataBound(ByVal sender As Object, ByVal e As EventArgs)
        Dim varGroup As Integer = Session("GroupID")
        Dim AddInitialCost As TextBox = CType(fvAddCost.FindControl("txtInitialCostAdd"), TextBox)
        Dim AddTec As TextBox = CType(fvAddCost.FindControl("txtTotalEstCostAdd"), TextBox)

        'If fvAddCost.DataItemCount > 0 Then
        '    fvAddCost.Visible = False
        '    Exit Sub
        'Else
        If varGroup < 500 Then
            AddInitialCost.Enabled = False
            AddTec.Enabled = False
        Else
            AddInitialCost.Enabled = True
            AddTec.Enabled = True
        End If
        'fvCost.Visible = False
        'End If
    End Sub
    ''' <summary>
    ''' Clicking the Save button in adding main project cost will run the AddCostMainProject SP. 
    ''' </summary>
    Protected Sub btnAddCostEst_Click(sender As Object, e As EventArgs)
        Dim TotalEstCost As TextBox = DirectCast(fvAddCost.FindControl("txtTotalEstCostAdd"), TextBox)
        Dim CurrentEstimated As TextBox = DirectCast(fvAddCost.FindControl("txtCurrentEstCostAdd"), TextBox)
        Dim Approved As TextBox = DirectCast(fvAddCost.FindControl("txtApprovedAdd"), TextBox)
        Dim InitialCost As TextBox = DirectCast(fvAddCost.FindControl("txtInitialCostAdd"), TextBox)
        Dim USACEinitialAwardAmn As TextBox = DirectCast(fvAddCost.FindControl("txtUSACEinitialAwardAmnAdd"), TextBox)
        Dim USACEcontingencies As TextBox = DirectCast(fvAddCost.FindControl("txtUSACEcontingenciesAdd"), TextBox)
        Dim strUser As String = lblUserNm.Text
        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))

        Dim strTotalEstCost, strCurrentEstimated, strApproved, strInitialCost, strUSACEinitialAward, strUSACEcontingencies As Double

        Double.TryParse(TotalEstCost.Text.Replace("$", "").Replace(",", ""), strTotalEstCost)
        Double.TryParse(CurrentEstimated.Text.Replace("$", "").Replace(",", ""), strCurrentEstimated)
        Double.TryParse(Approved.Text.Replace("$", "").Replace(",", ""), strApproved)
        Double.TryParse(InitialCost.Text.Replace("$", "").Replace(",", ""), strInitialCost)
        Double.TryParse(USACEinitialAwardAmn.Text.Replace("$", "").Replace(",", ""), strUSACEinitialAward)
        Double.TryParse(USACEcontingencies.Text.Replace("$", "").Replace(",", ""), strUSACEcontingencies)

        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand
            com.Connection = conn
            com.CommandType = CommandType.StoredProcedure
            com.CommandText = "AddCostMainProject"

            com.Parameters.AddWithValue("@project_FK", SqlDbType.Int).Value = strProjId
            com.Parameters.AddWithValue("@TotalEstimatedCost", SqlDbType.Money).Value = strTotalEstCost
            com.Parameters.AddWithValue("@Approved", SqlDbType.Money).Value = strApproved
            com.Parameters.AddWithValue("@CurrentEstimatedCost", SqlDbType.Money).Value = strCurrentEstimated
            com.Parameters.AddWithValue("@InitialCost", SqlDbType.Money).Value = strInitialCost
            com.Parameters.AddWithValue("@UsaceInitialAwAmt", SqlDbType.VarChar).Value = strUSACEinitialAward
            com.Parameters.AddWithValue("@UsaceContingencies", SqlDbType.VarChar).Value = strUSACEcontingencies
            com.Parameters.AddWithValue("@username", SqlDbType.VarChar).Value = strUser
            com.Parameters.Add("@Result", SqlDbType.VarChar, 100)
            com.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
            lblUpdtCostMsg.Text = com.Parameters("@Result").Value.ToString
        End Using
        'fvAddCost.DataBind()
        fvCost.DataBind()
        Dim pageUrl As String = "ProjectDetails.aspx?project_pk=" + varId ' + "&tab=2"
        Response.Redirect(pageUrl)

    End Sub
    ''' <summary>
    ''' The formview for sub project cost will be in the edit mode when the page loads if there is any
    ''' entry there. Othetwise it will be in the insert mode. It will be in read only mode for
    ''' user with Reader access.
    ''' </summary>
    Protected Sub fvSubProjCost_DataBound(sender As Object, e As EventArgs) Handles fvSubProjCost.DataBound
        If Session("GroupID") >= 200 Then
            If fvSubProjCost.DataItemCount = 0 Then
                fvSubProjCost.ChangeMode(FormViewMode.Insert)
            Else
                fvSubProjCost.ChangeMode(FormViewMode.Edit)
            End If
        Else
            fvSubProjCost.ChangeMode(FormViewMode.ReadOnly)
        End If
    End Sub
    ''' <summary>
    ''' Clicking the Save button in updating sub project cost will run the UpdateCostSubProject SP. 
    ''' </summary>
    Protected Sub btnEditSubCostEst_Click(sender As Object, e As EventArgs)
        Dim strTecEdit As String = CType(fvSubProjCost.FindControl("txtEditTecSub"), TextBox).Text
        Dim strCostId As String = CType(fvSubProjCost.FindControl("lblSubCostId"), Label).Text
        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim strUser As String = lblUserNm.Text
        'Dim strResult As String
        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim com As New SqlCommand
            com.Connection = conn
            com.CommandType = CommandType.StoredProcedure
            com.CommandText = "UpdateCostSubProject"
            com.Parameters.AddWithValue("@project_FK", SqlDbType.Int).Value = strProjId
            com.Parameters.AddWithValue("@CostId", SqlDbType.Int).Value = strCostId
            com.Parameters.AddWithValue("@TotalEstimatedCost", SqlDbType.Money).Value = strTecEdit
            com.Parameters.AddWithValue("@username", SqlDbType.VarChar).Value = strUser
            com.Parameters.Add("@Result", SqlDbType.VarChar, 1000)
            com.Parameters("@Result").Direction = ParameterDirection.Output

            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
            lblUpdtCostMsg.Text = com.Parameters("@Result").Value.ToString
            'strResult = com.Parameters("@Result").Value.ToString()
            'ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "alert", "alert('" + strResult + "');", True)

        End Using
        fvSubProjCost.DataBind()
    End Sub
    ''' <summary>
    ''' Clicking the Save button in adding sub project cost will run the UpdateCostSubProject SP. 
    ''' </summary>
    Protected Sub btnAddSubCostEst_Click(sender As Object, e As EventArgs)
        Dim strTec As String = CType(fvSubProjCost.FindControl("txtAddTecSub"), TextBox).Text
        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim strUser As String = lblUserNm.Text
        'Dim strResult As String

        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim com As New SqlCommand
            com.Connection = conn
            com.CommandType = CommandType.StoredProcedure
            com.CommandText = "AddCostSubProject"
            com.Parameters.AddWithValue("@project_FK", SqlDbType.Int).Value = strProjId
            com.Parameters.AddWithValue("@TotalEstimatedCost", SqlDbType.Money).Value = strTec
            com.Parameters.AddWithValue("@username", SqlDbType.VarChar).Value = strUser
            com.Parameters.Add("@Result", SqlDbType.VarChar, 1000)
            com.Parameters("@Result").Direction = ParameterDirection.Output

            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
            lblUpdtCostMsg.Text = com.Parameters("@Result").Value.ToString
            'strResult = com.Parameters("@Result").Value.ToString()
            'ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "alert", "alert('" + strResult + "');", True)
            If lblUpdtCostMsg.Text.Contains("Cannot be added") Then
                Exit Sub
            End If
        End Using
        fvSubProjCost.DataBind()

        Dim pageUrl As String = "ProjectDetails.aspx?project_pk=" + varId  ' + "&tab=2"
        Response.Redirect(pageUrl)

    End Sub
    ''' <summary>
    ''' Get the number of pages to populate the dropdown list in the pager when the grid view databound happens.
    ''' </summary>
    Protected Sub gvFunding_DataBound(sender As Object, e As EventArgs)
        If gvFunding.Rows.Count >= 1 Then
            Dim ddl As DropDownList = DirectCast(gvFunding.BottomPagerRow.Cells(0).FindControl("ddlFundPaging"), DropDownList)
            For cnt As Integer = 0 To gvFunding.PageCount - 1
                Dim curr As Integer = cnt + 1
                Dim item As New ListItem(curr.ToString())
                If cnt = gvFunding.PageIndex Then
                    item.Selected = True
                End If
                ddl.Items.Add(item)
            Next
        End If
    End Sub


    ''' <summary>
    ''' When the user selects different page number to go to that page by clicking in the dropdownlist.
    ''' </summary>
    ''' <remarks></remarks>
    Protected Sub ddlFundPaging_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddl As DropDownList = DirectCast(gvFunding.BottomPagerRow.Cells(0).FindControl("ddlFundPaging"), DropDownList)
        gvFunding.PageIndex = ddl.SelectedIndex
    End Sub
    ''' <summary>
    ''' Clicking Add Funding button will open the adding popup form.
    ''' </summary> 
    Protected Sub btnAddFunding_Click(sender As Object, e As EventArgs) Handles btnAddFunding.Click
        mpeAddFund.Show()
        fvAddFund.DataBind()
        Session("blnAddFundingClick") = "1"
    End Sub
    ''' <summary>
    ''' Clicking the Save button in the adding interface will run the SP AddFunding.
    ''' </summary> 
    Protected Sub lbAddFund_Click(sender As Object, e As EventArgs) Handles lbAddFund.Click
        Dim strFundYr As String = CType(fvAddFund.FindControl("txtFundingYr"), TextBox).Text
        Dim strApprovalTp As String = CType(fvAddFund.FindControl("ddlApprovalTp"), DropDownList).SelectedValue
        Dim strAppropriationPL As String = CType(fvAddFund.FindControl("txtAppropriationPL"), TextBox).Text
        Dim strAuthorizationPL As String = CType(fvAddFund.FindControl("txtAuthorizationPL"), TextBox).Text
        Dim strPurpose As String = CType(fvAddFund.FindControl("txtPurpose"), TextBox).Text
        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim strUser As String = lblUserNm.Text
        Dim RequestedFnd As TextBox = DirectCast(fvAddFund.FindControl("txtRequestedFund"), TextBox)
        Dim AppropriationFnd As TextBox = DirectCast(fvAddFund.FindControl("txtAppropriationFund"), TextBox)
        Dim AuthorizationFnd As TextBox = DirectCast(fvAddFund.FindControl("txtAuthorizationFund"), TextBox)

        Dim strRequestdFnd, strAppropriationFnd, strAuthorizationFnd As Double
        Double.TryParse(RequestedFnd.Text.Replace("$", "").Replace(",", ""), strRequestdFnd)
        Double.TryParse(AppropriationFnd.Text.Replace("$", "").Replace(",", ""), strAppropriationFnd)
        Double.TryParse(AuthorizationFnd.Text.Replace("$", "").Replace(",", ""), strAuthorizationFnd)

        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand
            com.Connection = conn
            com.CommandType = CommandType.StoredProcedure
            com.CommandText = "AddFunding"

            com.Parameters.AddWithValue("@projectId", SqlDbType.Int).Value = strProjId
            com.Parameters.AddWithValue("@FundingYr", SqlDbType.Int).Value = strFundYr
            com.Parameters.AddWithValue("@RequestedFund", SqlDbType.Money).Value = strRequestdFnd
            com.Parameters.AddWithValue("@AppropriationFund", SqlDbType.Money).Value = strAppropriationFnd
            com.Parameters.AddWithValue("@AuthorizationFund", SqlDbType.Money).Value = strAuthorizationFnd
            com.Parameters.AddWithValue("@AppropriationPL", DbNullOrStringValue(strAppropriationPL))
            com.Parameters.AddWithValue("@AuthorizationPL", DbNullOrStringValue(strAuthorizationPL))
            'com.Parameters.AddWithValue("@ApprovalTpFk", SqlDbType.Int).Value = strApprovalTp
            com.Parameters.AddWithValue("@Purpose", DbNullOrStringValue(strPurpose))
            com.Parameters.AddWithValue("@username", SqlDbType.VarChar).Value = strUser
            com.Parameters.Add("@ApprovalTpFk", SqlDbType.Int)
            If String.IsNullOrEmpty(strApprovalTp) = True Then
                com.Parameters("@ApprovalTpFk").Value = System.DBNull.Value
            Else
                com.Parameters("@ApprovalTpFk").Value = strApprovalTp
            End If
            com.Parameters.Add("@Result", SqlDbType.VarChar, 100)
            com.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
            lblAddMsg.Text = com.Parameters("@Result").Value.ToString
        End Using
        gvFunding.DataBind()

        Dim pageUrl As String = "ProjectDetails.aspx?project_pk=" + varId  ' + "&tab=3"
        Response.Redirect(pageUrl)
    End Sub
    ''' <summary>
    ''' Clicking Edit Funding button will open the editing popup form.
    ''' </summary> 
    Protected Sub btnEditFund_Click(sender As Object, e As EventArgs)
        Session("blnAddFundingClick") = "1"
        mpeEditFund.Show()
        fvEditFund.DataBind()
    End Sub

    Protected Sub btnDeleteFund_Click(sender As Object, e As EventArgs)
        'mpeEditFund.Show()
        'fvEditFund.DataBind()
    End Sub

    ''' <summary>
    ''' Clicking the Save button in the updating interface will run the SP UpdateFunding.
    ''' </summary> 
    Protected Sub lbEditFund_Click(sender As Object, e As EventArgs) Handles lbEditFund.Click
        Dim strFundYrEdt As String = CType(fvEditFund.FindControl("txtFundingYrEdit"), TextBox).Text
        Dim strApprovalTpEdt As String = CType(fvEditFund.FindControl("ddlApprovalTpEdit"), DropDownList).SelectedValue
        Dim strAppropriationPLEdt As String = CType(fvEditFund.FindControl("txtAppropriationPLEdit"), TextBox).Text
        Dim strAuthorizationPLEdt As String = CType(fvEditFund.FindControl("txtAuthorizationPLEdit"), TextBox).Text
        Dim strPurposeEdt As String = CType(fvEditFund.FindControl("txtPurposeEdit"), TextBox).Text
        Dim strFundId As String = CType(fvEditFund.FindControl("lblFundId"), Label).Text
        Dim strUser As String = lblUserNm.Text
        Dim RequestedFndEdt As TextBox = DirectCast(fvEditFund.FindControl("txtRequestedFundEdit"), TextBox)
        Dim AppropriationFndEdt As TextBox = DirectCast(fvEditFund.FindControl("txtAppropriationFundEdit"), TextBox)
        Dim AuthorizationFndEdt As TextBox = DirectCast(fvEditFund.FindControl("txtAuthorizationFundEdit"), TextBox)

        Dim strRequestdFndEdt, strAppropriationFndEdt, strAuthorizationFndEdt As Double
        Double.TryParse(RequestedFndEdt.Text.Replace("(", "-").Replace("$", "").Replace(",", "").Replace(")", ""), strRequestdFndEdt)
        Double.TryParse(AppropriationFndEdt.Text.Replace("(", "-").Replace("$", "").Replace(",", "").Replace(")", ""), strAppropriationFndEdt)
        Double.TryParse(AuthorizationFndEdt.Text.Replace("(", "-").Replace("$", "").Replace(",", "").Replace(")", ""), strAuthorizationFndEdt)

        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand
            com.Connection = conn
            com.CommandType = CommandType.StoredProcedure
            com.CommandText = "UpdateFunding"

            com.Parameters.AddWithValue("@FundId", SqlDbType.Int).Value = strFundId
            com.Parameters.AddWithValue("@FundingYr", SqlDbType.Int).Value = strFundYrEdt
            com.Parameters.AddWithValue("@RequestedFund", SqlDbType.Money).Value = strRequestdFndEdt
            com.Parameters.AddWithValue("@AppropriationFund", SqlDbType.Money).Value = strAppropriationFndEdt
            com.Parameters.AddWithValue("@AuthorizationFund", SqlDbType.Money).Value = strAuthorizationFndEdt
            com.Parameters.AddWithValue("@AppropriationPL", DbNullOrStringValue(strAppropriationPLEdt))
            com.Parameters.AddWithValue("@AuthorizationPL", DbNullOrStringValue(strAuthorizationPLEdt))
            com.Parameters.AddWithValue("@Purpose", DbNullOrStringValue(strPurposeEdt))
            com.Parameters.AddWithValue("@username", SqlDbType.VarChar).Value = strUser
            com.Parameters.Add("@ApprovalTpFk", SqlDbType.Int)
            If String.IsNullOrEmpty(strApprovalTpEdt) = True Then
                com.Parameters("@ApprovalTpFk").Value = System.DBNull.Value
            Else
                com.Parameters("@ApprovalTpFk").Value = strApprovalTpEdt
            End If
            com.Parameters.Add("@Result", SqlDbType.VarChar, 100)
            com.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
            lblAddMsg.Text = com.Parameters("@Result").Value.ToString
        End Using
        gvFunding.DataBind()

        Dim pageUrl As String = "ProjectDetails.aspx?project_pk=" + varId  ' + "&tab=3"
        Response.Redirect(pageUrl)
    End Sub
    ''' <summary>
    ''' Clicking Add Comment button will open the adding comment popup form.
    ''' </summary> 
    Protected Sub btnAddCostComment_Click(sender As Object, e As EventArgs) Handles btnAddCostComment.Click
        mpeAddCostComment.Show()
        fvAddCostComment.DataBind()
    End Sub
    ''' <summary>
    ''' Clicking the Save button in the adding interface will run the SP AddCostComment.
    ''' </summary> 
    Protected Sub lbAddCostComment_Click(sender As Object, e As EventArgs) Handles lbAddCostComment.Click
        Dim strCostComment As String = CType(fvAddCostComment.FindControl("txtCostCommentAdd"), TextBox).Text
        Dim strProjNum As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text

        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand
            com.Connection = conn
            com.CommandType = CommandType.StoredProcedure
            com.CommandText = "AddCostComment"

            com.Parameters.AddWithValue("@Comment", SqlDbType.VarChar).Value = strCostComment
            com.Parameters.AddWithValue("@project_fk", SqlDbType.Int).Value = strProjNum
            com.Parameters.AddWithValue("@username", SqlDbType.VarChar).Value = struser
            com.Parameters.Add("@Result", SqlDbType.VarChar, 100)
            com.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
            lblAddCostComMsg.Text = com.Parameters("@Result").Value.ToString
        End Using
        fvLatestComment.DataBind()
        gvCostCommentHistory.DataBind()
    End Sub
    ''' <summary>
    ''' Clicking Save button in the comment form will run the SP UpdateCostComment
    ''' </summary> 
    Protected Sub btnEditCostCom_Click(sender As Object, e As EventArgs)
        Dim strLatestCom As String = CType(fvLatestComment.FindControl("txtCostCommentEdt"), TextBox).Text
        Dim strCommentId As String = CType(fvLatestComment.FindControl("lblCommentId"), Label).Text
        Dim strProjNum As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text

        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand
            com.Connection = conn
            com.CommandType = CommandType.StoredProcedure
            com.CommandText = "UpdateCostComment"

            com.Parameters.AddWithValue("@Comment", SqlDbType.VarChar).Value = strLatestCom
            com.Parameters.AddWithValue("@Comment_PK", SqlDbType.Int).Value = strCommentId
            com.Parameters.AddWithValue("@project_FK", SqlDbType.Int).Value = strProjNum
            com.Parameters.AddWithValue("@username", SqlDbType.VarChar).Value = struser
            com.Parameters.Add("@Result", SqlDbType.VarChar, 100)
            com.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
            lblAddCostComMsg.Text = com.Parameters("@Result").Value.ToString
        End Using
        fvLatestComment.DataBind()
        gvCostCommentHistory.DataBind()
    End Sub
    ''' <summary>
    ''' Clicking the save button in upload will keep the users in same tab.
    ''' </summary>
    ''' <remarks></remarks>
    Protected Sub lbInsert_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        tcProjectDetails.ActiveTabIndex = 5
    End Sub
    ''' <summary>
    ''' Upload a .pdf file in the attachment table in the database.
    ''' </summary>
    ''' <remarks></remarks>
    Protected Sub dtvUpload_ItemInserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewInsertEventArgs) Handles dtvUpload.ItemInserting
        Dim fuUpload As FileUpload
        fuUpload = CType(dtvUpload.FindControl("fuUpload"), FileUpload)
        Dim strDocType As String = Nothing
        Dim fileLen As Integer 'to get the file size
        Dim fileOK As Boolean = False
        If fuUpload.HasFile Then
            Dim fileExtension As String
            fileExtension = System.IO.Path.
                GetExtension(fuUpload.FileName).ToLower()
            Dim allowedExtensions As String() =
                {".jpg", ".jpeg", ".png", ".gif", ".pdf", ".doc", ".docx", ".tif", ".tiff", ".xlsx", ".xls", ".txt"}
            For i As Integer = 0 To allowedExtensions.Length - 1
                If fileExtension = allowedExtensions(i) Then
                    fileOK = True
                End If
            Next
            If fileOK Then
                lblMessage.Text = "File uploaded!"
            Else
                lblMessage.Text = "Cannot accept files of this type."
                e.Cancel = True
                Exit Sub
            End If

            lblDoc.Text = fuUpload.FileName
            lblFileName.Text = "File Uploaded: " & fuUpload.FileName
        Else
            'make sure there is a file selected in the box before click upload
            lblMessage.Text = "Choose a File to upload!"
            e.Cancel = True
            Exit Sub
        End If
        If String.Compare(System.IO.Path.GetExtension(fuUpload.FileName), ".pdf", True) = 0 Then
            strDocType = "application/pdf"
        ElseIf String.Compare(System.IO.Path.GetExtension(fuUpload.FileName), ".jpeg", True) = 0 Then
            strDocType = "image/jpeg"
        ElseIf String.Compare(System.IO.Path.GetExtension(fuUpload.FileName), ".jpg", True) = 0 Then
            strDocType = "image/jpeg"
        ElseIf String.Compare(System.IO.Path.GetExtension(fuUpload.FileName), ".png", True) = 0 Then
            strDocType = "image/png"
        ElseIf String.Compare(System.IO.Path.GetExtension(fuUpload.FileName), ".gif", True) = 0 Then
            strDocType = "image/gif"
        ElseIf String.Compare(System.IO.Path.GetExtension(fuUpload.FileName), ".tif", True) = 0 Then
            strDocType = "image/tif"
        ElseIf String.Compare(System.IO.Path.GetExtension(fuUpload.FileName), ".tiff", True) = 0 Then
            strDocType = "image/tiff"
        ElseIf String.Compare(System.IO.Path.GetExtension(fuUpload.FileName), ".doc", True) = 0 Then
            strDocType = "application/msword"
        ElseIf String.Compare(System.IO.Path.GetExtension(fuUpload.FileName), ".docx", True) = 0 Then
            strDocType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        ElseIf String.Compare(System.IO.Path.GetExtension(fuUpload.FileName), ".xls", True) = 0 Then
            strDocType = "application/vnd.ms-excel"
        ElseIf String.Compare(System.IO.Path.GetExtension(fuUpload.FileName), ".xlsx", True) = 0 Then
            strDocType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        ElseIf String.Compare(System.IO.Path.GetExtension(fuUpload.FileName), ".txt", True) = 0 Then
            strDocType = "text/plain"
        End If
        'getting the file length and putting in a label to add in the database
        fileLen = fuUpload.PostedFile.ContentLength
        lblFileSize.Text = fileLen.ToString

        lblDocType.Text = strDocType
        'Specify the values for the MIMEType and ImageData parameters
        e.Values("DocType") = CType((lblDocType), Label).Text

        'Load FileUpload's InputStream into Byte array
        Dim DocBytes(CInt(fuUpload.PostedFile.InputStream.Length)) As Byte
        fuUpload.PostedFile.InputStream.Read(DocBytes, 0, DocBytes.Length)
        e.Values("doc") = DocBytes

    End Sub
    ''' <summary>
    ''' get the add datetime and add by from lblUserNm.
    ''' </summary>
    ''' <remarks></remarks>  
    Protected Sub odsrcDocument_Inserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceMethodEventArgs) Handles odsrcDocument.Inserting
        e.InputParameters("ProjectID") = Request.QueryString("project_pk")
        e.InputParameters("createdDate") = DateTime.Now
        e.InputParameters("createdBy") = CType(lblUserNm, Label).Text
        e.InputParameters("docName") = CType(lblDoc, Label).Text
        e.InputParameters("docType") = CType(lblDocType, Label).Text
        e.InputParameters("docSize") = CType(lblFileSize, Label).Text
    End Sub
    ''' <summary>
    ''' Get the number of pages when the grid view databound happens.
    ''' </summary>
    ''' <remarks></remarks>
    Protected Sub gvUpload_DataBound(ByVal sender As Object, ByVal e As EventArgs)
        If gvUpload.Rows.Count >= 1 Then
            Dim ddl As DropDownList = CType(gvUpload.BottomPagerRow.Cells(0).FindControl("ddlPaging"), DropDownList)
            For cnt As Integer = 0 To gvUpload.PageCount - 1
                Dim curr As Integer = cnt + 1
                Dim item As New ListItem(curr.ToString())
                If cnt = gvUpload.PageIndex Then
                    item.Selected = True
                End If
                ddl.Items.Add(item)
            Next cnt
        End If
        lblTotalRec.Text = "of " & tr.ToString
    End Sub
    ''' <summary>
    ''' When the user selects different page number to go to that page by clicking in the dropdownlist.
    ''' </summary>
    ''' <remarks></remarks>
    Protected Sub ddlPaging_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim ddl As DropDownList = CType(gvUpload.BottomPagerRow.Cells(0).FindControl("ddlPaging"), DropDownList)
        gvUpload.PageIndex = ddl.SelectedIndex
    End Sub
    ''' <summary>
    ''' To show the updatePrograss for Next button click in the upload gridview.
    ''' </summary>
    ''' <remarks></remarks>   
    Protected Sub lbNext_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        System.Threading.Thread.Sleep(5000)
    End Sub
    ''' <summary>
    ''' To show the updatePrograss for First button click in the upload gridview.
    ''' </summary>
    ''' <remarks></remarks>
    Protected Sub lbFirst_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        System.Threading.Thread.Sleep(5000)
    End Sub
    ''' <summary>
    ''' To show the updatePrograss for Prev button click in the upload gridview.
    ''' </summary>
    ''' <remarks></remarks>
    Protected Sub lbPrev_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        System.Threading.Thread.Sleep(5000)
    End Sub
    ''' <summary>
    ''' To show the updatePrograss for Last button click in the upload gridview.
    ''' </summary>
    ''' <remarks></remarks>
    Protected Sub lbLast_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        System.Threading.Thread.Sleep(5000)
    End Sub

    Private Sub odsrcDocument_Selected(sender As Object, e As ObjectDataSourceStatusEventArgs) Handles odsrcDocument.Selected
        Dim dt As Data.DataTable = CType(e.ReturnValue, Data.DataTable)
        tr = dt.Rows.Count
    End Sub
    ''' <summary>
    ''' If user select Cemetery in the region dropdown list, it will make the NCA label and dropdownlist visible.
    ''' </summary>
    ''' <remarks></remarks>
    Protected Sub ddlEditRegion_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddlRegion As DropDownList = CType(fvMainInfo.FindControl("ddlEditRegion"), DropDownList)
        Dim lblNcaDistrict As Label = CType(fvMainInfo.FindControl("lblNcaDistrict"), Label)
        Dim ddlNcaDistrict As DropDownList = CType(fvMainInfo.FindControl("ddlNcaDistrict"), DropDownList)

        If ddlRegion.SelectedItem.Text = "Cemetery" Then
            lblNcaDistrict.Visible = True
            ddlNcaDistrict.Visible = True
        Else
            lblNcaDistrict.Text = ""
            ddlNcaDistrict.Visible = False
        End If
    End Sub

    Protected Sub ddlEditDesignAgent_SelectedIndexChanged(sender As Object, e As EventArgs)
        'Dim ddlRegion As DropDownList = CType(fvMainInfo.FindControl("ddlEditRegion"), DropDownList)
        'Dim lblNcaDistrict As Label = CType(fvMainInfo.FindControl("lblNcaDistrict"), Label)
        'Dim ddlNcaDistrict As DropDownList = CType(fvMainInfo.FindControl("ddlNcaDistrict"), DropDownList)

        'If ddlRegion.SelectedItem.Text = "Cemetery" Then
        '    lblNcaDistrict.Visible = True
        '    ddlNcaDistrict.Visible = True
        'Else
        '    lblNcaDistrict.Text = ""
        '    ddlNcaDistrict.Visible = False
        'End If
    End Sub

    Protected Sub ddlEditConstructionAgent_SelectedIndexChanged(sender As Object, e As EventArgs)
        'Dim ddlRegion As DropDownList = CType(fvMainInfo.FindControl("ddlEditRegion"), DropDownList)
        'Dim lblNcaDistrict As Label = CType(fvMainInfo.FindControl("lblNcaDistrict"), Label)
        'Dim ddlNcaDistrict As DropDownList = CType(fvMainInfo.FindControl("ddlNcaDistrict"), DropDownList)

        'If ddlRegion.SelectedItem.Text = "Cemetery" Then
        '    lblNcaDistrict.Visible = True
        '    ddlNcaDistrict.Visible = True
        'Else
        '    lblNcaDistrict.Text = ""
        '    ddlNcaDistrict.Visible = False
        'End If
    End Sub


    ' rvb added for Project POCs
    Protected Sub grdPocs_RowCommand(ByVal sender As Object, ByVal e As GridViewCommandEventArgs)
        If (e.CommandName = "delpoc") Then
            Dim arg(2) As String
            Dim pocid As String
            Dim projectid As String

            arg = e.CommandArgument.ToString().Split(";")
            pocid = arg(0)
            projectid = arg(1)

            Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
            Using conn As New SqlConnection(ConnStr)
                Dim command As New SqlCommand
                command.Connection = conn
                command.CommandText = "DELETE FROM projectPOC WHERE projectPOCID = " + pocid + " AND project_FK = " + projectid
                command.CommandType = Data.CommandType.Text
                conn.Open()
                command.ExecuteNonQuery()
                conn.Close()
            End Using
            LoadProjectPocGrid(projectid)
            Response.Redirect("~/ProjectDetails.aspx?project_pk=" + projectid.ToString())

        End If
    End Sub

    Private Sub BindPocGrid(ByVal ProjectId As Integer)
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        cmd.CommandText = "ProjectPOCGET"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add(New SqlParameter("@ProjectId", ProjectId))
        cmd.Connection = conn
        If conn.State = ConnectionState.Closed Then
            conn.Open()
        End If
        Dim drResult As SqlDataReader = cmd.ExecuteReader()
        Dim dt As New DataTable()
        dt.Load(drResult)

        Dim rowcount As Integer = dt.Rows.Count()

        For i As Integer = rowcount To 7
            Dim dr As DataRow = dt.NewRow()
            dr("projectPOCID") = 0
            dr("project_FK") = ProjectId


            dt.Rows.Add(dr)
            If i = 5 Then
                Exit For
            End If
        Next
        If (dt.Rows.Count > 0) Then
            'grdPocs.DataSource = dt
            'grdPocs.DataBind()
            'hdnRowCount.Value = IIf(rowcount = 0, "1", rowcount.ToString())
        End If
        If conn.State = ConnectionState.Open Then conn.Close()
    End Sub


    Private Sub BindTempPocGrid(ByVal ProjectId As Integer)
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        cmd.CommandText = "TempProjectPOCGET"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add(New SqlParameter("@ProjectId", ProjectId))
        cmd.Connection = conn
        If conn.State = ConnectionState.Closed Then
            conn.Open()
        End If
        Dim drResult As SqlDataReader = cmd.ExecuteReader()

        Dim dt As New DataTable()
        dt.Load(drResult)

        Dim rowcount As Integer = dt.Rows.Count()

        For i As Integer = rowcount To 7
            Dim dr As DataRow = dt.NewRow()
            dr("projectPOCID") = 0
            dr("project_FK") = ProjectId
            dt.Rows.Add(dr)
            If i = 5 Then
                Exit For
            End If
        Next

        If (dt.Rows.Count > 0) Then
            'grdPocs.DataSource = dt
            'grdPocs.DataBind()
            'hdnRowCount.Value = IIf(rowcount = 0, "1", rowcount.ToString())
        End If
        If conn.State = ConnectionState.Open Then conn.Close()
    End Sub

    Private Sub LoadProjectPocGrid(ByVal ProjectId As Integer)
        If ProjectId = 0 Then
            Dim dt As New DataTable("tempGrid")
            dt.Columns.Add("projectPOCID", Type.GetType("System.Int32"))
            dt.Columns.Add("project_FK", Type.GetType("System.Int32"))
            dt.Columns.Add("firstName", Type.GetType("System.String"))
            dt.Columns.Add("lastName", Type.GetType("System.String"))
            dt.Columns.Add("title", Type.GetType("System.String"))
            dt.Columns.Add("phoneNumber", Type.GetType("System.String"))
            '            dt.Columns.Add("Address", Type.GetType("System.String"))
            '            dt.Columns.Add("ProjectRole", Type.GetType("System.String"))
            For i As Integer = 1 To 5
                Dim dr As DataRow = dt.NewRow()
                dr("projectPOCID") = 0
                dt.Rows.Add(dr)
            Next
            'grdPocs.DataSource = dt
            'grdPocs.DataBind()
            'hdnRowCount.Value = 1
        End If
    End Sub


    Private Sub SaveProjectPOC(ByVal ProjectId As Integer, ByVal firstName As String,
                                    ByVal lastName As String, ByVal Title As String, ByVal phoneNumber As String, Optional ByVal PocId As Integer = 0)
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        cmd.CommandText = "ProjectPocADDUPDATE"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = conn

        cmd.Parameters.Add(New SqlParameter("@PocId", PocId))
        cmd.Parameters.Add(New SqlParameter("@ProjectId", ProjectId))
        cmd.Parameters.Add(New SqlParameter("@firstName", firstName))
        cmd.Parameters.Add(New SqlParameter("@lastName", lastName))
        cmd.Parameters.Add(New SqlParameter("@title", Title))
        cmd.Parameters.Add(New SqlParameter("@phoneNumber", phoneNumber))
        If (conn.State = ConnectionState.Closed) Then
            conn.Open()
        End If
        cmd.ExecuteNonQuery()
        If (conn.State = ConnectionState.Open) Then
            conn.Close()
        End If
    End Sub

    Private Sub RefreshGridPOCs()
        Dim editProjectId As Integer = 0
        editProjectId = Request.QueryString("project_pk")
        Response.Redirect("~/ProjectDetails.aspx?project_pk=" + editProjectId.ToString())
    End Sub

    Protected Function GetProjectPOCCount() As Integer
        Dim strProjNum As String = Convert.ToString(Request.QueryString("project_pk"))

        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand()
        conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        cmd.Connection = conn
        cmd.CommandText = "GetprojectPOCCount"
        cmd.CommandType = System.Data.CommandType.StoredProcedure
        cmd.Parameters.Add("@project_pk", SqlDbType.Int).Value = strProjNum
        cmd.Parameters.Add("@Result", SqlDbType.Int)
        cmd.Parameters("@Result").Direction = ParameterDirection.Output
        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()

        Return cmd.Parameters("@Result").Value

    End Function

    ''' <summary>
    ''' Get the number of pages to populate the dropdown list in the pager when the grid view databound happens.
    ''' </summary>
    Protected Sub gvPOC_DataBound(sender As Object, e As EventArgs)
        If gvPOC.Rows.Count >= 1 Then
            Dim ddl As DropDownList = DirectCast(gvPOC.BottomPagerRow.Cells(0).FindControl("ddlPOCPaging"), DropDownList)
            For cnt As Integer = 0 To gvPOC.PageCount - 1
                Dim curr As Integer = cnt + 1
                Dim item As New ListItem(curr.ToString())
                If cnt = gvPOC.PageIndex Then
                    item.Selected = True
                End If
                ddl.Items.Add(item)
            Next
        End If
    End Sub

    Protected Sub gvPOC_RowDeleting(sender As Object, e As GridViewDeleteEventArgs)

        Dim pocID As Integer = Convert.ToInt32(gvPOC.DataKeys(e.RowIndex).Value)
        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "DELETE FROM projectPOC WHERE projectPOCID = " + pocID.ToString()
            command.CommandType = Data.CommandType.Text
            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()
        End Using
        Response.Redirect("~/ProjectDetails.aspx?project_pk=" + Convert.ToString(Request.QueryString("project_pk")).ToString())

    End Sub

    ''' <summary>
    ''' When the user selects different page number to go to that page by clicking in the dropdownlist.
    ''' </summary>
    ''' <remarks></remarks>
    Protected Sub ddlPOCPaging_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddl As DropDownList = DirectCast(gvPOC.BottomPagerRow.Cells(0).FindControl("ddlPOCPaging"), DropDownList)
        gvPOC.PageIndex = ddl.SelectedIndex
    End Sub

    '' <summary>
    '' Clicking Add Funding button will open the adding popup form.
    '' </summary> 
    Protected Sub btnAddPOCNew_Click(sender As Object, e As EventArgs) Handles btnAddPOCNew.Click
        mpeAddPOCNew.Show()
        fvAddPOCNew.DataBind()
        Session("blnAddPOCClick") = "1"
    End Sub

    'Protected Sub btnAddPOC_Click(sender As Object, e As EventArgs) Handles btnAddPOC.Click
    '    Session("blnAddPOCClick") = "1"
    '    mpeAddPOCNew.Show()
    '    fvAddPOCNew.DataBind()
    'End Sub

    '' <summary>
    '' Clicking the Save button in the adding interface will run the SP AddFunding.
    '' </summary> 
    Protected Sub lbAddPOCNew_Click(sender As Object, e As EventArgs) Handles lbAddPOCNew.Click

        Dim strfirstName As String = CType(fvAddPOCNew.FindControl("txtfirstName"), TextBox).Text
        Dim strlastName As String = CType(fvAddPOCNew.FindControl("txtlastName"), TextBox).Text
        Dim strmanagerRole As String = CType(fvAddPOCNew.FindControl("ddlManagerRole"), DropDownList).SelectedValue
        Dim strphoneNumber As String = CType(fvAddPOCNew.FindControl("txtphoneNumber"), TextBox).Text
        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))

        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand
            com.Connection = conn
            com.CommandType = CommandType.StoredProcedure
            com.CommandText = "ProjectPocADDUPDATE"

            com.Parameters.AddWithValue("@PocId", SqlDbType.Int).Value = "0"
            com.Parameters.AddWithValue("@projectId", SqlDbType.Int).Value = strProjId
            com.Parameters.AddWithValue("@firstName", DbNullOrStringValue(strfirstName))
            com.Parameters.AddWithValue("@lastName", DbNullOrStringValue(strlastName))
            com.Parameters.AddWithValue("@title", SqlDbType.VarChar).Value = ""
            com.Parameters.AddWithValue("@phoneNumber", DbNullOrStringValue(strphoneNumber))
            If String.IsNullOrEmpty(strmanagerRole) = True Then
                com.Parameters.AddWithValue("@managerRoles_FK", SqlDbType.Int).Value = System.DBNull.Value
            Else
                com.Parameters.AddWithValue("@managerRoles_FK", SqlDbType.Int).Value = strmanagerRole
            End If

            com.Parameters.Add("@Result", SqlDbType.VarChar, 100)
            com.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
            lblAddMsgPOC.Text = com.Parameters("@Result").Value.ToString
        End Using
        gvPOC.DataBind()

        Dim pageUrl As String = "ProjectDetails.aspx?project_pk=" + varId    ' + "&tab=3"
        Response.Redirect(pageUrl)
    End Sub


    Protected Sub lbEditPOC_Click(sender As Object, e As EventArgs) Handles lbEditPOC.Click

        Dim strfirstName As String = CType(fvEditPOC.FindControl("txtfirstNameEdit"), TextBox).Text
        Dim strlastName As String = CType(fvEditPOC.FindControl("txtlastNameEdit"), TextBox).Text
        Dim strmanagerRole As String = CType(fvEditPOC.FindControl("ddlManagerRoleEdit"), DropDownList).SelectedValue
        Dim strphoneNumber As String = CType(fvEditPOC.FindControl("txtphoneNumberEdit"), TextBox).Text
        Dim strPocId As String = CType(fvEditPOC.FindControl("lblPOCId"), Label).Text
        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand
            com.Connection = conn
            com.CommandType = CommandType.StoredProcedure
            com.CommandText = "ProjectPocADDUPDATE"

            com.Parameters.AddWithValue("@PocId", SqlDbType.Int).Value = strPocId
            com.Parameters.AddWithValue("@projectId", SqlDbType.Int).Value = strProjId
            com.Parameters.AddWithValue("@firstName", DbNullOrStringValue(strfirstName))
            com.Parameters.AddWithValue("@lastName", DbNullOrStringValue(strlastName))
            com.Parameters.AddWithValue("@title", SqlDbType.VarChar).Value = ""
            com.Parameters.AddWithValue("@phoneNumber", DbNullOrStringValue(strphoneNumber))
            If String.IsNullOrEmpty(strmanagerRole) = True Then
                com.Parameters.AddWithValue("@managerRoles_FK", SqlDbType.Int).Value = System.DBNull.Value
            Else
                com.Parameters.AddWithValue("@managerRoles_FK", SqlDbType.Int).Value = strmanagerRole
            End If

            com.Parameters.Add("@Result", SqlDbType.VarChar, 100)
            com.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
            lblAddMsgPOC.Text = com.Parameters("@Result").Value.ToString
        End Using
        gvPOC.DataBind()

        Dim pageUrl As String = "ProjectDetails.aspx?project_pk=" + varId  ' + "&tab=3"
        Response.Redirect(pageUrl)
    End Sub


    ' <summary>
    '' Clicking Edit Funding button will open the editing popup form.
    '' </summary> 
    Protected Sub btnEditPOC_Click(sender As Object, e As EventArgs)
        Session("blnAddPOCClick") = "1"
        mpeEditPOC.Show()
        fvEditPOC.DataBind()
    End Sub

    Protected Sub btnDeletePOC_Click(sender As Object, e As EventArgs)
        'mpeEditFund.Show()
        'fvEditFund.DataBind()
    End Sub

    ''' <summary>
    ''' Clicking the Save button in the updating interface will run the SP UpdateFunding.
    ''' </summary> 
    ''Protected Sub lbEditPOC_Click(sender As Object, e As EventArgs) Handles lbEditFund.Click

    ''    Dim strfirstNameEdt As String = CType(fvEditPOC.FindControl("txtfirstNameEdit"), TextBox).Text
    ''    Dim strlastNameEdt As String = CType(fvEditPOC.FindControl("txtlastNameEdit"), TextBox).Text
    ''    Dim strmanagerRoleEdt As String = CType(fvEditPOC.FindControl("ddlManagerRolesEdit"), DropDownList).SelectedValue
    ''    Dim strphoneNumberEdt As String = CType(fvEditPOC.FindControl("txtphoneNumberEdit"), TextBox).Text
    ''    Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))
    ''    Dim strPocId As String = CType(fvEditFund.FindControl("lblPOCId"), Label).Text

    ''    Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
    ''    Using conn As New SqlConnection(connStr)
    ''        Dim com As New SqlCommand
    ''        com.Connection = conn
    ''        com.CommandType = CommandType.StoredProcedure
    ''        com.CommandText = "ProjectPocADDUPDATE"

    ''        com.Parameters.AddWithValue("@PocId", SqlDbType.Int).Value = strPocId
    ''        com.Parameters.AddWithValue("@projectId", SqlDbType.Int).Value = strProjId
    ''        com.Parameters.AddWithValue("@firstName", DbNullOrStringValue(strfirstNameEdt))
    ''        com.Parameters.AddWithValue("@lastName", DbNullOrStringValue(strlastNameEdt))
    ''        If String.IsNullOrEmpty(strmanagerRoleEdt) = True Then
    ''            com.Parameters("@managerRoles_FK").Value = System.DBNull.Value
    ''        Else
    ''            com.Parameters("@managerRoles_FK").Value = strmanagerRoleEdt
    ''        End If
    ''        com.Parameters.AddWithValue("@phoneNumber", DbNullOrStringValue(strphoneNumberEdt))
    ''        com.Parameters.AddWithValue("@title", SqlDbType.VarChar).Value = ""

    ''        com.Parameters.Add("@Result", SqlDbType.VarChar, 100)
    ''        com.Parameters("@Result").Direction = ParameterDirection.Output
    ''        conn.Open()
    ''        com.ExecuteNonQuery()
    ''        conn.Close()
    ''        lblAddMsgPOC.Text = com.Parameters("@Result").Value.ToString

    ''    End Using
    ''    gvFunding.DataBind()

    ''    Dim pageUrl As String = "ProjectDetails.aspx?project_pk=" + varId + "&tab=3"
    ''    Response.Redirect(pageUrl)
    ''End Sub


    ' rvb end adding project POCs


    ''Environemntal Tab Starts
    Protected Function Pageloadsubmittedrecords()
        'rblsharepointaccessible.SelectedValue = 1
        'chkseps.SelectedValue = 1
        ' convert the Project Environment Survey into pivot table to avoid looping
        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        cmd.CommandText = "GetProjectEnviroSurvey"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add(New SqlParameter("@ProjectId", strProjId))
        cmd.Connection = conn
        If conn.State = ConnectionState.Closed Then
            conn.Open()
        End If
        Dim adp As New SqlDataAdapter

        adp.SelectCommand = cmd
        Dim ds As New DataSet
        adp.Fill(ds)
        If conn.State = ConnectionState.Open Then
            conn.Close()
        End If
        adp.Dispose()
        If ds.Tables(0).Rows.Count = 0 Then

        Else
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("1").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("1").ToString()) = 1 Then
                    rblsharepointaccessible.SelectedValue = 1
                    firsthdnquestion.Visible = True
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("1").ToString()) = 2 Then
                    rblsharepointaccessible.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("1").ToString()) = 3 Then
                    rblsharepointaccessible.SelectedValue = 3
                End If
            End If
            txtPinNo.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "49", True)

            '2- chkseps
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("2").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("2").ToString()) = 1 Then
                    chkseps.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("2").ToString()) = 2 Then
                    chkseps.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("2").ToString()) = 3 Then
                    chkseps.SelectedValue = 3
                End If
            End If

            '3- chkMp
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("3").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("3").ToString()) = 1 Then
                    chkMp.SelectedValue = 1
                    landusehdnquestion.Visible = True
                    lnkmstrplanhdnquestion.Visible = True
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("3").ToString()) = 2 Then
                    chkMp.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("3").ToString()) = 3 Then
                    chkMp.SelectedValue = 3
                End If
            End If

            '4- chkcnslnd
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("4").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("4").ToString()) = 1 Then
                    chkcnslnd.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("4").ToString()) = 2 Then
                    chkcnslnd.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("4").ToString()) = 3 Then
                    chkcnslnd.SelectedValue = 3
                End If
            End If
            txtPinNo2.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "5", True)
            If txtPinNo2.Text = "" Then
            Else
                lnkmstrplanhdnquestion.Visible = True
            End If

            '6- consistentwithmarketstudy
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("6").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("6").ToString()) = 1 Then
                    consistentwithmarketstudy.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("6").ToString()) = 2 Then
                    consistentwithmarketstudy.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("6").ToString()) = 3 Then
                    consistentwithmarketstudy.SelectedValue = 3
                End If
            End If

            '50- Outleasethroughorp
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("50").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("50").ToString()) = 1 Then
                    Outleasethroughorp.SelectedValue = 1
                    orphdnfirstquestion.Visible = True
                    orphdnsecondquestion.Visible = True
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("50").ToString()) = 2 Then
                    Outleasethroughorp.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("50").ToString()) = 3 Then
                    Outleasethroughorp.SelectedValue = 3
                End If
            End If

            '51- orphandlingpm
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("51").ToString()) <> 0 Then
                'If ConvertToInteger(ds.Tables(0).Rows(0).Item("51").ToString()) = 1 Then
                '    orphandlingpm.SelectedValue = 1
                'ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("51").ToString()) = 2 Then
                '    orphandlingpm.SelectedValue = 2
                'ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("51").ToString()) = 3 Then
                '    orphandlingpm.SelectedValue = 3
                'End If
                orphandlingpm.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "51", True)
            End If

            '52- outleaseexpirationdate
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("52").ToString()) <> 0 Then
                'If ConvertToInteger(ds.Tables(0).Rows(0).Item("52").ToString()) = 1 Then
                '    outleaseexpirationdate.SelectedValue = 1
                'ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("52").ToString()) = 2 Then
                '    outleaseexpirationdate.SelectedValue = 2
                'ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("52").ToString()) = 3 Then
                '    outleaseexpirationdate.SelectedValue = 3
                'End If
                outleaseexpirationdate.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "52", True)
            End If

            '53- knowneasement
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("53").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("53").ToString()) = 1 Then
                    knowneasement.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("53").ToString()) = 2 Then
                    knowneasement.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("53").ToString()) = 3 Then
                    knowneasement.SelectedValue = 3
                End If
            End If
            '54
            txtOrprecordsofeasement.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "54", True)

            '90 -2ndtab
            dvRealestateaction.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "90", True)

            '7- proposedaction 
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("7").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("7").ToString()) = 1 Then
                    proposedaction.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("7").ToString()) = 2 Then
                    proposedaction.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("7").ToString()) = 3 Then
                    proposedaction.SelectedValue = 3
                End If
            End If

            '8- pairea
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("8").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("8").ToString()) = 1 Then
                    pairea.SelectedValue = 1
                    If pairea.Text = "1" Then
                        lndusefirsthiddenquestion.Visible = True
                        lndusesecondhiddenquestion.Visible = True
                        lndusethirdhiddenquestion.Visible = True
                        lndusefourthhiddenquestion.Visible = True
                        lndusefifthhiddenquestion.Visible = True
                        lndusesixthhiddenquestion.Visible = True
                    End If

                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("8").ToString()) = 2 Then
                    pairea.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("8").ToString()) = 3 Then
                    pairea.SelectedValue = 3
                End If
            End If
            '9- rpeffortchk
            If rpeffortchk.Text = "" Then
                rpeffortchk.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "9", True)
            End If
            'If ConvertToInteger(ds.Tables(0).Rows(0).Item("9").ToString()) <> 0 Then
            'If ConvertToInteger(ds.Tables(0).Rows(0).Item("9").ToString()) = 1 Then
            '    rpeffortchk.SelectedValue = 1
            'ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("9").ToString()) = 2 Then
            '    rpeffortchk.SelectedValue = 2
            'ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("9").ToString()) = 3 Then
            '    rpeffortchk.SelectedValue = 3
            'End If
            'End If

            '10- adnacres
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("10").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("10").ToString()) = 1 Then
                    adnacres.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("10").ToString()) = 2 Then
                    adnacres.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("10").ToString()) = 3 Then
                    adnacres.SelectedValue = 3
                End If
            End If
            '11
            If txtSizeofadnacres.Text = "" Then
                txtSizeofadnacres.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "11", True)
            End If


            '12- requirenew
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("12").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("12").ToString()) = 1 Then
                    requirenew.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("12").ToString()) = 2 Then
                    requirenew.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("12").ToString()) = 3 Then
                    requirenew.SelectedValue = 3
                End If
            End If

            '13- increaseofacreagechk
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("13").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("13").ToString()) = 1 Then
                    increaseofacreagechk.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("13").ToString()) = 2 Then
                    increaseofacreagechk.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("13").ToString()) = 3 Then
                    increaseofacreagechk.SelectedValue = 3
                End If
            End If

            '14- realestatepointchk
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("14").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("14").ToString()) = 1 Then
                    realestatepointchk.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("14").ToString()) = 2 Then
                    realestatepointchk.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("14").ToString()) = 3 Then
                    realestatepointchk.SelectedValue = 3
                End If
            End If


            '15- procurmentorleasing
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("15").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("15").ToString()) = 1 Then
                    procurmentorleasing.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("15").ToString()) = 2 Then
                    procurmentorleasing.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("15").ToString()) = 3 Then
                    procurmentorleasing.SelectedValue = 3
                End If
            End If

            '16- demolition
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("16").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("16").ToString()) = 1 Then
                    demolition.SelectedValue = 1
                    If demolition.Text = "1" Then
                        lnduseseventhhiddenquestion.Visible = True
                    End If
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("16").ToString()) = 2 Then
                    demolition.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("16").ToString()) = 3 Then
                    demolition.SelectedValue = 3
                End If
            End If
            '17
            If txtSqrfootagedemolition.Text = "" Then
                txtSqrfootagedemolition.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "17", True)
            End If


            '18- footprintcaptured
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("18").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("18").ToString()) = 1 Then
                    footprintcaptured.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("18").ToString()) = 2 Then
                    footprintcaptured.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("18").ToString()) = 3 Then
                    footprintcaptured.SelectedValue = 3
                End If
            End If

            '19- pkngstructure
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("19").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("19").ToString()) = 1 Then
                    pkngstructure.SelectedValue = 1
                    lnduseeighthhiddenquestion.Visible = True
                    lnduseninthhiddenquestion.Visible = True
                    lndusetenthhiddenquestion.Visible = True
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("19").ToString()) = 2 Then
                    pkngstructure.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("19").ToString()) = 3 Then
                    pkngstructure.SelectedValue = 3
                End If
            End If

            '20- adnsqftgoverallprojectscope
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("20").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("20").ToString()) = 1 Then
                    adnsqftgoverallprojectscope.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("20").ToString()) = 2 Then
                    adnsqftgoverallprojectscope.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("20").ToString()) = 3 Then
                    adnsqftgoverallprojectscope.SelectedValue = 3
                End If
            End If

            '21
            txtAppropriatesqfootage.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "21", True)

            '22
            txtProjectheight.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "22", True)

            '23- envsiteassement
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("23").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("23").ToString()) = 1 Then
                    envsiteassement.SelectedValue = 1
                    sitegeologyfirsthiddenquestion.Visible = True
                    sitegeologysecondhiddenquestion.Visible = True
                    sitegeologythirdhiddenquestion.Visible = True
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("23").ToString()) = 2 Then
                    envsiteassement.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("23").ToString()) = 3 Then
                    envsiteassement.SelectedValue = 3
                End If
            End If

            '24
            txtLnktoreport.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "24", True)

            '25- recenvcondition
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("25").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("25").ToString()) = 1 Then
                    recenvcondition.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("25").ToString()) = 2 Then
                    recenvcondition.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("25").ToString()) = 3 Then
                    recenvcondition.SelectedValue = 3
                End If
            End If

            '26
            txtbriefdscpn.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "26", True)

            '27- subsurfacesuitability
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("27").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("27").ToString()) = 1 Then
                    subsurfacesuitability.SelectedValue = 1
                    sitegeologyfourthhiddenquestion.Visible = True
                    sitegeologyfifthhhiddenquestion.Visible = True
                    sitegeologysixthhhiddenquestion.Visible = True
                    sitegeologyseventhhhiddenquestion.Visible = True
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("27").ToString()) = 2 Then
                    subsurfacesuitability.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("27").ToString()) = 3 Then
                    subsurfacesuitability.SelectedValue = 3
                End If
            End If

            '28
            txtReportSoil.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "28", True)

            '29- highgrndlevels
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("29").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("29").ToString()) = 1 Then
                    highgrndlevels.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("29").ToString()) = 2 Then
                    highgrndlevels.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("29").ToString()) = 3 Then
                    highgrndlevels.SelectedValue = 3
                End If
            End If

            '30- effectconstruction
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("30").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("30").ToString()) = 1 Then
                    effectconstruction.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("30").ToString()) = 2 Then
                    effectconstruction.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("30").ToString()) = 3 Then
                    effectconstruction.SelectedValue = 3
                End If
            End If

            '31- containmentssoil
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("31").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("31").ToString()) = 1 Then
                    containmentssoil.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("31").ToString()) = 2 Then
                    containmentssoil.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("31").ToString()) = 3 Then
                    containmentssoil.SelectedValue = 3
                End If
            End If

            '32- hazordousmtrl
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("32").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("32").ToString()) = 1 Then
                    hazordousmtrl.SelectedValue = 1
                    hazardousknowncontainment.Visible = True
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("32").ToString()) = 2 Then
                    hazordousmtrl.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("32").ToString()) = 3 Then
                    hazordousmtrl.SelectedValue = 3
                End If
            End If

            '33- dcmntlimits
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("33").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("33").ToString()) = 1 Then
                    dcmntlimits.SelectedValue = 1
                    rdbtnlinktoknowncontainments.Visible = True
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("33").ToString()) = 2 Then
                    dcmntlimits.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("33").ToString()) = 3 Then
                    dcmntlimits.SelectedValue = 3
                End If
            End If
            '91 documents link
            txtlinktocontainmentsdocuments.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "91", True)
            '34- fullasbestos
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("34").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("34").ToString()) = 1 Then
                    fullasbestos.SelectedValue = 1
                    hazordousfirsthiddenquestion.Visible = True

                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("34").ToString()) = 2 Then
                    fullasbestos.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("34").ToString()) = 3 Then
                    fullasbestos.SelectedValue = 3
                End If
            End If

            '35
            txtPreviouselbpandacmanalysis.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "35", True)

            '36- polychlorinatepiphenyls
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("36").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("36").ToString()) = 1 Then
                    polychlorinatepiphenyls.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("36").ToString()) = 2 Then
                    polychlorinatepiphenyls.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("36").ToString()) = 3 Then
                    polychlorinatepiphenyls.SelectedValue = 3
                End If
            End If

            '37- bldngfiftyyears
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("37").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("37").ToString()) = 1 Then
                    bldngfiftyyears.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("37").ToString()) = 2 Then
                    bldngfiftyyears.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("37").ToString()) = 3 Then
                    bldngfiftyyears.SelectedValue = 3
                End If
            End If

            '38- nhpaevaluation
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("38").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("38").ToString()) = 1 Then
                    nhpaevaluation.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("38").ToString()) = 2 Then
                    nhpaevaluation.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("38").ToString()) = 3 Then
                    nhpaevaluation.SelectedValue = 3
                End If
            End If

            '39- lstedhistoricregister
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("39").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("39").ToString()) = 1 Then
                    lstedhistoricregister.SelectedValue = 1
                    historicalculturalfirsthiddenquestion.Visible = True
                    historicalculturalsecondhiddenquestion.Visible = True
                    historicalculturalthirdhiddenquestion.Visible = True
                    historicalculturalfourthhiddenquestion.Visible = True
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("39").ToString()) = 2 Then
                    lstedhistoricregister.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("39").ToString()) = 3 Then
                    lstedhistoricregister.SelectedValue = 3
                End If
            End If

            '40 hsitoricarcheolgical
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("40").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("40").ToString()) = 1 Then
                    hsitoricarcheolgical.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("40").ToString()) = 2 Then
                    hsitoricarcheolgical.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("40").ToString()) = 3 Then
                    hsitoricarcheolgical.SelectedValue = 3
                End If
            End If

            '41
            txtLinktopastreports.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "41", True)

            '42 - preservationplan
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("42").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("42").ToString()) = 1 Then
                    preservationplan.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("42").ToString()) = 2 Then
                    preservationplan.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("42").ToString()) = 3 Then
                    preservationplan.SelectedValue = 3
                End If
            End If

            '43
            txtLinktopreservationplan.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "43", True)

            '44- exstnhpaagreement
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("44").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("44").ToString()) = 1 Then
                    exstnhpaagreement.SelectedValue = 1
                    historicalculturalfifthhiddenquestion.Visible = True
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("44").ToString()) = 2 Then
                    exstnhpaagreement.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("44").ToString()) = 3 Then
                    exstnhpaagreement.SelectedValue = 3
                End If
            End If

            '45
            Txtlnktoanyagreement.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "45", True)

            '46- exstrelnwithconsuparties
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("46").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("46").ToString()) = 1 Then
                    exstrelnwithconsuparties.SelectedValue = 1
                    historicalculturalsixthhiddenquestion.Visible = True
                    historicalculturalseventhhiddenquestion.Visible = True

                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("46").ToString()) = 2 Then
                    exstrelnwithconsuparties.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("46").ToString()) = 3 Then
                    exstrelnwithconsuparties.SelectedValue = 3
                End If
            End If

            '47- lnktoannualrptsreuirement
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("47").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("47").ToString()) = 1 Then
                    lnktoannualrptsreuirement.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("47").ToString()) = 2 Then
                    lnktoannualrptsreuirement.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("47").ToString()) = 3 Then
                    lnktoannualrptsreuirement.SelectedValue = 3
                End If
            End If

            '48
            Txtlinktolatestannualreports.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "48", True)

            '55- envsensitive
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("55").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("55").ToString()) = 1 Then
                    envsensitive.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("55").ToString()) = 2 Then
                    envsensitive.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("55").ToString()) = 3 Then
                    envsensitive.SelectedValue = 3
                End If
            End If

            '56- stateorfederalthreatened
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("56").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("56").ToString()) = 1 Then
                    stateorfederalthreatened.SelectedValue = 1
                    naturalresourcesfirsthiddenquestion.Visible = True
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("56").ToString()) = 2 Then
                    stateorfederalthreatened.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("56").ToString()) = 3 Then
                    stateorfederalthreatened.SelectedValue = 3
                End If
            End If

            '57- stateorfederalthreatenedprevreport
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("57").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("57").ToString()) = 1 Then
                    stateorfederalthreatenedprevreport.SelectedValue = 1
                    naturalresourcessecondhiddenquestion.Visible = True
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("57").ToString()) = 2 Then
                    stateorfederalthreatenedprevreport.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("57").ToString()) = 3 Then
                    stateorfederalthreatenedprevreport.SelectedValue = 3
                End If
            End If
            '58
            Txtlnktoattachesarpt.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "58", True)


            '59- femafloodplain
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("59").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("59").ToString()) = 1 Then
                    femafloodplain.SelectedValue = 1
                    naturalresourcesthirdhiddenquestion.Visible = True
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("59").ToString()) = 2 Then
                    femafloodplain.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("59").ToString()) = 3 Then
                    femafloodplain.SelectedValue = 3
                End If
            End If

            '60
            Txtpercentageinfloodplain.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "60", True)

            '61- knownormappedwetlands
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("61").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("61").ToString()) = 1 Then
                    knownormappedwetlands.SelectedValue = 1
                    naturalresourcesfourthhiddenquestion.Visible = True
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("61").ToString()) = 2 Then
                    knownormappedwetlands.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("61").ToString()) = 3 Then
                    knownormappedwetlands.SelectedValue = 3
                End If
            End If

            '62- wetlandimpacted
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("62").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("62").ToString()) = 1 Then
                    wetlandimpacted.SelectedValue = 1
                    naturalresourcesfifthiddenquestion.Visible = True
                    naturalresourcessixthiddenquestion.Visible = True
                    naturalresourcesseventhhiddenquestion.Visible = True
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("62").ToString()) = 2 Then
                    wetlandimpacted.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("62").ToString()) = 3 Then
                    wetlandimpacted.SelectedValue = 3
                End If
            End If

            '63- anticpatedwetlandspermit
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("63").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("63").ToString()) = 1 Then
                    anticpatedwetlandspermit.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("63").ToString()) = 2 Then
                    anticpatedwetlandspermit.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("63").ToString()) = 3 Then
                    anticpatedwetlandspermit.SelectedValue = 3
                End If
            End If

            '64- exstwetlandpermitsoragreement
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("64").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("64").ToString()) = 1 Then
                    exstwetlandpermitsoragreement.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("64").ToString()) = 2 Then
                    exstwetlandpermitsoragreement.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("64").ToString()) = 3 Then
                    exstwetlandpermitsoragreement.SelectedValue = 3
                End If
            End If

            '65
            txtwetlandsexcitingpermits.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "65", True)

            '66- currentstormwateradequate
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("66").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("66").ToString()) = 1 Then
                    currentstormwateradequate.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("66").ToString()) = 2 Then
                    currentstormwateradequate.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("66").ToString()) = 3 Then
                    currentstormwateradequate.SelectedValue = 3
                End If
            End If

            '67- retentionofsw
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("67").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("67").ToString()) = 1 Then
                    retentionofsw.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("67").ToString()) = 2 Then
                    retentionofsw.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("67").ToString()) = 3 Then
                    retentionofsw.SelectedValue = 3
                End If
            End If

            '68- fallcoastalzone
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("68").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("68").ToString()) = 1 Then
                    fallcoastalzone.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("68").ToString()) = 2 Then
                    fallcoastalzone.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("68").ToString()) = 3 Then
                    fallcoastalzone.SelectedValue = 3
                End If
            End If


            '70- sufficesntutilities
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("70").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("70").ToString()) = 1 Then
                    sufficesntutilities.SelectedValue = 1
                    utilities_1.Visible = True
                    utilities_2.Visible = True
                    utilities_3.Visible = True
                    utilities_4.Visible = True
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("70").ToString()) = 2 Then
                    sufficesntutilities.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("70").ToString()) = 3 Then
                    sufficesntutilities.SelectedValue = 3
                End If
            End If

            '71 not yet done and '73 not yet done
            Dim utility_1 As String = Getutilitiescheckedornot(strProjId, "1")
            If utility_1 = "1" Then
                chkElectrical.Checked = True
            End If
            Dim utility_2 As String = Getutilitiescheckedornot(strProjId, "2")
            If utility_2 = "2" Then
                chkSanitarysewer.Checked = True
            End If
            Dim utility_3 As String = Getutilitiescheckedornot(strProjId, "3")
            If utility_3 = "3" Then
                chkStormsewer.Checked = True

            End If
            Dim utility_4 As String = Getutilitiescheckedornot(strProjId, "4")
            If utility_4 = "4" Then
                chkPortablewater.Checked = True
            End If
            Dim utility_5 As String = Getutilitiescheckedornot(strProjId, "5")
            If utility_5 = "5" Then
                chkChilledWater.Checked = True
            End If
            Dim utility_6 As String = Getutilitiescheckedornot(strProjId, "6")
            If utility_6 = "6" Then
                chkSteam.Checked = True
            End If
            Dim utility_7 As String = Getutilitiescheckedornot(strProjId, "7")
            If utility_7 = "7" Then
                chkNaturalgas.Checked = True
            End If
            Dim utility_8 As String = Getutilitiescheckedornot(strProjId, "8")
            If utility_8 = "8" Then
                chkRelaimedwater.Checked = True

            End If
            txtElectrical.Text = Getutilitiesrecords(strProjId, "1")
            txtSanitarysewer.Text = Getutilitiesrecords(strProjId, "2")
            txtStormsewer.Text = Getutilitiesrecords(strProjId, "3")
            txtSteam.Text = Getutilitiesrecords(strProjId, "4")
            txtPortablewater.Text = Getutilitiesrecords(strProjId, "5")
            txtChilledwater.Text = Getutilitiesrecords(strProjId, "6")
            txtNaturalgas.Text = Getutilitiesrecords(strProjId, "7")
            txtReclaimedwatersource.Text = Getutilitiesrecords(strProjId, "8")

            '72- utilitiestobebroughtfrmsite
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("72").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("72").ToString()) = 1 Then
                    utilitiestobebroughtfrmsite.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("72").ToString()) = 2 Then
                    utilitiestobebroughtfrmsite.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("72").ToString()) = 3 Then
                    utilitiestobebroughtfrmsite.SelectedValue = 3
                End If
            End If
            '74- proposedroutingofutilities
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("74").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("74").ToString()) = 1 Then
                    proposedroutingofutilities.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("74").ToString()) = 2 Then
                    proposedroutingofutilities.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("74").ToString()) = 3 Then
                    proposedroutingofutilities.SelectedValue = 3
                End If
            End If

            '75- utilitiesevaluationofsite
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("75").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("75").ToString()) = 1 Then
                    utilitiesevaluationofsite.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("75").ToString()) = 2 Then
                    utilitiesevaluationofsite.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("75").ToString()) = 3 Then
                    utilitiesevaluationofsite.SelectedValue = 3
                End If
            End If

            '76- trafficissue
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("76").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("76").ToString()) = 1 Then
                    trafficissue.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("76").ToString()) = 2 Then
                    trafficissue.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("76").ToString()) = 3 Then
                    trafficissue.SelectedValue = 3
                End If
            End If

            '77- impacttrafficsiteaccess
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("77").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("77").ToString()) = 1 Then
                    impacttrafficsiteaccess.SelectedValue = 1
                    trafficfirsthiddenquestion.Visible = True
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("77").ToString()) = 2 Then
                    impacttrafficsiteaccess.SelectedValue = 2
                    trafficstudycompleted.Visible = True
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("77").ToString()) = 3 Then
                    impacttrafficsiteaccess.SelectedValue = 3
                End If
            End If

            '78- trafficimpactsduringconstn
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("78").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("78").ToString()) = 1 Then
                    trafficimpactsduringconstn.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("78").ToString()) = 2 Then
                    trafficimpactsduringconstn.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("78").ToString()) = 3 Then
                    trafficimpactsduringconstn.SelectedValue = 3
                End If
            End If

            '79- trafficstudycompleted"
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("79").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("79").ToString()) = 1 Then
                    trafficstudycompleted.SelectedValue = 1
                    trafficthirdhiddenquestion.Visible = True
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("79").ToString()) = 2 Then
                    trafficstudycompleted.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("79").ToString()) = 3 Then
                    trafficstudycompleted.SelectedValue = 3
                End If
            End If

            '80 ???????
            txtProvidelnkotrafficstudy.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "80", True)

            '81- masstransitcloseproximity
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("81").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("81").ToString()) = 1 Then
                    masstransitcloseproximity.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("81").ToString()) = 2 Then
                    masstransitcloseproximity.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("81").ToString()) = 3 Then
                    masstransitcloseproximity.SelectedValue = 3
                End If
            End If

            '82- previousnepaeaoreis
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("82").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("82").ToString()) = 1 Then
                    previousnepaeaoreis.SelectedValue = 1
                    nepafirsthiddenquestion.Visible = True
                    nepasecondhiddenquestion.Visible = True
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("82").ToString()) = 2 Then
                    previousnepaeaoreis.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("82").ToString()) = 3 Then
                    previousnepaeaoreis.SelectedValue = 3
                End If
            End If

            '83- finaleasignedfonsi
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("83").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("83").ToString()) = 1 Then
                    finaleasignedfonsi.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("83").ToString()) = 2 Then
                    finaleasignedfonsi.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("83").ToString()) = 3 Then
                    finaleasignedfonsi.SelectedValue = 3
                End If
            End If

            '84
            txtpreviousnepaeaoreis.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "84", True)


            '85- prevcomplnepadocnavailable
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("85").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("85").ToString()) = 1 Then
                    prevcomplnepadocnavailable.SelectedValue = 1
                    nepathirdhiddenquestion.Visible = True
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("85").ToString()) = 2 Then
                    prevcomplnepadocnavailable.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("85").ToString()) = 3 Then
                    prevcomplnepadocnavailable.SelectedValue = 3
                End If
            End If

            '86
            txtLnksitepocpastnepadocn.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "86", True)

            '87- otherprojectunderwayorplanned
            If ConvertToInteger(ds.Tables(0).Rows(0).Item("87").ToString()) <> 0 Then
                If ConvertToInteger(ds.Tables(0).Rows(0).Item("87").ToString()) = 1 Then
                    otherprojectunderwayorplanned.SelectedValue = 1
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("87").ToString()) = 2 Then
                    otherprojectunderwayorplanned.SelectedValue = 2
                ElseIf ConvertToInteger(ds.Tables(0).Rows(0).Item("87").ToString()) = 3 Then
                    otherprojectunderwayorplanned.SelectedValue = 3
                End If
            End If

            '88
            txtImpactsofphysicalsecurity.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "88", True)

            '89
            txtProposedpotentiallyimpacts.Text = GetprojectEnviroSurveyLinkorComment(strProjId, "89", True)



            Dim a As String
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "SELECT distinct isSubmited FROM ProjectEnviroSurvey where project_fk=" + varId + " order by isSubmited desc"
            command.CommandType = CommandType.Text
            conn.Open()
            Dim reader As SqlDataReader = command.ExecuteReader()
            reader.Read()
            a = reader("isSubmited").ToString
            reader.Close()
            conn.Close()

            If a = True Then
                btnSubmit.Enabled = False
                btnSave.Enabled = False
            End If
            conn.Close()


            'btnSubmit.Enabled = False
            'btnSave.Enabled = False
        End If
    End Function
    Public Function btnSaveInsertOperation(hiddensurvey, answers, link, comment) As Object
        'This is when save is Clicked.
        If answers = Nothing Then
        Else
            Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
            varId = Convert.ToString(Request.QueryString("project_pk"))
            Dim struser As String = lblUserNm.Text
            Using conn As New SqlConnection(connStr)
                Dim com As New SqlCommand With {
                                .Connection = conn,
                                .CommandType = CommandType.StoredProcedure,
                                .CommandText = "AddSurvay"
                }
                com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
                com.Parameters.AddWithValue("@survey_pk", SqlDbType.Int).Value = hiddensurvey
                com.Parameters.AddWithValue("@answer_pk", SqlDbType.Int).Value = answers
                com.Parameters.Add("@link", SqlDbType.VarChar).Value = link
                com.Parameters.Add("@comment", SqlDbType.VarChar).Value = comment
                com.Parameters.Add("@documents", SqlDbType.VarBinary).Value = DBNull.Value
                com.Parameters.Add("@User", SqlDbType.VarChar).Value = struser
                com.Parameters.Add("@isSubmited", SqlDbType.Bit).Value = 0
                conn.Open()
                com.ExecuteNonQuery()
                conn.Close()
            End Using
        End If

    End Function

    Public Function btnSubmitInsertOperation(hiddensurvey, answers, link, comment) As Object
        'This is when Submit is Clicked.
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        varId = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "AddSurvay"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
            com.Parameters.AddWithValue("@survey_pk", SqlDbType.Int).Value = hiddensurvey
            com.Parameters.AddWithValue("@answer_pk", SqlDbType.Int).Value = answers
            com.Parameters.Add("@link", SqlDbType.VarChar).Value = link
            com.Parameters.Add("@comment", SqlDbType.VarChar).Value = comment
            com.Parameters.Add("@documents", SqlDbType.VarBinary).Value = DBNull.Value
            com.Parameters.Add("@User", SqlDbType.VarChar).Value = struser
            com.Parameters.Add("@isSubmited", SqlDbType.Bit).Value = 1
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
        End Using
    End Function
    Public Function btnSubmitInsertOperationforUtilties(hiddensurvey, answers, link, comment) As Object
        'This is when Submit is Clicked.
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        varId = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "AddSurvay"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
            com.Parameters.AddWithValue("@survey_pk", SqlDbType.Int).Value = hiddensurvey
            com.Parameters.AddWithValue("@answer_pk", SqlDbType.Int).Value = answers
            com.Parameters.Add("@link", SqlDbType.VarChar).Value = link
            com.Parameters.Add("@comment", SqlDbType.VarChar).Value = comment
            com.Parameters.Add("@documents", SqlDbType.VarBinary).Value = DBNull.Value
            com.Parameters.Add("@User", SqlDbType.VarChar).Value = struser
            com.Parameters.Add("@isSubmited", SqlDbType.Bit).Value = 1
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()

        End Using
    End Function
    Public Function btnSubmitAddUtilities(utility, estdistance)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim enviropk As String
        Using conn As New SqlConnection(connStr)
            Dim com2 As New SqlCommand With {
                                    .Connection = conn,
                                    .CommandType = CommandType.StoredProcedure,
                                    .CommandText = "GetProjectEnviroPK"
                    }
            com2.Parameters.Add(New SqlParameter("@Surveyfk", 71))
            com2.Parameters.Add(New SqlParameter("@projectfk", varId))
            conn.Open()
            Using sdr As SqlDataReader = com2.ExecuteReader()
                sdr.Read()
                enviropk = sdr("EnviroSurvey_pk").ToString()
            End Using
            conn.Close()
            Dim com3 As New SqlCommand With {
                                .Connection = conn,
                                .CommandType = CommandType.StoredProcedure,
                                .CommandText = "AddUtilities"
                }
            com3.Parameters.AddWithValue("@utilitypk", SqlDbType.Int).Value = utility
            com3.Parameters.AddWithValue("@ProjectEnviroSurvayfk", SqlDbType.Int).Value = enviropk
            com3.Parameters.AddWithValue("@EstDist", SqlDbType.VarChar).Value = estdistance
            conn.Open()
            com3.ExecuteNonQuery()
            conn.Close()
        End Using
    End Function
    Protected Sub btnEnvironmentalSave_Click(sender As Object, e As EventArgs)
        Dim enviropk As String
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        varId = Convert.ToString(Request.QueryString("project_pk"))

        Dim struser As String = lblUserNm.Text
        Using conn As New SqlConnection(connStr)
            Dim com2 As New SqlCommand With {
                                    .Connection = conn,
                                    .CommandType = CommandType.StoredProcedure,
                                    .CommandText = "GetProjectEnviroPK"
                    }
            com2.Parameters.Add(New SqlParameter("@Surveyfk", 71))
            com2.Parameters.Add(New SqlParameter("@projectfk", varId))
            conn.Open()
            Using sdr As SqlDataReader = com2.ExecuteReader()
                sdr.Read()
                'enviropk = sdr("EnviroSurvey_pk").ToString()
                ' conn.Close()
                If sdr.HasRows Then
                    enviropk = sdr("EnviroSurvey_pk").ToString()
                    conn.Close()
                    Dim com As New SqlCommand With {
           .Connection = conn,
           .CommandType = CommandType.Text,
           .CommandText = "delete from projectUtility where ProjectEnviroSurvayID=" + enviropk
}
                    conn.Open()
                    com.ExecuteNonQuery()
                    conn.Close()
                End If
                conn.Close()
            End Using

            Dim com3 As New SqlCommand With {
            .Connection = conn,
            .CommandType = CommandType.StoredProcedure,
            .CommandText = "DeleteSurvey"
}
            com3.Parameters.AddWithValue("@projectid", SqlDbType.Int).Value = varId
            conn.Open()
            com3.ExecuteNonQuery()
            conn.Close()
        End Using



        'hdnSurvey_fk_1 (Is the Project Share Point Accessible to Environmental?)
        btnSaveInsertOperation(hdnSurvey_fk_1.Value, rblsharepointaccessible.SelectedValue, "", "")
        If rblsharepointaccessible.SelectedValue = "1" Then
            'hdnSurvey_fk_49 ---- if yes scenario(Please provide link and access to Envi SME to Project Share Point here)           
            btnSaveInsertOperation(hdnSurvey_fk_49.Value, 1, txtPinNo.Text, "")
        End If
        'hdnSurvey_fk_2(Has this been documented In SEPS coordination With OCFM Regional Office Planners.)     
        btnSaveInsertOperation(hdnSurvey_fk_2.Value, chkseps.SelectedValue, "", "")
        'hdnSurvey_fk_3(Is there a Recent Facility Master Plan?)
        btnSaveInsertOperation(hdnSurvey_fk_3.Value, chkMp.SelectedValue, "", "")
        If chkMp.SelectedValue = "1" Then
            'hdnSurvey_fk_4 ---- if yes scenario(Is the project proposed for an existing site that is consistent with the land use/project in the Master Plan?)
            btnSaveInsertOperation(hdnSurvey_fk_4.Value, chkcnslnd.SelectedValue, "", "")
            'hdnSurvey_fk_5 ---- if yes scenario(If yes to above ,please provide link to Master Plan)
            btnSaveInsertOperation(hdnSurvey_fk_5.Value, 1, txtPinNo2.Text, "")
        End If
        'hdnSurvey_fk_6(Is the Project site consistent with the Market Study (VHA)?)
        btnSaveInsertOperation(hdnSurvey_fk_6.Value, consistentwithmarketstudy.SelectedValue, "", "")
        'hdnSurvey_fk_50(Does the site has an "Outlease" through ORP?)
        btnSaveInsertOperation(hdnSurvey_fk_50.Value, Outleasethroughorp.SelectedValue, "", "")
        'hdnSurvey_fk_51(Who is the ORP PM handling the "Outlease"?)
        btnSaveInsertOperation(hdnSurvey_fk_51.Value, 1, orphandlingpm.Text, "")
        'hdnSurvey_fk_52(What is the expiration date of "Outlease"?  )
        btnSaveInsertOperation(hdnSurvey_fk_52.Value, 1, outleaseexpirationdate.Text, "")
        'hdnSurvey_fk_53(Are there known easements for the site?)
        btnSaveInsertOperation(hdnSurvey_fk_53.Value, knowneasement.SelectedValue, "", "")
        'hdnSurvey_fk_54(Where are the records of easements and who is the responsible ORP PM?)
        If txtOrprecordsofeasement.Text = "" Then
        Else
            btnSaveInsertOperation(hdnSurvey_fk_54.Value, 1, txtOrprecordsofeasement.Text, "")
        End If


        'General Environmental Site Characteristics, Resources, Potential Impacts Start
        'hdnSurvey_fk_90(Please attach a general site map or project boundary map of the proposed project area)
        If dvRealestateaction.Text = "" Then
        Else
            btnSaveInsertOperation(hdnSurvey_fk_90.Value, 1, dvRealestateaction.Text, "")
        End If

        'General Environmental Site Characteristics, Resources, Potential Impacts End

        'Land Use Start
        'hdnSurvey_fk_7(Will the proposed action alter the present land use of the site?)
        btnSaveInsertOperation(hdnSurvey_fk_7.Value, proposedaction.SelectedValue, "", "")
        'hdnSurvey_fk_8(Does the proposed action involve a real estate action (e.g., purchase, lease, easement, permit, or license, disposal)?)
        btnSaveInsertOperation(hdnSurvey_fk_8.Value, pairea.SelectedValue, "", "")
        If pairea.SelectedValue = "1" Then
            'hdnSurvey_fk_9 ---- if yes scenario--  Is ORP leading this effort, whom is the ORP PM - Name, email and phone #     
            btnSaveInsertOperation(hdnSurvey_fk_9.Value, 1, rpeffortchk.Text, "")
            'hdnSurvey_fk_10 ---- if yes scenario-- Require new purchase of additional acres using federal funds? 
            btnSaveInsertOperation(hdnSurvey_fk_10.Value, adnacres.SelectedValue, "", "")
            'hdnSurvey_fk_11 ---- if yes scenario-- Provide size of additional acres needed. 
            btnSaveInsertOperation(hdnSurvey_fk_11.Value, 1, txtSizeofadnacres.Text, "")
            'hdnSurvey_fk_12 ---- if yes scenario--Require a new lease, license, and/or land use permit?
            btnSaveInsertOperation(hdnSurvey_fk_12.Value, requirenew.SelectedValue, "", "")
            'hdnSurvey_fk_13 ---- if yes scenario--Would the action Require an increase of acreage/amendment to an existing lease or license?
            btnSaveInsertOperation(hdnSurvey_fk_13.Value, increaseofacreagechk.SelectedValue, "", "")
            'hdnSurvey_fk_14 ---- if yes scenario-- From a Realestate standpoint will the project replace or dispose of existing federal facilities? 
            btnSaveInsertOperation(hdnSurvey_fk_14.Value, realestatepointchk.SelectedValue, "", "")
        End If
        'hdnSurvey_fk_15(Will the project include procurement or leasing of temporary swing space off campus for staff or functions during the project?)
        btnSaveInsertOperation(hdnSurvey_fk_15.Value, procurmentorleasing.SelectedValue, "", "")
        'hdnSurvey_fk_16(Will any demolition be required as part of the project?)
        btnSaveInsertOperation(hdnSurvey_fk_16.Value, demolition.SelectedValue, "", "")
        If demolition.SelectedValue = "1" Then
            'hdnSurvey_fk_17--- if yes scenario=1(If yes… provide square footage of demolition. )
            btnSaveInsertOperation(hdnSurvey_fk_17.Value, 1, txtSqrfootagedemolition.Text, "")
        End If
        'hdnSurvey_fk_18 Is the construction laydown footprint captured in the project area proposed footprint?
        btnSaveInsertOperation(hdnSurvey_fk_18.Value, footprintcaptured.SelectedValue, "", "")
        'hdnSurvey_fk_19  	Will a parking structure be needed?
        btnSaveInsertOperation(hdnSurvey_fk_19.Value, pkngstructure.SelectedValue, "", "")
        If pkngstructure.SelectedValue = "1" Then
            'hdnSurvey_fk_20---- if yes scenario Is the additional Sq footage and parking structure taken into consideration in the overall project scope?
            btnSaveInsertOperation(hdnSurvey_fk_20.Value, adnsqftgoverallprojectscope.SelectedValue, "", "")
            'hdnSurvey_fk_21---- if no scenario What is the approximate Sq footage of the needed parking structure 
            btnSaveInsertOperation(hdnSurvey_fk_21.Value, 2, txtAppropriatesqfootage.Text, "")
            'hdnSurvey_fk_22---- if no scenario 	What is the project height of parking struture
            btnSaveInsertOperation(hdnSurvey_fk_22.Value, 2, txtProjectheight.Text, "")

        End If
        'Land Use End

        'Site Geology and Soil Suitability Starts
        'hdnSurvey_fk_23(Does the site have a current Environmental Site Assessment (ESA) Phase 1 (within last 2 yrs.)?)
        btnSaveInsertOperation(hdnSurvey_fk_23.Value, envsiteassement.SelectedValue, "", "")
        If envsiteassement.SelectedValue = "1" Then
            'hdnSurvey_fk_24-- if yes 24 Please attach or provide link to report	
            btnSaveInsertOperation(hdnSurvey_fk_24.Value, 1, txtLnktoreport.Text, "")
            'hdnSurvey_fk_25-- if yes --are there any Recognized Environmental Condition (REC) indicated in the Phase I ESA? (Abandoned Tanks, Soil or Water Contamination, Munitions, Landfill)
            btnSaveInsertOperation(hdnSurvey_fk_25.Value, recenvcondition.SelectedValue, "", "")
            'hdnSurvey_fk_26-- if yes  If yes.. Please provide brief description if known
            btnSaveInsertOperation(hdnSurvey_fk_26.Value, 1, txtbriefdscpn.Text, "")
        End If
        'hdnSurvey_fk_27(Have soil borings been conducted  to evaluate sub surface suitability for construction?)
        btnSaveInsertOperation(hdnSurvey_fk_27.Value, subsurfacesuitability.SelectedValue, "", "")
        If subsurfacesuitability.SelectedValue = "1" Then
            'hdnSurvey_fk_28-- if yes-- Please attached or provide link to report
            btnSaveInsertOperation(hdnSurvey_fk_28.Value, 1, txtReportSoil.Text, "")
            'hdnSurvey_fk_29-- if yes If borings were done did it identify high groundwater levels? 
            btnSaveInsertOperation(hdnSurvey_fk_29.Value, highgrndlevels.SelectedValue, "", "")
            'hdnSurvey_fk_30-- if yes Will this effect construction?
            btnSaveInsertOperation(hdnSurvey_fk_30.Value, effectconstruction.SelectedValue, "", "")
            'hdnSurvey_fk_31(Where any known contaminants identified during soil borings or as part of the ESA Phase I that could impact construction or require mitigation prior to  or after construction? )
            btnSaveInsertOperation(hdnSurvey_fk_31.Value, containmentssoil.SelectedValue, "", "")
        End If

        'Site Geology And Soil Suitability Ends

        'Hazardous Material Starts (SurveyType_fk = 6)
        'hdnSurvey_fk_32 Is there any known contamination, munitions or hazardous materials onsite?
        btnSaveInsertOperation(hdnSurvey_fk_32.Value, hazordousmtrl.SelectedValue, "", "")
        If hazordousmtrl.SelectedValue = "1" Then
            'hdnSurvey_fk_33 Is there any documentation of the known limits of potential contamination or hazardous materials buried onsite?
            btnSaveInsertOperation(hdnSurvey_fk_33.Value, dcmntlimits.SelectedValue, "", "")
        End If
        If dcmntlimits.SelectedValue = "1" Then
            btnSaveInsertOperation(hdnSurvey_fk_91.Value, 1, txtlinktocontainmentsdocuments.Text, "")
        End If
        'hdnSurvey_fk_34 As part of the site/building study has there been a full Asbestos (ACM) Lead Based Paint(LBP) analysis of the project area and effected buildings to determine the extent of potential LBP and Asbestos contamination?
        btnSaveInsertOperation(hdnSurvey_fk_34.Value, fullasbestos.SelectedValue, "", "")
        If fullasbestos.SelectedValue = "1" Then
            'hdnSurvey_fk_35-- if yes If yes… please provide copies of all previous LBP and ACM analysis reports for the site or effected buildings. 
            btnSaveInsertOperation(hdnSurvey_fk_35.Value, 1, txtPreviouselbpandacmanalysis.Text, "")
        End If
        'hdnSurvey_fk_36 Are  any known Polychlorinated biphenyls (PCBs) present in any of the buildings on the site that will be impacted as part of the project? (Current generators, elevators, other old oil containing machinery)
        btnSaveInsertOperation(hdnSurvey_fk_36.Value, polychlorinatepiphenyls.SelectedValue, "", "")
        'Hazardous Material Ends

        'Historical and Cultural Starts
        'hdnSurvey_fk_37(Is the facility, building or VA campus 50 yrs. old or is it a National Cemetery? )
        btnSaveInsertOperation(hdnSurvey_fk_37.Value, bldngfiftyyears.SelectedValue, "", "")
        'hdnSurvey_fk_38 Has the facility, building, VA campus or National Cemetery or site been evaluated under the National Historic Preservation Act (NHPA) for listing on the National Register of Historic Places (NRHP)? 
        btnSaveInsertOperation(hdnSurvey_fk_38.Value, nhpaevaluation.SelectedValue, "", "")
        'hdnSurvey_fk_39(Is the site listed on the Historic Register?)
        btnSaveInsertOperation(hdnSurvey_fk_39.Value, lstedhistoricregister.SelectedValue, "", "")
        If lstedhistoricregister.SelectedValue = "1" Then
            'hdnSurvey_fk_40- if yes scenario  If yes.. are there any historic or archeological site reports available for the current project or for past projects at the site?
            btnSaveInsertOperation(hdnSurvey_fk_40.Value, hsitoricarcheolgical.SelectedValue, "", "")
            'hdnSurvey_fk_41- if yes scenario If yes… please provide a link to the reports or attach past reports.
            btnSaveInsertOperation(hdnSurvey_fk_41.Value, 1, txtLinktopastreports.Text, "")
            'hdnSurvey_fk_42- if yes scenario If yes, Is there a preservation plan for the property?
            btnSaveInsertOperation(hdnSurvey_fk_42.Value, preservationplan.SelectedValue, "", "")
            'hdnSurvey_fk_43- if yes scenario If yes… please provide a link to the preservation plan. 
            btnSaveInsertOperation(hdnSurvey_fk_43.Value, 1, txtLinktopreservationplan.Text, "")
        End If
        'hdnSurvey_fk_44 Are there any existing NHPA agreements in effect for the property (see: achp.gov/va) or Native American Graves Protection and Repatriation Act (NAGPRA) Plans of Action or Agreements?
        btnSaveInsertOperation(hdnSurvey_fk_44.Value, exstnhpaagreement.SelectedValue, "", "")
        If exstnhpaagreement.SelectedValue = "1" Then
            'hdnSurvey_fk_45- if yes If yes… please provide a link to any agreements. 
            btnSaveInsertOperation(hdnSurvey_fk_45.Value, 1, Txtlnktoanyagreement.Text, "")
        End If
        'hdnSurvey_fk_46(Does the facility have existing relationships with likely consulting parties (i.e. State Historic Preservation Office (SHPO), local government, Tribes)?)
        btnSaveInsertOperation(hdnSurvey_fk_46.Value, exstrelnwithconsuparties.SelectedValue, "", "")
        If exstrelnwithconsuparties.SelectedValue = "1" Then
            'hdnSurvey_fk_47- if yes scenario If yes… are there any annual reports requirements?
            btnSaveInsertOperation(hdnSurvey_fk_47.Value, lnktoannualrptsreuirement.SelectedValue, "", "")
            'hdnSurvey_fk_48- if yes scenario If yes please provide latest annual report?
            btnSaveInsertOperation(hdnSurvey_fk_48.Value, 1, Txtlinktolatestannualreports.Text, "")
        End If
        'Historical and Cultural Ends


        'Natural Resources Start (Survey Type_fk = 8)
        'hdnSurvey_fk_55(Will the proposed action alter, destroy, or significantly impact environmentally sensitive areas (wetlands and/or existing fish or wildlife habitat, coastal zones, flood plains))   
        btnSaveInsertOperation(hdnSurvey_fk_55.Value, envsensitive.SelectedValue, "", "")
        'hdnSurvey_fk_56(Are there any known state or federal listed threatened or endangered species on this site?)
        btnSaveInsertOperation(hdnSurvey_fk_56.Value, stateorfederalthreatened.SelectedValue, "", "")
        If stateorfederalthreatened.SelectedValue = "1" Then
            'hdnSurvey_fk_57- if yes scenario If yes, are any previous reports available?
            btnSaveInsertOperation(hdnSurvey_fk_57.Value, stateorfederalthreatenedprevreport.SelectedValue, "", "")
            'hdnSurvey_fk_58- if yes scenario Please provide link or attach ESA report
            btnSaveInsertOperation(hdnSurvey_fk_58.Value, 1, Txtlnktoattachesarpt.Text, "")
        End If
        'hdnSurvey_fk_59(Does the Site fall within the FEMA 100 yr. Floodplain? )
        btnSaveInsertOperation(hdnSurvey_fk_59.Value, femafloodplain.SelectedValue, "", "")
        If femafloodplain.SelectedValue = "1" Then
            'hdnSurvey_fk_60- if yes scenario  If yes,How much of the project falls  within the  100 yr. floodplain?
            btnSaveInsertOperation(hdnSurvey_fk_60.Value, 1, Txtpercentageinfloodplain.Text, "")
        End If
        'hdnSurvey_fk_61 Are there known or mapped wetlands on site?
        btnSaveInsertOperation(hdnSurvey_fk_61.Value, knownormappedwetlands.SelectedValue, "", "")
        If knownormappedwetlands.SelectedValue = "1" Then
            'hdnSurvey_fk_62- if yes scenario--If yes. Are wetland likely to be impacted as a result of the project?
            btnSaveInsertOperation(hdnSurvey_fk_62.Value, wetlandimpacted.SelectedValue, "", "")
            'hdnSurvey_fk_63- if yes scenario  If yes… is it anticipated that a Wetlands permit will be required at the State or Federal level for the project?
            btnSaveInsertOperation(hdnSurvey_fk_63.Value, anticpatedwetlandspermit.SelectedValue, "", "")
            'hdnSurvey_fk_64- if yes scenario  Is there existing wetland permits or agreement for the development of this site? 
            btnSaveInsertOperation(hdnSurvey_fk_64.Value, exstwetlandpermitsoragreement.SelectedValue, "", "")
            'hdnSurvey_fk_65- if yes scenario  	Please provide exciting permit or agreement.
            btnSaveInsertOperation(hdnSurvey_fk_65.Value, 1, txtwetlandsexcitingpermits.Text, "")
        End If
        'Natural Resources End

        'Stormwater and Coastal Zone Starts (SurveyType_fk =9)
        'hdnSurvey_fk_66 Are current Stormwater (SW) Facilities on site adequate to handle additional flow? 
        btnSaveInsertOperation(hdnSurvey_fk_66.Value, currentstormwateradequate.SelectedValue, "", "")
        'hdnSurvey_fk_67 Will the site be able to handle the 24 hr. retention of SW associated with the change in impervious surface? 
        btnSaveInsertOperation(hdnSurvey_fk_67.Value, retentionofsw.SelectedValue, "", "")
        'hdnSurvey_fk_68 Does the project fall within 1000 ft of the Coastal Zone ( Coastline)or tidal waters?
        btnSaveInsertOperation(hdnSurvey_fk_68.Value, fallcoastalzone.SelectedValue, "", "")
        'Stormwater and Coastal Zone Ends


        'Utilities Start
        'answersurveyfk_70 	Are there sufficient utilities (with capacity) to support the proposed project on site? Only answer yes, if it is known that all utilities have sufficent capacity 
        btnSaveInsertOperation(hdnSurvey_fk_70.Value, sufficesntutilities.SelectedValue, "", "")
        'answersurveyfk_71 Please inidcate which utilities could require modifications or changes to support the project.
        ' Dim answer_71 As String = Request.Form("sufficesntutilities")
        If chkElectrical.Checked Then
            btnSaveInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        ElseIf chkSanitarysewer.Checked Then
            btnSaveInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        ElseIf chkStormsewer.Checked Then
            btnSaveInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        ElseIf chkSteam.Checked Then
            btnSaveInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        ElseIf chkPortablewater.Checked Then
            btnSaveInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        ElseIf chkChilledWater.Checked Then
            btnSaveInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        ElseIf chkNaturalgas.Checked Then
            btnSaveInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        ElseIf chkRelaimedwater.Checked Then
            btnSaveInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        End If

        If chkElectrical.Checked Then
            btnSubmitAddUtilities(hdnElectricalfk_1.Value, txtElectrical.Text)
        End If
        If chkSanitarysewer.Checked Then
            btnSubmitAddUtilities(hdnSanitarySewerfk_2.Value, txtSanitarysewer.Text)
        End If
        If chkStormsewer.Checked Then
            btnSubmitAddUtilities(hdnstormwaterfk_3.Value, txtStormsewer.Text)
        End If
        If chkSteam.Checked Then
            btnSubmitAddUtilities(hdnSteamfk_4.Value, txtSteam.Text)
        End If
        If chkPortablewater.Checked Then
            btnSubmitAddUtilities(hdnPoratbalewaterfk_5.Value, txtPortablewater.Text)
        End If
        If chkChilledWater.Checked Then
            btnSubmitAddUtilities(hdnChilledwaterfk_6.Value, txtChilledwater.Text)
        End If
        If chkNaturalgas.Checked Then
            btnSubmitAddUtilities(hdnNaturalgasfk_7.Value, txtNaturalgas.Text)
        End If
        If chkRelaimedwater.Checked Then
            btnSubmitAddUtilities(hdnReclaimedwaterfk_8.Value, txtReclaimedwatersource.Text)
        End If


        'answersurveyfk_72 If there is not sufficent capacity , will the project require utilities to be brought in from off site? 

        If utilitiestobebroughtfrmsite.SelectedValue = "" Then
        Else
            btnSaveInsertOperation(hdnSurvey_fk_72.Value, utilitiestobebroughtfrmsite.SelectedValue, "", "")
        End If

        'answersurveyfk_73 Please indicate estimated distance for each needed utility. 

        'answersurveyfk_74 	Is proposed routing of utilities known?

        If proposedroutingofutilities.SelectedValue = "" Then
        Else
            btnSaveInsertOperation(hdnSurvey_fk_74.Value, proposedroutingofutilities.SelectedValue, "", "")
        End If
        'answersurveyfk_75 	Are there any overhead utilities, underground utilities or easements that would need to be evaluated as part of the developability of the site? 
        btnSaveInsertOperation(hdnSurvey_fk_75.Value, utilitiesevaluationofsite.SelectedValue, "", "")
        'Utilities End

        'Traffic Starts (SurveyType_fk = 11)
        'hdnSurvey_fk_76 Are there known traffic issues in the immediate area?
        btnSaveInsertOperation(hdnSurvey_fk_76.Value, trafficissue.SelectedValue, "", "")
        'hdnSurvey_fk_77(	Will the project impact traffic and site access during construction or during operation?)
        btnSaveInsertOperation(hdnSurvey_fk_77.Value, impacttrafficsiteaccess.SelectedValue, "", "")
        If impacttrafficsiteaccess.SelectedValue = "1" Then
            'hdnSurvey_fk_78- if yes scenario If yes …. Will traffic impacts be limited only during construction? 
            btnSaveInsertOperation(hdnSurvey_fk_78.Value, trafficimpactsduringconstn.SelectedValue, "", "")
            'hdnSurvey_fk_80- if yes/no both scenario  Please provide link or attached previously completed traffic study
            btnSaveInsertOperation(hdnSurvey_fk_80.Value, 1, txtProvidelnkotrafficstudy.Text, "")
        ElseIf impacttrafficsiteaccess.SelectedValue = "2" Then
            'hdnSurvey_fk_79- if no scenario  If no…. Has a traffic study been completed for after construction/ during operation of the facility and traffic Level of Service(LOS)
            btnSaveInsertOperation(hdnSurvey_fk_79.Value, trafficstudycompleted.SelectedValue, "", "")
            'hdnSurvey_fk_80- if yes/no both scenario  Please provide link or attached previously completed traffic study
            btnSaveInsertOperation(hdnSurvey_fk_80.Value, 2, txtProvidelnkotrafficstudy.Text, "")
        End If
        'hdnSurvey_fk_81 Is there mass transit in close proximity which could be utilized to alleviate traffic impacts? 
        btnSaveInsertOperation(hdnSurvey_fk_81.Value, masstransitcloseproximity.SelectedValue, "", "")
        'Traffic Ends

        'NEPA, PREVIOUS COMPLETED DOCUMENTS, EA), EIS Start (Surveyfk_type= 12)
        'hdnSurvey_fk_82 Has an previous NEPA EA or EIS  been completed for the project? 
        btnSaveInsertOperation(hdnSurvey_fk_82.Value, previousnepaeaoreis.SelectedValue, "", "")
        If previousnepaeaoreis.SelectedValue = "1" Then
            'hdnSurvey_fk_83- if yes scenario If yes… is there a Final EA and signed Finding of No Significant Impact (FONSI) for the project? 
            btnSaveInsertOperation(hdnSurvey_fk_83.Value, finaleasignedfonsi.SelectedValue, "", "")
            'hdnSurvey_fk_84- if yes scenario Please provide link or attach copy of previous NEPA EA or EIS and signed FONSI. 
            btnSaveInsertOperation(hdnSurvey_fk_84.Value, 1, txtpreviousnepaeaoreis.Text, "")
        End If
        'hdnSurvey_fk_85 Does the site have any previously completed NEPA documents for past projects that are available? (This can help to frame the potential resource areas or concern) 
        btnSaveInsertOperation(hdnSurvey_fk_85.Value, prevcomplnepadocnavailable.SelectedValue, "", "")
        If prevcomplnepadocnavailable.SelectedValue = "1" Then
            'hdnSurvey_fk_86- if yes secenario If yes.. Please provide site POC for past NEPA documentation  or attach past NEPA documentation 
            btnSaveInsertOperation(hdnSurvey_fk_86.Value, 1, txtLnksitepocpastnepadocn.Text, "")
        End If
        'hdnSurvey_fk_87 Are there other projects underway or planned for the near term at the property (Minors)?
        btnSaveInsertOperation(hdnSurvey_fk_87.Value, otherprojectunderwayorplanned.SelectedValue, "", "")
        'NEPA, PREVIOUS COMPLETED DOCUMENTS, EA), EIS End

        'Physical Security Starts (SurveyType_fk=13)
        'hdnSurvey_fk_88
        If txtImpactsofphysicalsecurity.Text = "" Then
        Else
            btnSaveInsertOperation(hdnSurvey_fk_88.Value, 1, txtImpactsofphysicalsecurity.Text, "")
        End If

        'hdnSurvey_fk_89
        If txtImpactsofphysicalsecurity.Text = "" Then
        Else
            btnSaveInsertOperation(hdnSurvey_fk_89.Value, 1, txtProposedpotentiallyimpacts.Text, "")
        End If

        'Physical Security End

        '        SendNotificationToEnvProjectInitiationSubmittedFormRecipient()

        ScriptManager.RegisterClientScriptBlock(Me, [GetType](), "Message", "SaveAlertMsg('Records Saved Successfully.');", True)
        'Dim message As String = "If Critical, you MUST provide a reason."
        'Dim script As String = "<script type='text/javascript'> alert(" + message + ");</script>"

        'ClientScript.RegisterClientScriptBlock(Me.GetType(), "AlertBox", script)
        'Dim Script As String = "alert('abc');"
        'ClientScript.RegisterClientScriptBlock([GetType](), "Alert", Script, True)
    End Sub
    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs)
        Dim enviropk As String
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        varId = Convert.ToString(Request.QueryString("project_pk"))

        Dim struser As String = lblUserNm.Text

        'if there's no project manager, make the submitter as the project manager
        AddPMinProjectEnvironmental()


        Using conn As New SqlConnection(connStr)
            Dim com2 As New SqlCommand With {
                                    .Connection = conn,
                                    .CommandType = CommandType.StoredProcedure,
                                    .CommandText = "GetProjectEnviroPK"
                    }
            com2.Parameters.Add(New SqlParameter("@Surveyfk", 71))
            com2.Parameters.Add(New SqlParameter("@projectfk", varId))
            conn.Open()
            Using sdr As SqlDataReader = com2.ExecuteReader()
                sdr.Read()
                'enviropk = sdr("EnviroSurvey_pk").ToString()
                ' conn.Close()
                If sdr.HasRows Then
                    enviropk = sdr("EnviroSurvey_pk").ToString()
                    conn.Close()
                    Dim com As New SqlCommand With {
           .Connection = conn,
           .CommandType = CommandType.Text,
           .CommandText = "delete from projectUtility where ProjectEnviroSurvayID=" + enviropk
}
                    conn.Open()
                    com.ExecuteNonQuery()
                    conn.Close()
                End If
                conn.Close()
            End Using

            Dim com3 As New SqlCommand With {
            .Connection = conn,
            .CommandType = CommandType.StoredProcedure,
            .CommandText = "DeleteSurvey"
}
            com3.Parameters.AddWithValue("@projectid", SqlDbType.Int).Value = varId
            conn.Open()
            com3.ExecuteNonQuery()
            conn.Close()
        End Using


        'hdnSurvey_fk_1 (Is the Project Share Point Accessible to Environmental?)
        btnSubmitInsertOperation(hdnSurvey_fk_1.Value, rblsharepointaccessible.SelectedValue, "", "")
        If rblsharepointaccessible.SelectedValue = "1" Then
            'hdnSurvey_fk_49 ---- if yes scenario(Please provide link and access to Envi SME to Project Share Point here)           
            btnSubmitInsertOperation(hdnSurvey_fk_49.Value, 1, txtPinNo.Text, "")
        End If
        'hdnSurvey_fk_2(Has this been documented In SEPS coordination With OCFM Regional Office Planners.)     
        btnSubmitInsertOperation(hdnSurvey_fk_2.Value, chkseps.SelectedValue, "", "")
        'hdnSurvey_fk_3(Is there a Recent Facility Master Plan?)
        btnSubmitInsertOperation(hdnSurvey_fk_3.Value, chkMp.SelectedValue, "", "")
        If chkMp.SelectedValue = "1" Then
            'hdnSurvey_fk_4 ---- if yes scenario(Is the project proposed for an existing site that is consistent with the land use/project in the Master Plan?)
            btnSubmitInsertOperation(hdnSurvey_fk_4.Value, chkcnslnd.SelectedValue, "", "")
            'hdnSurvey_fk_5 ---- if yes scenario(If yes to above ,please provide link to Master Plan)
            btnSubmitInsertOperation(hdnSurvey_fk_5.Value, 1, txtPinNo2.Text, "")
        End If
        'hdnSurvey_fk_6(Is the Project site consistent with the Market Study (VHA)?)
        btnSubmitInsertOperation(hdnSurvey_fk_6.Value, consistentwithmarketstudy.SelectedValue, "", "")
        'hdnSurvey_fk_50(Does the site has an "Outlease" through ORP?)
        btnSubmitInsertOperation(hdnSurvey_fk_50.Value, Outleasethroughorp.SelectedValue, "", "")
        'hdnSurvey_fk_51(Who is the ORP PM handling the "Outlease"?)
        btnSubmitInsertOperation(hdnSurvey_fk_51.Value, 1, orphandlingpm.Text, "")
        'hdnSurvey_fk_52(What is the expiration date of "Outlease"?  )
        btnSubmitInsertOperation(hdnSurvey_fk_52.Value, 1, outleaseexpirationdate.Text, "")
        'hdnSurvey_fk_53(Are there known easements for the site?)
        btnSubmitInsertOperation(hdnSurvey_fk_53.Value, knowneasement.SelectedValue, "", "")
        'hdnSurvey_fk_54(Where are the records of easements and who is the responsible ORP PM?)
        btnSubmitInsertOperation(hdnSurvey_fk_54.Value, 1, txtOrprecordsofeasement.Text, "")

        'General Environmental Site Characteristics, Resources, Potential Impacts Start
        'hdnSurvey_fk_90(Please attach a general site map or project boundary map of the proposed project area)
        btnSubmitInsertOperation(hdnSurvey_fk_90.Value, 1, dvRealestateaction.Text, "")
        'General Environmental Site Characteristics, Resources, Potential Impacts End

        'Land Use Start
        'hdnSurvey_fk_7(Will the proposed action alter the present land use of the site?)
        btnSubmitInsertOperation(hdnSurvey_fk_7.Value, proposedaction.SelectedValue, "", "")
        'hdnSurvey_fk_8(Does the proposed action involve a real estate action (e.g., purchase, lease, easement, permit, or license, disposal)?)
        btnSubmitInsertOperation(hdnSurvey_fk_8.Value, pairea.SelectedValue, "", "")
        If pairea.SelectedValue = "1" Then
            'hdnSurvey_fk_9 ---- if yes scenario--  Is ORP leading this effort, whom is the ORP PM - Name, email and phone #     
            btnSubmitInsertOperation(hdnSurvey_fk_9.Value, 1, rpeffortchk.Text, "")
            'hdnSurvey_fk_10 ---- if yes scenario-- Require new purchase of additional acres using federal funds? 
            btnSubmitInsertOperation(hdnSurvey_fk_10.Value, adnacres.SelectedValue, "", "")
            'hdnSurvey_fk_11 ---- if yes scenario-- Provide size of additional acres needed. 
            btnSubmitInsertOperation(hdnSurvey_fk_11.Value, 1, txtSizeofadnacres.Text, "")
            'hdnSurvey_fk_12 ---- if yes scenario--Require a new lease, license, and/or land use permit?
            btnSubmitInsertOperation(hdnSurvey_fk_12.Value, requirenew.SelectedValue, "", "")
            'hdnSurvey_fk_13 ---- if yes scenario--Would the action Require an increase of acreage/amendment to an existing lease or license?
            btnSubmitInsertOperation(hdnSurvey_fk_13.Value, increaseofacreagechk.SelectedValue, "", "")
            'hdnSurvey_fk_14 ---- if yes scenario-- From a Realestate standpoint will the project replace or dispose of existing federal facilities? 
            btnSubmitInsertOperation(hdnSurvey_fk_14.Value, realestatepointchk.SelectedValue, "", "")
        End If
        'hdnSurvey_fk_15(Will the project include procurement or leasing of temporary swing space off campus for staff or functions during the project?)
        btnSubmitInsertOperation(hdnSurvey_fk_15.Value, procurmentorleasing.SelectedValue, "", "")
        'hdnSurvey_fk_16(Will any demolition be required as part of the project?)
        btnSubmitInsertOperation(hdnSurvey_fk_16.Value, demolition.SelectedValue, "", "")
        If demolition.SelectedValue = "1" Then
            'hdnSurvey_fk_17--- if yes scenario=1(If yes… provide square footage of demolition. )
            btnSubmitInsertOperation(hdnSurvey_fk_17.Value, 1, txtSqrfootagedemolition.Text, "")
        End If
        'hdnSurvey_fk_18 Is the construction laydown footprint captured in the project area proposed footprint?
        btnSubmitInsertOperation(hdnSurvey_fk_18.Value, footprintcaptured.SelectedValue, "", "")
        'hdnSurvey_fk_19  	Will a parking structure be needed?
        btnSubmitInsertOperation(hdnSurvey_fk_19.Value, pkngstructure.SelectedValue, "", "")
        If pkngstructure.SelectedValue = "1" Then
            'hdnSurvey_fk_20---- if yes scenario Is the additional Sq footage and parking structure taken into consideration in the overall project scope?
            btnSubmitInsertOperation(hdnSurvey_fk_20.Value, 1, adnsqftgoverallprojectscope.SelectedValue, "")
            'hdnSurvey_fk_21---- if no scenario What is the approximate Sq footage of the needed parking structure 
            btnSubmitInsertOperation(hdnSurvey_fk_21.Value, 2, txtAppropriatesqfootage.Text, "")
            'hdnSurvey_fk_22---- if no scenario 	What is the project height of parking struture
            btnSubmitInsertOperation(hdnSurvey_fk_22.Value, 2, txtProjectheight.Text, "")
        End If
        'Land Use End

        'Site Geology and Soil Suitability Starts
        'hdnSurvey_fk_23(Does the site have a current Environmental Site Assessment (ESA) Phase 1 (within last 2 yrs.)?)
        btnSubmitInsertOperation(hdnSurvey_fk_23.Value, envsiteassement.SelectedValue, "", "")
        If envsiteassement.SelectedValue = "1" Then
            'hdnSurvey_fk_24-- if yes 24 Please attach or provide link to report	
            btnSubmitInsertOperation(hdnSurvey_fk_24.Value, 1, txtLnktoreport.Text, "")
            'hdnSurvey_fk_25-- if yes --are there any Recognized Environmental Condition (REC) indicated in the Phase I ESA? (Abandoned Tanks, Soil or Water Contamination, Munitions, Landfill)
            btnSubmitInsertOperation(hdnSurvey_fk_25.Value, recenvcondition.SelectedValue, "", "")
            'hdnSurvey_fk_26-- if yes  If yes.. Please provide brief description if known
            btnSubmitInsertOperation(hdnSurvey_fk_26.Value, 1, txtbriefdscpn.Text, "")
        End If
        'hdnSurvey_fk_27(Have soil borings been conducted  to evaluate sub surface suitability for construction?)
        btnSubmitInsertOperation(hdnSurvey_fk_27.Value, subsurfacesuitability.SelectedValue, "", "")
        If subsurfacesuitability.SelectedValue = "1" Then
            'hdnSurvey_fk_28-- if yes-- Please attached or provide link to report
            btnSubmitInsertOperation(hdnSurvey_fk_28.Value, 1, txtReportSoil.Text, "")
            'hdnSurvey_fk_29-- if yes If borings were done did it identify high groundwater levels? 
            btnSubmitInsertOperation(hdnSurvey_fk_29.Value, highgrndlevels.SelectedValue, "", "")
            'hdnSurvey_fk_30-- if yes Will this effect construction?
            btnSubmitInsertOperation(hdnSurvey_fk_30.Value, effectconstruction.SelectedValue, "", "")
            'hdnSurvey_fk_31(Where any known contaminants identified during soil borings or as part of the ESA Phase I that could impact construction or require mitigation prior to  or after construction? )
            btnSubmitInsertOperation(hdnSurvey_fk_31.Value, containmentssoil.SelectedValue, "", "")
        End If

        'Site Geology And Soil Suitability Ends

        'Hazardous Material Starts (SurveyType_fk = 6)
        btnSaveInsertOperation(hdnSurvey_fk_32.Value, hazordousmtrl.SelectedValue, "", "")
        If hazordousmtrl.SelectedValue = "1" Then
            'hdnSurvey_fk_33 Is there any documentation of the known limits of potential contamination or hazardous materials buried onsite?
            btnSaveInsertOperation(hdnSurvey_fk_33.Value, dcmntlimits.SelectedValue, "", "")
        End If
        If dcmntlimits.SelectedValue = "1" Then
            btnSaveInsertOperation(hdnSurvey_fk_91.Value, 1, txtlinktocontainmentsdocuments.Text, "")
        End If


        'hdnSurvey_fk_34 As part of the site/building study has there been a full Asbestos (ACM) Lead Based Paint(LBP) analysis of the project area and effected buildings to determine the extent of potential LBP and Asbestos contamination?
        btnSubmitInsertOperation(hdnSurvey_fk_34.Value, fullasbestos.SelectedValue, "", "")
        If fullasbestos.SelectedValue = "1" Then
            'hdnSurvey_fk_35-- if yes If yes… please provide copies of all previous LBP and ACM analysis reports for the site or effected buildings. 
            btnSubmitInsertOperation(hdnSurvey_fk_35.Value, 1, txtPreviouselbpandacmanalysis.Text, "")
        End If
        'hdnSurvey_fk_36 Are  any known Polychlorinated biphenyls (PCBs) present in any of the buildings on the site that will be impacted as part of the project? (Current generators, elevators, other old oil containing machinery)
        btnSubmitInsertOperation(hdnSurvey_fk_36.Value, polychlorinatepiphenyls.SelectedValue, "", "")
        'Hazardous Material Ends

        'Historical and Cultural Starts
        'hdnSurvey_fk_37(Is the facility, building or VA campus 50 yrs. old or is it a National Cemetery? )
        btnSubmitInsertOperation(hdnSurvey_fk_37.Value, bldngfiftyyears.SelectedValue, "", "")
        'hdnSurvey_fk_38 Has the facility, building, VA campus or National Cemetery or site been evaluated under the National Historic Preservation Act (NHPA) for listing on the National Register of Historic Places (NRHP)? 
        btnSubmitInsertOperation(hdnSurvey_fk_38.Value, nhpaevaluation.SelectedValue, "", "")
        'hdnSurvey_fk_39(Is the site listed on the Historic Register?)
        btnSubmitInsertOperation(hdnSurvey_fk_39.Value, lstedhistoricregister.SelectedValue, "", "")
        If lstedhistoricregister.SelectedValue = "1" Then
            'hdnSurvey_fk_40- if yes scenario  If yes.. are there any historic or archeological site reports available for the current project or for past projects at the site?
            btnSubmitInsertOperation(hdnSurvey_fk_40.Value, hsitoricarcheolgical.SelectedValue, "", "")
            'hdnSurvey_fk_41- if yes scenario If yes… please provide a link to the reports or attach past reports.
            btnSubmitInsertOperation(hdnSurvey_fk_41.Value, 1, txtLinktopastreports.Text, "")
            'hdnSurvey_fk_42- if yes scenario If yes, Is there a preservation plan for the property?
            btnSubmitInsertOperation(hdnSurvey_fk_42.Value, preservationplan.SelectedValue, "", "")
            'hdnSurvey_fk_43- if yes scenario If yes… please provide a link to the preservation plan. 
            btnSubmitInsertOperation(hdnSurvey_fk_43.Value, 1, txtLinktopreservationplan.Text, "")
        End If
        'hdnSurvey_fk_44 Are there any existing NHPA agreements in effect for the property (see: achp.gov/va) or Native American Graves Protection and Repatriation Act (NAGPRA) Plans of Action or Agreements?
        btnSubmitInsertOperation(hdnSurvey_fk_44.Value, exstnhpaagreement.SelectedValue, "", "")
        If exstnhpaagreement.SelectedValue = "1" Then
            'hdnSurvey_fk_45- if yes If yes… please provide a link to any agreements. 
            btnSubmitInsertOperation(hdnSurvey_fk_45.Value, 1, Txtlnktoanyagreement.Text, "")
        End If
        'hdnSurvey_fk_46(Does the facility have existing relationships with likely consulting parties (i.e. State Historic Preservation Office (SHPO), local government, Tribes)?)
        btnSubmitInsertOperation(hdnSurvey_fk_46.Value, exstrelnwithconsuparties.SelectedValue, "", "")
        If exstrelnwithconsuparties.SelectedValue = "1" Then
            'hdnSurvey_fk_47- if yes scenario If yes… are there any annual reports requirements?
            btnSubmitInsertOperation(hdnSurvey_fk_47.Value, lnktoannualrptsreuirement.SelectedValue, "", "")
            'hdnSurvey_fk_48- if yes scenario If yes please provide latest annual report?
            btnSubmitInsertOperation(hdnSurvey_fk_48.Value, 1, Txtlinktolatestannualreports.Text, "")
        End If
        'Historical and Cultural Ends


        'Natural Resources Start (Survey Type_fk = 8)
        'hdnSurvey_fk_55(Will the proposed action alter, destroy, or significantly impact environmentally sensitive areas (wetlands and/or existing fish or wildlife habitat, coastal zones, flood plains))   
        btnSubmitInsertOperation(hdnSurvey_fk_55.Value, envsensitive.SelectedValue, "", "")
        'hdnSurvey_fk_56(Are there any known state or federal listed threatened or endangered species on this site?)
        btnSubmitInsertOperation(hdnSurvey_fk_56.Value, stateorfederalthreatened.SelectedValue, "", "")
        If stateorfederalthreatened.SelectedValue = "1" Then
            'hdnSurvey_fk_57- if yes scenario If yes, are any previous reports available?
            btnSubmitInsertOperation(hdnSurvey_fk_57.Value, stateorfederalthreatenedprevreport.SelectedValue, "", "")
            'hdnSurvey_fk_58- if yes scenario Please provide link or attach ESA report
            btnSubmitInsertOperation(hdnSurvey_fk_58.Value, 1, Txtlnktoattachesarpt.Text, "")
        End If
        'hdnSurvey_fk_59(Does the Site fall within the FEMA 100 yr. Floodplain? )
        btnSubmitInsertOperation(hdnSurvey_fk_59.Value, femafloodplain.SelectedValue, "", "")
        If femafloodplain.SelectedValue = "1" Then
            'hdnSurvey_fk_60- if yes scenario  If yes,How much of the project falls  within the  100 yr. floodplain?
            btnSubmitInsertOperation(hdnSurvey_fk_60.Value, 1, Txtpercentageinfloodplain.Text, "")
        End If
        'hdnSurvey_fk_61 Are there known or mapped wetlands on site?
        btnSubmitInsertOperation(hdnSurvey_fk_61.Value, knownormappedwetlands.SelectedValue, "", "")
        If knownormappedwetlands.SelectedValue = "1" Then
            'hdnSurvey_fk_62- if yes scenario--If yes. Are wetland likely to be impacted as a result of the project?
            btnSubmitInsertOperation(hdnSurvey_fk_62.Value, wetlandimpacted.SelectedValue, "", "")
            'hdnSurvey_fk_63- if yes scenario  If yes… is it anticipated that a Wetlands permit will be required at the State or Federal level for the project?
            btnSubmitInsertOperation(hdnSurvey_fk_63.Value, anticpatedwetlandspermit.SelectedValue, "", "")
            'hdnSurvey_fk_64- if yes scenario  Is there existing wetland permits or agreement for the development of this site? 
            btnSubmitInsertOperation(hdnSurvey_fk_64.Value, exstwetlandpermitsoragreement.SelectedValue, "", "")
            'hdnSurvey_fk_65- if yes scenario  	Please provide exciting permit or agreement.
            btnSubmitInsertOperation(hdnSurvey_fk_65.Value, 1, txtwetlandsexcitingpermits.Text, "")
        End If
        'Natural Resources End

        'Stormwater and Coastal Zone Starts (SurveyType_fk =9)
        'hdnSurvey_fk_66 Are current Stormwater (SW) Facilities on site adequate to handle additional flow? 
        btnSubmitInsertOperation(hdnSurvey_fk_66.Value, currentstormwateradequate.SelectedValue, "", "")
        'hdnSurvey_fk_67 Will the site be able to handle the 24 hr. retention of SW associated with the change in impervious surface? 
        btnSubmitInsertOperation(hdnSurvey_fk_67.Value, retentionofsw.SelectedValue, "", "")
        'hdnSurvey_fk_68 Does the project fall within 1000 ft of the Coastal Zone ( Coastline)or tidal waters?
        btnSubmitInsertOperation(hdnSurvey_fk_68.Value, fallcoastalzone.SelectedValue, "", "")
        'Stormwater and Coastal Zone Ends


        'Utilities Start
        'answersurveyfk_70 	Are there sufficient utilities (with capacity) to support the proposed project on site? Only answer yes, if it is known that all utilities have sufficent capacity 
        btnSubmitInsertOperation(hdnSurvey_fk_70.Value, sufficesntutilities.SelectedValue, "", "")
        'answersurveyfk_71 Please inidcate which utilities could require modifications or changes to support the project.
        ' Dim answer_71 As String = Request.Form("sufficesntutilities")
        If chkElectrical.Checked Then
            btnSubmitInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        ElseIf chkSanitarysewer.Checked Then
            btnSubmitInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        ElseIf chkStormsewer.Checked Then
            btnSubmitInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        ElseIf chkSteam.Checked Then
            btnSubmitInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        ElseIf chkPortablewater.Checked Then
            btnSubmitInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        ElseIf chkChilledWater.Checked Then
            btnSubmitInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        ElseIf chkNaturalgas.Checked Then
            btnSubmitInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        ElseIf chkRelaimedwater.Checked Then
            btnSubmitInsertOperation(hdnSurvey_fk_71.Value, 1, "", "")
        End If

        If chkElectrical.Checked Then
            btnSubmitAddUtilities(hdnElectricalfk_1.Value, txtElectrical.Text)
        End If
        If chkSanitarysewer.Checked Then
            btnSubmitAddUtilities(hdnSanitarySewerfk_2.Value, txtSanitarysewer.Text)
        End If
        If chkStormsewer.Checked Then
            btnSubmitAddUtilities(hdnstormwaterfk_3.Value, txtStormsewer.Text)
        End If
        If chkSteam.Checked Then
            btnSubmitAddUtilities(hdnSteamfk_4.Value, txtSteam.Text)
        End If
        If chkPortablewater.Checked Then
            btnSubmitAddUtilities(hdnPoratbalewaterfk_5.Value, txtPortablewater.Text)
        End If
        If chkChilledWater.Checked Then
            btnSubmitAddUtilities(hdnChilledwaterfk_6.Value, txtChilledwater.Text)
        End If
        If chkNaturalgas.Checked Then
            btnSubmitAddUtilities(hdnNaturalgasfk_7.Value, txtNaturalgas.Text)
        End If
        If chkRelaimedwater.Checked Then
            btnSubmitAddUtilities(hdnReclaimedwaterfk_8.Value, txtReclaimedwatersource.Text)
        End If


        'answersurveyfk_72 If there is not sufficent capacity , will the project require utilities to be brought in from off site? 

        If utilitiestobebroughtfrmsite.SelectedValue = "" Then
        Else
            btnSubmitInsertOperation(hdnSurvey_fk_72.Value, utilitiestobebroughtfrmsite.SelectedValue, "", "")
        End If

        'answersurveyfk_73 Please indicate estimated distance for each needed utility. 

        'answersurveyfk_74 	Is proposed routing of utilities known?

        If proposedroutingofutilities.SelectedValue = "" Then
        Else
            btnSubmitInsertOperation(hdnSurvey_fk_74.Value, proposedroutingofutilities.SelectedValue, "", "")
        End If
        'answersurveyfk_75 	Are there any overhead utilities, underground utilities or easements that would need to be evaluated as part of the developability of the site? 
        btnSubmitInsertOperation(hdnSurvey_fk_75.Value, utilitiesevaluationofsite.SelectedValue, "", "")
        'Utilities End

        'Traffic Starts (SurveyType_fk = 11)
        'hdnSurvey_fk_76 Are there known traffic issues in the immediate area?
        btnSubmitInsertOperation(hdnSurvey_fk_76.Value, trafficissue.SelectedValue, "", "")
        'hdnSurvey_fk_77(	Will the project impact traffic and site access during construction or during operation?)
        btnSubmitInsertOperation(hdnSurvey_fk_77.Value, impacttrafficsiteaccess.SelectedValue, "", "")
        If impacttrafficsiteaccess.SelectedValue = "1" Then
            'hdnSurvey_fk_78- if yes scenario If yes …. Will traffic impacts be limited only during construction? 
            btnSubmitInsertOperation(hdnSurvey_fk_78.Value, trafficimpactsduringconstn.SelectedValue, "", "")
            'hdnSurvey_fk_80- if yes/no both scenario  Please provide link or attached previously completed traffic study
            btnSubmitInsertOperation(hdnSurvey_fk_80.Value, 1, txtProvidelnkotrafficstudy.Text, "")
        ElseIf impacttrafficsiteaccess.SelectedValue = "2" Then
            'hdnSurvey_fk_79- if no scenario  If no…. Has a traffic study been completed for after construction/ during operation of the facility and traffic Level of Service(LOS)
            btnSubmitInsertOperation(hdnSurvey_fk_79.Value, trafficstudycompleted.SelectedValue, "", "")
            'hdnSurvey_fk_80- if yes/no both scenario  Please provide link or attached previously completed traffic study
            btnSubmitInsertOperation(hdnSurvey_fk_80.Value, 2, txtProvidelnkotrafficstudy.Text, "")
        End If
        'hdnSurvey_fk_81 Is there mass transit in close proximity which could be utilized to alleviate traffic impacts? 
        btnSubmitInsertOperation(hdnSurvey_fk_81.Value, masstransitcloseproximity.SelectedValue, "", "")
        'Traffic Ends

        'NEPA, PREVIOUS COMPLETED DOCUMENTS, EA), EIS Start (Surveyfk_type= 12)
        'hdnSurvey_fk_82 Has an previous NEPA EA or EIS  been completed for the project? 
        btnSubmitInsertOperation(hdnSurvey_fk_82.Value, previousnepaeaoreis.SelectedValue, "", "")
        If previousnepaeaoreis.SelectedValue = "1" Then
            'hdnSurvey_fk_83- if yes scenario If yes… is there a Final EA and signed Finding of No Significant Impact (FONSI) for the project? 
            btnSubmitInsertOperation(hdnSurvey_fk_83.Value, finaleasignedfonsi.SelectedValue, "", "")
            'hdnSurvey_fk_84- if yes scenario Please provide link or attach copy of previous NEPA EA or EIS and signed FONSI. 
            btnSubmitInsertOperation(hdnSurvey_fk_84.Value, 1, txtpreviousnepaeaoreis.Text, "")
        End If
        'hdnSurvey_fk_85 Does the site have any previously completed NEPA documents for past projects that are available? (This can help to frame the potential resource areas or concern) 
        btnSubmitInsertOperation(hdnSurvey_fk_85.Value, prevcomplnepadocnavailable.SelectedValue, "", "")
        If prevcomplnepadocnavailable.SelectedValue = "1" Then
            'hdnSurvey_fk_86- if yes secenario If yes.. Please provide site POC for past NEPA documentation  or attach past NEPA documentation 
            btnSubmitInsertOperation(hdnSurvey_fk_86.Value, 1, txtLnksitepocpastnepadocn.Text, "")
        End If
        'hdnSurvey_fk_87 Are there other projects underway or planned for the near term at the property (Minors)?
        btnSubmitInsertOperation(hdnSurvey_fk_87.Value, otherprojectunderwayorplanned.SelectedValue, "", "")
        'NEPA, PREVIOUS COMPLETED DOCUMENTS, EA), EIS End

        'Physical Security Starts (SurveyType_fk=13)
        'hdnSurvey_fk_88
        btnSubmitInsertOperation(hdnSurvey_fk_88.Value, 1, txtImpactsofphysicalsecurity.Text, "")
        'hdnSurvey_fk_89
        btnSubmitInsertOperation(hdnSurvey_fk_89.Value, 1, txtProposedpotentiallyimpacts.Text, "")
        'Physical Security End
        btnSave.Enabled = False
        btnSubmit.Enabled = False
        SendNotificationToEnvProjectInitiationSubmittedFormRecipient()
        ScriptManager.RegisterClientScriptBlock(Me, [GetType](), "Message", "SaveAlertAndCloseWindowMsg1('Records Submitted Successfully.');", True)

    End Sub

    Private Sub SendNotificationToEnvProjectInitiationSubmittedFormRecipient()
        Dim strPersonnelEmail As String
        Dim strProjectCode As String
        Dim strEnvironmentalProjectFromEmail As String = ConfigurationManager.AppSettings("EnvironmentalProjectFromEmail").ToString
        Dim strproject_pk = Convert.ToString(Request.QueryString("project_pk"))

        'new line
        Dim uname As String = Context.User.Identity.Name
        Dim strLoggedUser As String = uname.Substring(uname.LastIndexOf("\") + 1)

        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        strPersonnelEmail = ConfigurationManager.AppSettings("EnvProjectInitiationSubmittedFormRecipient").ToString
        ''       EnvProjectInitiationSubmittedFormRecipient            EnvProjectInitiationSubmittedFormRecipient
        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "GetprojectCode"
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = strproject_pk
            command.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
            command.Parameters("@Result").Direction = ParameterDirection.Output

            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()

            strProjectCode = command.Parameters("@Result").Value.ToString
        End Using

        Dim sb As New StringBuilder()
        'sb.Append(Convert.ToString("<p>Comments on project</p>"))
        sb.Append("<table>")
        sb.Append((Convert.ToString("<tr><td><br>A new Environmental Project Initiation Form has been submitted into CFMIS. ") + "</td></tr>"))
        sb.Append((Convert.ToString("<tr><td><br>To view the form, click on this link: " + ConfigurationManager.AppSettings("EnviProjectInitiationFormURL").ToString + strproject_pk + "</td></tr>")))

        Dim mm As New MailMessage()
        mm.IsBodyHtml = True
        mm.From = New MailAddress(strEnvironmentalProjectFromEmail)
        mm.[To].Add(strPersonnelEmail)
        mm.Subject = "CFMIS Environmental Project Initiation Form for Project # " + strProjectCode

        sb.Append("</table>")
        mm.Body = sb.ToString()
        Application("strIP") = "smtp.va.gov"
        Dim smtp As New SmtpClient(Application("strIP").ToString())
        smtp.Send(mm)
        mm.Dispose()

        '        End If
    End Sub

    Private Sub AddPMinProjectEnvironmental()
        Try
            Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))
            '   Dim conn As New SqlConnection()
            Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
            Dim blnAddProjectPersonnel As Boolean
            Dim strPersonnelId As String

            Using conn As New SqlConnection(ConnStr)
                Dim command As New SqlCommand
                command.Connection = conn
                command.CommandText = "SELECT Count(*) noofPM FROM ProjectPersonnel WHERE ManagerRole_fk = 2 and deleted = 0 and project_fk = @projectID"
                command.CommandType = CommandType.Text

                command.Parameters.Add(New SqlParameter("@projectID", strProjId))
                conn.Open()
                blnAddProjectPersonnel = command.ExecuteScalar().ToString() = "0"
                conn.Close()
            End Using

            If blnAddProjectPersonnel Then

                Using conn As New SqlConnection(ConnStr)
                    Dim command As New SqlCommand
                    command.Connection = conn
                    command.CommandText = "SELECT personnel_pk FROM Personnel WHERE username = @username"
                    command.CommandType = CommandType.Text

                    command.Parameters.Add(New SqlParameter("@username", Session("UserNm")))
                    conn.Open()
                    strPersonnelId = command.ExecuteScalar().ToString()
                    conn.Close()
                End Using

                If strPersonnelId >= 0 Then
                    Using conn As New SqlConnection(ConnStr)
                        Dim command As New SqlCommand
                        command.Connection = conn
                        command.CommandText = "AddPersonnelInProject"
                        command.CommandType = CommandType.StoredProcedure

                        command.Parameters.AddWithValue("@ProjectId", DbNullOrStringValue(strProjId))
                        command.Parameters.AddWithValue("@PersonnelId", DbNullOrStringValue(strPersonnelId))
                        command.Parameters.AddWithValue("@RoleId", 2)
                        command.Parameters.Add("@Result", SqlDbType.VarChar, 100)
                        command.Parameters("@Result").Direction = ParameterDirection.Output   ' just ignore the output

                        conn.Open()
                        command.ExecuteNonQuery()
                        conn.Close()

                    End Using
                End If
            End If
        Catch ex As Exception
        End Try
    End Sub


    Private Sub SendNotificationToanEngineer(strPersonnelName As String, strPersonnelId As String, strproject_pk As String)
        Dim strPersonnelEmail As String
        Dim strProjectCode As String
        Dim strEnvironmentalProjectFromEmail As String = ConfigurationManager.AppSettings("EnvironmentalProjectFromEmail").ToString

        'new line
        Dim uname As String = Context.User.Identity.Name
        Dim strLoggedUser As String = uname.Substring(uname.LastIndexOf("\") + 1)

        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "GetPersonnelEmail"
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@personnel_pk", SqlDbType.Int).Value = strPersonnelId
            command.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
            command.Parameters("@Result").Direction = ParameterDirection.Output

            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()

            strPersonnelEmail = command.Parameters("@Result").Value.ToString
        End Using

        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "GetprojectCode"
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = strproject_pk
            command.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
            command.Parameters("@Result").Direction = ParameterDirection.Output

            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()

            strProjectCode = command.Parameters("@Result").Value.ToString
        End Using

        '        strPersonnelEmail = "Richard.Belandres@va.gov"
        Dim sb As New StringBuilder()
        'sb.Append(Convert.ToString("<p>Comments on project</p>"))
        sb.Append("<table>")
        sb.Append((Convert.ToString("<tr><td>Hello ") & strPersonnelName) + ",</td></tr>")
        sb.Append((Convert.ToString("<tr><td><br>You have a new project assign to you for initial response in CFMIS. ") + "</td></tr>"))
        sb.Append((Convert.ToString("<tr><td><br>To view the list of project(s) for initial response, click on this link: " + ConfigurationManager.AppSettings("ProjectforInitialListURL").ToString + "</td></tr>")))

        Dim mm As New MailMessage()
        mm.IsBodyHtml = True
        mm.From = New MailAddress(strEnvironmentalProjectFromEmail)
        mm.[To].Add(strPersonnelEmail)
        mm.Subject = "CFMIS Project # " + strProjectCode

        sb.Append("</table>")
        mm.Body = sb.ToString()
        Application("strIP") = "smtp.va.gov"
        Dim smtp As New SmtpClient(Application("strIP").ToString())
        smtp.Send(mm)
        mm.Dispose()

        '        End If
    End Sub
    Protected Sub rdbtnutilities(ByVal sender As Object, ByVal e As EventArgs)
        If sufficesntutilities.Text = "1" Then
            utilities_1.Visible = True
            utilities_2.Visible = True
            'utilities_3.Visible = True
            utilities_4.Visible = True
        Else
            utilities_1.Visible = False
            utilities_2.Visible = False
            utilities_3.Visible = False
            utilities_4.Visible = False
            utilitiestobebroughtfrmsite.ClearSelection()
        End If
    End Sub
    Protected Sub rdbtnutilitydistances(ByVal sender As Object, ByVal e As EventArgs)
        If utilitiestobebroughtfrmsite.Text = "1" Then
            utilities_3.Visible = True
        Else
            utilities_3.Visible = False

        End If
    End Sub
    Protected Sub rdbnselection(ByVal sender As Object, ByVal e As EventArgs)
        If rblsharepointaccessible.Text = "1" Then
            firsthdnquestion.Visible = True
        Else
            firsthdnquestion.Visible = False
            txtPinNo.Text = ""
        End If
    End Sub
    Protected Sub recentmstrplan(ByVal sender As Object, ByVal e As EventArgs)
        If chkMp.Text = "1" Then
            landusehdnquestion.Visible = True
            lnkmstrplanhdnquestion.Visible = True
        Else
            landusehdnquestion.Visible = False
            lnkmstrplanhdnquestion.Visible = False
            txtPinNo2.Text = ""
        End If
    End Sub
    Protected Sub realestateinvolvment(ByVal sender As Object, ByVal e As EventArgs)
        If pairea.Text = "1" Then
            lndusefirsthiddenquestion.Visible = True
            lndusesecondhiddenquestion.Visible = True
            lndusethirdhiddenquestion.Visible = True
            lndusefourthhiddenquestion.Visible = True
            lndusefifthhiddenquestion.Visible = True
            lndusesixthhiddenquestion.Visible = True

        Else
            lndusefirsthiddenquestion.Visible = False
            lndusesecondhiddenquestion.Visible = False
            lndusethirdhiddenquestion.Visible = False
            lndusefourthhiddenquestion.Visible = False
            lndusefifthhiddenquestion.Visible = False
            lndusesixthhiddenquestion.Visible = False
        End If
    End Sub
    Protected Sub anydemolition(ByVal sender As Object, ByVal e As EventArgs)
        If demolition.Text = "1" Then
            lnduseseventhhiddenquestion.Visible = True
        Else
            lnduseseventhhiddenquestion.Visible = False
            txtSqrfootagedemolition.Text = ""
        End If


    End Sub
    Protected Sub Pkngstructureneeds(ByVal sender As Object, ByVal e As EventArgs)
        If pkngstructure.Text = "1" Then
            lnduseeighthhiddenquestion.Visible = True
            lnduseninthhiddenquestion.Visible = True
            lndusetenthhiddenquestion.Visible = True
        Else
            lnduseeighthhiddenquestion.Visible = False
            lnduseninthhiddenquestion.Visible = False
            lndusetenthhiddenquestion.Visible = False
        End If
    End Sub
    Protected Sub rdbtnenvsiteassement(ByVal sender As Object, ByVal e As EventArgs)
        If envsiteassement.Text = "1" Then
            sitegeologyfirsthiddenquestion.Visible = True
            sitegeologysecondhiddenquestion.Visible = True
            sitegeologythirdhiddenquestion.Visible = True
        Else
            sitegeologyfirsthiddenquestion.Visible = False
            sitegeologysecondhiddenquestion.Visible = False
            sitegeologythirdhiddenquestion.Visible = False
        End If

    End Sub
    Protected Sub rdbtnsubsurfacesuitability(ByVal sender As Object, ByVal e As EventArgs)
        If subsurfacesuitability.Text = "1" Then
            sitegeologyfourthhiddenquestion.Visible = True
            sitegeologyfifthhhiddenquestion.Visible = True
            sitegeologysixthhhiddenquestion.Visible = True
            sitegeologyseventhhhiddenquestion.Visible = True
        Else
            sitegeologyfourthhiddenquestion.Visible = False
            sitegeologyfifthhhiddenquestion.Visible = False
            sitegeologysixthhhiddenquestion.Visible = False
            sitegeologyseventhhhiddenquestion.Visible = False
        End If

    End Sub
    Protected Sub rdbtnknowncontaminations(ByVal sender As Object, ByVal e As EventArgs)
        If hazordousmtrl.Text = "1" Then
            hazardousknowncontainment.Visible = True
        Else
            hazardousknowncontainment.Visible = False
            rdbtnlinktoknowncontainments.Visible = False
            dcmntlimits.ClearSelection()
            txtlinktocontainmentsdocuments.Text = ""
        End If
    End Sub
    Protected Sub rdbtnfullasbetos(ByVal sender As Object, ByVal e As EventArgs)
        If fullasbestos.Text = "1" Then
            hazordousfirsthiddenquestion.Visible = True
        Else
            hazordousfirsthiddenquestion.Visible = False
        End If
    End Sub
    Protected Sub rdbtndocumentationonknowncontainments(ByVal sender As Object, ByVal e As EventArgs)
        If dcmntlimits.Text = "1" Then
            rdbtnlinktoknowncontainments.Visible = True
        Else
            rdbtnlinktoknowncontainments.Visible = False
        End If
    End Sub
    Protected Sub rdbtnlstedhistoricregister(ByVal sender As Object, ByVal e As EventArgs)
        If lstedhistoricregister.Text = "1" Then
            historicalculturalfirsthiddenquestion.Visible = True
            historicalculturalsecondhiddenquestion.Visible = True
            historicalculturalthirdhiddenquestion.Visible = True
            historicalculturalfourthhiddenquestion.Visible = True
        Else
            historicalculturalfirsthiddenquestion.Visible = False
            historicalculturalsecondhiddenquestion.Visible = False
            historicalculturalthirdhiddenquestion.Visible = False
            historicalculturalfourthhiddenquestion.Visible = False
        End If
    End Sub
    Protected Sub rdbtnexstnhpaagreement(ByVal sender As Object, ByVal e As EventArgs)
        If exstnhpaagreement.Text = "1" Then
            historicalculturalfifthhiddenquestion.Visible = True
        Else
            historicalculturalfifthhiddenquestion.Visible = False
        End If
    End Sub
    Protected Sub rdbtnlnktoannualrptsreuirement(ByVal sender As Object, ByVal e As EventArgs)
        If exstrelnwithconsuparties.Text = "1" Then
            historicalculturalsixthhiddenquestion.Visible = True
            historicalculturalseventhhiddenquestion.Visible = True
        Else
            historicalculturalsixthhiddenquestion.Visible = False
            historicalculturalseventhhiddenquestion.Visible = False
        End If
    End Sub
    Protected Sub rdbnstateorfederalthreatenedprevreport(ByVal sender As Object, ByVal e As EventArgs)
        If stateorfederalthreatened.Text = "1" Then
            naturalresourcesfirsthiddenquestion.Visible = True
            'naturalresourcessecondhiddenquestion.Visible = True
        Else
            naturalresourcesfirsthiddenquestion.Visible = False
            naturalresourcessecondhiddenquestion.Visible = False
        End If
    End Sub
    Protected Sub Subrdbnendangeredspeciesreport(ByVal sender As Object, ByVal e As EventArgs)
        If stateorfederalthreatenedprevreport.Text = "1" Then

            naturalresourcessecondhiddenquestion.Visible = True
        Else

            naturalresourcessecondhiddenquestion.Visible = False
        End If
    End Sub
    Protected Sub rdbtngeafloodplain(ByVal sender As Object, ByVal e As EventArgs)
        If femafloodplain.Text = "1" Then
            naturalresourcesthirdhiddenquestion.Visible = True
        Else
            naturalresourcesthirdhiddenquestion.Visible = False
        End If
    End Sub
    Protected Sub rdbtnknownormappedwetlands(ByVal sender As Object, ByVal e As EventArgs)
        If knownormappedwetlands.Text = "1" Then
            naturalresourcesfourthhiddenquestion.Visible = True
            'naturalresourcesfifthiddenquestion.Visible = True
            'naturalresourcessixthiddenquestion.Visible = True
            'naturalresourcesseventhhiddenquestion.Visible = True

        Else
            naturalresourcesfourthhiddenquestion.Visible = False
            naturalresourcesfifthiddenquestion.Visible = False
            naturalresourcessixthiddenquestion.Visible = False
            naturalresourcesseventhhiddenquestion.Visible = False
        End If
    End Sub
    Protected Sub rdbtnlikelyimpactsowetlands(ByVal sender As Object, ByVal e As EventArgs)
        If wetlandimpacted.Text = "1" Then
            naturalresourcesfifthiddenquestion.Visible = True
            naturalresourcessixthiddenquestion.Visible = True
            naturalresourcesseventhhiddenquestion.Visible = True
        Else
            naturalresourcesfifthiddenquestion.Visible = False
            naturalresourcessixthiddenquestion.Visible = False
            naturalresourcesseventhhiddenquestion.Visible = False
        End If
    End Sub

    Protected Sub rdbtnimpacttrafficsiteaccess(ByVal sender As Object, ByVal e As EventArgs)
        If impacttrafficsiteaccess.Text = "1" Then
            trafficfirsthiddenquestion.Visible = True
            trafficthirdhiddenquestion.Visible = True
            trafficsecondhiddenquestion.Visible = False

        ElseIf impacttrafficsiteaccess.Text = "2" Then
            trafficsecondhiddenquestion.Visible = True
            trafficthirdhiddenquestion.Visible = True
            trafficfirsthiddenquestion.Visible = False

        Else
            trafficthirdhiddenquestion.Visible = False
            trafficfirsthiddenquestion.Visible = False
            trafficsecondhiddenquestion.Visible = False

        End If
    End Sub
    Protected Sub rdbtnpreviousnepaeaoreis(ByVal sender As Object, ByVal e As EventArgs)
        If previousnepaeaoreis.Text = "1" Then
            nepafirsthiddenquestion.Visible = True
            nepasecondhiddenquestion.Visible = True
        Else
            nepafirsthiddenquestion.Visible = False
            nepasecondhiddenquestion.Visible = False
        End If

    End Sub

    Protected Sub rdbtnoutleaseselection(ByVal sender As Object, ByVal e As EventArgs)
        If Outleasethroughorp.Text = "1" Then
            orphdnfirstquestion.Visible = True
            orphdnsecondquestion.Visible = True
        Else
            orphdnfirstquestion.Visible = False
            orphdnsecondquestion.Visible = False
        End If

    End Sub
    Protected Sub rdbtnprevcomplnepadocnavailable(ByVal sender As Object, ByVal e As EventArgs)
        If prevcomplnepadocnavailable.Text = "1" Then
            nepathirdhiddenquestion.Visible = True
        Else
            nepathirdhiddenquestion.Visible = False
        End If

    End Sub
    Private Function ConvertToInteger(ByRef value As String) As Integer
        If String.IsNullOrEmpty(value) Then
            value = "0"
        End If
        Return Convert.ToInt32(value.Replace(",", ""))
    End Function
    Public Function GetprojectEnviroSurveyLinkorComment(strProjId As String, Survey_pk As String, IsLink As Boolean) As String
        Dim strResult As String
        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "GetprojectEnviroSurveyLinkorComment"
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = strProjId
            command.Parameters.AddWithValue("@survey_pk", SqlDbType.Int).Value = Survey_pk
            command.Parameters.AddWithValue("@isLink", SqlDbType.Bit).Value = IsLink
            command.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
            command.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()
            strResult = command.Parameters("@Result").Value.ToString
        End Using
        Return strResult
    End Function



    Public Function Getutilitiesrecords(strProjId As String, Survey_pk As String) As String
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim strResult As String
        Dim enviropk As String
        Using conn As New SqlConnection(connStr)
            Dim com2 As New SqlCommand With {
                                    .Connection = conn,
                                    .CommandType = CommandType.StoredProcedure,
                                    .CommandText = "GetProjectEnviroPK"
                    }
            com2.Parameters.Add(New SqlParameter("@Surveyfk", 71))
            com2.Parameters.Add(New SqlParameter("@projectfk", varId))
            conn.Open()
            Using sdr As SqlDataReader = com2.ExecuteReader()
                sdr.Read()
                If sdr.HasRows Then
                    enviropk = sdr("EnviroSurvey_pk").ToString()
                    conn.Close()
                    Dim command As New SqlCommand
                    command.Connection = conn
                    command.CommandText = "GetUtilitiesrecords"
                    command.CommandType = CommandType.StoredProcedure
                    command.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = enviropk
                    command.Parameters.AddWithValue("@utility", SqlDbType.Int).Value = Survey_pk
                    command.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
                    command.Parameters.Add("@Result_utlchck", SqlDbType.NVarChar, 200)
                    command.Parameters("@Result").Direction = ParameterDirection.Output
                    command.Parameters("@Result_utlchck").Direction = ParameterDirection.Output
                    conn.Open()
                    command.ExecuteNonQuery()
                    conn.Close()
                    strResult = command.Parameters("@Result").Value.ToString
                    Return strResult
                End If

            End Using
        End Using
    End Function
    Public Function Getutilitiescheckedornot(strProjId As String, Survey_pk As String) As String
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim strResult As String
        Dim enviropk As String
        Using conn As New SqlConnection(connStr)
            Dim com2 As New SqlCommand With {
                                    .Connection = conn,
                                    .CommandType = CommandType.StoredProcedure,
                                    .CommandText = "GetProjectEnviroPK"
                    }
            com2.Parameters.Add(New SqlParameter("@Surveyfk", 71))
            com2.Parameters.Add(New SqlParameter("@projectfk", varId))
            conn.Open()
            Using sdr As SqlDataReader = com2.ExecuteReader()
                sdr.Read()
                If sdr.HasRows Then
                    enviropk = sdr("EnviroSurvey_pk").ToString()
                    conn.Close()
                    Dim command As New SqlCommand
                    command.Connection = conn
                    command.CommandText = "GetUtilitiesrecords"
                    command.CommandType = CommandType.StoredProcedure
                    command.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = enviropk
                    command.Parameters.AddWithValue("@utility", SqlDbType.Int).Value = Survey_pk
                    command.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
                    command.Parameters.Add("@Result_utlchck", SqlDbType.NVarChar, 200)
                    command.Parameters("@Result").Direction = ParameterDirection.Output
                    command.Parameters("@Result_utlchck").Direction = ParameterDirection.Output
                    conn.Open()
                    command.ExecuteNonQuery()
                    conn.Close()
                    strResult = command.Parameters("@Result_utlchck").Value.ToString
                    If strResult = "" Then
                        Return strResult = "0"
                    Else
                        Return strResult
                    End If

                End If
            End Using
        End Using
    End Function

    Protected Function GetprojectEnvironmentScheduleCount() As Integer
        Dim strProjNum As String = Convert.ToString(Request.QueryString("project_pk"))

        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand()
        conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        cmd.Connection = conn
        cmd.CommandText = "GetprojectEnvironmentalScheduleCount"
        cmd.CommandType = System.Data.CommandType.StoredProcedure
        cmd.Parameters.Add("@project_pk", SqlDbType.Int).Value = strProjNum
        cmd.Parameters.Add("@Result", SqlDbType.Int)
        cmd.Parameters("@Result").Direction = ParameterDirection.Output
        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()

        Return cmd.Parameters("@Result").Value

    End Function


    Protected Sub gvCurrentPersonnel_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim btn As Button = e.Row.FindControl("btnDelete")
            'If e.Row.Cells(4).Text = "Environmental Engineer" And (Session("GroupID") <> 600 Or Session("GroupID") <> 220) Then
            '    btn.Enabled = False
            'End If

            Dim numbers() As Integer = {220, 600}
            If e.Row.Cells(4).Text = "Environmental Engineer" And Not numbers.Contains(Session("GroupID")) Then
                btn.Enabled = False
            End If

        End If
    End Sub

    Protected Sub GetByUserGroupManagerRoles()


        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            conn.Open()
            command.CommandText = "GetByUserGroupManagerRoles"
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.Add("@userGroup", SqlDbType.Int).Value = ConvertToInteger(Session("GroupID"))

            Dim reader As SqlDataReader = command.ExecuteReader()

            ddlManagerRoles.DataSource = reader
            ddlManagerRoles.DataTextField = "name"
            ddlManagerRoles.DataValueField = "lkManagerRoles_pk"
            ddlManagerRoles.DataBind()
            ddlManagerRoles.Items.Insert(0, New ListItem("-Select-"))

            conn.Close()
        End Using

        'Else
        '    ddlPersonnel.SelectedIndex = 0
        'End If

        'If ddlManagerRoles.SelectedValue <> "0" Then
        '    ddlPersonnel.Visible = True
        'Else
        '    ddlPersonnel.Visible = False
        'End If

    End Sub

    Protected Sub chkFinal_CheckedChanged(sender As Object, e As EventArgs)

    End Sub

    Protected Sub txtSqFtConst_TextChanged(sender As Object, e As EventArgs)
        txtSqFtConst.Text = txtSqFtConst.Text.ToString("N0")
    End Sub

    Protected Sub BtnSavePhase_Click(sender As Object, e As EventArgs)
        If ddSustCoord.SelectedValue = "O" Then
            ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "alert('Please enter a number of buildings for this phase-save cancelled.')", True)
            Return
        End If
        ' If Not DataExistsForPhase() Then
        If Session("CurrState") = "NbrOfBuildings" Then
            SavePhase()
            GetSustainabilityPhase()
        Else
            SaveAllPanels()
        End If
        Session("CurrState") = "ALLPANELS"
        SetPanels()
    End Sub

    Private Sub GetSustainabilityPhase()
        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim phaseID As Decimal = Convert.ToDecimal(Request.QueryString("project_pk"))
            Dim uname As String = Context.User.Identity.Name
            Dim strLoggedUser = uname.Substring(uname.LastIndexOf("\") + 1)
            Dim commandCoord As New SqlCommand
            commandCoord.Connection = conn
            commandCoord.Parameters.AddWithValue("@username", DbNullOrStringValue(phaseID))

            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "getSustainabilityNumberOfBldgs"
            command.CommandType = CommandType.StoredProcedure

            command.Parameters.AddWithValue("@Phase_FK", DbNullOrStringValue(Convert.ToDecimal(phaseID)))
            command.Parameters.AddWithValue("@User", DbNullOrStringValue(strLoggedUser))



            conn.Open()
            Dim adp As New SqlDataAdapter
            adp.SelectCommand = command
            Dim ds As New DataSet
            adp.Fill(ds)

            ddSustCoord.SelectedValue = ds.Tables(0).Rows(0)("NbrOfBuildings")
            conn.Close()
            Session("NumberOfBuildings") = ds.Tables(0).Rows(0)("NbrOfBuildings")
            ddSustCoord.SelectedValue = ds.Tables(0).Rows(0)("NbrOfBuildings")

            Dim command2 As New SqlCommand
            Dim Getsustainabilitygeningo As New SqlCommand
            command2.Connection = conn
            command2.CommandText = "getSustainabilityPhaseCoordinators"
            command2.CommandType = CommandType.StoredProcedure

            command2.Parameters.AddWithValue("@Phase_FK", DbNullOrStringValue(Convert.ToDecimal(phaseID)))

            command2.Parameters.AddWithValue("@User", DbNullOrStringValue(strLoggedUser))
            Dim adp2 As New SqlDataAdapter
            adp2.SelectCommand = command2
            Dim ds2 As New DataSet
            adp2.Fill(ds2)

            If ds2.Tables(0).Rows(0)("Personnel_FK").ToString <> "" Then
                ddChooseSustCoord.SelectedValue = ds2.Tables(0).Rows(0)("Personnel_FK")
                Session("Personnel_FK") = ddChooseSustCoord.SelectedValue
            End If
        End Using
    End Sub															

End Class