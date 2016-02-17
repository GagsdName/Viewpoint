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
    <%@page import="dbreflib.URL.*"%>
    	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="WEB-INF/jsp/menu.jsp" %>
<script type="text/javascript" src="jQuery.js"></script>
<script type="text/javascript" src="validation.js"></script>
<link href="page.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	$(document).ready(function() {
		//alert("hi");
		fillCategoryList();

	});

	function fillCategoryList() {
var l="<%=dbreflib.URL.url%>"+"databse_functions_calling"
		$.ajax({
			type : 'POST',
			url : l,
			data : "id=" + 1,
			async : false,
			success : function(resp) {
	
				$("#categoryList").html(resp);
				//alert(resp);
				//alert("hi");
			}
		}); //ajax
	}//fillCategoryList
	
	
	function category() {
		 var answer = confirm ("Are you sure to delete this Category");
			if (answer) {
		var category=document.getElementById("categoryList").value;
		var l="<%=dbreflib.URL.url%>"+"databse_functions_calling"
				$.ajax({
					type : 'POST',
					url : l,
					data : "id=" +20+"&category_name="+category,
					async : false,
					success : function(resp) {
			
					
						alert(resp);
						 fillCategoryList();
						//alert("hi");
					}
				}); //ajax
			}
			}//fillCategoryList
</script>
</head>


<div style="margin-top: 100px;position: absolute;">

<form id='target' name="delete_category"   method="post" >
<fieldset class="f" id="deletecategory">	
	<label class="formlabel" id="deletecategory" >Delete a Category</label>
	<table border=0px width=100%>
	<tr>
	<td></td>
	<tr>
	
		<td>
		<label>Select Category</label>
		 <select id="categoryList" name="categoryList" /></select>
		 </td>
		
	</tr>
	
		
		
		<tr>
		
		
	
</tr>
</table>
<input type="image" src="images/button-check.png" class="buttoncheck" id="deletecategorybutton" title="Click to submit" onclick="category();"    />
</fieldset>
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

