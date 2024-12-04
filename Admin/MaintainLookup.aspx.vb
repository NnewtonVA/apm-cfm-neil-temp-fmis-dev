Imports System.IO
Imports AjaxControlToolkit
Imports System.Web.Services
Imports System.Web.Script.Services
Imports System.Collections.Generic
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.HtmlControls
Imports System.Data.SqlClient

Public Class MaintainLookup
    Inherits System.Web.UI.Page

    ''' <summary>
    ''' The VA Logo at the top will be hidden for this page when the page loads.
    ''' </summary>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim menu1 As ContentPlaceHolder = CType(Master.FindControl("cphMainMenu"), ContentPlaceHolder)
        menu1.Visible = False
        
    End Sub
    ''' <summary>
    ''' Clicking the Add New button in the project status grid will run the SP AddNewStatusInLookup
    ''' to add new status name and code in the database.
    ''' </summary>
    Protected Sub btnAddStatus_Click(sender As Object, e As EventArgs)
        Dim btn As Button = DirectCast(sender, Button)
        Dim GrdRow As GridViewRow = DirectCast(btn.Parent.Parent, GridViewRow)
        Dim varResult As String

        Dim txtStatusNm As TextBox = DirectCast(GrdRow.Cells(1).FindControl("txtAddStatus"), TextBox)
        Dim txtStatusCd As TextBox = DirectCast(GrdRow.Cells(2).FindControl("txtAddStatusCd"), TextBox)

        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "AddNewStatusInLookup"
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@StatusName", SqlDbType.VarChar).Value = txtStatusNm.Text
            command.Parameters.AddWithValue("@StatusCode", SqlDbType.VarChar).Value = txtStatusCd.Text
            command.Parameters.Add("@Result", SqlDbType.NVarChar, 100)
            command.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()
            varResult = command.Parameters("@Result").Value.ToString()
            ClientScript.RegisterStartupScript(Me.GetType(), "ClientScript", "alert('" + varResult + "')", True)
        End Using
        gvProjStatus.DataBind()
    End Sub
    ''' <summary>
    ''' Clicking the Add New button in the project category grid will run the SP AddNewProgCategoryInLookup
    ''' to add new category name and code in the database.
    ''' </summary>
    Protected Sub btnAddCategory_Click(sender As Object, e As EventArgs)
        Dim btn As Button = DirectCast(sender, Button)
        Dim GrdRow As GridViewRow = DirectCast(btn.Parent.Parent, GridViewRow)
        Dim varResult As String

        Dim txtCategoryNm As TextBox = DirectCast(GrdRow.Cells(1).FindControl("txtAddProgCat"), TextBox)
        Dim txtCategoryCd As TextBox = DirectCast(GrdRow.Cells(2).FindControl("txtAddCatCode"), TextBox)

        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "AddNewProgCategoryInLookup"
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@CategoryName", SqlDbType.VarChar).Value = txtCategoryNm.Text
            command.Parameters.AddWithValue("@CategoryCode", SqlDbType.VarChar).Value = txtCategoryCd.Text
            command.Parameters.Add("@Result", SqlDbType.NVarChar, 100)
            command.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()
            varResult = command.Parameters("@Result").Value.ToString()
            ClientScript.RegisterStartupScript(Me.GetType(), "ClientScript", "alert('" + varResult + "')", True)
        End Using
        gvProgCat.DataBind()
    End Sub
    ''' <summary>
    ''' Clicking the Add New button in the project sub category grid will run the SP AddNewProgSubCategoryInLookup
    ''' to add new sub category name and code in the database.
    ''' </summary>
    Protected Sub btnAddSubCategory_Click(sender As Object, e As EventArgs)
        Dim btn As Button = DirectCast(sender, Button)
        Dim GrdRow As GridViewRow = DirectCast(btn.Parent.Parent, GridViewRow)
        Dim varResult As String

        Dim txtSubCategoryNm As TextBox = DirectCast(GrdRow.Cells(1).FindControl("txtAddSubCat"), TextBox)
        Dim txtSubCategoryCd As TextBox = DirectCast(GrdRow.Cells(2).FindControl("txtAddSubCatCode"), TextBox)

        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "AddNewProgSubCategoryInLookup"
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@SubCategoryName", SqlDbType.VarChar).Value = txtSubCategoryNm.Text
            command.Parameters.AddWithValue("@SubCategoryCode", SqlDbType.VarChar).Value = txtSubCategoryCd.Text
            command.Parameters.Add("@Result", SqlDbType.NVarChar, 100)
            command.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()
            varResult = command.Parameters("@Result").Value.ToString()
            ClientScript.RegisterStartupScript(Me.GetType(), "ClientScript", "alert('" + varResult + "')", True)
        End Using
        gvProgSubCat.DataBind()
    End Sub
    ''' <summary>
    ''' Clicking the Add New button in the project delivery method grid will run the SP AddNewProgDeliveryMethodInLookup
    ''' to add new delivery method name, description and code in the database.
    ''' </summary>
    Protected Sub btnAddDeliveryMthd_Click(sender As Object, e As EventArgs)
        Dim btn As Button = DirectCast(sender, Button)
        Dim GrdRow As GridViewRow = DirectCast(btn.Parent.Parent, GridViewRow)
        Dim varResult As String

        Dim txtDeliveryMthdNm As TextBox = DirectCast(GrdRow.Cells(1).FindControl("txtAddMethodName"), TextBox)
        Dim txtDeliveryMthdCd As TextBox = DirectCast(GrdRow.Cells(2).FindControl("txtAddMethodCode"), TextBox)
        Dim txtDeliveryDesc As TextBox = DirectCast(GrdRow.Cells(3).FindControl("txtAddMthdDesc"), TextBox)

        Dim connStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString
        Using conn As New SqlConnection(connStr)
            Dim command As New SqlCommand
            command.Connection = conn
            command.CommandText = "AddNewProgDeliveryMethodInLookup"
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@DeliveryMethodName", SqlDbType.VarChar).Value = txtDeliveryMthdNm.Text
            command.Parameters.AddWithValue("@DeliveryMethodCode", SqlDbType.VarChar).Value = txtDeliveryMthdCd.Text
            command.Parameters.AddWithValue("@DeliveryMethodDesc", SqlDbType.VarChar).Value = txtDeliveryDesc.Text
            command.Parameters.Add("@Result", SqlDbType.NVarChar, 100)
            command.Parameters("@Result").Direction = ParameterDirection.Output
            conn.Open()
            command.ExecuteNonQuery()
            conn.Close()
            varResult = command.Parameters("@Result").Value.ToString()
            ClientScript.RegisterStartupScript(Me.GetType(), "ClientScript", "alert('" + varResult + "')", True)
        End Using
        gvProjDeliveryMthd.DataBind()
    End Sub
End Class