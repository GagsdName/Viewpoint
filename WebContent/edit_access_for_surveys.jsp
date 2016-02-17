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
    <%@ include file="WEB-INF/jsp/menu.jsp" %>
    <%@page import="dbreflib.URL.*"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Access for Surveys</title>
<script type="text/javascript" src="validation.js"></script>
</head>
<body>
<link href="page.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="jQuery.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		//alert("hi");
         fillUsers();	
       

	});

	function fillUsers() {
		//alert("hello");
var l="<%=dbreflib.URL.url%>"+"databse_functions_calling";
//alert(l);
		$.ajax({
			type : 'POST',
			url : l,
			data : "id="+16,
			async : false,
			success : function(resp) {
				$("#userlist").html(resp);
	//	alert(resp);
		//alert("hi");
			}
		}); //ajax
	}//userlist
	
	
	function fillSurveyList() {
		//alert("hello");
var l="<%=dbreflib.URL.url%>"+"databse_functions_calling";  
var user_emp_id=document.getElementById("userlist").value;
//alert(user_emp_id);
		$.ajax({
			type : 'POST',
			url : l,
			data : "id="+17+"&user_emp_id="+user_emp_id,
			async : false,
			success : function(resp) {
				$("#survey_list").html(resp);
			//alert(resp);
		//alert("hi");
			}
		}); //ajax
	}//userlist
	
	
	
	
	
	
	
</script>

	<img src="images/unlock.png"  id="report"/>
<div style="margin-top: 100px;position: absolute;">

<form name="access-form" action='<%=dbreflib.URL.url+"databse_functions_calling"%>' onsubmit="return valDrop()" method="post">

	<fieldset class="f" id="accessprivileges">
	<label class="formlabel" id="accessprivileges">Edit Survey Access</label>
<br>
	<label>Select User</label>
		 <select id="userlist" name="userlist" onchange="  fillSurveyList();"/></select>
		 <input type="hidden" value=18 name="id">

		<br><br>
		<input  type="image" src="images/button-check.png" class="buttoncheck" id="accessprivilegesbutton"  title="Click to Update!"/>

</fieldset>
<div id="survey_list"></div>

</form>
</div>

</body>
</html>
<%  
}
else
{
	response.sendRedirect(dbreflib.URL.url+"Access-Denied.jsp");
}
%>
