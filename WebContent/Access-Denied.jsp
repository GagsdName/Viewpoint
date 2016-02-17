
<% 	response.setHeader("Cache-Control", "no-cache"); //Forces caches to obtain a new copy of the page from the origin server
	response.setHeader("Cache-Control", "no-store"); //Directs caches not to store the page under any circumstance
	response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0 backward compatibility
	
	if(session.getAttribute("RoleID")!=null && session.getAttribute("EmployeeID")!=null){
		session.setAttribute("EmployeeID",null);
		session.setAttribute("RoleID",null);
		session.invalidate();	
	}
	 
	
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="refresh" content="5; url=login.jsp"/>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Warning</title>
<script type="text/javascript" src="jQuery.js"></script>
<script type="text/javascript">
var time=5;
$(document).ready(function(){
	
	CreateTimer(time);
})

function CreateTimer(Time) {
    Timer = document.getElementById("sec");
    TotalSeconds = time;
    
    UpdateTimer();
    window.setTimeout("Tick()", 1000);
}
function Tick() {
    TotalSeconds -= 1;
    UpdateTimer()
    window.setTimeout("Tick()", 1000);
}

function UpdateTimer() {
    Timer.innerHTML = TotalSeconds;
}

</script>
</head>
<body>
	<p>You are not authorized to view this page!!</p><p>Redirecting to login page in <label id="sec"></label> seconds</p>
</body>
</html>