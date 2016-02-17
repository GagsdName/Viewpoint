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
<%@ include file="WEB-INF/jsp/menu.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style type="text/css">
@import "page.css";
</style>
<title>Reports</title>

<script type="text/javascript" src="jQuery.js"></script>
<script type="text/javascript" src="functions.js"></script>

<script type="text/javascript">
	$(document).ready(function() {

		document.getElementById("field2").style.display = "none";
		fillCategoryList();

	});
</script>

<link href="page.css" rel="stylesheet" type="text/css" />
</head>
<body>
<br>
<br><br>

	<img src="images/bar_chart.png"  id="report"/>
	<fieldset class="f" id="report">
		<label class="formlabel" id="report">Generate Report</label>
		<br><br>

		<table border=0px width="auto">
			<tr>
				<td><label><font color="white">Select Category:</font></label></td>
				<td><select id='categoryList' onchange='fillSurveyList()'></select>
				</td>

			</tr>
			<tr>
				<td><label><font color="white">Select Survey:</font></label></td>
				<td><select id='surveyList' name="survey">
				</select></td>

			</tr>


			<tr>
				<td style="border: 0px"><br>
				<center>
				
						<input type="image" title="Click here to generate report!" src="images/button-check.png" onclick="getSurvey();" class="buttoncheck" id="reportsubmit"/>
					</center></td>

			</tr>
		</table>

	</fieldset>

	<fieldset style="border: 0px; height: auto;" id="field2">

		<center>
			<table border="0px" width="1000px">
				<tr >
					<td id="surveyTitle" ></td>
				</tr>
				<tr>
				<label id="reporttable">Report Table</label>
				<div  id="qTable" >
				
					</div>
				</tr>
			</table>
		</center>
	</fieldset>

</body>
</html>
<%}else
	response.sendRedirect(dbreflib.URL.url+"Access-Denied.jsp");%>