package controllers;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
//import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import dbreflib.PasswordHashing;

public class UserController implements Controller{
	
	public ModelAndView handleRequest(HttpServletRequest request, 
			HttpServletResponse response)throws IOException, ServletException{
		PreparedStatement   stmt,stmt1,stmt2;  
		 Connection conn;
		PrintWriter pw=response.getWriter();
		 //String employeeRole= request.getParameter("Role");
		 //String employeeName= request.getParameter("EmpName");
		 //String employeeId= request.getParameter("EmpId");
		 //String employeeEmail= request.getParameter("EmailId");
		 //String employeePass= request.getParameter("EmpPass");
		 // String confirmPass= request.getParameter("RetypePass");
		 
		 //PasswordHashing pass_obj= new PasswordHashing();
		 String hashedPassword=PasswordHashing.generateHash(request.getParameter("EmpPass"));
		 String str="Successfully Added the User",survey_user_query="";
		  
		 try{
			conn=dbreflib.DbConn.getConnection();
			stmt=conn.prepareStatement("insert into users values (?,?,?,?,?,?)");
			stmt1=conn.prepareStatement("insert into user_role_map values(?,?)");
			String surveys_value[] = null;
			try {
				surveys_value=request.getParameterValues("surveys_checkbox");
			 survey_user_query="insert into survey_user_map values(?,?)";
			 for(int i=0;i<surveys_value.length;i++)
			 {
				 stmt2=conn.prepareStatement(survey_user_query);
				 stmt2.setInt(1,Integer.parseInt(request.getParameter("EmpId")));
				 stmt2.setInt(2,Integer.parseInt(surveys_value[i]));
				 stmt2.executeUpdate();
				 
			 }
			}
			catch(Exception ee)
			{
				pw.print(ee.getMessage());
			}
			 
			
			stmt.setInt(1,Integer.parseInt(request.getParameter("EmpId")));
			stmt.setString(2,hashedPassword);
			stmt.setString(3,request.getParameter("EmpName"));
			stmt.setString(4,request.getParameter("EmailId"));
			stmt.setString(5,"active");
			stmt.setLong(6, System.currentTimeMillis());
			
			stmt1.setString(1,request.getParameter("Role"));
			stmt1.setInt(2,Integer.parseInt(request.getParameter("EmpId")));
			
			
			conn.setAutoCommit(false);
			stmt.executeUpdate();
			stmt1.executeUpdate();
			 
			conn.commit();
			
		}catch(SQLException e){
			str=e.getMessage();
		}
		
		 
		 
		ModelAndView mAV= new ModelAndView("after_user_creation");
		mAV.addObject("message",str);
		
		return mAV;
	}
	

}
