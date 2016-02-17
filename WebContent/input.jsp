
<%
	response.setHeader("Cache-Control", "no-cache"); //Forces caches to obtain a new copy of the page from the origin server
	response.setHeader("Cache-Control", "no-store"); //Directs caches not to store the page under any circumstance
	response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0 backward compatibility

	if (session.getAttribute("RoleID") == null
			&& session.getAttribute("EmployeeID") == null) //||!session.getAttribute("RoleID").toString().equals("USR131")||!session.getAttribute("RoleID").toString().equals("ADM121"))
	{
		response.sendRedirect("login.jsp");
	} else if (session.getAttribute("RoleID").toString().equals("SAD111")|| session.getAttribute("RoleID").toString().equals("USR131")|| session.getAttribute("RoleID").toString().equals("ADM121")) 
	{
		int timeout = session.getMaxInactiveInterval();
		response.setHeader("Refresh", timeout + "; URL =login.jsp");

%>



<%@page import="java.sql.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.Cookie"%>

<%@page import="javax.servlet.http.*"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page import="java.util.*"%>
<%@page import="dbreflib.DbConn"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="WEB-INF/jsp/menu.jsp"%>
<!DOCTYPE html>

<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
@import "page.css";
</style>

<title>Survey_Page</title>
<script type="text/javascript" src="jQuery.js"></script>
</head>

<body>


		<%int surveyid=0;int empid=Integer.parseInt(session.getAttribute("EmployeeID").toString());int question=0;
		int q=0;	
		try {

					Connection con = DbConn.getConnection();
					Statement stmt = con.createStatement();
					Statement stmt2 = con.createStatement();
					String surveyname=request.getParameter("surveyname").toString();
					String category=request.getParameter("category").toString();
					ResultSet rst=stmt.executeQuery("select * from surveys where Flag='active'");
				
					
					while(rst.next()){
					
				if(rst.getString("Survey_Name").equals(surveyname)&& rst.getString("Category").equals(category))
					surveyid=rst.getInt("Survey_Id");
					//out.println(sid);
				}	
					 rst=stmt.executeQuery("select count(*) from submission where Survey_ID ="
							+ surveyid + " and Employee_ID=" + empid);
					rst.absolute(1);
			
					if(rst.getInt("count(*)")==0)
					{
						
						
						 ResultSet rst3=stmt.executeQuery("select count(*) from survey_question_map where Survey_ID ="+ surveyid + " and Flag='active'");
						 rst3.absolute(1);
						if(rst3.getInt("count(*)")!=0)
						{	
							ResultSet rs1=stmt.executeQuery("select * from survey_question_map where Flag='active'");
							
						%>
						
						<label id="takesurveytable">Take this Survey!</label><br>
						<div id="takesurvey">
						<table id="takesurveytable">
						
						<form name="survey" id="survey" action="takesurvey.html" onsubmit="return validate_survey()">
						<%
						while(rs1.next())
						{
							int sid=Integer.parseInt(rs1.getString("Survey_ID"));
							int qid=Integer.parseInt(rs1.getString("Question_ID"));
							if(surveyid==sid)
							{ ResultSet rs2=stmt2.executeQuery("select * from questions");
							session.setAttribute("surveyid",sid);
							question++;
								while(rs2.next())
								{
									int qid1=Integer.parseInt(rs2.getString("Question_ID"));
									if(qid1==qid)
									{ q++;
									String name="opt"+q;
									%>
									<tr ><th colspan='5' rowspan='2' >
									
									<%
										out.println("Que."+question+"\t\t"+rs2.getString("Question"));
					                 
					                %></th></tr>
					                <tr></tr>
					                <tr class="alt">
					                <% String choice1=rs2.getString("Opt_1");
					                if(choice1==null||choice1.trim().equals("null"))
					                {
					                	 choice1=" ";  
					                	 }
					                	
					                %>
					                <td>
					                  <% if(!choice1.equals(" ")){%><input type="radio" name="<%=name %>" value="<%=choice1%>"  ><%} %>
					                  <% out.println(choice1);
					                  %>
					                  </input>
					                  </td>
					                  
					                  
					                  <% String choice2=rs2.getString("Opt_2");
					                  if(choice2==null||choice2.trim().equals("null"))
						                {
					                	  choice2=" ";  
					                	  }
						                	
						                %><td>
						                   <% if(!choice2.equals(" ")){%><input type="radio" name="<%=name %>" value="<%=choice2%>" ><%} %>
					                  <% out.println(choice2);
					                  %>
					                  </input>
					                  </td>
					                  
					                  <% String choice3=rs2.getString("Opt_3");
					                  if(choice3==null||choice3.trim().equals("null"))
						                {
					                	  choice3=" "; 
						                }
						                	
						                %>
						                  
					                 <td>
					                 <% if(!choice3.equals(" ")){%><input type="radio" name="<%=name %>" value="<%=choice3%>" ><%} %>
					                  <% out.println(choice3);
					                  %>
					                  </input> 
					                  </td>
					                  <% String choice4=rs2.getString("Opt_4");
					                  if(choice4==null||choice4.trim().equals("null"))
						                {
					                	choice4=" "; 
						                }
						                	
						                %>
						                               
					 <td>
					 				 <% if(!choice4.equals(" ")){%><input type="radio" name="<%=name %>" value="<%=choice4%>" ><%} %>
					                  <% 
					                  out.println(choice4);
					                  %>
					                  </input>	</td>
					                  
					                  <% String choice5=rs2.getString("Opt_5");
					                  if(choice5==null||choice5.trim().equals("null"))
						                {
					                	  choice5=" "; 
						                }
						                	
						                %>
						                    
					 <td>
					                  <% if(!choice5.equals(" ")){%><input type="radio" name="<%=name %>" value="<%=choice5%>" ><%} %>
					                  <% 
					                  out.println(choice5);
					                  %>
					                  </input>	</td></tr>
					                
					            
			        
			        <% 					
								}
									}
								//out.println(rs1.getString("Question_ID"));
							}
								
						}
						%>
					
					<tr class="alt"><td colspan="5"><input type="image" src="images/button-check.png" class="buttoncheck" id="takesurveybutton" title="Submit Response" onclick="alert('Are you sure, you want to submit your response?');"/></td></tr>
						</form>
						<% }
						else{
							%>
							<label class="msg">No Questions in this Survey!</label>
							<% 
						}

						
							}
						
					else{
						%>
						<label class="msg">You have already taken this Survey!</label>
						<% 
					
						
					}
					
				
					
						
					
			}
			
catch(Exception e){}

%>

</table>
</div>
</body>
<script type="text/javascript">
function validate_survey(){
	var q_count=<%=q%>;
	var options,i,j;
	for(j=1;j<=q_count;j++){
		options=document.getElementsByName("opt"+j);
		
		
		for(i=0;i<options.length;i++){
			//alert("entered");
			if(options[i].checked==true){
				break;
			}else
				continue;
		}
		if(i==options.length){
			alert("Question no. "+j+" has not been answered!");
			return false;
		}
	}
	if(j>q_count)
		return true;
	/*else{
		alert("Some logical error!");
		return false;	
	}*/

}
</script>
</html>

<%
	}
		else {
		response.sendRedirect(dbreflib.URL.url + "Access-Denied.jsp");
	}
%>
