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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<center><c:out value="${message}"/><br><br></center>
<center><a href="http://localhost:8080/Survey_Version2.0/resetPassword.jsp">Click here</a>to reset your password.</center>
</body>
</html>
<%} %>