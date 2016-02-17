<% if(session.getAttribute("RoleID")!=null && session.getAttribute("EmployeeID")!=null) 
 {
		response.sendRedirect("home.jsp");
	}else //if(session.getAttribute("RoleID").toString().equals("SAD111")||session.getAttribute("RoleID").toString().equals("USR131")||session.getAttribute("RoleID").toString().equals("ADM121"))
	 {

		 response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
 		 response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
 		 response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
 		 response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility 
 
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="dao.DaoClass"%>
<%@page import="java.util.*"%>
 <html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<title>Survey Wizard</title>
		<link href="login-box.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="jQuery.js"></script>
		<script type="text/javascript" src="functions.js"></script>
		<script>
		$(document).ready(function(){
			document.getElementById("f2_username_errorloc").innerHTML = "";
			document.getElementById("f2_pswd_errorloc").innerHTML = "";
		});
		
		
		</script>
	</head>
	

	<body bgcolor="#999999" >
		<div style="padding: 100px 0 0 250px;">
		<div id="login-box">
		<H2>Login</H2>
		Survey Wizard
						<form name="myform" onsubmit="return loginValidate('<%=System.currentTimeMillis()%>');" method="post" >
										<div id='f2_username_errorloc' align="center" ></div>
										<div id="login-box-name" style="margin-top: 20px;">Email:</div>
										<div id="login-box-field" style="margin-top: 20px;">
										<input id="user_id" name="username" class="form-login" title="Username" value="" size="30" maxlength="2048" /></div>
		                                <div id='f2_pswd_errorloc' align="center"></div>
				                        <div id="login-box-name">Password:</div>
				                        <div id="login-box-field">
					                    <input name="pswd" id="pswd_id" type="password" class="form-login" title="Password" value="" size="30" maxlength="2048" /></div>
		                                <span class="login-box-options">
		                                <input type="checkbox" name="1" value="1">Remember Me</span>
                                        <input type="submit" style="background-color: #135181; width: 103px; height: 42px; position: absolute; color: #EEEEEE;
                                        position:absolute;margin-top: 25px;margin-left:-100px "; value="Login" />
			           					<div name="error" id="error_id"></div>
			           						
			           </form>
			                           <font color="white" size="-1"><br><br><p style="margin-top: 35px">Please contact administrator if you Forgot password?</p>
			                           </font>
                                       </div>
                                       </div>



	</body>
	
	
</html>
<%}%>