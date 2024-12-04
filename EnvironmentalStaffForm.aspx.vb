Imports System.Data.SqlClient
Public Class EnvironmentalStaffForm
    Inherits System.Web.UI.Page

    Dim varId As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim Logon As String
        Logon = Request.LogonUserIdentity.Name
        Dim nIndex As Integer = Logon.IndexOf("\")
        Logon = Logon.Substring(nIndex + 1)
        lblUserNm.Text = Logon

        varId = Convert.ToString(Request.QueryString("project_pk"))

        If Not Page.IsPostBack() Then

            Dim conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString

            ' Get Environmental Intake Schedule
            GetSchedule()
            ' Get checkboxes values
            GetCheckboxesrecord()
            'Get NHPA
            GetNHPA()

            'Project Overview
            Dim cmd1 As New SqlCommand
            cmd1.CommandText = "GetProjectEnvironmentalProjectOverview"
            cmd1.CommandType = CommandType.StoredProcedure
            cmd1.Parameters.Add(New SqlParameter("@ProjectId", varId))
            cmd1.Connection = conn
            If conn.State = ConnectionState.Closed Then
                conn.Open()
            End If
            Dim adp1 As New SqlDataAdapter

            adp1.SelectCommand = cmd1
            Dim ds1 As New DataSet
            adp1.Fill(ds1)
            If conn.State = ConnectionState.Open Then
                conn.Close()
            End If
            adp1.Dispose()
            '
            'Check if Environmental Contract does exist and populate Environmental Contract information
            If ds1.Tables(0).Rows.Count > 0 Then
                txtProjectOffice.Text = ds1.Tables(0).Rows(0).Item("region").ToString()
                txtProjectnumber.Text = ds1.Tables(0).Rows(0).Item("projectCode").ToString()
                txtLocation.Text = ds1.Tables(0).Rows(0).Item("Location").ToString()
                txtPm.Text = ds1.Tables(0).Rows(0).Item("ProjectManager").ToString()
                txtDescription.Text = ds1.Tables(0).Rows(0).Item("projectDesc").ToString()
                If ds1.Tables(0).Rows(0).Item("ProjBookAwardDate").ToString() <> "" Then txtPrjbookawarddate.InnerText = ds1.Tables(0).Rows(0).Item("ProjBookAwardDate").ToString()
                If ds1.Tables(0).Rows(0).Item("ProjBookCompleteDate").ToString() <> "" Then txtPrjbookcompletiondate.InnerText = ds1.Tables(0).Rows(0).Item("ProjBookCompleteDate").ToString()
                If ds1.Tables(0).Rows(0).Item("DesignAwardDate").ToString() <> "" Then txtDesignawrddate.InnerText = ds1.Tables(0).Rows(0).Item("DesignAwardDate").ToString()
                If ds1.Tables(0).Rows(0).Item("ConstrAwardDate").ToString() <> "" Then txtFyantcptaedconstawddate.InnerText = ds1.Tables(0).Rows(0).Item("ConstrAwardDate").ToString()

                txtNotes.InnerText = ds1.Tables(0).Rows(0).Item("environmentalOverviewNote").ToString()


            End If


            'Environmental Contract
            Dim cmd2 As New SqlCommand
            cmd2.CommandText = "GetProjectEnvironmentalContract"
            cmd2.CommandType = CommandType.StoredProcedure
            cmd2.Parameters.Add(New SqlParameter("@ProjectId", varId))
            cmd2.Connection = conn
            If conn.State = ConnectionState.Closed Then
                conn.Open()
            End If
            Dim adp2 As New SqlDataAdapter

            adp2.SelectCommand = cmd2
            Dim ds2 As New DataSet
            adp2.Fill(ds2)
            If conn.State = ConnectionState.Open Then
                conn.Close()
            End If
            adp2.Dispose()
            '
            'Check if Environmental Contract does exist and populate Environmental Contract information
            If ds2.Tables(0).Rows.Count > 0 Then
                ddlEnvvontracreq.SelectedValue = ds2.Tables(0).Rows(0).Item("SOWIGCESubmitted").ToString()
                If ds2.Tables(0).Rows(0).Item("SOWCompletedDate").ToString() <> "" Then txtEnvsowcompldate.Text = Convert.ToDateTime(ds2.Tables(0).Rows(0).Item("SOWCompletedDate").ToString())
                txtContractstatus.Text = ds2.Tables(0).Rows(0).Item("ContractStatus").ToString()
                'If ds2.Tables(0).Rows(0).Item("AnticipatedAwardDate").ToString() <> "" Then txtAnticipatedawarddate.Text = Convert.ToDateTime(ds2.Tables(0).Rows(0).Item("AnticipatedAwardDate").ToString())
                'If ds2.Tables(0).Rows(0).Item("ActualAwardDate").ToString() <> "" Then txtActualawarddate.Text = Convert.ToDateTime(ds2.Tables(0).Rows(0).Item("ActualAwardDate").ToString())
                'If ds2.Tables(0).Rows(0).Item("AnticipatedCompletionDate").ToString() <> "" Then txtAnticipatedcompletiondate.Text = Convert.ToDateTime(ds2.Tables(0).Rows(0).Item("AnticipatedCompletionDate").ToString())
                txtContractbaseawardamt.Text = String.Format("{0:#,##0.00}", Double.Parse(ds2.Tables(0).Rows(0).Item("ContractBaseAwardedAmount").ToString()))
                txtContrbasedoptionawrd.Text = String.Format("{0:#,##0.00}", Double.Parse(ds2.Tables(0).Rows(0).Item("OptionAwardAmount").ToString()))
                txtNotesenvcontractsummary.InnerText = ds2.Tables(0).Rows(0).Item("ContractComment").ToString()
            End If


            Dim cmd3 As New SqlCommand
            cmd3.CommandText = "GetProjectNEPA"
            cmd3.CommandType = CommandType.StoredProcedure
            cmd3.Parameters.Add(New SqlParameter("@ProjectId", varId))
            cmd3.Connection = conn
            If conn.State = ConnectionState.Closed Then
                conn.Open()
            End If
            Dim adp3 As New SqlDataAdapter

            adp3.SelectCommand = cmd3
            Dim ds3 As New DataSet
            adp3.Fill(ds3)
            If conn.State = ConnectionState.Open Then
                conn.Close()
            End If
            adp3.Dispose()

            If ds3.Tables(0).Rows.Count > 0 Then
                ' NEPA SUMMARY AND STATUS
                ddlRequirednepadocnlevel.SelectedValue = ds3.Tables(0).Rows(0).Item("NEPA_fk").ToString()
                ddlNepastatus.SelectedValue = ds3.Tables(0).Rows(0).Item("NEPAStatus").ToString()
                ddlfonsirodsigneddate.SelectedValue = ds3.Tables(0).Rows(0).Item("FONSIRODsigned").ToString()
                If ds3.Tables(0).Rows(0).Item("NEPASumStatNotes").ToString() <> "" Then txtNEPASumStatNotes.InnerText = ds3.Tables(0).Rows(0).Item("NEPASumStatNotes").ToString()

                'ADDITIONAL NEPA DOCUMENTATION COMPLETED
                ddlSupplemntaleaeis.SelectedValue = ds3.Tables(0).Rows(0).Item("SupplementalEAorEIS").ToString()
                If ds3.Tables(0).Rows(0).Item("PreviousEAorSEAorPEA").ToString() <> "" Then txtpreviouseaseapea.Text = ds3.Tables(0).Rows(0).Item("PreviousEAorSEAorPEA").ToString()
                If ds3.Tables(0).Rows(0).Item("DateCompletionFINAL").ToString() <> "" Then txtDateofcompletionfinal.Text = Convert.ToDateTime(ds3.Tables(0).Rows(0).Item("DateCompletionFINAL").ToString())
                If ds3.Tables(0).Rows(0).Item("DateofFONSI").ToString() <> "" Then txtDateoffonsi.Text = Convert.ToDateTime(ds3.Tables(0).Rows(0).Item("DateofFONSI").ToString())
                If ds3.Tables(0).Rows(0).Item("EISFINAL").ToString() <> "" Then txtEisfinal.Text = ds3.Tables(0).Rows(0).Item("EISFINAL").ToString()
                If ds3.Tables(0).Rows(0).Item("EISrod").ToString() <> "" Then txtEisrod.Text = ds3.Tables(0).Rows(0).Item("EISrod").ToString()
                If ds3.Tables(0).Rows(0).Item("NEPASignatory").ToString() <> "" Then txtNepasignatory.Text = ds3.Tables(0).Rows(0).Item("NEPASignatory").ToString()
                If ds3.Tables(0).Rows(0).Item("SupplementalEAorEISnote").ToString() <> "" Then txtNepdocumentationcompletednotes.InnerText = ds3.Tables(0).Rows(0).Item("SupplementalEAorEISnote").ToString()

                ' NHPA/ SECTION 106
                ddlNhpaconsultation.SelectedValue = ds3.Tables(0).Rows(0).Item("NHPAConsultationRequired").ToString()
                If ds3.Tables(0).Rows(0).Item("NHPALettersSent").ToString() <> "" Then txtNhpalettersent.Text = Convert.ToDateTime(ds3.Tables(0).Rows(0).Item("NHPALettersSent").ToString())
                If ds3.Tables(0).Rows(0).Item("NHPA30Days").ToString() <> "" Then txtNhpa30days.Text = Convert.ToDateTime(ds3.Tables(0).Rows(0).Item("NHPA30Days").ToString())
                If ds3.Tables(0).Rows(0).Item("NHPAMOAPA").ToString() <> "" Then txtNhpamoapa.Text = ds3.Tables(0).Rows(0).Item("NHPAMOAPA").ToString()
                If ds3.Tables(0).Rows(0).Item("NHPAnotes").ToString() <> "" Then txtNhpanotes.InnerText = ds3.Tables(0).Rows(0).Item("NHPAnotes").ToString()
                If ds3.Tables(0).Rows(0).Item("NHPASignatory").ToString() <> "" Then txtNhpasignatory.Text = ds3.Tables(0).Rows(0).Item("NHPASignatory").ToString()

                ' Get Due Diligence Reports Note
                If ds3.Tables(0).Rows(0).Item("DueDiligenceReportsNote").ToString() <> "" Then txtDueDiligenceReportsNote.InnerText = ds3.Tables(0).Rows(0).Item("DueDiligenceReportsNote").ToString()

            End If


            'PROJECT COMMITMENTS AND ANNUAL REPORTING
            Dim cmd4 As New SqlCommand
            cmd4.CommandText = "GetProjectEnviroCommitmentsAnnualReportingNote"
            cmd4.CommandType = CommandType.StoredProcedure
            cmd4.Parameters.Add(New SqlParameter("@ProjectId", varId))
            cmd4.Connection = conn
            If conn.State = ConnectionState.Closed Then
                conn.Open()
            End If
            Dim adp4 As New SqlDataAdapter

            adp4.SelectCommand = cmd4
            Dim ds4 As New DataSet
            adp4.Fill(ds4)
            If conn.State = ConnectionState.Open Then
                conn.Close()
            End If
            adp4.Dispose()
            '
            'Check if Environmental Contract does exist and populate Environmental Contract information
            If ds4.Tables(0).Rows.Count > 0 Then
                txtWetlandmitigation.InnerText = ds4.Tables(0).Rows(0).Item("wetlandMitigation").ToString()
                txtNhpareportsstipulations.InnerText = ds4.Tables(0).Rows(0).Item("NHPAReportsStipulations").ToString()
                txtEsamitigation.InnerText = ds4.Tables(0).Rows(0).Item("ESAMitigation").ToString()
                txtCzma.InnerText = ds4.Tables(0).Rows(0).Item("CZMA").ToString()
                txtStormwater.InnerText = ds4.Tables(0).Rows(0).Item("Stormwater").ToString()
            End If

        End If

    End Sub

    ''' <summary>
    '''Clicking Save Update button in projrct detail form will run the SP UpdateProject. See the comments in the
    ''' stored procedure to get the Cost update information.
    ''' </summary>
    Protected Sub btnSave_Click(sender As Object, e As EventArgs)

        Dim strProjNum As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim struser As String = lblUserNm.Text

        'Environmental Contract
        Dim strEnvvontracreq As String = ddlEnvvontracreq.SelectedValue
        Dim strEnvsowcompldate As String = txtEnvsowcompldate.Text
        Dim strContractstatus As String = txtContractstatus.Text
        Dim strContractbaseawardamt As String = txtContractbaseawardamt.Text
        Dim strContrbasedoptionawrd As String = txtContrbasedoptionawrd.Text
        Dim strNotesenvcontractsummary As String = txtNotesenvcontractsummary.InnerText.ToString()

        ' save Environmental Contract
        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "AddUpdateProjectEnvironmentalContract"
            command.CommandType = CommandType.StoredProcedure

            command.Parameters.Add("@project_fk", SqlDbType.Int).Value = strProjNum
            command.Parameters.Add("@SOWIGCESubmitted", SqlDbType.Int).Value = IIf(Left(strEnvvontracreq, 1) = "P", "0", strEnvvontracreq)
            command.Parameters.AddWithValue("@SOWCompletedDate", IIf(String.IsNullOrEmpty(strEnvsowcompldate), DBNull.Value, strEnvsowcompldate))
            command.Parameters.Add("@Contractstatus", SqlDbType.Text).Value = strContractstatus

            command.Parameters.Add("@ContractBaseAwardedAmount", SqlDbType.Money).Value = IIf(String.IsNullOrEmpty(strContractbaseawardamt), "0.00", strContractbaseawardamt)
            command.Parameters.Add("@OptionAwardAmount", SqlDbType.Money).Value = IIf(String.IsNullOrEmpty(strContrbasedoptionawrd), "0.00", strContrbasedoptionawrd)
            command.Parameters.Add("@ContractComment", SqlDbType.Text).Value = strNotesenvcontractsummary
            command.Parameters.Add("@UserName", SqlDbType.Text).Value = struser

            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()

        End Using

        ' NEPA
        Dim strNEPA_fk As String = ddlRequirednepadocnlevel.SelectedValue
        Dim strNEPAStatus As String = ddlNepastatus.SelectedValue
        Dim strfonsirodsigneddate As String = ddlfonsirodsigneddate.SelectedValue
        Dim strNEPASumStatNotes As String = txtNEPASumStatNotes.InnerText

        ' ADDITIONAL NEPA DOCUMENTATION COMPLETED
        Dim strSupplementalEAorEIS As String = ddlSupplemntaleaeis.SelectedValue
        Dim strPreviousEAorSEAorPEA As String = txtpreviouseaseapea.Text
        Dim strDateCompletionFINAL As String = txtDateofcompletionfinal.Text
        Dim strDateofFONSI As String = txtDateoffonsi.Text
        Dim strEISFINAL As String = txtEisfinal.Text
        Dim strEISrod As String = txtEisrod.Text
        Dim strNEPASignatory As String = txtNepasignatory.Text
        Dim strSupplementalEAorEISnote As String = txtNepdocumentationcompletednotes.InnerText

        ' Due Diligence Reports
        Dim strDueDiligenceReportsNote As String = txtDueDiligenceReportsNote.InnerText

        ' NHPA/ SECTION 106
        Dim strNhpaconsultation As String = ddlNhpaconsultation.SelectedValue
        Dim strNHPALettersSent As String = txtNhpalettersent.Text
        Dim strNHPA30Days As String = txtNhpa30days.Text
        Dim strNHPAMOAPA As String = txtNhpamoapa.Text
        Dim strNHPAnotes As String = txtNhpanotes.InnerText
        Dim strNHPASignatory As String = txtNhpasignatory.Text

        ' save NEPA, NHPA/ SECTION 106
        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "AddUpdateProjectNEPA"
            command.CommandType = CommandType.StoredProcedure

            command.Parameters.Add("@project_fk", SqlDbType.Int).Value = strProjNum
            command.Parameters.Add("@NEPA_fk", SqlDbType.Int).Value = IIf(Left(strNEPA_fk, 1) = "P", "0", strNEPA_fk)
            command.Parameters.Add("@NEPAStatus", SqlDbType.Int).Value = IIf(Left(strNEPAStatus, 1) = "P", "0", strNEPAStatus)
            command.Parameters.Add("@NEPASumStatNotes", SqlDbType.Text).Value = strNEPASumStatNotes

            command.Parameters.AddWithValue("@FONSIRODsigned", IIf(String.IsNullOrEmpty(strfonsirodsigneddate), DBNull.Value, strfonsirodsigneddate))
            command.Parameters.Add("@UserName", SqlDbType.Text).Value = struser

            command.Parameters.Add("@SupplementalEAorEIS", SqlDbType.Text).Value = strSupplementalEAorEIS
            command.Parameters.Add("@PreviousEAorSEAorPEA", SqlDbType.Text).Value = strPreviousEAorSEAorPEA
            command.Parameters.AddWithValue("@DateCompletionFINAL", IIf(String.IsNullOrEmpty(strDateCompletionFINAL), DBNull.Value, strDateCompletionFINAL))
            command.Parameters.AddWithValue("@DateofFONSI", IIf(String.IsNullOrEmpty(strDateofFONSI), DBNull.Value, strDateofFONSI))
            command.Parameters.Add("@EISFINAL", SqlDbType.Text).Value = strEISFINAL
            command.Parameters.Add("@EISrod", SqlDbType.Text).Value = strEISrod
            command.Parameters.Add("@NEPASignatory", SqlDbType.Text).Value = strNEPASignatory
            command.Parameters.Add("@SupplementalEAorEISnote", SqlDbType.Text).Value = strSupplementalEAorEISnote

            command.Parameters.Add("@NHPAConsultationRequired", SqlDbType.Text).Value = strNhpaconsultation
            command.Parameters.AddWithValue("@NHPALettersSent", IIf(String.IsNullOrEmpty(strNHPALettersSent), DBNull.Value, strNHPALettersSent))
            command.Parameters.AddWithValue("@NHPA30Days", IIf(String.IsNullOrEmpty(strNHPA30Days), DBNull.Value, strNHPA30Days))

            command.Parameters.Add("@NHPAMOAPA", SqlDbType.Text).Value = strNHPAMOAPA
            command.Parameters.Add("@NHPAnotes", SqlDbType.Text).Value = strNHPAnotes
            command.Parameters.Add("@NHPASignatory", SqlDbType.Text).Value = strNHPASignatory

            command.Parameters.Add("@DueDiligenceReportsNote", SqlDbType.Text).Value = strDueDiligenceReportsNote

            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()

            ' clean up temporary files
            Using conn2 As New SqlConnection(ConnStr)
                Dim command2 As New SqlCommand
                command2.Connection = conn2
                command2.CommandText = "Delete  FROM tempSchedule where project_fk=" + varId + " and mileStone_FK >= 36 and mileStone_FK <=42 and createdBy = '" + struser.Trim() + "'"
                command2.CommandType = CommandType.Text
                conn2.Open()
                command2.ExecuteNonQuery()
                conn2.Close()
            End Using

            Using conn3 As New SqlConnection(ConnStr)
                Dim command3 As New SqlCommand
                command3.Connection = conn3
                command3.CommandText = "Delete From tempProjectEnvironmentalDueDiligenceReport Where project_fk =" + varId + " and createdBy = '" + struser.Trim() + "'"
                command3.CommandType = CommandType.Text
                conn3.Open()
                command3.ExecuteNonQuery()
                conn3.Close()
            End Using

            Using conn4 As New SqlConnection(ConnStr)
                Dim command4 As New SqlCommand
                command4.Connection = conn4
                command4.CommandText = " Delete From tempProjectEnvironmentalNHPA Where project_fk =" + varId + " and createdBy = '" + struser.Trim() + "'"
                command4.CommandType = CommandType.Text
                conn4.Open()
                command4.ExecuteNonQuery()
                conn4.Close()
            End Using


            ' save NHPA questions with anticipatedDate and ActualDate into temp table
            btnSaveInsertOperationTemp(hdnNHPA_fk_1.Value, rbPhase1.SelectedValue, txtPhase1AnticipatedDate.Text, txtPhase1ActualDate.Text)
            btnSaveInsertOperationTemp(hdnNHPA_fk_2.Value, rbPhase2.SelectedValue, txtPhase2AnticipatedDate.Text, txtPhase2ActualDate.Text)
            btnSaveInsertOperationTemp(hdnNHPA_fk_3.Value, rbPhase1.SelectedValue, txtAdditionalSect106AnticipatedDate.Text, txtAdditionalSect106ActualDate.Text)

            Dim environmentalService As New EnvironmentalService()

            ' save schedules into temp table
            environmentalService.InsertScheduleforEnvironmentalTemp(txtEnvcontractawardproswpectus.Text, txtEnvcontractawardoriginal.Text, txtEnvcontractawardrevised.Text, txtEnvcontractawardactual.Text, 36, varId, lblUserNm.Text)
            environmentalService.InsertScheduleforEnvironmentalTemp(txtDuedilligeneceprospectus.Text, txtDuedilligeneceoriginal.Text, txtDuedilligenecerevised.Text, txtDuedilligeneceactual.Text, 37, varId, lblUserNm.Text)
            environmentalService.InsertScheduleforEnvironmentalTemp(txtAnticipatednepadocumentationkickoffprospectus.Text, txtAnticipatednepadocumentationkickofforiginal.Text, txtAnticipatednepadocumentationkickoffrevised.Text, txtAnticipatednepadocumentationkickoffactual.Text, 39, varId, lblUserNm.Text)
            environmentalService.InsertScheduleforEnvironmentalTemp(txtAnticipateddraftnepadocumentdateprospectus.Text, txtAnticipateddraftnepadocumentdateoriginal.Text, txtAnticipateddraftnepadocumentdaterevised.Text, txtAnticipateddraftnepadocumentdateactual.Text, 40, varId, lblUserNm.Text)
            environmentalService.InsertScheduleforEnvironmentalTemp(txtAnticipatedfinalnepadocumentprospectus.Text, txtAnticipatedfinalnepadocumentoriginal.Text, txtAnticipatedfinalnepadocumentrevised.Text, txtAnticipatedfinalnepadocumentactual.Text, 41, varId, lblUserNm.Text)
            environmentalService.InsertScheduleforEnvironmentalTemp(txtAnticipatednepadecisionfonsiprospectus.Text, txtAnticipatednepadecisionfonsioriginal.Text, txtAnticipatednepadecisionfonsirevised.Text, txtAnticipatednepadecisionfonsiactual.Text, 42, varId, lblUserNm.Text)

            ' save checkboxes into temp table 
            InsertdataTemp()


            ' save data stored in temp tables to permanent table
            SaveEnvironmentalNHPA_Schedule_DueDiligenceReport()

            ScriptManager.RegisterClientScriptBlock(Me, [GetType](), "Message", "SaveAlertMsg('Records Added Successfully.');", True)

        End Using


        'PROJECT COMMITMENTS AND ANNUAL REPORTING
        Dim strwetlandMitigation As String = txtWetlandmitigation.InnerText.ToString()
        Dim strNhpareportsstipulations As String = txtNhpareportsstipulations.InnerText.ToString()
        Dim strEsamitigation As String = txtEsamitigation.InnerText.ToString()
        Dim strCzma As String = txtCzma.InnerText.ToString()
        Dim strStormwater As String = txtStormwater.InnerText.ToString()

        Dim strenvironmentalOverviewNote As String = txtNotes.InnerText.ToString()


        ' save PROJECT COMMITMENTS AND ANNUAL REPORTING
        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "AddUpdateProjectCommitmentAndAnnualReporting"
            command.CommandType = CommandType.StoredProcedure

            command.Parameters.Add("@project_pk", SqlDbType.Int).Value = strProjNum
            command.Parameters.Add("@wetlandMitigation", SqlDbType.Text).Value = strwetlandMitigation
            command.Parameters.Add("@ESAMitigation", SqlDbType.Text).Value = strEsamitigation
            command.Parameters.Add("@Stormwater", SqlDbType.Text).Value = strStormwater
            command.Parameters.Add("@NHPAReportsStipulations", SqlDbType.Text).Value = strNhpareportsstipulations
            command.Parameters.Add("@CZMA", SqlDbType.Text).Value = strCzma
            command.Parameters.Add("@environmentalOverviewNote", SqlDbType.Text).Value = strenvironmentalOverviewNote


            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()

        End Using

        Dim pageUrl As String = "EnvironmentalStaffSMEList.aspx"
        Response.Redirect(pageUrl)

    End Sub

    Private Function DbNullOrStringValue(ByVal value As String) As Object
        If String.IsNullOrEmpty(value) Then
            Return DBNull.Value
        Else
            Return value
        End If
    End Function

    ''' The Home image button will open the Home page.
    ''' </summary>
    Protected Sub ibHome_Click(sender As Object, e As ImageClickEventArgs) Handles ibHome.Click
        Response.Redirect("Default.aspx")
    End Sub
    ''' <summary>
    ''' The Searh image button will open the Search page.
    ''' </summary>
    Protected Sub ibSearch_Click(sender As Object, e As ImageClickEventArgs) Handles ibSearch.Click
        Response.Redirect("SearchProject.aspx")
    End Sub

    Private Function GetSchedule()

        Dim environmentalService As New EnvironmentalService()
        'propsectus
        Dim schedule1_propsectus As String = environmentalService.GetProspectusScheduleforEnvironmental(varId, 36)
        If schedule1_propsectus = "" Then
        Else
            txtEnvcontractawardproswpectus.Text = Convert.ToDateTime(schedule1_propsectus)
        End If

        Dim schedule2_propsectus As String = environmentalService.GetProspectusScheduleforEnvironmental(varId, 37)
        If schedule2_propsectus = "" Then
        Else
            txtDuedilligeneceprospectus.Text = Convert.ToDateTime(schedule2_propsectus)
        End If
        Dim schedule3_propsectus As String = environmentalService.GetProspectusScheduleforEnvironmental(varId, 38)

        Dim schedule4_propsectus As String = environmentalService.GetProspectusScheduleforEnvironmental(varId, 39)
        If schedule4_propsectus = "" Then
        Else
            txtAnticipatednepadocumentationkickoffprospectus.Text = Convert.ToDateTime(schedule4_propsectus)
        End If
        Dim schedule5_propsectus As String = environmentalService.GetProspectusScheduleforEnvironmental(varId, 40)
        If schedule5_propsectus = "" Then
        Else
            txtAnticipateddraftnepadocumentdateprospectus.Text = Convert.ToDateTime(schedule5_propsectus)
        End If
        Dim schedule6_propsectus As String = environmentalService.GetProspectusScheduleforEnvironmental(varId, 41)
        If schedule6_propsectus = "" Then
        Else
            txtAnticipatedfinalnepadocumentprospectus.Text = Convert.ToDateTime(schedule6_propsectus)
        End If
        Dim schedule7_propsectus As String = environmentalService.GetProspectusScheduleforEnvironmental(varId, 42)
        If schedule7_propsectus = "" Then
        Else
            txtAnticipatednepadecisionfonsiprospectus.Text = Convert.ToDateTime(schedule7_propsectus)
        End If
        'orignal
        Dim schedule1_orignal As String = environmentalService.GetOriginalScheduleforEnvironmental(varId, 36)
        If schedule1_orignal = "" Then
        Else
            txtEnvcontractawardoriginal.Text = Convert.ToDateTime(schedule1_orignal)
        End If

        Dim schedule2_orignal As String = environmentalService.GetOriginalScheduleforEnvironmental(varId, 37)
        If schedule2_orignal = "" Then
        Else
            txtDuedilligeneceoriginal.Text = Convert.ToDateTime(schedule2_orignal)
        End If

        Dim schedule4_orignal As String = environmentalService.GetOriginalScheduleforEnvironmental(varId, 39)
        If schedule4_orignal = "" Then
        Else
            txtAnticipatednepadocumentationkickofforiginal.Text = Convert.ToDateTime(schedule4_orignal)
        End If
        Dim schedule5_orignal As String = environmentalService.GetOriginalScheduleforEnvironmental(varId, 40)
        If schedule5_orignal = "" Then
        Else
            txtAnticipateddraftnepadocumentdateoriginal.Text = Convert.ToDateTime(schedule5_orignal)
        End If
        Dim schedule6_orignal As String = environmentalService.GetOriginalScheduleforEnvironmental(varId, 41)
        If schedule6_orignal = "" Then
        Else
            txtAnticipatedfinalnepadocumentoriginal.Text = Convert.ToDateTime(schedule6_orignal)
        End If
        Dim schedule7_orignal As String = environmentalService.GetOriginalScheduleforEnvironmental(varId, 42)
        If schedule7_orignal = "" Then
        Else
            txtAnticipatednepadecisionfonsioriginal.Text = Convert.ToDateTime(schedule7_orignal)
        End If
        'revised
        Dim schedule1_revised As String = environmentalService.GetRevisedScheduleforEnvironmental(varId, 36)
        If schedule1_revised = "" Then
        Else
            txtEnvcontractawardrevised.Text = Convert.ToDateTime(schedule1_revised)
        End If

        Dim schedule2_revised As String = environmentalService.GetRevisedScheduleforEnvironmental(varId, 37)
        If schedule2_revised = "" Then
        Else
            txtDuedilligenecerevised.Text = Convert.ToDateTime(schedule2_revised)
        End If
        Dim schedule3_revised As String = environmentalService.GetRevisedScheduleforEnvironmental(varId, 38)

        Dim schedule4_revised As String = environmentalService.GetRevisedScheduleforEnvironmental(varId, 39)
        If schedule4_revised = "" Then
        Else
            txtAnticipatednepadocumentationkickoffrevised.Text = Convert.ToDateTime(schedule4_revised)
        End If
        Dim schedule5_revised As String = environmentalService.GetRevisedScheduleforEnvironmental(varId, 40)
        If schedule5_revised = "" Then
        Else
            txtAnticipateddraftnepadocumentdaterevised.Text = Convert.ToDateTime(schedule5_revised)
        End If
        Dim schedule6_revised As String = environmentalService.GetRevisedScheduleforEnvironmental(varId, 41)
        If schedule6_revised = "" Then
        Else
            txtAnticipatedfinalnepadocumentrevised.Text = Convert.ToDateTime(schedule6_revised)
        End If
        Dim schedule7_revised As String = environmentalService.GetRevisedScheduleforEnvironmental(varId, 42)
        If schedule7_revised = "" Then
        Else
            txtAnticipatednepadecisionfonsirevised.Text = Convert.ToDateTime(schedule7_revised)
        End If
        'actual
        Dim schedule1_actual As String = environmentalService.GetActualScheduleforEnvironmental(varId, 36)
        If schedule1_actual = "" Then
        Else
            txtEnvcontractawardactual.Text = Convert.ToDateTime(schedule1_actual)
        End If

        Dim schedule2_actual As String = environmentalService.GetActualScheduleforEnvironmental(varId, 37)
        If schedule2_actual = "" Then
        Else
            txtDuedilligeneceactual.Text = Convert.ToDateTime(schedule2_actual)
        End If

        Dim schedule3_actual As String = environmentalService.GetActualScheduleforEnvironmental(varId, 38)
        Dim schedule4_actual As String = environmentalService.GetActualScheduleforEnvironmental(varId, 39)
        If schedule4_actual = "" Then
        Else
            txtAnticipatednepadocumentationkickoffactual.Text = Convert.ToDateTime(schedule4_actual)
        End If
        Dim schedule5_actual As String = environmentalService.GetActualScheduleforEnvironmental(varId, 40)
        If schedule5_actual = "" Then
        Else
            txtAnticipateddraftnepadocumentdateactual.Text = Convert.ToDateTime(schedule5_actual)
        End If
        Dim schedule6_actual As String = environmentalService.GetActualScheduleforEnvironmental(varId, 41)
        If schedule6_actual = "" Then
        Else
            txtAnticipatedfinalnepadocumentactual.Text = Convert.ToDateTime(schedule6_actual)
        End If
        Dim schedule7_actual As String = environmentalService.GetActualScheduleforEnvironmental(varId, 42)
        If schedule7_actual = "" Then
        Else
            txtAnticipatednepadecisionfonsiactual.Text = Convert.ToDateTime(schedule7_actual)
        End If

        '    environmentalService.Dispose()

    End Function


    Protected Sub rdbnselectionPhase1(ByVal sender As Object, ByVal e As EventArgs)
        If rbPhase1.Text = "1" Then
            firsthdnquestionphase1.Visible = True
            secondhdnquestionphase1.Visible = True
        Else
            firsthdnquestionphase1.Visible = False
            secondhdnquestionphase1.Visible = False
            txtPhase1AnticipatedDate.Text = ""
            txtPhase1ActualDate.Text = ""
        End If
    End Sub


    Protected Sub rdbnselectionPhase2(ByVal sender As Object, ByVal e As EventArgs)
        If rbPhase2.Text = "1" Then
            firsthdnquestionphase2.Visible = True
            secondhdnquestionphase2.Visible = True
        Else
            firsthdnquestionphase2.Visible = False
            secondhdnquestionphase2.Visible = False
            txtPhase2AnticipatedDate.Text = ""
            txtPhase2ActualDate.Text = ""
        End If
    End Sub

    Protected Sub rdbnselectionAdditionalSect106(ByVal sender As Object, ByVal e As EventArgs)
        If rbAdditionalSect106.Text = "1" Then
            firsthdnquestionAdditionalSect106.Visible = True
            secondhdnquestionAdditionalSect106.Visible = True
        Else
            firsthdnquestionAdditionalSect106.Visible = False
            secondhdnquestionAdditionalSect106.Visible = False
            txtAdditionalSect106AnticipatedDate.Text = ""
            txtAdditionalSect106ActualDate.Text = ""
        End If
    End Sub


    Private Sub GetCheckboxesrecord()
        Dim ddreport_1 As String = GetProjectEnviroDueDiligenceReportsChkboxesRecords(1)
        If ddreport_1 = "1" Then
            chkTrafficReport.Checked = True
        End If
        Dim ddreport_2 As String = GetProjectEnviroDueDiligenceReportsChkboxesRecords(2)
        If ddreport_2 = "2" Then
            chkRegulatoryReport.Checked = True
        End If
        Dim ddreport_3 As String = GetProjectEnviroDueDiligenceReportsChkboxesRecords(3)
        If ddreport_3 = "3" Then
            chkCulturalAndHistoric.Checked = True
        End If
        Dim ddreport_4 As String = GetProjectEnviroDueDiligenceReportsChkboxesRecords(4)
        If ddreport_4 = "4" Then
            chkUtilityReport.Checked = True
        End If
        Dim ddreport_5 As String = GetProjectEnviroDueDiligenceReportsChkboxesRecords(5)
        If ddreport_5 = "5" Then
            chkAirQualityReport.Checked = True
        End If
        Dim ddreport_6 As String = GetProjectEnviroDueDiligenceReportsChkboxesRecords(6)
        If ddreport_6 = "6" Then
            chkPhaseIEnvReport.Checked = True
        End If
        Dim ddreport_7 As String = GetProjectEnviroDueDiligenceReportsChkboxesRecords(7)
        If ddreport_7 = "7" Then
            chkStakeholderReport.Checked = True
        End If
        Dim ddreport_8 As String = GetProjectEnviroDueDiligenceReportsChkboxesRecords(8)
        If ddreport_8 = "8" Then
            chkNoiseReport.Checked = True
        End If
        Dim ddreport_9 As String = GetProjectEnviroDueDiligenceReportsChkboxesRecords(9)
        If ddreport_9 = "9" Then
            chkHydrologyStormwaterReport.Checked = True
        End If
        Dim ddreport_10 As String = GetProjectEnviroDueDiligenceReportsChkboxesRecords(10)
        If ddreport_10 = "10" Then
            chkLBPReport.Checked = True
        End If
        Dim ddreport_11 As String = GetProjectEnviroDueDiligenceReportsChkboxesRecords(11)
        If ddreport_11 = "11" Then
            chkAsbestosReport.Checked = True
        End If
        Dim ddreport_12 As String = GetProjectEnviroDueDiligenceReportsChkboxesRecords(12)
        If ddreport_12 = "12" Then
            chkWetlandsReport.Checked = True
        End If
        Dim ddreport_13 As String = GetProjectEnviroDueDiligenceReportsChkboxesRecords(13)
        If ddreport_13 = "13" Then
            chkEngSpeciesActReport.Checked = True
        End If
        Dim ddreport_14 As String = GetProjectEnviroDueDiligenceReportsChkboxesRecords(14)
        If ddreport_14 = "14" Then
            chkGeoTechnicalReport.Checked = True
        End If
        Dim ddreport_15 As String = GetProjectEnviroDueDiligenceReportsChkboxesRecords(15)
        If ddreport_15 = "15" Then
            chkTopographicSurveyReport.Checked = True
        End If
        Dim ddreport_16 As String = GetProjectEnviroDueDiligenceReportsChkboxesRecords(16)
        If ddreport_16 = "16" Then
            chkPhaseIIESA.Checked = True
        End If

    End Sub

    Private Function GetProjectEnviroDueDiligenceReportsChkboxesRecords(ddreportpk)
        Dim strResult As String
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "GetProjectEnviroDueDiligenceReportChkboxesRecords"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
            com.Parameters.AddWithValue("@ddreporttype", SqlDbType.Int).Value = ddreportpk
            com.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
            com.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
            strResult = com.Parameters("@Result").Value.ToString
            If strResult = "" Then
                Return strResult = "0"
            Else
                Return strResult
            End If
        End Using
    End Function


    Private Function GetNHPA()
        Dim environmentalService As New EnvironmentalService()

        Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        cmd.CommandText = "GetProjectEnvironmentalNHPA"
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
        If ds.Tables(0).Rows.Count > 0 Then

            If environmentalService.ConvertToInteger(ds.Tables(0).Rows(0).Item("1").ToString()) <> 0 Then
                If environmentalService.ConvertToInteger(ds.Tables(0).Rows(0).Item("1").ToString()) = 1 Then
                    rbPhase1.SelectedValue = 1
                    firsthdnquestionphase1.Visible = True
                    secondhdnquestionphase1.Visible = True
                ElseIf environmentalService.ConvertToInteger(ds.Tables(0).Rows(0).Item("1").ToString()) = 2 Then
                    rbPhase1.SelectedValue = 2
                ElseIf environmentalService.ConvertToInteger(ds.Tables(0).Rows(0).Item("1").ToString()) = 3 Then
                    rbPhase1.SelectedValue = 3
                End If
            End If
            txtPhase1AnticipatedDate.Text = GetprojectEnvironmentalNHPADate(strProjId, "1", "1")   ' 1 - get anticipated date
            If txtPhase1AnticipatedDate.Text <> "" Then
                txtPhase1AnticipatedDate.Text = Convert.ToDateTime(txtPhase1AnticipatedDate.Text)
            End If
            txtPhase1ActualDate.Text = GetprojectEnvironmentalNHPADate(strProjId, "1", "2")        ' 2 - get actual date
            If txtPhase1ActualDate.Text <> "" Then
                txtPhase1ActualDate.Text = Convert.ToDateTime(txtPhase1ActualDate.Text)
            End If

            If environmentalService.ConvertToInteger(ds.Tables(0).Rows(0).Item("2").ToString()) <> 0 Then
                If environmentalService.ConvertToInteger(ds.Tables(0).Rows(0).Item("2").ToString()) = 1 Then
                    rbPhase2.SelectedValue = 1
                    firsthdnquestionphase2.Visible = True
                    secondhdnquestionphase2.Visible = True
                ElseIf environmentalService.ConvertToInteger(ds.Tables(0).Rows(0).Item("2").ToString()) = 2 Then
                    rbPhase2.SelectedValue = 2
                ElseIf environmentalService.ConvertToInteger(ds.Tables(0).Rows(0).Item("2").ToString()) = 3 Then
                    rbPhase2.SelectedValue = 3
                End If
            End If
            txtPhase2AnticipatedDate.Text = GetprojectEnvironmentalNHPADate(strProjId, "2", "1")   ' 1 - get anticipated date
            If txtPhase2AnticipatedDate.Text <> "" Then
                txtPhase2AnticipatedDate.Text = Convert.ToDateTime(txtPhase2AnticipatedDate.Text)
            End If
            txtPhase2ActualDate.Text = GetprojectEnvironmentalNHPADate(strProjId, "2", "2")        ' 2 - get actual date
            If txtPhase2ActualDate.Text <> "" Then
                txtPhase2ActualDate.Text = Convert.ToDateTime(txtPhase2ActualDate.Text)
            End If

            If environmentalService.ConvertToInteger(ds.Tables(0).Rows(0).Item("3").ToString()) <> 0 Then
                If environmentalService.ConvertToInteger(ds.Tables(0).Rows(0).Item("3").ToString()) = 1 Then
                    rbAdditionalSect106.SelectedValue = 1
                    firsthdnquestionAdditionalSect106.Visible = True
                    secondhdnquestionAdditionalSect106.Visible = True
                ElseIf environmentalService.ConvertToInteger(ds.Tables(0).Rows(0).Item("3").ToString()) = 2 Then
                    rbAdditionalSect106.SelectedValue = 2
                ElseIf environmentalService.ConvertToInteger(ds.Tables(0).Rows(0).Item("3").ToString()) = 3 Then
                    rbAdditionalSect106.SelectedValue = 3
                End If
            End If
            txtAdditionalSect106AnticipatedDate.Text = GetprojectEnvironmentalNHPADate(strProjId, "3", "1")   ' 1 - get anticipated date
            If txtAdditionalSect106AnticipatedDate.Text <> "" Then
                txtAdditionalSect106AnticipatedDate.Text = Convert.ToDateTime(txtAdditionalSect106AnticipatedDate.Text)
            End If
            txtAdditionalSect106ActualDate.Text = GetprojectEnvironmentalNHPADate(strProjId, "3", "2")        ' 2 - get actual date
            If txtAdditionalSect106ActualDate.Text <> "" Then
                txtAdditionalSect106ActualDate.Text = Convert.ToDateTime(txtAdditionalSect106ActualDate.Text)
            End If

        End If

    End Function


    Private Function GetprojectEnvironmentalNHPADate(strProjId As String, nhpa_pk As String, dateType As String) As String
        Dim strResult As String
        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "GetprojectEnvironmentalNHPADate"
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = strProjId
            command.Parameters.AddWithValue("@nhpa_pk", SqlDbType.Int).Value = nhpa_pk
            command.Parameters.AddWithValue("@dateType", SqlDbType.Int).Value = dateType
            command.Parameters.Add("@Result", SqlDbType.NVarChar, 200)
            command.Parameters("@Result").Direction = ParameterDirection.Output

            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()

            strResult = command.Parameters("@Result").Value.ToString
        End Using

        Return strResult
    End Function


    Private Function Insertdata()

        If chkTrafficReport.Checked Then
            btnSubmitInsertOperationforCheckboxes(1)
        End If
        If chkRegulatoryReport.Checked Then
            btnSubmitInsertOperationforCheckboxes(2)
        End If
        If chkCulturalAndHistoric.Checked Then
            btnSubmitInsertOperationforCheckboxes(3)
        End If
        If chkUtilityReport.Checked Then
            btnSubmitInsertOperationforCheckboxes(4)
        End If
        If chkAirQualityReport.Checked Then
            btnSubmitInsertOperationforCheckboxes(5)
        End If
        If chkPhaseIEnvReport.Checked Then
            btnSubmitInsertOperationforCheckboxes(6)
        End If
        If chkStakeholderReport.Checked Then
            btnSubmitInsertOperationforCheckboxes(7)
        End If
        If chkNoiseReport.Checked Then
            btnSubmitInsertOperationforCheckboxes(8)
        End If
        If chkHydrologyStormwaterReport.Checked Then
            btnSubmitInsertOperationforCheckboxes(9)
        End If
        If chkLBPReport.Checked Then
            btnSubmitInsertOperationforCheckboxes(10)
        End If
        If chkAsbestosReport.Checked Then
            btnSubmitInsertOperationforCheckboxes(11)
        End If
        If chkWetlandsReport.Checked Then
            btnSubmitInsertOperationforCheckboxes(12)
        End If
        If chkEngSpeciesActReport.Checked Then
            btnSubmitInsertOperationforCheckboxes(13)
        End If
        If chkGeoTechnicalReport.Checked Then
            btnSubmitInsertOperationforCheckboxes(14)
        End If
        If chkTopographicSurveyReport.Checked Then
            btnSubmitInsertOperationforCheckboxes(15)
        End If
        If chkPhaseIIESA.Checked Then
            btnSubmitInsertOperationforCheckboxes(16)
        End If

    End Function


    Private Sub InsertdataTemp()

        If chkTrafficReport.Checked Then
            btnSubmitInsertOperationforCheckboxesTemp(1)
        End If
        If chkRegulatoryReport.Checked Then
            btnSubmitInsertOperationforCheckboxesTemp(2)
        End If
        If chkCulturalAndHistoric.Checked Then
            btnSubmitInsertOperationforCheckboxesTemp(3)
        End If
        If chkUtilityReport.Checked Then
            btnSubmitInsertOperationforCheckboxesTemp(4)
        End If
        If chkAirQualityReport.Checked Then
            btnSubmitInsertOperationforCheckboxesTemp(5)
        End If
        If chkPhaseIEnvReport.Checked Then
            btnSubmitInsertOperationforCheckboxesTemp(6)
        End If
        If chkStakeholderReport.Checked Then
            btnSubmitInsertOperationforCheckboxesTemp(7)
        End If
        If chkNoiseReport.Checked Then
            btnSubmitInsertOperationforCheckboxesTemp(8)
        End If
        If chkHydrologyStormwaterReport.Checked Then
            btnSubmitInsertOperationforCheckboxesTemp(9)
        End If
        If chkLBPReport.Checked Then
            btnSubmitInsertOperationforCheckboxesTemp(10)
        End If
        If chkAsbestosReport.Checked Then
            btnSubmitInsertOperationforCheckboxesTemp(11)
        End If
        If chkWetlandsReport.Checked Then
            btnSubmitInsertOperationforCheckboxesTemp(12)
        End If
        If chkEngSpeciesActReport.Checked Then
            btnSubmitInsertOperationforCheckboxesTemp(13)
        End If
        If chkGeoTechnicalReport.Checked Then
            btnSubmitInsertOperationforCheckboxesTemp(14)
        End If
        If chkTopographicSurveyReport.Checked Then
            btnSubmitInsertOperationforCheckboxesTemp(15)
        End If
        If chkPhaseIIESA.Checked Then
            btnSubmitInsertOperationforCheckboxesTemp(16)
        End If

    End Sub


    Private Sub SaveEnvironmentalNHPA_Schedule_DueDiligenceReport()
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        varId = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "AddEnvironmentalNHPA_Schedule_DueDiligenceReport"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
            com.Parameters.Add("@User", SqlDbType.VarChar).Value = struser
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
        End Using
    End Sub


    Private Sub btnSubmitInsertOperationforCheckboxes(ddreportpk)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        varId = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "AddCheckboxesValuesforDueDiligenceReport"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
            com.Parameters.AddWithValue("@ddreport_pk", SqlDbType.VarChar).Value = ddreportpk 'textarea
            com.Parameters.Add("@User", SqlDbType.VarChar).Value = struser
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
        End Using
    End Sub

    Private Sub btnSubmitInsertOperationforCheckboxesTemp(ddreportpk)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        varId = Convert.ToString(Request.QueryString("project_pk"))
        Dim struser As String = lblUserNm.Text
        Using conn As New SqlConnection(connStr)
            Dim com As New SqlCommand With {
                            .Connection = conn,
                            .CommandType = CommandType.StoredProcedure,
                            .CommandText = "AddCheckboxesValuesforDueDiligenceReportTemp"
            }
            com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
            com.Parameters.AddWithValue("@ddreport_pk", SqlDbType.VarChar).Value = ddreportpk 'textarea
            com.Parameters.Add("@User", SqlDbType.VarChar).Value = struser
            conn.Open()
            com.ExecuteNonQuery()
            conn.Close()
        End Using
    End Sub


    Private Sub btnSaveInsertOperation(hiddennhpa, answers, anticipateddate, actualdate)
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
                                .CommandText = "AddEnvironmentalNHPA"
                }
                com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
                com.Parameters.AddWithValue("@NHPA_pk", SqlDbType.Int).Value = hiddennhpa
                com.Parameters.AddWithValue("@answer_pk", SqlDbType.Int).Value = answers
                com.Parameters.Add("@anticipateddate", SqlDbType.VarChar).Value = IIf(String.IsNullOrEmpty(anticipateddate), DBNull.Value, anticipateddate)
                com.Parameters.Add("@actualdate", SqlDbType.VarChar).Value = IIf(String.IsNullOrEmpty(actualdate), DBNull.Value, actualdate)
                com.Parameters.Add("@User", SqlDbType.VarChar).Value = struser
                conn.Open()
                com.ExecuteNonQuery()
                conn.Close()
            End Using
        End If
    End Sub


    Private Sub btnSaveInsertOperationTemp(hiddennhpa, answers, anticipateddate, actualdate)
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
                                .CommandText = "AddEnvironmentalNHPATemp"
                }
                com.Parameters.AddWithValue("@project_pk", SqlDbType.Int).Value = varId
                com.Parameters.AddWithValue("@NHPA_pk", SqlDbType.Int).Value = hiddennhpa
                com.Parameters.AddWithValue("@answer_pk", SqlDbType.Int).Value = answers
                com.Parameters.Add("@anticipateddate", SqlDbType.VarChar).Value = IIf(String.IsNullOrEmpty(anticipateddate), DBNull.Value, anticipateddate)
                com.Parameters.Add("@actualdate", SqlDbType.VarChar).Value = IIf(String.IsNullOrEmpty(actualdate), DBNull.Value, actualdate)
                com.Parameters.Add("@User", SqlDbType.VarChar).Value = struser
                conn.Open()
                com.ExecuteNonQuery()
                conn.Close()
            End Using
        End If
    End Sub


End Class

