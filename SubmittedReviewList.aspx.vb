Public Class SubmittedReviewList
    Inherits System.Web.UI.Page

    ''' <summary>
    ''' The VA logo at the top and the Home and Search icons will not be visible for this page.
    ''' User with admin group will be have the Admin menu. 
    ''' The grids are visible to the user with reviewer role.
    ''' Different grid will be visible to different user based on their group id.
    ''' </summary>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim menu1 As ContentPlaceHolder = CType(Master.FindControl("cphMainMenu"), ContentPlaceHolder)
        menu1.Visible = False
        Dim menu As ContentPlaceHolder = CType(Master.FindControl("cphQuickMenu"), ContentPlaceHolder)
        menu.Visible = False

        'If Session("GroupID") >= 400 Then
        '    UCMenuAdmin.Visible = True
        '    UCMenuGeneral.Visible = False
        '    lblAccessMsg.Visible = False
        'Else
        '    UCMenuAdmin.Visible = False
        '    UCMenuGeneral.Visible = True
        'End If

        If Session("GroupID") >= 320 Then
            UCMenuAdmin.Visible = True
            UCMenuGeneral.Visible = False
            UCMenuEnvDirector.Visible = False
            UCMenuEnvEngineer.Visible = False
            UCMenuSustainability.Visible = False
        ElseIf Session("GroupID") = 210 Then
            UCMenuAdmin.Visible = False
            UCMenuGeneral.Visible = False
            UCMenuEnvDirector.Visible = False
            UCMenuEnvEngineer.Visible = True
            UCMenuSustainability.Visible = False
        ElseIf Session("GroupID") = 220 Then
            UCMenuAdmin.Visible = False
            UCMenuGeneral.Visible = False
            UCMenuEnvDirector.Visible = True
            UCMenuEnvEngineer.Visible = False
            UCMenuSustainability.Visible = False
        ElseIf Session("GroupID") = 225 Or Session("GroupID") = 230 Then
            UCMenuAdmin.Visible = False
            UCMenuGeneral.Visible = False
            UCMenuEnvDirector.Visible = False
            UCMenuEnvEngineer.Visible = False
            UCMenuSustainability.Visible = True
        Else
            UCMenuAdmin.Visible = False
            UCMenuGeneral.Visible = True
            UCMenuEnvDirector.Visible = False
            UCMenuEnvEngineer.Visible = False
            UCMenuSustainability.Visible = False
        End If

        If Session("GroupID") < 300 Then
            pnlFinalReview.Visible = False
            pnlEastReview.Visible = False
            pnlWestReview.Visible = False
            pnlCentralReview.Visible = False
            pnlNCAReview.Visible = False
            lblAccessMsg.Visible = True
        ElseIf Session("GroupID") = 320 Then
            pnlFinalReview.Visible = True
            pnlEastReview.Visible = False
            pnlWestReview.Visible = False
            pnlCentralReview.Visible = False
            pnlNCAReview.Visible = False
        ElseIf Session("GroupID") = 312 Then
            pnlFinalReview.Visible = False
            pnlEastReview.Visible = True
            pnlWestReview.Visible = False
            pnlCentralReview.Visible = False
            pnlNCAReview.Visible = False
        ElseIf Session("GroupID") = 311 Then
            pnlFinalReview.Visible = False
            pnlEastReview.Visible = False
            pnlWestReview.Visible = False
            pnlCentralReview.Visible = True
            pnlNCAReview.Visible = False
        ElseIf Session("GroupID") = 313 Then
            pnlFinalReview.Visible = False
            pnlEastReview.Visible = False
            pnlWestReview.Visible = True
            pnlCentralReview.Visible = False
            pnlNCAReview.Visible = False
        ElseIf Session("GroupID") = 314 Then
            pnlFinalReview.Visible = False
            pnlEastReview.Visible = False
            pnlWestReview.Visible = False
            pnlCentralReview.Visible = False
            pnlNCAReview.Visible = True
        ElseIf Session("GroupID") = 600 Then
            pnlFinalReview.Visible = True
            pnlEastReview.Visible = True
            pnlWestReview.Visible = True
            pnlCentralReview.Visible = True
            pnlNCAReview.Visible = True
            btnViewAll.Visible = False
        End If
    End Sub
    ''' <summary>
    ''' When the user selects different page number to go to that page by clicking in the dropdownlist in the pager.
    ''' </summary>
    Protected Sub ddlPaging_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddl As DropDownList = DirectCast(gvSubmittedReview.BottomPagerRow.Cells(0).FindControl("ddlPaging"), DropDownList)
        gvSubmittedReview.PageIndex = ddl.SelectedIndex
    End Sub
    ''' <summary>
    ''' Get the number of pages to populate the dropdown list in the pager when the grid view databound happens.
    ''' </summary>
    Protected Sub gvSubmittedReview_DataBound(sender As Object, e As EventArgs)
        If gvSubmittedReview.Rows.Count >= 1 Then
            Dim ddl As DropDownList = DirectCast(gvSubmittedReview.BottomPagerRow.Cells(0).FindControl("ddlPaging"), DropDownList)
            For cnt As Integer = 0 To gvSubmittedReview.PageCount - 1
                Dim curr As Integer = cnt + 1
                Dim item As New ListItem(curr.ToString())
                If cnt = gvSubmittedReview.PageIndex Then
                    item.Selected = True
                End If
                ddl.Items.Add(item)
            Next
        End If
        'lblTotalRec.Text = "of " + tr.ToString;
    End Sub
    ''' <summary>
    ''' When the user selects different page number to go to that page by clicking in the dropdownlist in the pager.
    ''' </summary>
    Protected Sub ddlPagingEast_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddlEast As DropDownList = DirectCast(gvSubmittedReviewForEastDirector.BottomPagerRow.Cells(0).FindControl("ddlPagingEast"), DropDownList)
        gvSubmittedReviewForEastDirector.PageIndex = ddlEast.SelectedIndex
    End Sub
    ''' <summary>
    ''' Get the number of pages to populate the dropdown list in the pager when the grid view databound happens.
    ''' </summary>
    Protected Sub gvSubmittedReviewForEastDirector_DataBound(sender As Object, e As EventArgs)
        If gvSubmittedReviewForEastDirector.Rows.Count >= 1 Then
            Dim ddlEast As DropDownList = DirectCast(gvSubmittedReviewForEastDirector.BottomPagerRow.Cells(0).FindControl("ddlPagingEast"), DropDownList)
            For cnt As Integer = 0 To gvSubmittedReviewForEastDirector.PageCount - 1
                Dim curr As Integer = cnt + 1
                Dim item As New ListItem(curr.ToString())
                If cnt = gvSubmittedReviewForEastDirector.PageIndex Then
                    item.Selected = True
                End If
                ddlEast.Items.Add(item)
            Next
        End If
        'lblTotalRec.Text = "of " + tr.ToString;
    End Sub
    ''' <summary>
    ''' When the user selects different page number to go to that page by clicking in the dropdownlist in the pager.
    ''' </summary>
    Protected Sub ddlPagingWest_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddlWest As DropDownList = DirectCast(gvSubmittedReviewForWestDirector.BottomPagerRow.Cells(0).FindControl("ddlPagingWest"), DropDownList)
        gvSubmittedReviewForWestDirector.PageIndex = ddlWest.SelectedIndex
    End Sub
    ''' <summary>
    ''' Get the number of pages to populate the dropdown list in the pager when the grid view databound happens.
    ''' </summary>
    Protected Sub gvSubmittedReviewForWestDirector_DataBound(sender As Object, e As EventArgs)
        If gvSubmittedReviewForWestDirector.Rows.Count >= 1 Then
            Dim ddlWest As DropDownList = DirectCast(gvSubmittedReviewForWestDirector.BottomPagerRow.Cells(0).FindControl("ddlPagingWest"), DropDownList)
            For cnt As Integer = 0 To gvSubmittedReviewForWestDirector.PageCount - 1
                Dim curr As Integer = cnt + 1
                Dim item As New ListItem(curr.ToString())
                If cnt = gvSubmittedReviewForWestDirector.PageIndex Then
                    item.Selected = True
                End If
                ddlWest.Items.Add(item)
            Next
        End If
        'lblTotalRec.Text = "of " + tr.ToString;
    End Sub
    ''' <summary>
    ''' When the user selects different page number to go to that page by clicking in the dropdownlist in the pager.
    ''' </summary>
    Protected Sub ddlPagingCentral_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddlCentral As DropDownList = DirectCast(gvSubmittedReviewForCentralDirector.BottomPagerRow.Cells(0).FindControl("ddlPagingCentral"), DropDownList)
        gvSubmittedReviewForCentralDirector.PageIndex = ddlCentral.SelectedIndex
    End Sub
    ''' <summary>
    ''' Get the number of pages to populate the dropdown list in the pager when the grid view databound happens.
    ''' </summary>
    Protected Sub gvSubmittedReviewForCentralDirector_DataBound(sender As Object, e As EventArgs)
        If gvSubmittedReviewForCentralDirector.Rows.Count >= 1 Then
            Dim ddlCentral As DropDownList = DirectCast(gvSubmittedReviewForCentralDirector.BottomPagerRow.Cells(0).FindControl("ddlPagingCentral"), DropDownList)
            For cnt As Integer = 0 To gvSubmittedReviewForCentralDirector.PageCount - 1
                Dim curr As Integer = cnt + 1
                Dim item As New ListItem(curr.ToString())
                If cnt = gvSubmittedReviewForCentralDirector.PageIndex Then
                    item.Selected = True
                End If
                ddlCentral.Items.Add(item)
            Next
        End If
        'lblTotalRec.Text = "of " + tr.ToString;
    End Sub
    ''' <summary>
    ''' When the user selects different page number to go to that page by clicking in the dropdownlist in the pager.
    ''' </summary>
    Protected Sub ddlPagingNCA_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddlNCA As DropDownList = DirectCast(gvSubmittedReviewForNCADirector.BottomPagerRow.Cells(0).FindControl("ddlPagingNCA"), DropDownList)
        gvSubmittedReviewForNCADirector.PageIndex = ddlNCA.SelectedIndex
    End Sub
    ''' <summary>
    ''' Get the number of pages to populate the dropdown list in the pager when the grid view databound happens.
    ''' </summary>
    Protected Sub gvSubmittedReviewForNCADirector_DataBound(sender As Object, e As EventArgs)
        If gvSubmittedReviewForNCADirector.Rows.Count >= 1 Then
            Dim ddlNCA As DropDownList = DirectCast(gvSubmittedReviewForNCADirector.BottomPagerRow.Cells(0).FindControl("ddlPagingNCA"), DropDownList)
            For cnt As Integer = 0 To gvSubmittedReviewForNCADirector.PageCount - 1
                Dim curr As Integer = cnt + 1
                Dim item As New ListItem(curr.ToString())
                If cnt = gvSubmittedReviewForNCADirector.PageIndex Then
                    item.Selected = True
                End If
                ddlNCA.Items.Add(item)
            Next
        End If
    End Sub
    ''' <summary>
    ''' Clicking the View All button by the Final reviewer user group will show the grid for all the regions.
    ''' </summary>
    Protected Sub btnViewAll_Click(sender As Object, e As EventArgs) Handles btnViewAll.Click
        If Session("GroupID") = 320 Then
            pnlFinalReview.Visible = True
            pnlEastReview.Visible = True
            pnlWestReview.Visible = True
            pnlCentralReview.Visible = True
            pnlNCAReview.Visible = True
        End If
    End Sub
End Class