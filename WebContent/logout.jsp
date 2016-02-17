
<%

session.setAttribute("EmployeeID",null);
session.setAttribute("RoleID",null);
session.invalidate();
response.sendRedirect("login.jsp");

%>