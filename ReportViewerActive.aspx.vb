Imports Microsoft.Reporting.WebForms
Imports System.Security.Principal
Imports System.Net
Imports System.Configuration
Imports System.Collections.Generic

Public Class ReportViewerActive
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        Dim varProjectId As String = Session("ProjectId")
        Dim varProjName As String = Session("ProjName")
        Dim varProjNo As String = Session("ProjNo")

        rvFS.ProcessingMode = ProcessingMode.Remote
        Dim serverReport As ServerReport = rvFS.ServerReport
        Dim reportName As String = Request.QueryString("report")
        If Not Page.IsPostBack Then

            Dim strEnvironment As String = ConfigurationManager.AppSettings("EnvironmentMode").ToString
            serverReport.ReportServerUrl = New Uri(ConfigurationManager.AppSettings("ReportServer").ToString)
            Select Case reportName
                Case "ActiveReport_VHA"
                    If strEnvironment = "PROD" Then
                        serverReport.ReportPath = "/CFM/CFM_CFMIS/ActiveReport_VHA"                '- this is the prod folder
                    Else
                        serverReport.ReportPath = "/CFM/CFMConstReports/ActiveReport_VHA"          '-this is the dev folder
                    End If

                Case "ActiveReport_NCA"
                    If strEnvironment = "PROD" Then
                        serverReport.ReportPath = "/CFM/CFM_CFMIS/ActiveReport_NCA"                '- this is the prod folder
                    Else
                        serverReport.ReportPath = "/CFM/CFMConstReports/ActiveReport_NCA"          '- this is the dev folder
                    End If

                Case "FundingHisory_VHA"
                    If strEnvironment = "PROD" Then
                        serverReport.ReportPath = ""                                               '- this is the prod folder, no report yet to put
                    Else
                        serverReport.ReportPath = "/CFM/CFMConstReports/FundingHisory_VHA"         '- this is the dev folder
                    End If

                Case "EnvironmentalProject"
                    If strEnvironment = "PROD" Then
                        serverReport.ReportPath = "/CFM/CFM_CFMIS/EnvironmentalProject"                                               '- this is the prod folder, no report yet to put
                    Else
                        serverReport.ReportPath = "/CFM/CFMConstReports/CFMIS_Enviro/EnvironmentalProject"         '- this is the dev folder
                    End If

                Case "EnviroProjectReportDetail"
                    If strEnvironment = "PROD" Then
                        serverReport.ReportPath = "/CFM/CFM_CFMIS/EnviroProjectReportDetail"                                             '- this is the prod folder, no report yet to put
                    Else
                        serverReport.ReportPath = "/CFM/CFMConstReports/CFMIS_Enviro/EnviroProjectReportDetail"         '- this is the dev folder
                    End If

                Case "Sustainability"
                    If strEnvironment = "PROD" Then
                        serverReport.ReportPath = "/CFM/CFM_CFMIS/Sustainability Report"                                             '- this is the prod folder, no report yet to put
                    Else
                        serverReport.ReportPath = "/CFM/CFM_CFMIS/CFMIS_DEV/Sustainability Report1"         '- this is the dev folder
                    End If



                    ' Case "AppendixFundingVHA"
                    '    serverReport.ReportPath = "/CFM/CFMConstReports/AppendixFundingVHA"

            End Select

            rvFS.ServerReport.Refresh()

        End If
    End Sub

End Class
