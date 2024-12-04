Imports System.Drawing
Imports System.Data.SqlClient
Imports System.Globalization

Public Class FSDetails
    Inherits System.Web.UI.Page

    Dim prevVal As String
    Dim varProjectId As String

    ''' <summary>
    ''' The VA Logo at the top will be hidden for this page.
    ''' </summary>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim menu As ContentPlaceHolder = CType(Master.FindControl("cphMainMenu"), ContentPlaceHolder)
        menu.Visible = False

        'to get the project number and show it in the page title in the browser tab
        lblProjectNum.Text = CType(fvProjInfo.FindControl("lblProjNum"), Label).Text
        Me.Page.Title = "FS " + lblProjectNum.Text

        'This session values are used in reportviewer page to create the export file name
        Session("ProjName") = CType(fvProjInfo.FindControl("lblProjName"), Label).Text
        Session("ProjNo") = lblProjectNum.Text

        varProjectId = Convert.ToString(Request.QueryString("project_pk"))
        Session("ProjectId") = varProjectId
        Session("EnvSchedCount") = GetprojectEnvironmentScheduleCount()

        hlDetailsPage.NavigateUrl = "ProjectDetails.aspx?project_pk=" + varProjectId
        'lblProjPk.Text = varProjectId

        'to get the logged on user
        Dim Logon As String
        Logon = Request.LogonUserIdentity.Name
        Dim nIndex As Integer = Logon.IndexOf("\")
        Logon = Logon.Substring(nIndex + 1)
        lblUserNm.Text = Logon

        'calling the function to populate the message to show the status of the project
        ReviewStatus()
        LastReview()

        'by default the checkbox cbDue is checked and txtDue and lblDue are not visible
        'If Not Page.IsPostBack Then
        '    cbDue.Checked = True
        '    txtDue.Visible = False
        '    lblDue.Visible = False
        'End If
        'refresh the formview fvReviewDue to get the last review montn-year period and the last activity
        fvReviewDue.DataBind()
        If fvReviewDue.DataItemCount = 0 Then
            'cbDue.Checked = True
        ElseIf fvReviewDue.DataItemCount > 0 Then
            Dim strDueMonth As String = RTrim(CType(fvReviewDue.FindControl("lblShowReportDue"), Label).Text)
            Dim strCurrentMonthYr As String = DateTime.Now.Month.ToString("d2") + "-" + DateTime.Now.Year.ToString()
            Dim strCurrentActivity As String = CType(fvReviewDue.FindControl("lblLastActivity"), Label).Text
            'If strDueMonth = strCurrentMonthYr Then
            '    cbDue.Checked = True
            If strDueMonth <> strCurrentMonthYr And strCurrentActivity <> 4 Then
                cbDue.Checked = False
                'cbDue.Visible = False
                txtDue.Text = strDueMonth
                'ElseIf strDueMonth <> strCurrentMonthYr And strCurrentActivity = 4 Then
                '    cbDue.Checked = True
            End If
        End If

        If Not Page.IsPostBack Then
            GetFunding()
        End If

        Dim intMonth As Integer
        intMonth = Convert.ToInt32(DateTime.Now.Month)
        If intMonth >= "10" Then
            lblAppropriatedTh.Text = "Appropriated Through " & DateTime.Now.AddYears(1).ToString("yyyy") & ": "
        Else
            lblAppropriatedTh.Text = "Appropriated Through " & DateTime.Now.Year.ToString() & ": "
        End If

        If Session("GroupID") < 320 Then
            divProjectHealthandLeadershipHightlights.Visible = True
        Else
            divProjectHealthandLeadershipHightlights.Visible = False
        End If

    End Sub

    ''' <summary>
    ''' Clicking Submit For Review button will check if there is data in project, comment and CostEstimate
    ''' tables and will run the SP InsertFactsheetReportInfoNew to insert the information in the tempFactsheetReport
    ''' and tempFactsheetSchedule tables. 
    ''' Label lblReviewStatus will be empty.
    ''' </summary>   
    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs)
        Dim strRegion As String = DirectCast(fvProjInfo.FindControl("lblRegion"), Label).Text

        If lblFuture.Text.Contains("-") Then
            If Session("GroupID") < 311 Then
                lblFundingRequired.Text = "Review cannot be submitted. Please check funding values."
                Return
            End If
        ElseIf gvProjManager.Rows.Count = 0 Then
            lblProjManagerMsg.Text = "Project doesn't have a Project Manager"
            Return
        ElseIf strRegion = String.Empty Then
            lblProjManagerMsg.Text = "Select a region for this project"
            Return
        End If

        Dim strProjectid As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim strCity As String = DirectCast(fvProjInfo.FindControl("lblCity"), Label).Text
        Dim strState As String = DirectCast(fvProjInfo.FindControl("lblState"), Label).Text
        Dim strSiteNm As String = DirectCast(fvProjInfo.FindControl("lblProjSite"), Label).Text
        Dim strProjtitle As String = DirectCast(fvProjInfo.FindControl("lblProjTitle"), Label).Text
        Dim strProjNo As String = DirectCast(fvProjInfo.FindControl("lblProjNum"), Label).Text
        Dim strVisn As String = DirectCast(fvProjInfo.FindControl("lblVisnNo"), Label).Text

        Dim strNcaDistrict As String = DirectCast(fvProjInfo.FindControl("lblNcaDistrict"), Label).Text
        Dim strTotalEstCost As String = lblTec.Text
        Dim strAppropriateThroughCurrentYr As String = lblAppThr.Text
        Dim strApprvRqst As String = lblRequestd.Text
        Dim strFutureRqst As String = lblFuture.Text
        ' Dim strNewDue As String = txtDue.Text

        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand()
        conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        cmd.Connection = conn
        cmd.CommandText = "InsertFactsheetReportInfoNew"
        cmd.CommandType = System.Data.CommandType.StoredProcedure
        cmd.Parameters.Add("@projectID", SqlDbType.Int).Value = strProjectid
        cmd.Parameters.AddWithValue("@City", SqlDbType.Text).Value = strCity
        cmd.Parameters.AddWithValue("@State", SqlDbType.Text).Value = strState
        cmd.Parameters.AddWithValue("@SiteName", SqlDbType.Text).Value = strSiteNm
        cmd.Parameters.AddWithValue("@ProjectTitle", SqlDbType.Text).Value = strProjtitle
        cmd.Parameters.AddWithValue("@ProjectNo", SqlDbType.Text).Value = strProjNo
        cmd.Parameters.AddWithValue("@VISN", SqlDbType.Int).Value = strVisn
        cmd.Parameters.AddWithValue("@Region", SqlDbType.Text).Value = strRegion
        cmd.Parameters.AddWithValue("@NCAdistrict", SqlDbType.Text).Value = strNcaDistrict
        cmd.Parameters.Add(New SqlParameter("@TotalEstCost", strTotalEstCost.Replace(",", "")))
        cmd.Parameters.Add(New SqlParameter("@ApproCurrentYr", strAppropriateThroughCurrentYr.Replace(",", "")))
        cmd.Parameters.Add(New SqlParameter("@ApprovReq", strApprvRqst.Replace(",", "")))
        cmd.Parameters.Add(New SqlParameter("@FutureReq", strFutureRqst.Replace(",", "")))
        cmd.Parameters.AddWithValue("@ActivityID", SqlDbType.Int).Value = 1
        cmd.Parameters.AddWithValue("@ReportDue", SqlDbType.Char)
        'If cbDue.Checked Then
        cmd.Parameters("@ReportDue").Value = DateTime.Now.Month.ToString("d2") + "-" + DateTime.Now.Year.ToString()
        'Else
        'cmd.Parameters("@ReportDue").Value = strNewDue
        'End If

        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()
        'lblDuePeriod.Text = String.Empty
        'lblDue.Visible = False
        'txtDue.Visible = False
        ReviewStatus()
    End Sub
    ''' <summary>
    ''' Clicking Deny Review button will run the SP DenyReviewStatus. It will update the tempFactSheetReport table
    ''' to make the denied =2. It will also get the project manager and director email from Personnel table and open Outlook
    ''' window to send email.
    ''' </summary>
    Protected Sub btnDeny_Click(sender As Object, e As EventArgs) Handles btnDeny.Click
        Dim strProjectid As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim strProjNo As String = CType(fvProjInfo.FindControl("lblProjNum"), Label).Text
        Dim strDueMonth As String = CType(fvReviewDue.FindControl("lblShowReportDue"), Label).Text

        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand()
        conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        cmd.Connection = conn
        cmd.CommandText = "DenyReviewStatusNew"
        cmd.CommandType = System.Data.CommandType.StoredProcedure
        cmd.Parameters.Add("@ProjectId", SqlDbType.Int).Value = strProjectid
        cmd.Parameters.Add("@ProjectNo", SqlDbType.VarChar).Value = strProjNo
        cmd.Parameters.Add("@ReportDue", SqlDbType.Char).Value = strDueMonth

        Dim outPutParameter As New SqlParameter()
        outPutParameter.ParameterName = "@EmailCC"
        outPutParameter.SqlDbType = System.Data.SqlDbType.VarChar
        outPutParameter.Size = 100
        outPutParameter.Direction = System.Data.ParameterDirection.Output
        cmd.Parameters.Add(outPutParameter)

        Dim outPutParameter2 As New SqlParameter()
        outPutParameter2.ParameterName = "@EmailOut"
        outPutParameter2.SqlDbType = System.Data.SqlDbType.VarChar
        outPutParameter2.Size = 100
        outPutParameter2.Direction = System.Data.ParameterDirection.Output
        cmd.Parameters.Add(outPutParameter2)

        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()

        Dim emailCC As String = outPutParameter.Value.ToString()
        Dim email As String = outPutParameter2.Value.ToString()
        If email <> String.Empty Then
            If emailCC <> String.Empty Then
                Dim url As String = "mailto:" + email
                Dim subject As String
                Dim msgBody As String
                Dim cc As String
                cc = "?cc=" + emailCC
                subject = "&subject=Returned Factsheet Review For Project Number " + strProjNo
                msgBody = "&body=The Factsheet review has been returned for following reasons. Please submit again after correction."
                url = url + cc + subject + msgBody
             '   ClientScript.RegisterStartupScript(Me.GetType(), "OpenWin", "<script>openNewWin('" & url & "')</script>")
                ClientScript.RegisterStartupScript(Me.GetType(), "OpenWin", "<script>window.location.href=' " & url & "';</script>")																																	
                'in case there is no director for a region
            Else
                Dim url As String = "mailto:" + email
                Dim subject As String
                Dim msgBody As String
                subject = "?subject=Returned Factsheet Review For Project Number " + strProjNo
                msgBody = "&body=The Factsheet review has been returned for following reasons. Please submit again after correction."
                url = url + subject + msgBody
             '   ClientScript.RegisterStartupScript(Me.GetType(), "OpenWin", "<script>openNewWin('" & url & "')</script>")
                ClientScript.RegisterStartupScript(Me.GetType(), "OpenWin", "<script>window.location.href=' " & url & "';</script>")																																	
            End If
        End If
        ReviewStatus()
    End Sub
    ''' <summary>
    ''' Clicking Approve to Publish button will run the SP InsertFactsheetReportArchive to insert the information 
    ''' in the FactSheetReport and FactSheetReportSchedule tables for archieve.
    ''' </summary>   
    Protected Sub btnApprove_Click(sender As Object, e As EventArgs) Handles btnApprove.Click
        
        '       If lblFuture.Text.Contains("-") Then
        If lblFuture.Text.Contains("-") And Session("GroupID") < 320 Then
            lblFundingRequired.Text = "Review cannot be submitted. Please check funding values."
            Return
        End If
        Dim strProjectid As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim strProjNo As String = DirectCast(fvProjInfo.FindControl("lblProjNum"), Label).Text
        Dim varSubProjFlag As CheckBox = DirectCast(fvProjInfo.FindControl("cbSubProjFlag"), CheckBox)
        Dim strStationFk As String = DirectCast(fvProjInfo.FindControl("lblStationFk"), Label).Text
        Dim strTotalEstCost As String = lblTec.Text
        Dim strAppropriateThroughCurrentYr As String = lblAppThr.Text
        Dim strApprvRqst As String = lblRequestd.Text
        Dim strFutureRqst As String = lblFuture.Text
        Dim strDueMonth As String = CType(fvReviewDue.FindControl("lblShowReportDue"), Label).Text

        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand()
        conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        cmd.Connection = conn
        cmd.CommandText = "InsertFactsheetReportArchive"
        cmd.CommandType = System.Data.CommandType.StoredProcedure
        cmd.Parameters.Add("@projectID", SqlDbType.Int).Value = strProjectid
        cmd.Parameters.AddWithValue("@ProjectNo", SqlDbType.Text).Value = strProjNo
        cmd.Parameters.AddWithValue("@StationFk", SqlDbType.Int).Value = strStationFk
        cmd.Parameters.AddWithValue("@ReportDue", SqlDbType.Char).Value = strDueMonth
        cmd.Parameters.Add(New SqlParameter("@TotalEstCost", strTotalEstCost.Replace(",", "")))
        cmd.Parameters.Add(New SqlParameter("@ApproCurrentYr", strAppropriateThroughCurrentYr.Replace(",", "")))
        cmd.Parameters.Add(New SqlParameter("@ApprovReq", strApprvRqst.Replace(",", "")))
        cmd.Parameters.Add(New SqlParameter("@FutureReq", strFutureRqst.Replace(",", "")))
        cmd.Parameters.AddWithValue("@SubProjFlag", SqlDbType.Bit)
        If varSubProjFlag.Checked Then
            cmd.Parameters("@SubProjFlag").Value = 1
        Else
            cmd.Parameters("@SubProjFlag").Value = 0
        End If
        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()
        ReviewStatus()

        Response.Redirect("ReportViewer.aspx?report=FactSreport")
    End Sub
    ''' <summary>
    ''' If the check box is checked, the txtDue text box and lblDue label will not show.
    ''' </summary>
    Protected Sub cbDue_CheckedChanged(sender As Object, e As EventArgs) Handles cbDue.CheckedChanged
        If cbDue.Checked Then
            txtDue.Visible = False
            lblDue.Visible = False
        Else
            txtDue.Visible = True
            lblDue.Visible = True
        End If
    End Sub
    ''' <summary>
    ''' Clicking the Return button for director will run the SP ReviewReturnedByDirector and will open the
    ''' outlook page with the PM in the To box, subject and default message in the body.
    ''' </summary>
    Protected Sub btnReturnByDirector_Click(sender As Object, e As EventArgs) Handles btnReturnByDirector.Click
        Dim strProjectid As String = Convert.ToString(Request.QueryString("project_pk"))
        'Dim strProjManager As String = CType(fvProjManager.FindControl("lblPersonId"), Label).Text
        Dim strProjNo As String = CType(fvProjInfo.FindControl("lblProjNum"), Label).Text
        Dim strDueMonth As String = CType(fvReviewDue.FindControl("lblShowReportDue"), Label).Text

        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand()
        conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        cmd.Connection = conn
        cmd.CommandText = "ReviewReturnedByDirector"
        cmd.CommandType = System.Data.CommandType.StoredProcedure
        cmd.Parameters.Add("@ProjectId", SqlDbType.Int).Value = strProjectid
        'cmd.Parameters.Add("@PersonelId", SqlDbType.Int).Value = strProjManager
        cmd.Parameters.Add("@ProjectNo", SqlDbType.VarChar).Value = strProjNo
        cmd.Parameters.Add("@ReportDue", SqlDbType.Char).Value = strDueMonth

        Dim outPutParameter2 As New SqlParameter()
        outPutParameter2.ParameterName = "@EmailOut"
        outPutParameter2.SqlDbType = System.Data.SqlDbType.VarChar
        outPutParameter2.Size = 100
        outPutParameter2.Direction = System.Data.ParameterDirection.Output
        cmd.Parameters.Add(outPutParameter2)

        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()

        Dim email As String = outPutParameter2.Value.ToString()
        If email <> String.Empty Then
            Dim url As String = "mailto:" + email
            Dim subject As String
            Dim msgBody As String
            'Dim Link As String = "Click " + hlProjLink.NavigateUrl
            'Dim ProjLink As String = Link
            'ProjLink.Text = "Click here"
            'Dim ProjLink As New HyperLink
            'ProjLink.NavigateUrl = "http://cfm.vaco.va.gov/CFMIS_Factsheet/ProjectDetails.aspx?project_pk=" + strProjectid
            'Dim ProjLink As String = "Click on the <a href=\'http://cfm.vaco.va.gov/CFMIS_Factsheet/ProjectDetails.aspx?project_pk=" + strProjectid + "\'>Link</a>"
            subject = "?subject=Returned Factsheet Review For Project Number " + strProjNo
            'msgBody = "&body=The Factsheet review has been returned for following reasons. Please submit again after correction. " + ProjLink.NavigateUrl
            msgBody = "&body=The Factsheet review has been returned for following reasons. Please submit again after correction. "
            url = url + subject + msgBody
            ClientScript.RegisterStartupScript(Me.GetType(), "OpenWin", "<script>window.location.href=' " & url & "';</script>")
            '            ClientScript.RegisterStartupScript(Me.GetType(), "OpenWin", "<script>openNewWin('" & url & "');</script>")																																
        End If
        ReviewStatus()
    End Sub
    ''' <summary>
    ''' Clicking the Approve button for director will run the SP ReviewApprovedByDirector
    ''' </summary>
    Protected Sub btnApproveByDirector_Click(sender As Object, e As EventArgs) Handles btnApproveByDirector.Click
        If lblFuture.Text.Contains("-") And Session("GroupID") < 311 Then
            lblFundingRequired.Text = "Review cannot be submitted. Please check funding values."
            Return
        End If

        Dim strProjectid As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim strCity As String = DirectCast(fvProjInfo.FindControl("lblCity"), Label).Text
        Dim strState As String = DirectCast(fvProjInfo.FindControl("lblState"), Label).Text
        Dim strSiteNm As String = DirectCast(fvProjInfo.FindControl("lblProjSite"), Label).Text
        Dim strProjtitle As String = DirectCast(fvProjInfo.FindControl("lblProjTitle"), Label).Text
        Dim strProjNo As String = DirectCast(fvProjInfo.FindControl("lblProjNum"), Label).Text
        Dim strVisn As String = DirectCast(fvProjInfo.FindControl("lblVisnNo"), Label).Text
        Dim strRegion As String = DirectCast(fvProjInfo.FindControl("lblRegion"), Label).Text
        Dim strTotalEstCost As String = lblTec.Text
        Dim strAppropriateThroughCurrentYr As String = lblAppThr.Text
        Dim strApprvRqst As String = lblRequestd.Text
        Dim strFutureRqst As String = lblFuture.Text
        Dim strDueMonth As String = CType(fvReviewDue.FindControl("lblShowReportDue"), Label).Text

        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand()
        conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        cmd.Connection = conn
        cmd.CommandText = "ReviewApprovedByDirector"
        cmd.CommandType = System.Data.CommandType.StoredProcedure
        cmd.Parameters.Add("@projectID", SqlDbType.Int).Value = strProjectid
        cmd.Parameters.AddWithValue("@City", SqlDbType.Text).Value = strCity
        cmd.Parameters.AddWithValue("@State", SqlDbType.Text).Value = strState
        cmd.Parameters.AddWithValue("@SiteName", SqlDbType.Text).Value = strSiteNm
        cmd.Parameters.AddWithValue("@ProjectTitle", SqlDbType.Text).Value = strProjtitle
        cmd.Parameters.AddWithValue("@ProjectNo", SqlDbType.Text).Value = strProjNo
        cmd.Parameters.AddWithValue("@VISN", SqlDbType.Int).Value = strVisn
        cmd.Parameters.AddWithValue("@Region", SqlDbType.Text).Value = strRegion
        cmd.Parameters.Add(New SqlParameter("@TotalEstCost", strTotalEstCost.Replace(",", "")))
        cmd.Parameters.Add(New SqlParameter("@ApproCurrentYr", strAppropriateThroughCurrentYr.Replace(",", "")))
        cmd.Parameters.Add(New SqlParameter("@ApprovReq", strApprvRqst.Replace(",", "")))
        cmd.Parameters.Add(New SqlParameter("@FutureReq", strFutureRqst.Replace(",", "")))
        cmd.Parameters.Add("@ReportDue", SqlDbType.Char).Value = strDueMonth

        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()
        ReviewStatus()

    End Sub
    ''' <summary>
    ''' This is a function to populate the review status message at the top in the label lblReviewStatus.
    ''' The message color will change to red if PM needs to submit the review at any stage.
    ''' The Submit for Review/Return/Approve buttons will be visible based on the status.
    ''' </summary>
    Private Function ReviewStatus() As String
        Dim strProjectid As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim strCurrentMonthYr As String = DateTime.Now.Month.ToString("d2") + "-" + DateTime.Now.Year.ToString()
        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand()
        conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        cmd.Connection = conn
        cmd.CommandText = "ShowReviewDueInfo"
        cmd.CommandType = System.Data.CommandType.StoredProcedure
        cmd.Parameters.Add("@ProjectId", SqlDbType.Int).Value = strProjectid
        Dim outPutParameter As New SqlParameter()
        outPutParameter.ParameterName = "@Due"
        outPutParameter.SqlDbType = System.Data.SqlDbType.VarChar
        outPutParameter.Size = 100
        outPutParameter.Direction = System.Data.ParameterDirection.Output
        cmd.Parameters.Add(outPutParameter)

        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()
        Dim result As String = outPutParameter.Value.ToString()
        lblReviewStatus.Text = result
        Dim varGroup As Integer = Session("GroupID")
        'The 5 buttons in this page will be visible on condition of the review status.
        'Submit for Review button used by PM will be visible when a review has not submitted
        If lblReviewStatus.Text = "Review has not been submitted" Or lblReviewStatus.Text = "Review is due for current month" Or result.Contains("returned by Director") = True Or result.Contains("returned by Final Approver") = True Then
            lblReviewStatus.ForeColor = Drawing.Color.Red
            If varGroup = 200 Or varGroup >= 500 Then
                btnSubmit.Visible = True
                btnApprove.Visible = False
                btnDeny.Visible = False
                btnReturnByDirector.Visible = False
                btnApproveByDirector.Visible = False
                'cbDue.Visible = True
                fvReviewDue.Visible = False
            Else
                btnSubmit.Visible = True
                btnApprove.Visible = False
                btnDeny.Visible = False
                btnReturnByDirector.Visible = False
                btnApproveByDirector.Visible = False
                'cbDue.Visible = True
                fvReviewDue.Visible = False
            End If
            'Return and Approve buttons for directors will be visible when review has been submitted by PM
        ElseIf result.Contains("submitted by PM") = True Then
            lblReviewStatus.ForeColor = Drawing.Color.Green
            If varGroup = 200 Then
                btnSubmit.Visible = False
                btnApprove.Visible = False
                btnDeny.Visible = False
                btnReturnByDirector.Visible = False
                btnApproveByDirector.Visible = False
                cbDue.Visible = False
                fvReviewDue.Visible = False
            ElseIf (varGroup > 300 And varGroup <= 320) Then
                btnSubmit.Visible = False
                btnApprove.Visible = False
                btnDeny.Visible = False
                btnReturnByDirector.Visible = True
                btnApproveByDirector.Visible = True
                'cbDue.Visible = False
                fvReviewDue.Visible = False
                'ElseIf varGroup = 320 Then
                '    btnSubmit.Visible = False
                '    btnApprove.Visible = False
                '    btnDeny.Visible = False
                '    btnReturnByDirector.Visible = False
                '    btnApproveByDirector.Visible = False
                '    cbDue.Visible = False
                '    fvReviewDue.Visible = False
            ElseIf varGroup >= 500 Then
                btnSubmit.Visible = False
                btnApprove.Visible = False
                btnDeny.Visible = False
                btnReturnByDirector.Visible = True
                btnApproveByDirector.Visible = True
                'cbDue.Visible = False
                fvReviewDue.Visible = False
            End If
            'Return and Approve to Publish buttons will be visible when review has been approved by the directors
            'These buttons are for the final approver.
        ElseIf result.Contains("submitted for Final Approval") = True Then
            lblReviewStatus.ForeColor = Drawing.Color.Green
            If varGroup >= 320 Then
                btnSubmit.Visible = False
                btnApprove.Visible = True
                btnDeny.Visible = True
                btnReturnByDirector.Visible = False
                btnApproveByDirector.Visible = False
                'cbDue.Visible = False
                fvReviewDue.Visible = False
            Else
                btnSubmit.Visible = False
                btnApprove.Visible = False
                btnDeny.Visible = False
                btnReturnByDirector.Visible = False
                btnApproveByDirector.Visible = False
                'cbDue.Visible = False
                fvReviewDue.Visible = False
            End If
            'As no action is needed for this stage
        ElseIf result.Contains("Review has been approved") = True Then
            lblReviewStatus.ForeColor = Drawing.Color.Green
            btnSubmit.Visible = True
            btnApprove.Visible = False
            btnDeny.Visible = False
            btnReturnByDirector.Visible = False
            btnApproveByDirector.Visible = False
            'cbDue.Visible = False
            fvReviewDue.Visible = False
            'btnPublish.Visible = True
        End If

        Return lblReviewStatus.Text
    End Function
    ''' <summary>
    ''' This function will run the SP LastReview to get the month and year of the last published
    ''' review from FsApprovalHistory table. The result will be visible at the upper right side of
    ''' the page.
    ''' </summary>
    Private Function LastReview() As String
        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand()
        conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        cmd.Connection = conn
        cmd.CommandText = "LastReview"
        cmd.CommandType = System.Data.CommandType.StoredProcedure
        cmd.Parameters.Add("@ProjectId", SqlDbType.Int).Value = varProjectId
        Dim outPutParameter As New SqlParameter()
        outPutParameter.ParameterName = "@Published"
        outPutParameter.SqlDbType = System.Data.SqlDbType.VarChar
        outPutParameter.Size = 100
        outPutParameter.Direction = System.Data.ParameterDirection.Output
        cmd.Parameters.Add(outPutParameter)

        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()
        Dim result As String = outPutParameter.Value.ToString()
        lblLastReview.Text = result
        Return lblLastReview.Text
    End Function
    ''' <summary>
    ''' gvSchedule gridview will hide the duplicate project code for easy readability.
    ''' </summary>
    Protected Sub gvSchedule_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim btn As Button = e.Row.FindControl("btnEdit")
            'switch for first row 
            If e.Row.RowIndex = 1 Then
                Dim Gprev As GridViewRow = gvSchedule.Rows(e.Row.RowIndex - 1)
                If Gprev.Cells(3).Text.Equals(e.Row.Cells(3).Text) Then
                    e.Row.Cells(3).Text = ""
                    btn.Visible = False
                End If
            End If
            'now continue with the rest of the rows
            If e.Row.RowIndex > 1 Then
                'set reference to the row index and the current value
                Dim intC As Integer = e.Row.RowIndex
                Dim lookfor As String = e.Row.Cells(3).Text
                'Dim btn As Button = e.Row.FindControl("btnEdit")
                'now loop back through checking previous entries for matches 
                Do
                    Dim Gprev As GridViewRow = gvSchedule.Rows(intC - 1)
                    If Gprev.Cells(3).Text.Equals(e.Row.Cells(3).Text) Then
                        e.Row.Cells(3).Text = ""
                        btn.Visible = False
                    End If

                    intC = intC - 1
                Loop While intC > 0
            End If
        End If
    End Sub


    ' ''' <summary>
    ' ''' Clicking the Publish button will go to the ReportViewer page and run the FactSreport report
    ' ''' to show the archieved Fachsheet info.
    ' ''' </summary>
    'Protected Sub btnPublish_Click(sender As Object, e As EventArgs) Handles btnPublish.Click
    '    Response.Redirect("ReportViewer.aspx?report=FactSreport")
    'End Sub

    ''' <summary>
    ''' The schedule will be populated based on the main or sub project.
    ''' </summary> 
    Protected Sub OnSelectedIndexChanged(sender As Object, e As EventArgs)
        Dim strProjId As String = TryCast(gvSchedule.SelectedRow.FindControl("lblProjId"), Label).Text
        Dim varSubProjFlag As CheckBox = CType(gvSchedule.SelectedRow.FindControl("cbSubProjFlag"), CheckBox)
        Dim IsSubProj As Integer
        If varSubProjFlag.Checked Then
            IsSubProj = 1
        Else
            IsSubProj = 0
        End If

        Session("ProjectIdFSD") = strProjId

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
        mpeEditSchedule.Show()
       
    End Sub 
   
    ''' <summary>
    ''' The repeater will not show same stage name on each row.
    ''' The stage label will have a grey background color for the stages that are relevant to factsheet.
    ''' </summary> 
    Protected Sub rptSchedule_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
        Dim lblID As Label = DirectCast(e.Item.FindControl("lblStage"), Label)
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
        ' Environmental - rvb 09/16/2021
        If lblID.Text.Trim() = "Environmental" Then
            Dim lblschedule As Label = DirectCast(e.Item.FindControl("lblSchedule"), Label)
            Dim txtprospectus As TextBox = DirectCast(e.Item.FindControl("txtProspectus"), TextBox)
            Dim txtoriginal As TextBox = DirectCast(e.Item.FindControl("txtOriginal"), TextBox)
            Dim txtrevised As TextBox = DirectCast(e.Item.FindControl("txtRevised"), TextBox)
            Dim txtactual As TextBox = DirectCast(e.Item.FindControl("txtActual"), TextBox)

            If txtprospectus.Text.Trim() = "" And txtoriginal.Text.Trim() = "" And txtrevised.Text.Trim() = "" And txtactual.Text.Trim() = "" Then
                txtprospectus.Attributes.Add("style", "display:none;")
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

        If (lblMilestone.Text = "Project Book Award") Or (lblMilestone.Text = "Project Book Complete") Or
            (lblMilestone.Text = "Award the design contract") Or (lblMilestone.Text = "Design completed") Or
            (lblMilestone.Text = "Award Construction Contract") Or (lblMilestone.Text = "Contract Completion Date") Then
            lblMilestone.Attributes.Add("style", "background-color:#f6dba4;")
        End If


        'The Actual date will be disabled for general users if there is a date in the text box.
        'The text box will always be enabled for admin users.
        Dim txtActualDt As TextBox = DirectCast(e.Item.FindControl("txtActual"), TextBox)
        If Session("GroupID") <= 200 Then
            If txtActualDt.Text <> "" Then
                txtActualDt.Enabled = False
            Else
                txtActualDt.Enabled = True
            End If
        End If
    End Sub
    
    ''' <summary>
    ''' This is a method to delete schedule by project id when there is update.
    ''' </summary> 
    Private Sub DeleteSchedule()
        'Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim strProjFk As Integer = TryCast(gvSchedule.SelectedRow.FindControl("lblProjId"), Label).Text

        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        cmd.CommandText = "ScheduleDelete"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = conn
        cmd.Parameters.Add(New SqlParameter("@ProjectId", strProjFk))
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

        'Dim strProjId As String = Convert.ToString(Request.QueryString("project_pk"))
        Dim strProjFk As Integer
        Dim intMilestoneId As Integer
        Dim strProspectus As String
        Dim strOriginal As String
        Dim strRevised As String
        Dim strActual As String
        Dim strUser As String
        'Dim checkIsProspectus As CheckBox
        Dim IsProjectSchedsDeletedFromTempTable As Boolean = False
        Dim conn As New SqlConnection()
        Dim cmd As New SqlCommand

        Try

            conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
            cmd.Connection = conn
            conn.Open()
            For Each item As RepeaterItem In rptSchedule.Items
                If (item.ItemType = ListItemType.Item Or item.ItemType = ListItemType.AlternatingItem) Then
                    ' intenvironmentalMilestone = Convert.ToInt32((DirectCast(item.FindControl("hdnenvironmentalMilestone"), HiddenField)).Value)

                    ' exclude environmental milestones
                    If (DirectCast(item.FindControl("hdnenvironmentalMilestone"), HiddenField)).Value = "False" Then       ' intenvironmentalMilestone = 0 Then
                        intMilestoneId = Convert.ToInt32((DirectCast(item.FindControl("hdnMilestoneId"), HiddenField)).Value)
                        strProjFk = Session("ProjectIdFSD")
                        strProspectus = Convert.ToString(DirectCast(item.FindControl("txtProspectus"), TextBox).Text)
                        strOriginal = DirectCast(item.FindControl("txtOriginal"), TextBox).Text
                        strRevised = DirectCast(item.FindControl("txtRevised"), TextBox).Text
                        strActual = DirectCast(item.FindControl("txtActual"), TextBox).Text
                        strUser = lblUserNm.Text

                        ' check if deleting schedules pertaining to this project from temporary table has already been executed
                        If IsProjectSchedsDeletedFromTempTable = False Then
                            DeleteProjectFromTempTableFSD(strProjFk)
                            IsProjectSchedsDeletedFromTempTable = True
                        End If

                        '       cmd = New SqlCommand("ScheduleAddUpdate", conn)
                        cmd = New SqlCommand("ScheduleAddUpdateToTempTable", conn)
                        cmd.CommandType = CommandType.StoredProcedure

                        cmd.Parameters.AddWithValue("@ProjectId", strProjFk)
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

            DeletePreviousScheduleAndSaveNewScheduleFSD(strProjFk)
            conn.Close()
            lblUpdtMsg.Text = "Schedule updated"
        Catch ex As Exception
            lblUpdtMsg.Text = "Unable to update Schedule due to error(s)!"
        End Try

        mpeEditSchedule.Hide()
        gvSchedule.DataBind()
        Response.Redirect("~/FSDetails.aspx?project_pk=" + varProjectId)
    End Sub


    Private Sub DeletePreviousScheduleAndSaveNewScheduleFSD(strProjFk As String)

        Dim strUser As String
        strUser = lblUserNm.Text

        Dim conndps As New SqlConnection()
        conndps.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmddps As New SqlCommand
        '  cmd.CommandText = "ScheduleDelete"
        cmddps.CommandText = "ScheduleDeletePreviousScheduleAndSaveNewSchedule"
        cmddps.CommandType = CommandType.StoredProcedure
        cmddps.Connection = conndps
        cmddps.Parameters.Add(New SqlParameter("@ProjectId", strProjFk))
        cmddps.Parameters.Add(New SqlParameter("@Username", strUser))

        If (conndps.State = ConnectionState.Closed) Then
            conndps.Open()
        End If
        cmddps.ExecuteNonQuery()
        If (conndps.State = ConnectionState.Open) Then
            conndps.Close()
        End If

    End Sub

    ''' <summary>
    ''' This is a method to delete project schedules from temp schedule table prior to populating the table with the updated ones.
    ''' </summary> 
    Private Sub DeleteProjectFromTempTableFSD(strProjFk As Integer)
        Dim strUser As String
        strUser = lblUserNm.Text

        Dim conndpf As New SqlConnection()
        conndpf.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmddpf As New SqlCommand
        '  cmd.CommandText = "ScheduleDelete"
        cmddpf.CommandText = "ScheduleDeleteProjectFromTempTable"
        cmddpf.CommandType = CommandType.StoredProcedure
        cmddpf.Connection = conndpf
        cmddpf.Parameters.Add(New SqlParameter("@ProjectId", strProjFk))
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
    ''' Clicking Edit button in the Scope gridview will open the modal popup to edit scope information
    ''' </summary>
    Protected Sub btnEditScope_Click(sender As Object, e As EventArgs)
        mpeEditScope.Show()
        'fvEditScope.DataBind()
    End Sub

    ''' <summary>
    ''' Clicking Edit button in the Scope gridview will open the modal popup to edit scope information
    ''' </summary>
    'Protected Sub btnEditScopeExternal_Click(sender As Object, e As EventArgs)
    '    mpeEditScopeExternal.Show()
    'End Sub

    ''' <summary>
    ''' Clicking Edit button in the Status gridview will open the modal popup to edit status information
    ''' </summary>
    Protected Sub btnEditStatus_Click(sender As Object, e As EventArgs)
        mpeEditStatus.Show()
    End Sub
    ''' <summary>
    ''' Clicking Save button in the status modal popup will run the UpdateStatus stored procedure
    ''' and will update the status information.
    ''' </summary>
    Protected Sub lbUpdtStatus_Click(sender As Object, e As EventArgs) Handles lbUpdtStatus.Click
        Dim strStatus As String = CType(fvEditStatus.FindControl("txtEditStatus"), TextBox).Text
        Dim strStageTp As String = CType(fvEditStatus.FindControl("ddlStatusTp"), DropDownList).SelectedValue
        Dim strStatusId As String = CType(fvEditStatus.FindControl("lblStatusId"), Label).Text
        Dim strProjId As String = CType(fvEditStatus.FindControl("lblProjId"), Label).Text
        Dim strUser As String = lblUserNm.Text

        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandType = CommandType.StoredProcedure
            command.CommandText = "UpdateStatus"

            command.Parameters.AddWithValue("@Comment_PK", SqlDbType.Int).Value = strStatusId
            command.Parameters.AddWithValue("@project_FK", SqlDbType.Int).Value = strProjId
            command.Parameters.AddWithValue("@Comment", SqlDbType.NVarChar).Value = strStatus
            command.Parameters.AddWithValue("@StageType", SqlDbType.Int).Value = strStageTp
            command.Parameters.AddWithValue("@username", SqlDbType.VarChar).Value = strUser
            command.Parameters.Add("@Result", SqlDbType.VarChar, 100)
            command.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()

            lblUpdtStatusMsg.Text = command.Parameters("@Result").Value.ToString
        End Using
        gvStatus.DataBind()

    End Sub
    ''' <summary>
    ''' Clicking Save button in the scope modal popup will run the UpdateScope stored procedure
    ''' and will update the scope information.
    ''' </summary>
    Protected Sub lbUpdtScope_Click(sender As Object, e As EventArgs) Handles lbUpdtScope.Click
        Dim strScopeId As String = CType(fvEditScope.FindControl("lblCommentId"), Label).Text
        Dim strProjId As String = CType(fvEditScope.FindControl("lblProjetId"), Label).Text
        Dim strScope As String = CType(fvEditScope.FindControl("txtEditScope"), TextBox).Text
        Dim strUser As String = lblUserNm.Text

        'Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        'Using conn As New SqlConnection(ConnStr)
        '    Dim command As New SqlCommand
        '    command.Connection = conn
        '    command.CommandType = CommandType.StoredProcedure
        '    command.CommandText = "UpdateScope"

        '    command.Parameters.AddWithValue("@Comment_PK", SqlDbType.Int).Value = strScopeId
        '    command.Parameters.AddWithValue("@project_FK", SqlDbType.Int).Value = strProjId
        '    command.Parameters.AddWithValue("@Comment", SqlDbType.NVarChar).Value = strScope
        '    command.Parameters.AddWithValue("@username", SqlDbType.VarChar).Value = strUser
        '    command.Parameters.Add("@Result", SqlDbType.VarChar, 100)
        '    command.Parameters("@Result").Direction = ParameterDirection.Output

        '    conn.Open()
        '    command.ExecuteNonQuery()
        '    conn.Close()
        '    lblUpdtScopeMsg.Text = command.Parameters("@Result").Value.ToString
        'End Using

        lblUpdtScopeMsg.Text = SaveScope(strScopeId, strProjId, strScope, strUser)
        gvSubProjScope.DataBind()
    End Sub

    ''' <summary>
    ''' Clicking Save button in the scope modal popup will run the UpdateScope stored procedure
    ''' and will update the scope information.
    ''' </summary>
    'Protected Sub lbUpdtScopeExternal_Click(sender As Object, e As EventArgs) Handles lbUpdtScopeExternal.Click
    '    Dim strScopeId As String = CType(fvEditScopeExternal.FindControl("lblCommentId"), Label).Text
    '    Dim strProjId As String = CType(fvEditScopeExternal.FindControl("lblProjetId"), Label).Text
    '    Dim strScope As String = CType(fvEditScopeExternal.FindControl("txtEditScopeExternal"), TextBox).Text
    '    Dim strUser As String = lblUserNm.Text

    '    lblUpdtScopeMsg.Text = SaveScope(strScopeId, strProjId, strScope, strUser)
    '    gvSubProjScopeExternal.DataBind()
    'End Sub

    Private Function SaveScope(strScopeId As String, strProjId As String, strScope As String, strUser As String) As String

        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandType = CommandType.StoredProcedure
            command.CommandText = "UpdateScope"

            command.Parameters.AddWithValue("@Comment_PK", SqlDbType.Int).Value = strScopeId
            command.Parameters.AddWithValue("@project_FK", SqlDbType.Int).Value = strProjId
            command.Parameters.AddWithValue("@Comment", SqlDbType.NVarChar).Value = strScope
            command.Parameters.AddWithValue("@username", SqlDbType.VarChar).Value = strUser
            command.Parameters.Add("@Result", SqlDbType.VarChar, 100)
            command.Parameters("@Result").Direction = ParameterDirection.Output

            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()
            Return command.Parameters("@Result").Value.ToString
        End Using

    End Function

    ''' <summary>
    ''' This page shows the funding in a different way than project details page. this uses the
    ''' SP GetFSFunding to get the funding information for the factsheet.
    ''' </summary>
    Private Sub GetFunding()
        Dim strProjId = Convert.ToString(Request.QueryString("project_pk"))

        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Dim cmd As New SqlCommand
        cmd.CommandText = "GetFSFunding"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.Add(New SqlParameter("@ProjectId", strProjId))
        cmd.Parameters.Add("@ShowTEC", SqlDbType.VarChar, 100)
        cmd.Parameters("@ShowTEC").Direction = ParameterDirection.Output
        cmd.Parameters.Add("@ShowAppropriationThrough", SqlDbType.VarChar, 100)
        cmd.Parameters("@ShowAppropriationThrough").Direction = ParameterDirection.Output
        cmd.Parameters.Add("@ShowRequestedFund", SqlDbType.VarChar, 100)
        cmd.Parameters("@ShowRequestedFund").Direction = ParameterDirection.Output
        cmd.Parameters.Add("@ShowFutureRequest", SqlDbType.VarChar, 100)
        cmd.Parameters("@ShowFutureRequest").Direction = ParameterDirection.Output
        cmd.Parameters.Add("@ShowRequestFndLabel", SqlDbType.VarChar, 100)
        cmd.Parameters("@ShowRequestFndLabel").Direction = ParameterDirection.Output
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
        Dim customCurrencyInfo As CultureInfo = CultureInfo.CreateSpecificCulture("en-US")
        customCurrencyInfo.NumberFormat.CurrencyNegativePattern = 1
        Dim decTec As Decimal
        Dim decAppropriate As Decimal
        Dim decRequested As Decimal
        Dim decFutureReq As Decimal
        Dim strRequstLable As String

        decTec = Convert.ToDecimal(cmd.Parameters("@ShowTEC").Value.ToString())
        decAppropriate = Convert.ToDecimal(cmd.Parameters("@ShowAppropriationThrough").Value.ToString())
        decRequested = Convert.ToDecimal(cmd.Parameters("@ShowRequestedFund").Value.ToString())
        decFutureReq = Convert.ToDecimal(cmd.Parameters("@ShowFutureRequest").Value.ToString())
        strRequstLable = cmd.Parameters("@ShowRequestFndLabel").Value.ToString()
        lblTec.Text = decTec.ToString("C", customCurrencyInfo)
        lblAppThr.Text = decAppropriate.ToString("C", customCurrencyInfo)
        lblRequestd.Text = decRequested.ToString("C", customCurrencyInfo)
        lblFuture.Text = decFutureReq.ToString("C", customCurrencyInfo)
        lblReqstFnd.Text = strRequstLable
        'If lblFuture.Text.Contains("-") Then
        '    lblFundingRequired.Text = "Please check funding values."
        'End If
        If lblFuture.Text.Contains("-") Then
            lblFundingRequired.Text = "Please check funding values."
            lblFutureDisp.Text = "TBD"
        Else
            lblFutureDisp.Text = lblFuture.Text
        End If
        If decTec = 0 Then
            lblTecDisp.Text = "TBD"
            ' lblTecDisp.Text = "$0.00"
        Else
            lblTecDisp.Text = lblTec.Text
        End If

    End Sub
    ''' <summary>
    ''' Clicking Edit button in the Comment gridview will open the modal popup to edit comment information
    ''' </summary>
    Protected Sub btnEditComment_Click(sender As Object, e As EventArgs)
        mpeEditComment.Show()
    End Sub

    '' <summary>
    '' Clicking Edit button in the Comment gridview will open the modal popup to edit comment information
    '' </summary>
    Protected Sub btnEditCommentExternal_Click(sender As Object, e As EventArgs)
        mpeEditCommentExternal.Show()
    End Sub

    ''' <summary>
    ''' Clicking Save button in the scope modal popup will run the UpdateScope stored procedure
    ''' and will update the scope information.
    ''' </summary>
    Protected Sub lbUpdtComment_Click(sender As Object, e As EventArgs) Handles lbUpdtComment.Click
        Dim strCommentId As String = CType(fvEditComment.FindControl("lblCommentId"), Label).Text
        Dim strProjId As String = CType(fvEditComment.FindControl("lblProjetId"), Label).Text
        Dim strComment As String = CType(fvEditComment.FindControl("txtEditComment"), TextBox).Text
        Dim strUser As String = lblUserNm.Text

        lblUpdateCommentMsg.Text = SaveComment(strCommentId, strProjId, strComment, strUser)
        gvComments.DataBind()
    End Sub

    Protected Sub lbUpdtCommentExternal_Click(sender As Object, e As EventArgs) Handles lbUpdtCommentExternal.Click
        Dim strCommentId As String = CType(fvEditCommentExternal.FindControl("lblCommentId"), Label).Text
        Dim strProjId As String = CType(fvEditCommentExternal.FindControl("lblProjetId"), Label).Text
        Dim strComment As String = CType(fvEditCommentExternal.FindControl("txtEditCommentExternal"), TextBox).Text
        Dim strUser As String = lblUserNm.Text
        Dim strRiskType As String = CType(fvEditCommentExternal.FindControl("ddlRiskType"), DropDownList).SelectedValue

        lblUpdateCommentMsgExternal.Text = SaveCommentExternal(strCommentId, strProjId, strComment, strUser, strRiskType)
        gvCommentsExternal.DataBind()
    End Sub

    Private Function SaveComment(strCommentId As String, strProjId As String, strComment As String, strUser As String) As String
        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandType = CommandType.StoredProcedure
            command.CommandText = "UpdateProjectComment"

            command.Parameters.AddWithValue("@Comment_PK", SqlDbType.Int).Value = strCommentId
            command.Parameters.AddWithValue("@project_FK", SqlDbType.Int).Value = strProjId
            command.Parameters.AddWithValue("@Comment", SqlDbType.NVarChar).Value = strComment
            '            command.Parameters.AddWithValue("@RiskType", SqlDbType.Int).Value = vbNull
            command.Parameters.AddWithValue("@username", SqlDbType.VarChar).Value = strUser
            command.Parameters.Add("@Result", SqlDbType.VarChar, 100)
            command.Parameters("@Result").Direction = ParameterDirection.Output

            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()
            Return command.Parameters("@Result").Value.ToString
        End Using
    End Function

    Private Function SaveCommentExternal(strCommentId As String, strProjId As String, strComment As String, strUser As String, strRiskType As String) As String
        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(ConnStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandType = CommandType.StoredProcedure
            command.CommandText = "UpdateLeadershipHighlightsViaFactSheetDetails"

            command.Parameters.AddWithValue("@Comment_PK", SqlDbType.Int).Value = strCommentId
            command.Parameters.AddWithValue("@project_FK", SqlDbType.Int).Value = strProjId
            command.Parameters.AddWithValue("@Comment", SqlDbType.NVarChar).Value = strComment
            command.Parameters.AddWithValue("@CommentType", SqlDbType.Int).Value = 5
            command.Parameters.AddWithValue("@RiskType", SqlDbType.Int).Value = strRiskType
            command.Parameters.AddWithValue("@username", SqlDbType.VarChar).Value = strUser
            command.Parameters.Add("@Result", SqlDbType.VarChar, 100)
            command.Parameters("@Result").Direction = ParameterDirection.Output

            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()
            Return command.Parameters("@Result").Value.ToString
        End Using
    End Function


    Protected Sub fvEditScope_DataBound(sender As Object, e As EventArgs)

        Dim txtEditScope As TextBox = DirectCast(fvEditScope.FindControl("txtEditScope"), TextBox)
        Dim lblShowScopeMsg As Label = DirectCast(fvEditScope.FindControl("lblShowScopeMsg"), Label)

        If Not txtEditScope Is Nothing Then
            Dim varSubProjFlag As CheckBox = CType(fvEditScope.FindControl("cbSubProjFlagScope"), CheckBox)
            '    Dim maxLength As String = "675"
            If varSubProjFlag.Checked Then
                '    maxLength = "350"
                If Not lblShowScopeMsg Is Nothing Then lblShowScopeMsg.Text = lblShowScopeMsg.Text + " (limit up to 350 chars)"
            Else
                If Not lblShowScopeMsg Is Nothing Then lblShowScopeMsg.Text = lblShowScopeMsg.Text + " (limit up to 675 chars)"
            End If

            '            If Not txtEditScope Is Nothing Then txtEditScope.Attributes.Add("MaxLength", maxLength)
        End If


    End Sub

    'Protected Sub fvEditScopeExternal_DataBound(sender As Object, e As EventArgs)

    '    Dim txtEditScopeExternal As TextBox = DirectCast(fvEditScopeExternal.FindControl("txtEditScopeExternal"), TextBox)

    '    If Not txtEditScopeExternal Is Nothing Then
    '        Dim varSubProjFlag As CheckBox = CType(fvEditScopeExternal.FindControl("cbSubProjFlagScope"), CheckBox)
    '        Dim maxLength As String = "675"
    '        If varSubProjFlag.Checked Then
    '            maxLength = "350"
    '        End If

    '        If Not txtEditScopeExternal Is Nothing Then txtEditScopeExternal.Attributes.Add("MaxLength", maxLength)
    '    End If

    'End Sub

    Protected Sub fvEditComment_DataBound(sender As Object, e As EventArgs)

        '    Dim txtEditComment As TextBox = DirectCast(fvEditComment.FindControl("txtEditComment"), TextBox)
        Dim lblShowCommentMsg As Label = DirectCast(fvEditComment.FindControl("lblShowCommentMsg"), Label)

        '      If Not txtEditComment Is Nothing Then
        Dim varSubProjFlag As CheckBox = CType(fvEditComment.FindControl("cbSubProjFlagScope"), CheckBox)
        '    Dim maxLength As String = "675"

        '       If Not lblShowCommentMsg Is Nothing Then lblShowCommentMsg.Text = lblShowCommentMsg.Text + " (limit up to 675 chars)"
        ' If Not txtEditComment Is Nothing Then txtEditComment.Attributes.Add("MaxLength", maxLength)
        '     End If

    End Sub


    Protected Sub fvEditCommentExternal_DataBound(sender As Object, e As EventArgs)

        Dim txtEditCommentExternal As TextBox = DirectCast(fvEditCommentExternal.FindControl("txtEditCommentExternal"), TextBox)

        If Not txtEditCommentExternal Is Nothing Then
            Dim varSubProjFlag As CheckBox = CType(fvEditCommentExternal.FindControl("cbSubProjFlagScope"), CheckBox)
            'Dim lblCreatedDate As Label = DirectCast(fvEditCommentExternal.FindControl("lblCreatedDate"), Label)
            'If Not lblCreatedDate Is Nothing Then
            '    If (lblCreatedDate.Text.ToString = "") Or (lblCreatedDate.Text.ToString <> "" AndAlso Convert.ToDateTime(lblCreatedDate.Text.ToString) >= Convert.ToDateTime("11/08/2020")) Then
            If txtEditCommentExternal.Text.Length <= 675 Then

                '       txtEditCommentExternal.Attributes.Add("MaxLength", "675")
                txtEditCommentExternal.Attributes.Add("onKeyPress", "return (this.value.length <= 675);")
                txtEditCommentExternal.Attributes.Add("onchange", "validateLength(this);")
                txtEditCommentExternal.Attributes.Add("onkeyup", "validateLength(this);")
                txtEditCommentExternal.Attributes.Add("onpaste", "validateLength(this);")

            End If
            'End If
        End If

    End Sub

    ''' <summary>
    ''' gvSchedule gridview will hide the duplicate project code for easy readability.
    ''' </summary>
    Protected Sub gvSubProjScope_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim btn As Button = e.Row.FindControl("btnEditScope")

            If Session("GroupID") < 320 Then
                btn.Enabled = False
            End If
        End If
    End Sub

    ''' <summary>
    ''' gvSchedule gridview will hide the duplicate project code for easy readability.
    ''' </summary>
    Protected Sub gvCommentsExternal_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.Cells(4).Text = "Red" Then
                e.Row.Cells(4).BackColor = System.Drawing.Color.Red
            ElseIf e.Row.Cells(4).Text = "Yellow" Then
                e.Row.Cells(4).BackColor = System.Drawing.Color.Yellow
            Else
                e.Row.Cells(4).BackColor = System.Drawing.Color.Green
            End If
        End If
    End Sub


    ''' <summary>
    ''' gvSchedule gridview will hide the duplicate project code for easy readability.
    ''' </summary>
    'Protected Sub gvSubProjScopeExternal_RowDataBound(sender As Object, e As GridViewRowEventArgs)
    '    If e.Row.RowType = DataControlRowType.DataRow Then
    '        Dim btn As Button = e.Row.FindControl("btnEditScopeExternal")

    '        If Session("GroupID") < 320 Then
    '            btn.Enabled = False
    '        End If
    '    End If
    'End Sub

    ' added by RVB 09/26/2021
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

    ' end



End Class

