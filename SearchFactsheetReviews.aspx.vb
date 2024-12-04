Imports System.IO
Imports AjaxControlToolkit
Imports System.Web.Services
Imports System.Web.Script.Services
Imports System.Collections.Generic
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.HtmlControls

Public Class SearchFactsheetReviews
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Protected Sub btnSearch_Click(sender As Object, e As EventArgs)
        If (txtProjTitle.Text = "") And (txtProjectNum.Text = "") And (ddlManager.SelectedValue = "0") Then
            pnlShowGrid.Visible = False
            lblSearchError.Text = "Please enter some value to search"
        Else
            pnlShowGrid.Visible = True
            lblSearchError.Text = ""
        End If
    End Sub
    Protected Sub gvFctStSearch_DataBound(sender As Object, e As EventArgs)
        If gvFctStSearch.Rows.Count >= 1 Then
            Dim ddl As DropDownList = DirectCast(gvFctStSearch.BottomPagerRow.Cells(0).FindControl("ddlPaging"), DropDownList)
            For cnt As Integer = 0 To gvFctStSearch.PageCount - 1
                Dim curr As Integer = cnt + 1
                Dim item As New ListItem(curr.ToString())
                If cnt = gvFctStSearch.PageIndex Then
                    item.Selected = True
                End If
                ddl.Items.Add(item)
            Next
        End If
        'lblTotalRec.Text = "of " + tr.ToString;
    End Sub
    Protected Sub ddlPaging_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddl As DropDownList = DirectCast(gvFctStSearch.BottomPagerRow.Cells(0).FindControl("ddlPaging"), DropDownList)
        gvFctStSearch.PageIndex = ddl.SelectedIndex
    End Sub

    Protected Sub btnClear_Click(sender As Object, e As EventArgs)
        txtProjectNum.Text = String.Empty
        txtProjTitle.Text = String.Empty
        ddlManager.SelectedValue = "0"
        pnlShowGrid.Visible = False
    End Sub

    Private Sub SearchFactsheetReviews_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
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
        End If

    End Sub
End Class