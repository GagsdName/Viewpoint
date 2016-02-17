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
<link rel="stylesheet" href="page.css">
<title>Create New User</title>
<script type="text/javascript" src="jQuery.js"></script>
<script type="text/javascript" src="functions.js"></script>
<script type="text/javascript" src="validation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {

		fillRoleList();
		//validator();

	});
	

</script>
</head>
	<img src="images/engineer_close.png"  id="createuser"/>
<body>
	<br><br>

	<br><br>
	<div id="comment"></div>
	<form id="Form" action="createUser.html" method="POST">
		<fieldset class="f" id="createuser">
		<label id="createuser" class="formlabel">Fill in the following Details:</label>
			
			<table id="createusertable">
			<tr>
				<td><label for="roleList"><font color="white">Select Role</font></label></td>
			
				<td><select id="roleList" name="Role"></select></td>
			</tr>
			<tr>
				<td><label for="empName"><font color="white">Employee Name</font></label></td>
				
				<td><input type="text" name="EmpName" id="empName"/></td>
				<p id="errName"></p>
			</tr>
			<tr>
				<td><label for="empId"><font color="white">Employee ID</font></label></td>
				
				<td><input type="text" name="EmpId" id="empId" maxlength="4" onchange="empIdDuplicacyCheck(this.value)"/></td>
				<p  id="errId"></p>
			</tr>
			<tr>
				<td><label for="empEmail" ><font color="white">Email Id</font></label></td>
				
				<td><input type="text" name="EmailId" id="empEmail"  /></td>
				<p id="errEmail"></p>
			</tr>
			<tr>
				<td><label for="empPass"><font color="white">Password</font></label></td>
								<td><input type="password" name="EmpPass" id="empPass"/></td>
				<p id="errPass"></p>
			</tr>
			<tr>
				<td><label for="confirmPass"><font color="white">Confirm Password</font></label></td>
				
				<td><input type="password" name="RetypePass" id="confirmPass"/></td>
				<p id="errConfirm"></p>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td><input type="image" src="images/button-check.png" class="buttoncheck" onclick="return validator();" id="createuserbutton"/></td>
				
			</tr>
			</table>
		</fieldset>
		<script type="text/javascript" src="jQuery.js"></script>
<script>
$(document).ready(function(){
	//alert("filling");
	get_survey_for_user_mapping()
   

//document.getElementById("checkbutton").style.display="block";

});
function get_survey_for_user_mapping() {
	 // alert("hello");

	 

	   var l="<%=dbreflib.URL.url%>"+"databse_functions_calling"
		$.ajax({
			type : 'POST',
			url :l,
			data : "id="+15,
			async : false,
			success : function(resp) {
			
				//alert(resp);
				document.getElementById("survey_user_map").innerHTML=resp;
			}
		}); //ajax
	
		
}
 
 
 
</script>
		
	<div id="survey_user_map" ></div>
	</form>
	

</body>
</html>
<%  
}
else
{
	response.sendRedirect(dbreflib.URL.url+"Access-Denied.jsp");
}
%>