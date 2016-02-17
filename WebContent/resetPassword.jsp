<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
 response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
 response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
 response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
 response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
 
 
 if(session.getAttribute("RoleID")==null && session.getAttribute("EmployeeID")==null) //||!session.getAttribute("RoleID").toString().equals("USR131")||!session.getAttribute("RoleID").toString().equals("ADM121"))
 {
	 response.sendRedirect("Access-Denied.jsp");
	 }else if(session.getAttribute("RoleID").toString().equals("SAD111")||session.getAttribute("RoleID").toString().equals("USR131")||session.getAttribute("RoleID").toString().equals("ADM121"))
	 {%>
<%@ include file="WEB-INF/jsp/menu.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reset Password</title>
<script type="text/javascript" src="jQuery.js"></script>
<script type="text/javascript" src="functions.js"></script>
<script>

function changePassword(){
	document.getElementById("err1").innerHTML="";
	document.getElementById("err2").innerHTML="";
	document.getElementById("err3").innerHTML="";
	
	var old_pass=$.trim(document.getElementById("oldPass").value);	
	var new_pass=$.trim(document.getElementById("newPass").value);
	var con_pass=$.trim(document.getElementById("conPass").value);
	
	if(old_pass==null || old_pass==""){
		document.getElementById("err1").innerHTML="Vacant Field!";
		document.getElementById("oldPass").focus();
		return false;
	}else if(old_pass.length<6){
		alert("entered"); //Problem
		document.getElementById("err1").innerHTML="Password should have at least 6 characters.";
		document.getElementById("oldPass").focus();
		return false;
	}else if(new_pass==null||new_pass==""){
		document.getElementById("err2").innerHTML="Vacant Field!";
		document.getElementById("newPass").focus();
		return false;
	}else if(new_pass.length<6){
		alert("entered"); //Problem
		document.getElementById("err2").innerHTML="Password should have at least 6 characters.";
		document.getElementById("newPass").focus();
		return false;
	}else if(new_pass.match(" ")){
		document.getElementById("err2").innerHTML="Spaces not allowed!";
		document.getElementById("newPass").focus();
		return false;
	}else if(con_pass==null||con_pass==""){
		
		document.getElementById("err3").innerHTML="Vacant Field!";
		document.getElementById("conPass").focus();
		return false;
	}else if(new_pass!=con_pass){
		document.getElementById("err3").innerHTML="Values in these fields do not match";
		document.getElementById("newPass").focus();
		document.getElementById("conPass").focus();
		return false;
	}else
		return true;
	
}

</script>
</head>
<body><br><br>

	<br><br>
<div id="form">
	<form id="passForm" onsubmit="return changePassword();" method="post" action="resetPass.html">
		<input type="hidden" name="identifier" value="0"/>
		<input type="hidden" name="empID" value="<%=session.getAttribute("EmployeeID")%>">
		<table>
			
			<tr>
				<td>Type Old Password:</td>
				<td><input type="password" id="oldPass" name="oldPass"/></td>
				<td id="err1"></td>
			</tr>
			<tr>
				<td>New Password:</td>
				<td><input type="password" id="newPass" name="newPass"/></td>
				<td id="err2"></td>
			</tr>
			<tr>
				<td>Confirm New Password:</td>
				<td><input type="password" id="conPass" name="conPass"/></td>
				<td id="err3"></td>
			</tr>
			<tr>
				<td colspan="3"><input type="submit" value="Change Password" /></td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>
<%}%>