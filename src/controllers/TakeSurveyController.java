package controllers;

import java.io.IOException;
//import java.io.PrintWriter;

import javax.servlet.ServletException;
//import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
//import daoforsurvey.DAOSurvey;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import dbreflib.DbConn;
//import dbreflib.DbConn.*;
public class TakeSurveyController implements Controller {

	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		if(session.getAttribute("RoleID")!=null && session.getAttribute("EmployeeID")!=null){
		int surv = Integer
				.parseInt(session.getAttribute("surveyid").toString());
		String ans = "opt";
		String l = "Your response has been submitted.";
		

		int empid = Integer.parseInt(session.getAttribute("EmployeeID")
				.toString());
	
		try {
			Connection con = DbConn.getConnection();
			Connection con1 =DbConn.getConnection();

			Statement st = con.createStatement();
			Statement st1 = con.createStatement(ResultSet.CONCUR_READ_ONLY,
					ResultSet.TYPE_SCROLL_SENSITIVE);

			ResultSet rst = st
					.executeQuery("select count(*) from submission where Survey_ID ="
							+ surv + " and Employee_ID=" + empid);
			rst.absolute(1);
		
			ResultSet rst1 = st1
					.executeQuery("select Question_ID from survey_question_map where Survey_ID="
							+ surv + " and flag='active'");

			PreparedStatement pstmt = con1
					.prepareStatement("insert into submission values(?,?,?,?)");
//l=l+rst.getInt("count(*)");

	int k=0;
	while(rst1.next())
	{
		k++;

		pstmt.setInt(1,surv);
		pstmt.setInt(2,rst1.getInt("Question_ID"));
		pstmt.setString(3,request.getParameter(ans+k));
		pstmt.setInt(4, empid);
		pstmt.executeUpdate();
	}

			
		
		
			
		} catch (Exception e) {
		}

		ModelAndView modelAndView = new ModelAndView("after_taking_survey");

		modelAndView.addObject("message", l);

		return modelAndView;

	}
		else
		{
			response.sendRedirect("login.jsp");
			return null;
		}
	}
	
}
