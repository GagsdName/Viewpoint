<%
	response.setHeader("Cache-Control", "no-cache"); //Forces caches to obtain a new copy of the page from the origin server
	response.setHeader("Cache-Control", "no-store"); //Directs caches not to store the page under any circumstance
	response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0 backward compatibility

	if (session.getAttribute("RoleID") == null
			&& session.getAttribute("EmployeeID") == null) 
	{
		response.sendRedirect("login.jsp");
	} else if (session.getAttribute("RoleID").toString()
			.equals("SAD111")
			|| session.getAttribute("RoleID").toString()
					.equals("USR131")
			|| session.getAttribute("RoleID").toString()
					.equals("ADM121")) {
		
		
		int timeout = session.getMaxInactiveInterval();
		response.setHeader("Refresh", timeout + "; URL =login.jsp");
		
		
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file="WEB-INF/jsp/menu.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete User</title>
<link href="popup.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="jQuery.js"></script>
<script type="text/javascript" src="functions.js"></script>
<link href="page.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="csspopup.js"></script>


<script type="text/javascript">
function verifyPass(){
	//alert("verify!");
	if(document.getElementById('newPass').value==document.getElementById('conPass').value && document.getElementById('newPass').value!=""){
		return true;
	}else{
		alert("Ensure for non-vacant fields and passwords in both fields match?");
		return false;
	}
}
</script>
<%if(session.getAttribute("RoleID").toString().equals("ADM121")){
%>

 
<script type="text/javascript">
$(document).ready(function(){
	//document.getElementById("field2").style.display="none";
	//fillRoleList();
	
	fillEmpList();
	
});

function fillEmpList(){
		
	$.ajax({
		type: 'POST',
		url: "<%=dbreflib.URL.url+"getcategory"%>",
		data:"id="+10,
		async: false,
		success: function(resp){
			$("#empList").html(resp);
		}
	});
	
	dataDeleteUser();
	document.getElementById('empID').value=document.getElementById('empList').options[document.getElementById('empList').selectedIndex].value;
	
}
</script>

</head>
<body>
<br><br><br><br><br>
<div>
<div id="blanket" style="display: none;"></div>
	<div id="popUpDiv" align="left"
			style="display: none; border: solid; border-color: #333333; width: 500px;height: 200px;position:absolute;">
			
			<a href="#" onClick="popup('popUpDiv');document.getElementById('newPass').value='';document.getElementById('conPass').value='';"  style="border:0;position: absolute;margin-left: 393px;margin-top: -10;text-decoration:none;"><img alt="Close" src="images/cancel.gif" style="text-decoration: none;border: 0"></a>
			<div style="position:absolute;margin-top:50px;margin-left:50px">			
			<form onsubmit="return verifyPass();" action="resetPass.html" method="post" >
			<table>
			<input type="hidden" name="identifier" value="1"/>
			<input type="hidden" name="empID" id="empID"/>
			<input type="hidden" name="msg_id" id="msg_id"/>
			<tr><td><label for="newPass">Enter New Password:</label></td><td><input type="password" id="newPass" name="newPass"/></td></tr>
			<tr><td><label for="conPass">Confirm Password:</label></td><td><input type="password" id="conPass"/></td></tr>
			<tr><td colspan="2" align="center"><input type="submit" value="Submit"/></td><tr>
			</table>
			</form>
			
			
			</div>
			
			
	</div>
</div>
<fieldset class="f" id="field2" >


<select id="empList" onchange="dataDeleteUser()"></select>
<table id="dTable" border="1"></table>

<%}else if(session.getAttribute("RoleID").toString().equals("SAD111")){
%>
<script type="text/javascript">
$(document).ready(function(){
	//document.getElementById("field2").style.display="none";
	fillRoleList();
	fillEmpList();
	
	
	
});

function fillEmpList(){
	//alert("entered");
	var selectedRoleId=document.getElementById("roleList").options[document.getElementById("roleList").selectedIndex].value;
	$.ajax({
		type: 'POST',
		url: "<%=dbreflib.URL.url+"getcategory"%>",
		data:"id="+10+"&selectedRoleId="+selectedRoleId,
		async: false,
		success: function(resp){
			$("#empList").html(resp);
		}
	});
		
	if(document.getElementById('empList').options[document.getElementById('empList').selectedIndex].value!=0){
		dataDeleteUser();
		document.getElementById('empID').value=document.getElementById('empList').options[document.getElementById('empList').selectedIndex].value;
	}else{
		document.getElementById('dTable').innerHTML="";
	}
}
</script>
 
</head>
<body>
<br><br><br><br><br>
<div>
<div id="blanket" style="display: none;"></div>
	<div id="popUpDiv" align="left"
			style="display: none; border: solid; border-color: #333333; width: 400px;height:200px;position:absolute;">
			<a href="#" onClick="popup('popUpDiv');document.getElementById('newPass').value='';document.getElementById('conPass').value='';"  style="border:0;position: absolute;margin-left: 393px;margin-top: -10;text-decoration:none;"><img alt="Close" src="images/cancel.gif" style="text-decoration: none;border: 0"></a>
			<div style="position:absolute;margin-top:50px;margin-left:50px">
			<form onsubmit="return verifyPass();" action="resetPass.html" method="post">
			<table>
			<input type="hidden" name="identifier" value="1"/>
			<input type="hidden" name="empID" id="empID"/>
			<input type="hidden" name="msg_id" id="msg_id"/>
			<tr><td><label for="newPass">Enter New Password:</label></td><td><input type="password" id="newPass" name="newPass"/></td></tr>
			<tr><td><label for="conPass">Confirm Password:</label></td><td><input type="password" id="conPass"/></td></tr>
			<tr><td colspan="2" align="center"><input type="submit" value="Submit"/></td><tr>
			</table>
			</form>
			</div>
	</div>
</div>
<%}%>
<fieldset id="field2" class="f">
<label class="formlabel" id="deleteuser">Delete User</label>
<br>
Select Category: <select id="roleList" onchange="fillEmpList()"></select><br><br>
Select Employee: <select id="empList" onchange="dataDeleteUser()"></select>
<table id="dTable" border="1" ></table>
<br><br>
<!-- <label id="message"></label>-->
</fieldset>
			
		</body>
</html>

<%}%>