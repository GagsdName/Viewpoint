package controllers;

import java.sql.*;
import java.io.IOException;
import dbreflib.DbConn;
//import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;
 
public class UserLoginRequestController implements Controller {
	String name,pass;
	int empid;
	 PreparedStatement   stmt;  
	 Connection conn;
	 
	 
 
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		//PrintWriter out = response.getWriter();
		/*
		name = request.getParameter("username");
		   empid =Integer.parseInt(request.getParameter("userid")) ;
		   pass = request.getParameter("pswd1");
		String Mess = "Your User Name "+name;
		   String Mess1="Your Employee Id "+empid;
		   
		   try{
               conn=NewSurvey.MyConnection.getConnection();
              stmt= conn.prepareStatement("insert into survey values  (?,?,?)");
              stmt.setString(1,name);
              stmt.setInt(2,empid);
              stmt.setString(3,pass);
              
              stmt.executeUpdate();
            }  
		   catch ( SQLException ee)
		   {
			   
		   }
*/ 
		ModelAndView modelAndView = new ModelAndView("menu");
	//	modelAndView.addObject("message", Mess);
		//modelAndView.addObject("message1", Mess1);
		return modelAndView;
	}
}
