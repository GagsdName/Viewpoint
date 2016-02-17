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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ include file="WEB-INF/jsp/menu.jsp" %>
<div style="margin-top: 100px;position: absolute;">

<link href="page.css" rel="stylesheet" type="text/css" />
<img src="images/tool_box.png"  id="unpublishsurvey"/>
<form id='target' name="categoryform" action="databse_functions_calling" method="post">

<fieldset class="f" id="unpublishsurvey">	
	<label id="unpublishsurvey" class="formlabel">Unpublish A Survey</label>
	<table border=0px width=100% id="unpublishsurvey">
	<tr>
	<td></td>
	<tr>
	
		<td>
		Select Category:
		 <select id="category" name="category" onchange=fill_published_SurveyList()></select> 
		 </td>
		
	</tr>
	<tr>
		<td >
		Select Survey:
		<select id="surveyname" name="surveyname"></select> 
		<input type="hidden" name="id" value="9">
		</td>
		
		</tr>
		<tr>
		
		<td ><input type="image" id="unpublishbutton" src="images/button-cross.png" class="buttoncross" title="Click to Unpublish" "/></td>
	
</tr>
</table>

</fieldset>
</form>
</div>
<script type="text/javascript" src="jQuery.js"></script>
<script type="text/javascript" src="dropdown_functions.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	
	fillcategory();
	fill_published_SurveyList();

});
	
</script>


</body>
</html>

<%  
}
else
{
	response.sendRedirect(dbreflib.URL.url+"Access-Denied.jsp");
}
%>

