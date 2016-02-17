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
<%@ include file="WEB-INF/jsp/menu.jsp" %>
	
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="dbreflib.URL.*"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<img src="images/working_gloves.png"  id="createcategory"/>
<link href="page.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="jQuery.js"></script>
<script type="text/javascript" src="validation.js"></script>
<script type="text/javascript">

	function adding() {
		alert("hello");
	
		var category=document.getElementById("category_name").value;
		var l="<%=dbreflib.URL.url%>"+"databse_functions_calling"
				$.ajax({
					type : 'POST',
					url : l,
					data : "id=" +19+"&category_name="+category,
					async : false,
					success : function(resp) {
								alert(resp);
								document.getElementById("category_name").value="";
					}
				}); //ajax
			
			}//fillCategoryList
			
			
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create a Category</title>
</head>
<body>
<fieldset class="f" id="createcategory">
<label class="formlabel" id="createcategory">Create a Category</label>
<form name="create_category" method="post" >
<label>Enter Category Name: </label><input type="text" name="category_name" id="category_name">
<input type="image" src="images/button-check.png" class="buttoncheck" id="createcategorybutton" title="Click to submit" onclick="return validate_category();">
</form>
</fieldset>
</body>
</html>
<%  
}
else
{
	response.sendRedirect(dbreflib.URL.url+"Access-Denied.jsp");
}
%>
