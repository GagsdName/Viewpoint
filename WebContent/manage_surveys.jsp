<%
 response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
 response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
 response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
 response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
 
 
 if(session.getAttribute("RoleID")==null && session.getAttribute("EmployeeID")==null) //||!session.getAttribute("RoleID").toString().equals("USR131")||!session.getAttribute("RoleID").toString().equals("ADM121"))
 {
	 response.sendRedirect("login.jsp");
	 }else if(session.getAttribute("RoleID").toString().equals("SAD111")||session.getAttribute("RoleID").toString().equals("USR131")||session.getAttribute("RoleID").toString().equals("ADM121"))
	 {
int timeout = session.getMaxInactiveInterval();
response.setHeader("Refresh", timeout + "; URL =login.jsp");
%>
 <%@ page import="dbreflib.URL.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   

   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="WEB-INF/jsp/menu.jsp" %>

<link href="page.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manage Surveys</title>
</head>
<body>
<table id="managesurvey" cellspacing="190px">
<tr><td><a href="<%=dbreflib.URL.url+"create_survey.jsp"%>" ><img src="images/add.png" class="thumbnail"></img></a><br><label class="thumblabel">Create New Survey</label></td>
<td><a href="<%=dbreflib.URL.url+"unpublish_survey.jsp"%>"  ><img src="images/delete.png" class="thumbnail"></a><br><label class="thumblabel">Unpublish a Survey</label></td>
<td><a href="<%=dbreflib.URL.url+"update_survey.jsp"%>"  ><img src="images/pencil.png" class="thumbnail"></a><br><label class="thumblabel">Edit a Survey</label></td>
<td><a href="<%=dbreflib.URL.url+"survey_list.jsp"%>" ><img src="images/page.png" class="thumbnail"></a><br><label class="thumblabel">View Survey List</label></td>
</tr>


</table>
</body>


</html>
<%  
}
else
{
	response.sendRedirect(dbreflib.URL.url+"Access-Denied.jsp");
}
%>