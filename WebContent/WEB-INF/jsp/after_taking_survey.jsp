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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="menu.jsp" %>
<html>
<link rel="stylesheet" href="page.css">
	<body>	
	
		<div class="message"><font size="18"><c:out value="${message}" /></font></div>	
		
		
	</body>
</html>
<% }%>