Imports Microsoft.Reporting.WebForms
Imports System.Security.Principal
Imports System.Net
Imports System.Configuration
Imports System.Collections.Generic

Public Class ReportViewer
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(ByVal sender As Object, _
                            ByVal e As System.EventArgs) _
                            Handles Me.Init

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim menu As ContentPlaceHolder = CType(Master.FindControl("cphMainMenu"), ContentPlaceHolder)
        menu.Visible = False


        Dim varProjectId As String = Session("ProjectId")
        Dim varProjName As String = Session("ProjName")
        Dim varProjNo As String = Session("ProjNo")

        rvFS.ProcessingMode = ProcessingMode.Remote
        Dim serverReport As ServerReport = rvFS.ServerReport
        Dim reportName As String = Request.QueryString("report")
        If Not Page.IsPostBack Then

            Select Case reportName
                Case "FactSreport"
                    ' serverReport.ReportPath = "/CFM/CFMConstReports/FactSreport"  '- this is the dev folder
                    serverReport.ReportPath = "/CFM/CFM_CFMIS/FactSreport"

                    Dim ProjectID As ReportParameter
                    ProjectID = New ReportParameter("ProjectID", varProjectId)
                    Dim parameters() As ReportParameter = {ProjectID}
                    serverReport.SetParameters(parameters)

                    rvFS.ServerReport.DisplayName = varProjNo + " - " + varProjName + " - " + DateTime.Now.ToString("MMM") + DateTime.Now.Year.ToString()

                Case "FactSheetreportPublic"
                    'serverReport.ReportPath = "/CFM/CFMConstReports/FactSheetreportPublic"    '-this is the dev folder
                    serverReport.ReportPath = "/CFM/CFM_CFMIS/FactSheetreportPublic"

                Case "LastProjectUpdateReport"
                    'serverReport.ReportPath = "/CFM/CFMConstReports/FactSheetreportPublic"    '-this is the dev folder
                    serverReport.ReportPath = "/CFM/CFM_CFMIS/ProjectUpdateHisoty"
					
            End Select
            rvFS.ServerReport.Refresh()

        End If

    End Sub

End Class
<Serializable()> Public Class WindowsImpersonationCredentials
    Implements IReportServerCredentials

    Public Function GetFormsCredentials(ByRef authCookie As System.Net.Cookie, ByRef userName As String, ByRef password As String, ByRef authority As String) As Boolean Implements Microsoft.Reporting.WebForms.IReportServerCredentials.GetFormsCredentials
        authCookie = Nothing
        userName = password = authority = Nothing
        Return False
    End Function

    Public ReadOnly Property ImpersonationUser() As System.Security.Principal.WindowsIdentity Implements Microsoft.Reporting.WebForms.IReportServerCredentials.ImpersonationUser
        Get
            Return WindowsIdentity.GetCurrent()
        End Get
    End Property

    Public ReadOnly Property NetworkCredentials() As System.Net.ICredentials Implements Microsoft.Reporting.WebForms.IReportServerCredentials.NetworkCredentials
        Get
            'Return New NetworkCredential("ssrs_report_services", "password", "domain")
            Return Nothing
        End Get
    End Property
End Class