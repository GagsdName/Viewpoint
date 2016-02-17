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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ include file="WEB-INF/jsp/menu.jsp" %>
	<img src="images/notebook.png"  id="updatesurvey"/>
<link href="page.css" rel="stylesheet" type="text/css" />
<br><br><br>
<form id='target' name="categoryform" action="input.jsp" method="post">
<fieldset class="f" id="updatesurvey">	
	<label id="updatesurvey"><b>Take a Survey</b></label>
	<table border=0px width=100%>
	<tr>
	<td></td>
	<tr>
	
		<td>
		<label>Select Category:</label> 
		 <select id="category" name="category" onchange=fillSurveyList1()></select> 
		 </td>
		
	</tr>
	<tr>
		<td >
		<label>Select Survey:</label>  
		<select id="surveyname" name="surveyname"></select> 
		<input type="hidden" name="page_id" value="2">
		</td>
		
		</tr>
		<tr>
		
		<td style="border: 0px"><input type="image" src="images/button-check.png" class="buttoncheck" id="updatesurvey"/></td>
	
</tr>
</table>

</fieldset>
</form>

<script type="text/javascript" src="jQuery.js"></script>


<script type="text/javascript">


$(document).ready(function() {
	 fillCategoryList()

});
var l="<%=dbreflib.URL.url%>"+"getcategory";
function fillCategoryList() {
        //alert("entered category");
        $.ajax({
                type : 'POST',
                url : l,
                data : "id=" + 1,
                async : false,
                success : function(resp) {
                        //alert(resp);
                        $("#category").html(resp);

                }
        });
        fillSurveyList1();
}
function fillSurveyList1() {

    var combo = document.getElementById("category");
    var val = null;
    if (combo.selectedIndex >= 0) {

            val = combo.options[combo.selectedIndex].value;

    }
    var l="<%=dbreflib.URL.url%>"+"getcategory"

    $.ajax({
            type : 'POST',
            url :l,
            data : "id=" + 9 + "&value=" + val,
            async : false,
            success : function(resp) {
                    $("#surveyname").html(resp);
            //        alert(resp);
            }
    }); //ajax
}//fillSurveyList*/

</script>


</body>
</html>

<%  
}
else
{
	response.sendRedirect(dbreflib.URL.url+"Access-Denied.jsp");
}
%>



