Public Class UnassignedSubmittedQuestionnaireList
    Inherits System.Web.UI.Page
    Public tr As Long
    ''' <summary>
    ''' The VA Logo at the top and the Homw and Search Icons will be hidden for this page. The menu on
    ''' the left side will be visible based on the logged on user group.
    ''' </summary>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim menu1 As ContentPlaceHolder = CType(Master.FindControl("cphMainMenu"), ContentPlaceHolder)
        menu1.Visible = False
        Dim menu As ContentPlaceHolder = CType(Master.FindControl("cphQuickMenu"), ContentPlaceHolder)
        menu.Visible = False

        If Session("GroupID") >= 400 Then
            UCMenuAdmin.Visible = True
            UCMenuGeneral.Visible = False
            UCMenuEnvEngineer.Visible = False
            UCMenuEnvDirector.Visible = False
        ElseIf Session("GroupID") = 210 Then   ' Environmental Engineer
            UCMenuEnvEngineer.Visible = True
            UCMenuEnvDirector.Visible = False
            UCMenuAdmin.Visible = False
            UCMenuGeneral.Visible = False
        ElseIf Session("GroupID") = 220 Then   ' Environmental Director
            UCMenuEnvDirector.Visible = True
            UCMenuEnvEngineer.Visible = False
            UCMenuAdmin.Visible = False
            UCMenuGeneral.Visible = False
        Else
            UCMenuGeneral.Visible = True
            UCMenuAdmin.Visible = False
            UCMenuEnvEngineer.Visible = False
            UCMenuEnvDirector.Visible = False

        End If

        btnSearch_Click(btnSearch, New EventArgs())
        gvFctStSearch.DataBind()

    End Sub
    ''' <summary>
    ''' When the user selects different page number to go to that page by clicking in the dropdownlist in the pager.
    ''' </summary>
    Protected Sub ddlPagingPending_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddlPending As DropDownList = DirectCast(gvEnvironmentalUnassignedQuestionnaireSummary.BottomPagerRow.Cells(0).FindControl("ddlPagingPending"), DropDownList)
        gvEnvironmentalUnassignedQuestionnaireSummary.PageIndex = ddlPending.SelectedIndex
    End Sub
    ''' <summary>
    ''' Get the number of pages to populate the dropdown list in the pager when the grid view databound happens.
    ''' </summary>
    Protected Sub gvEnvironmentalUnassignedQuestionnaireSummary_DataBound(sender As Object, e As EventArgs)
        If gvEnvironmentalUnassignedQuestionnaireSummary.Rows.Count >= 1 Then
            Dim ddlPending As DropDownList = DirectCast(gvEnvironmentalUnassignedQuestionnaireSummary.BottomPagerRow.Cells(0).FindControl("ddlPagingPending"), DropDownList)
            For cnt As Integer = 0 To gvEnvironmentalUnassignedQuestionnaireSummary.PageCount - 1
                Dim curr As Integer = cnt + 1
                Dim item As New ListItem(curr.ToString())
                If cnt = gvEnvironmentalUnassignedQuestionnaireSummary.PageIndex Then
                    item.Selected = True
                End If
                ddlPending.Items.Add(item)
            Next
        End If

    End Sub
    Protected Sub btnSearch_Click(sender As Object, e As EventArgs)
        If (txtProjTitle.Text = "") And (txtProjectNum.Text = "") And (ddlManager.SelectedValue = "") And (txtLocation.Text = "") Then
            '    pnlShowGrid.Visible = False
            '    lblSearchError.Text = "Please enter some value to search"
            'Else
            pnlShowGrid.Visible = True
            lblSearchError.Text = ""
        End If
        gvFctStSearch.DataBind()
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
    ''' Get the number of pages to populate the dropdown list in the pager when the grid view databound happens.
    ''' </summary>
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
        lblTotalRec.Text = "of " + tr.ToString

    End Sub
    ''' <summary>
    ''' When the user selects different page number to go to that page by clicking in the dropdownlist in the pager.
    ''' </summary>

    '   Protected Sub DdlPaging_SelectedIndexChanged(sender As Object, e As EventArgs)
    '    Dim ddl As DropDownList = DirectCast(gvFctStSearch.BottomPagerRow.Cells(0).FindControl("DdlPaging"), DropDownList)
    '        gvFctStSearch.PageIndex = ddl.SelectedIndex
    '    End Sub

    Protected Sub ddlPaging_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddl As DropDownList = DirectCast(gvFctStSearch.BottomPagerRow.Cells(0).FindControl("ddlPaging"), DropDownList)
        gvFctStSearch.PageIndex = ddl.SelectedIndex
    End Sub


    ''' <summary>
    ''' Clicking the Reset button will remove the search criteria entered in the text boxes.
    ''' </summary>
    Protected Sub btnClear_Click(sender As Object, e As EventArgs)
        txtProjectNum.Text = String.Empty
        txtProjTitle.Text = String.Empty
        txtLocation.Text = String.Empty
        ddlManager.SelectedValue = ""
        pnlShowGrid.Visible = False
    End Sub
    ''' <summary>
    ''' When the user selects different page size by clicking in the dropdownlist.
    ''' </summary>
    Protected Sub ddlPageSize_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ddlPageSize As DropDownList = DirectCast(sender, DropDownList)
        gvFctStSearch.PageSize = Convert.ToInt32(ddlPageSize.SelectedValue)

        Dim pageindex As Integer = gvFctStSearch.PageIndex
        gvFctStSearch.DataBind()
        If gvFctStSearch.PageIndex <> pageindex Then
            'if page index changed it means the previous page was not valid and was adjusted. Rebind to fill control with adjusted page
            gvFctStSearch.DataBind()
        End If
    End Sub
    ''' <summary>
    ''' The page will open with different menu based on the logged on user's group permission.
    ''' </summary>
    'Private Sub Page_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
    '    If Session("GroupID") >= 400 Then
    '        UCMenuAdmin.Visible = True
    '        UCMenuGeneral.Visible = False
    '    Else
    '        UCMenuAdmin.Visible = False
    '        UCMenuGeneral.Visible = True
    '    End If
    'End Sub
    ''' <summary>
    ''' This is to count the total number of records to show in a label lblTotalRec in the
    ''' grid view data bound event.
    ''' </summary>    
    Protected Sub odsrcSearchFctst_Selected(sender As Object, e As ObjectDataSourceStatusEventArgs) Handles odsrcSearchFctst.Selected
        Dim dt As Data.DataTable = CType(e.ReturnValue, Data.DataTable)
        tr = dt.Rows.Count
    End Sub

End Class


