<%
 response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
 response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
 response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
 response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
 
 
 if(session.getAttribute("RoleID")==null && session.getAttribute("EmployeeID")==null) //||!session.getAttribute("RoleID").toString().equals("USR131")||!session.getAttribute("RoleID").toString().equals("ADM121"))
 {
	 response.sendRedirect("login.jsp");
	 }else if(session.getAttribute("RoleID").toString().equals("SAD111")||session.getAttribute("RoleID").toString().equals("USR131")||session.getAttribute("RoleID").toString().equals("ADM121"))
	 {%>
<%@page import="dbreflib.DbConn"%>
<%@page import="java.sql.*"%>

<HTML>
	<HEAD>
		<TITLE>FusionCharts Free - Simple Column 3D Chart using dataXML method</TITLE>
		<style type="text/css">
			<!--
			body {
				font-family: Arial, Helvetica, sans-serif;
				font-size: 12px;
			}
			-->
		</style>
	</HEAD>
	<BODY>
		<CENTER>
			
			<%
			String opt1=request.getParameter("opt1text").toString();
	String opt2=request.getParameter("opt2text").toString();
	String opt3=request.getParameter("opt3text").toString();
	String opt4=request.getParameter("opt4text").toString();
	String opt5=request.getParameter("opt5text").toString();
	
			int a=Integer.parseInt(request.getParameter("opt1").toString());
	int b=Integer.parseInt(request.getParameter("opt2").toString());
	int c=Integer.parseInt(request.getParameter("opt3").toString());
	int d=Integer.parseInt(request.getParameter("opt4").toString());
	int e=Integer.parseInt(request.getParameter("opt5").toString());
												String strXML="";
											
												strXML += "<graph caption='Question Review(*all figures in percentage format*)' xAxisName='Options' yAxisName='Users' decimalPrecision='0' formatNumberScale='0' scale='1'>";
												
												if(!opt1.equals(" ")&&a!=0)
													strXML += "<set name='"+opt1+"' value='"+a+"' color='AFD8F8'/>";
													if(!opt2.equals(" ")&&b!=0)
												strXML += "<set name='"+opt2+"' value='"+b+"' color='F6BD0F'/>";
												if(!opt3.equals(" ")&&c!=0)
												strXML += "<set name='"+opt3+"' value='"+c+"' color='8BBA00'/>";
												if(!opt4.equals(" ")&&d!=0)
												strXML += "<set name='"+opt4+"' value='"+d+"' color='FF8E46'/>";
												if(!opt5.equals(" ")&&e!=0)
												strXML += "<set name='"+opt5+"' value='"+e+"' color='008E8E'/>";
												
												strXML += "</graph>";
												
												//Create the chart - Column 3D Chart with data from strXML variable using dataXML method
						%> 
				<jsp:include page="FusionChartsHTMLRenderer.jsp" flush="true"> 
					<jsp:param name="chartSWF" value="FCF_Column3D.swf" /> 
					<jsp:param name="strURL" value="" /> 
					<jsp:param name="strXML" value="<%=strXML%>" /> 
					<jsp:param name="chartId" value="Question_Review" /> 
					<jsp:param name="chartWidth" value="600" /> 
					<jsp:param name="chartHeight" value="200" /> 
					<jsp:param name="debugMode" value="false" /> 	
				</jsp:include>
			<BR>
			<BR>
			</CENTER>
	</BODY>
</HTML>
<% }%>