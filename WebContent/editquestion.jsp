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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="validation.js"></script>
<title>Manage Surveys</title>
<%
	String question, option1, option2, option3, option4, option5, surveyname, category;
	int question_id, page_id;
	page_id = Integer.parseInt(request.getParameter("page_id"));
	question_id = Integer.parseInt(request.getParameter("question_id"));
	surveyname = request.getParameter("surveyname");
	category = request.getParameter("category");
	/*
	 out.println(question_id);
	 out.println(page_id);
	 out.println(surveyname);
	 out.println(category);
	 */
	if (page_id == 1) {
		question =(request.getParameter("question")).trim();
		option1 = (request.getParameter("option1")).trim();
		option2 = (request.getParameter("option2")).trim();
		option3 = (request.getParameter("option3")).trim();
		option4 = (request.getParameter("option4")).trim();
		option5 = (request.getParameter("option5")).trim();

		/*
		 out.println("Question "+question);
		 out.println("Option1 "+option1);
		 out.println("Option2 "+option2);
		 out.println("Option3 "+option3);
		 out.println("Option4 "+option4);
		 out.println("Option5 "+option5);
		 out.println("Question ID "+question_id);
		 out.println("Surveyname "+surveyname);
		 out.println("Category "+category);
		 */
%>

<script type="text/javascript" src="csspopup.js"></script>
<link href="popup.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div>
		<div id="blanket" style="display: none;"></div>





		<div id="popUpDiv" align="left"
			style="display: none; border: solid; border-color: #333333; width: 900px; height: 330px">
			<a href="#" onClick="redirect_page()"
				style="border: 0; position: absolute; margin-left: 885px; margin-top: -10; text-decoration: none;"><img
				alt="Close" src="images/cancel.gif"
				style="text-decoration: none; border: 0"></a>





			<form method="post" name="add_question_form">
				<table>

					<tr>
						<label style="position: absolute; margin-left: 63px; color: gray;"><b>Enter
								Question</b></label>
					</tr>
					<tr style="position: absolute; margin-left: 54px; margin-top: 14px">
						<td><textarea rows="6" cols="90" id="myquestion"><%out.print(question);%></textarea></td>
					</tr>
					<tr style="position: absolute; margin-top: 140px">
						<td><label style="color: gray;"><b>Option 1</b></label><input
							name="option1" id="myoption1" value='<%=option1%>' /></td>
						<td><label style="color: gray;"><b>Option 2</b></label><input
							name="option2" id="myoption2" value='<%=option2%>' /></td>
					</tr>
					<tr style="position: absolute; margin-top: 170px">
						<td><label style="color: gray;"><b>Option 3</b></label><input
							name="option3" id="myoption3" value='<%=option3%>' /></td>
						<td><label style="color: gray;"><b>Option 4</b></label><input
							name="option4" id="myoption4" value='<%=option4%>' /></td>
					<tr style="position: absolute; margin-top: 200px">
						<td><label style="color: gray;"><b>Option 5</b></label><input
							name="option5" id="myoption5" value='<%=option5%>' /></td>
					</tr>
					<tr style="position: absolute; margin-top: 250px">
						<td><input type="button" value="Update Question"
							style="height: 40px; margin-left: 200px"
							onclick="update_form();"></td>
					</tr>
				</table>










			</form>

			<%
				}

				else if (page_id == 2) {
			%>


			<%
				}
			%>
			<script type="text/javascript" src="jQuery.js"></script>


		</div>
	</div>


	<form name="myform" action="createsurvey.html" method="post">
		<input type="hidden" value="<%=surveyname%>" name="surveyname">
		<input type="hidden" value="<%=category%>" name="category"> <input
			type="hidden" value='0' name="page_id">
	</form>

	<script type="text/javascript">
	<%if (page_id == 1) {%>
	popupcall();
	<%}%>
		
		
		$.ajaxSetup ({
		    // Disable caching of AJAX responses
		    cache: false
		});
		
		
	 function redirect_page()
	 {
		// alert("jaspreet");
		  
		 document.myform.submit();
	 }

	
					 
		
	
	function popupcall() {
		//alert("hi");
		popup('popUpDiv');
		
	}
	
	
	
	function update_question_details(){
		   
		   question_id="<%=question_id%>";
		   surveyname="<%=surveyname%>";
		   category="<%=category%>";
		   //alert("surveyname "+surveyname+"categoryname"+category);
		   var option=new Array();
		   var i,j,count=0;
		// alert("hi");
	   myquestion=document.getElementById("myquestion").value;
	   option[0]=document.getElementById("myoption1").value;
	   option[1]=document.getElementById("myoption2").value;
	   option[2]=document.getElementById("myoption3").value;
	  option[3]=document.getElementById("myoption4").value;
	   option[4]=document.getElementById("myoption5").value;
	option[5]=null;
	
	   for(i=0;i<5;i++)
		   {
		   if(option[i]=="" || option[i]=="null")
			   { 
			   for(j=i;j<5;j++)
				  {
				   option[j]=option[j+1];
				   }
				   
				  
			   i=i-1;
		   
			   }
		   }
	
	var l="<%=dbreflib.URL.url%>"+ "databse_functions_calling"
	 //  alert(myquestion+myoption1+myoption2+myoption3+myoption4+myoption5+question_id);
			$.ajax({
				type: 'POST',
				url: l,
				data: "myquestion="+myquestion+"&myoption1="+option[0]+" &myoption2="+option[1]+" &myoption3="+option[2]+" &myoption4="+option[3]+" &myoption5="+option[4]+" &question_id="+question_id+"&id="+5+"&surveyname="+surveyname+"&category="+category,
				async: false,
				success:function(resp) {
					$("#response").html(resp);
					 alert(resp);
					 redirect_page();
					 
					
				}	
			}); 
		}
	
	
	
	</script>



	<script>
		
	</script>
</head>
<body>

</body>
</html>
<%}else
	response.sendRedirect(dbreflib.URL.url+"Access-Denied.jsp");%>