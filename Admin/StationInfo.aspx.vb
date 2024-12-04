Imports System.IO
Imports AjaxControlToolkit
Imports System.Web.Services
Imports System.Web.Script.Services
Imports System.Collections.Generic
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.HtmlControls
Imports System.Data.SqlClient

Public Class StationInfo
    Inherits System.Web.UI.Page

    Public tr As Long

    ''' <summary>
    ''' The VA Logo at the top will be hidden for this page. Also the menu in the left will be hidden.
    ''' </summary>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim menu1 As ContentPlaceHolder = CType(Master.FindControl("cphMainMenu"), ContentPlaceHolder)
        menu1.Visible = False
        Dim menu As ContentPlaceHolder = CType(Master.FindControl("cphQuickMenu"), ContentPlaceHolder)
        menu.Visible = False
    End Sub
    ''' <summary>
    ''' Get the number of pages to populate the dropdown list in the pager when the grid view databound happens.
    ''' </summary>
    Protected Sub gvStnSearch_DataBound(sender As Object, e As EventArgs)
        If gvStnSearch.Rows.Count >= 1 Then
            Dim ddl As DropDownList = DirectCast(gvStnSearch.BottomPagerRow.Cells(0).FindControl("ddlPaging"), DropDownList)
            For cnt As Integer = 0 To gvStnSearch.PageCount - 1
                Dim curr As Integer = cnt + 1
                Dim item As New ListItem(curr.ToString())
                If cnt = gvStnSearch.PageIndex Then
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
    Protected Sub ddlPaging_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddl As DropDownList = DirectCast(gvStnSearch.BottomPagerRow.Cells(0).FindControl("ddlPaging"), DropDownList)
        gvStnSearch.PageIndex = ddl.SelectedIndex
    End Sub
    ''' <summary>
    ''' When the user selects different page size by clicking in the dropdownlist.
    ''' </summary>
    Protected Sub ddlPageSize_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ddlPageSize As DropDownList = DirectCast(sender, DropDownList)
        gvStnSearch.PageSize = Convert.ToInt32(ddlPageSize.SelectedValue)

        Dim pageindex As Integer = gvStnSearch.PageIndex
        gvStnSearch.DataBind()
        If gvStnSearch.PageIndex <> pageindex Then
            'if page index changed it means the previous page was not valid and was adjusted. Rebind to fill control with adjusted page
            gvStnSearch.DataBind()
        End If
    End Sub
    ''' <summary>
    ''' Clicking the Reset button will remove the search criteria entered in the text boxes.
    ''' </summary>
    Protected Sub btnStnReset_Click(sender As Object, e As EventArgs) Handles btnStnReset.Click
        txtSearchStnNo.Text = String.Empty
        txtSearchStnName.Text = String.Empty
        txtSearchStnCity.Text = String.Empty
        ddlSearchStnState.SelectedValue = ""
        pnlShowGrid.Visible = False
    End Sub
    ''' <summary>
    ''' Clicking the search button will show the search result panel.
    ''' it will show the error message when all the search boxes are empty.
    ''' </summary>
    Protected Sub btnSearchStn_Click(sender As Object, e As EventArgs) Handles btnSearchStn.Click
        If (txtSearchStnNo.Text = "") And (txtSearchStnName.Text = "") And (ddlSearchStnState.SelectedValue = "") And (txtSearchStnCity.Text = "") Then
            pnlShowGrid.Visible = False
            lblStnSearchError.Text = "Please enter some value to search"
        Else
            pnlShowGrid.Visible = True
            lblStnSearchError.Text = ""
        End If
        gvStnSearch.DataBind()
    End Sub
    ''' <summary>
    ''' This is to count the total number of records to show in a label lblTotalRec in the
    ''' grid view data bound event.
    ''' </summary>
    Protected Sub odsrcSearchStn_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsrcSearchStn.Selected
        Dim dt As Data.DataTable = CType(e.ReturnValue, Data.DataTable)
        tr = dt.Rows.Count
    End Sub
End Class