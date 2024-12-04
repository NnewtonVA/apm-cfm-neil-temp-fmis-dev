Imports System.Data.SqlClient
Imports System.IO

Public Class QuestionnaireForInitialResponseList
    Inherits System.Web.UI.Page

    ''' <summary>
    ''' The VA Logo at the top and the Homw and Search Icons will be hidden for this page. The menu on
    ''' the left side will be visible based on the logged on user group.
    ''' </summary>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim menu1 As ContentPlaceHolder = CType(Master.FindControl("cphMainMenu"), ContentPlaceHolder)
        menu1.Visible = False
        Dim menu As ContentPlaceHolder = CType(Master.FindControl("cphQuickMenu"), ContentPlaceHolder)
        menu.Visible = False
        'If Session("GroupID") >= 400 Then
        '    UCMenuAdmin.Visible = True
        '    UCMenuGeneral.Visible = False
        'Else
        '    UCMenuAdmin.Visible = False
        '    UCMenuGeneral.Visible = True
        'End If

        If Session("GroupID") >= 320 Then
            UCMenuAdmin.Visible = True
            UCMenuGeneral.Visible = False
            UCMenuEnvDirector.Visible = False
            UCMenuEnvEngineer.Visible = False
        ElseIf Session("GroupID") = 210 Then
            UCMenuAdmin.Visible = False
            UCMenuGeneral.Visible = False
            UCMenuEnvDirector.Visible = False
            UCMenuEnvEngineer.Visible = True
        ElseIf Session("GroupID") = 220 Then
            UCMenuAdmin.Visible = False
            UCMenuGeneral.Visible = False
            UCMenuEnvDirector.Visible = True
            UCMenuEnvEngineer.Visible = False
        Else
            UCMenuAdmin.Visible = False
            UCMenuGeneral.Visible = True
            UCMenuEnvDirector.Visible = False
            UCMenuEnvEngineer.Visible = False
            lblPendingHdg.Text = "View Project Initial Response"
        End If

        lblUserRoleId.Text = Session("GroupID")
        lblUserName.Text = Session("UserNm")

    End Sub
    ''' <summary>
    ''' When the user selects different page number to go to that page by clicking in the dropdownlist in the pager.
    ''' </summary>
    Protected Sub ddlPagingPending_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddlPending As DropDownList = DirectCast(gvEnvironmentalForInitialResponseSummary.BottomPagerRow.Cells(0).FindControl("ddlPagingPending"), DropDownList)
        gvEnvironmentalForInitialResponseSummary.PageIndex = ddlPending.SelectedIndex
    End Sub
    ''' <summary>
    ''' Get the number of pages to populate the dropdown list in the pager when the grid view databound happens.
    ''' </summary>
    Protected Sub gvEnvironmentalForInitialResponseSummary_DataBound(sender As Object, e As EventArgs)
        If gvEnvironmentalForInitialResponseSummary.Rows.Count >= 1 Then
            Dim ddlPending As DropDownList = DirectCast(gvEnvironmentalForInitialResponseSummary.BottomPagerRow.Cells(0).FindControl("ddlPagingPending"), DropDownList)
            For cnt As Integer = 0 To gvEnvironmentalForInitialResponseSummary.PageCount - 1
                Dim curr As Integer = cnt + 1
                Dim item As New ListItem(curr.ToString())
                If cnt = gvEnvironmentalForInitialResponseSummary.PageIndex Then
                    item.Selected = True
                End If
                ddlPending.Items.Add(item)
            Next
        End If
    End Sub

End Class