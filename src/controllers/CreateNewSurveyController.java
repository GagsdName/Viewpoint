                                                                     
                                                                     
                                                                     
                                             
package controllers;

import java.io.IOException;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import dbreflib.DbConn;
public class CreateNewSurveyController implements Controller {
	String category,surveyname;

	PreparedStatement pstmt,pstmt1,pstmt2,pstmt3,pstmt4;
     Connection conn;
     ResultSet  rs,rs_key;
     String Mess;
     int auto_id=0;
	 
	 
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		if(Integer.parseInt(request.getParameter("page_id"))==1)
		{
			
		
		PrintWriter out = response.getWriter();
	
		Calendar currentDate = Calendar.getInstance();
		  SimpleDateFormat formatter=new SimpleDateFormat("yyyy/MM/dd");
		  String dateNow = formatter.format(currentDate.getTime()),role_id;
		category = request.getParameter("categoryList").toString();
		int id=0,emp_id=Integer.parseInt(session.getAttribute("EmployeeID").toString());
	
		   //no_of_questions =Integer.parseInt(request.getParameter("question")) ;
		   surveyname = request.getParameter("surveyname").toString();
	
		   try
		   {
			   conn=DbConn.getConnection();
			   role_id=session.getAttribute("RoleID").toString();
			   emp_id=Integer.parseInt(session.getAttribute("EmployeeID").toString());
			   if(role_id.equals("SAD111") || role_id.equals("ADM121"))
			   {
			 
			   pstmt1=conn.prepareStatement("select count(*) from surveys where Survey_Name=? and Category=? ");
			   pstmt1.setString(1,surveyname);
			   pstmt1.setString(2,category);
			  
			   rs=pstmt1.executeQuery();
			   
			   while(rs.next())
			   {
				   if(Integer.parseInt(rs.getString(1))==0)
				   {
					   
					   pstmt=conn.prepareStatement("insert into surveys(Survey_Name,Date_of_Creation,Category,Flag,Employee_ID) values (?,?,?,?,?)",Statement.RETURN_GENERATED_KEYS);
					   pstmt.setString(1,surveyname);
					   pstmt.setString(2,dateNow);
					   pstmt.setString(3,category);
					   pstmt.setString(4,"inactive");
					   pstmt.setInt(5,Integer.parseInt(session.getAttribute("EmployeeID").toString()));
					   pstmt.executeUpdate();
					   rs_key =pstmt.getGeneratedKeys();
		    		rs_key.absolute(1);
		    	    auto_id =rs_key.getInt(1);
					   Mess = "Your survey " +surveyname +"is successsfully created under categeory "+category;
					   
					   String query_to_select_administator="select Employee_ID from user_role_map where Role_ID=?";
					   String query_to_insert_administartor_in_survey_user_map="insert into survey_user_map (Survey_ID,Employee_ID)  values(?,?)";
					   pstmt2=conn.prepareStatement(query_to_select_administator);
					   pstmt2.setString(1,"SAD111");
					   ResultSet rs2=pstmt2.executeQuery();
					   while(rs2.next())
					   {
						   pstmt3=conn.prepareStatement(query_to_insert_administartor_in_survey_user_map); 
						   pstmt3.setInt(1,auto_id);
						   pstmt3.setInt(2,Integer.parseInt(rs2.getString(1)));
						   pstmt3.executeUpdate();
					   }
					   
					   if(role_id.equals("ADM121"))
					   {
						   pstmt4=conn.prepareStatement(query_to_insert_administartor_in_survey_user_map); 
						   pstmt4.setInt(1,auto_id);
						   pstmt4.setInt(2,emp_id);
						   pstmt4.executeUpdate();
					   }
					   
					   id=1;
					   
				   }
				   else 
				   {
				Mess="Please choose different Survey Name as its already exist in "+ category;
				
				   id=0;
				   }
			   }
			  
			   }
			   
		   }
		   
		   catch ( SQLException ee)
		   {
			 Mess=ee.getMessage();
			 
		   }

		   
		   catch(Exception ee)
		   {
			   Mess=ee.getMessage();
		
		   }
		   
		
		  
		System.out.println("hi");
		ModelAndView modelAndView = new ModelAndView("after_survey_creation");
		modelAndView.addObject("message", Mess);
		modelAndView.addObject("id",id);
		modelAndView.addObject("category",category);
		modelAndView.addObject("menu_display","active");

		modelAndView.addObject("surveyname",surveyname);
		
	
		return modelAndView;
		}
		
		else 
		{
			
			int id=1;
			String menu_display="";
			if(Integer.parseInt(request.getParameter("page_id"))==3)
			{
				menu_display="inactive";
			}
			else
			{
				menu_display="active";
			}
			
			surveyname=request.getParameter("surveyname").toString();
			category=request.getParameter("category");
			Mess="Questions under survey "+surveyname+" and category "+category;
			
			ModelAndView mymodel = new ModelAndView("after_survey_creation");
			mymodel.addObject("message",Mess);
			mymodel.addObject("id",id);
			mymodel.addObject("category",category);
			mymodel.addObject("surveyname",surveyname);
			mymodel.addObject("menu_display",menu_display);
			return mymodel;
		}
	}
}