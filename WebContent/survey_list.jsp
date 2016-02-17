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
<%@page import="dbreflib.URL"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@page import="dbreflib.URL.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Survey List</title>
<%@ include file="WEB-INF/jsp/menu.jsp"%>

<link href="page.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="jQuery.js"></script>
<script type="text/javascript" src="dropdown_functions.js"></script>
<script type="text/javascript" src="validation.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		//alert("hi");
		fillcategory();

	});

	
</script>
<link href="page.css" rel="stylesheet" type="text/css" />
	<img src="images/database.png" id="viewsurveylist"/>

	<form id='target' name="categoryform" 
		method="post" >
		<fieldset class="f" id="viewsurveylist">
			<label class="formlabel" id="viewsurveylist">View Survey List</label>
				<br>
			<table id="viewsurveylist" cellspacing="10px">
			<tr>
			<td>Select Category</td> 
			<td>
			<select id="category"
						name="category" /></select></td>

				</tr>
			<tr>
			
					<td>
						<a href="#"><img src="images/button-check.png" class="buttoncheck" onclick="show_surveys();" id="buttonviewsurveylist"></a>
					</td>


				</tr>



			</table>

		</fieldset>
	</form>
	

</head>
<body>


   <script type="text/javascript" src="jQuery.js"></script>
<script>


function publish_survey(surveyname) {
	  //alert("hello");

	  // var surveyname=document.getElementByName("surveyname").value; 
	 //  alert(surveyname);
var category=document.getElementById("category").value;
var l="<%=dbreflib.URL.url%>" + "databse_functions_calling"
	   
		$.ajax({
			type : 'POST',
			url : l,
			data : "id="+11+"&surveyname="+surveyname+"&category="+category,
			async : false,
			success : function(resp) {
			
				alert(resp);
			}
		}); //ajax
	
		show_surveys();
 
 }
 
 function unpublish_survey(surveyname) {
	  // alert("hello");
var category=document.getElementById("category").value;
var l="<%=dbreflib.URL.url%>" + "databse_functions_calling"

	 // alert(surveyname);
		$.ajax({
			type : 'POST',
			url : l,
			data : "id="+12+"&surveyname="+surveyname+"&category="+category,
			async : false,
			success : function(resp) {
			
				alert(resp);
			}
		}); //ajax
	
		show_surveys();
 
 }





function popupform(myform, windowname)
{
if (! window.focus)return true;
window.open('', windowname, 'height=700,width=700,scrollbars=yes');
myform.target=windowname;
return true;
}
 
function submitView(){
	document.overstand.submit();
	return false;
}
 
</script>

<div class="onpage"  id="delhi" > 

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