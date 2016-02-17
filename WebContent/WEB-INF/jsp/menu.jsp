


<% try { %>

<%@page import="dbreflib.URL.*"%>
<%@page import="dbreflib.database_functions_body"%>

<link href="menu_style.css" type="text/css" media="screen"
	rel="stylesheet">
	<link rel="shortcut icon" href="images/favicon.ico">

	
</head>
<body>
	<%

	String username=database_functions_body.get_username(Integer.parseInt(session.getAttribute("EmployeeID").toString()));
	
	%>
	</style>
</head>

<body>
	<table id="navigation">
		<tr>
			<%
									if (session.getAttribute("RoleID").equals("SAD111")
											|| session.getAttribute("RoleID").equals("ADM121")) 
									{
								%><td id="navitem"><a id="navlink"
				href=<%=dbreflib.URL.url+"manage_surveys.jsp"%>>Manage
					Surveys</a></td>
					<%
									}
								%>

	<%
									if (session.getAttribute("RoleID").equals("SAD111")
											|| session.getAttribute("RoleID").equals("ADM121")) {
								%>
			<td id="navitem"><a id="navlink"
				href=<%=dbreflib.URL.url+"manage_user.jsp"%>>Manage
					Users</a></td>
						<%
									}
								%>
	<%
									if (session.getAttribute("RoleID").equals("SAD111")
											) {
								%>
								
<td id="navitem"><a id="navlink"
				href=<%=dbreflib.URL.url+"manage_categories.jsp"%>>Manage Categories</a></td>
				<%
									}
								%>
			<td id="navitem"><a id="navlink"
				href=<%=dbreflib.URL.url+"welcome_take_survey.jsp"%>>Take
					a Survey</a></td>
			<%
									if (session.getAttribute("RoleID").equals("SAD111")
											|| session.getAttribute("RoleID").equals("ADM121")) {
								%>
								
			<td id="navitem"><a id="navlink"
				href=<%=dbreflib.URL.url+"report.jsp"%>>Generate
					Reports</a></td>
<%
									}
								%>
		
		
		<td id="navitem"><a id="navlink"
				href=<%=dbreflib.URL.url+"logout.jsp"%>>Logout</a></td>
				
			
		</tr>
	</table>
	<table><tr>
	<td id="navlink1"><span>Welcome <%out.println(username);%></span><br><a href="resetPassword.jsp">Change Password</a></td></tr></table>

<%}
catch(Exception ee)
{
	response.sendRedirect("login.jsp");
}
%>
</body>

</html>