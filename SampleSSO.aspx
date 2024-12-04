<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SampleSSO.aspx.vb" Inherits="CFMISNew.SampleSSO" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ACS SQL DB SSOi Traits Test Page!</title>
</head>
<body>
<%--    <form id="form1" runat="server">
        <div>
        </div>
    </form>--%>


<H1>ACS SQL DB SSOi Traits Test Page</H1>
<a href="https://ssologon.preprod.iam.va.gov/centrallogin/centrallanding.aspx?appid=traits&target=https://ssologon.preprod.iam.va.gov/testtraits/acsdb/index.asp">Log out</a>

<TABLE BORDER=1>

<TR><TD VALIGN=TOP><B>Variable</B></TD><TD VALIGN=TOP><B>Value</B></TD></TR>

<% For Each key in Request.ServerVariables %>

<TR>

<TD><% = key %></TD>

<TD>

<%

if Request.ServerVariables(key) = "" Then

if GetAttribute(key) = "" Then

Response.Write "&nbsp" ' To force border around table cell

else

Response.Write GetAttribute(key)

end if

else

Response.Write Request.ServerVariables(key)

end if

Response.Write "</TD>"

%>

</TR>

<% Next %>

</TABLE>


<% Function GetAttribute(AttrName)

Dim AllAttrs

Dim RealAttrName

Dim Location

Dim Result


AllAttrs = Request.ServerVariables("ALL_HTTP")

RealAttrName = AttrName


Location = instr(AllAttrs, RealAttrName & ":")


if Location <= 0 then

GetAttribute = ""

Exit Function

end if


Result = mid(AllAttrs, Location + Len(RealAttrName) + 1)


Location = instr(Result, chr(10))

if Location <= 0 then Location = len(Result) + 1


GetAttribute = left(Result, Location - 1)

End Function %>

</body>
</html>
