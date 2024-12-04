Imports System.Data
Imports System.Data.SqlClient.SqlCommand
Imports System.Data.SqlClient

Public Class ShowDoc
    Inherits System.Web.UI.Page

    ''' <summary>
    ''' When the page loads, it get the doc id from details page and run the query to open the document.
    ''' </summary>
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim varAttachId As String = Convert.ToString(Request.QueryString("docID"))
        Dim SQLStr As String = "SELECT [docType], [doc] FROM [CFMIS_doc] WHERE [docID] = @varDocId"
        Dim ConnStr As String = ConfigurationManager.ConnectionStrings("MainConn").ConnectionString

        Using connection As New SqlConnection(ConnStr)
            Dim command As New SqlCommand(SQLStr, connection)
            command.Parameters.Add("@varDocId", SqlDbType.VarChar)
            command.Parameters("@varDocId").Value = varAttachId
            connection.Open()
            Dim attachReader = command.ExecuteReader()
            If attachReader.Read Then
                Response.Clear()
                Response.ContentType = Trim(attachReader("docType").ToString())
                Response.BinaryWrite(CType(attachReader("doc"), Byte()))
                Response.Flush()
                Response.End()
            End If
            attachReader.Close()
        End Using
    End Sub

End Class