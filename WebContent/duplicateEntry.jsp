<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="dbreflib.URL"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<link rel="stylesheet" href="page.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Redirection..</title>
</head>
<body>
<label class="msg">Please choose a different Survey Name as it already exists in the database!<br><label> You will be redirected in 10 seconds....</label></label>

<% 
 response.setHeader("Refresh", "10; URL="+dbreflib.URL.url+"create_survey.jsp");
%>
</body>
</html>