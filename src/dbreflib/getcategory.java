package dbreflib;
import dao.DaoClass;

import java.sql.*;
import java.util.StringTokenizer;
//import java.util.ArrayList;
import java.io.IOException;
import java.io.PrintWriter;
//import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import org.springframework.web.servlet.ModelAndView;
//import org.springframework.web.servlet.mvc.Controller;

public class getcategory extends HttpServlet {
	/**
	 * 
	 */
	DaoClass dao=null;
	private static final long serialVersionUID = 1L;
	

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session=request.getSession();

		

		//ResultSet rs;
		dao=new DaoClass();
	
		PrintWriter pw = response.getWriter();
		int reckon = Integer.parseInt(request.getParameter("id"));
		 pw.println("<script type=\"text/javascript\">");
	       pw.println("alert(reckon);");
	       //pw.println(reckon);
	       pw.println("</script>");
			//pw.println(reckon);	
		try {
			
			

			if (reckon == 1) {
				String role_id=session.getAttribute("RoleID").toString();
				int emp_id=Integer.parseInt(session.getAttribute("EmployeeID").toString());
				//pw.println("heyy");
				pw.println(dao.getCategoryList());
				
 
			} else if (reckon == 2) {
				String role_id=session.getAttribute("RoleID").toString();
				int emp_id=Integer.parseInt(session.getAttribute("EmployeeID").toString());
                int function_id;
                function_id=Integer.parseInt(request.getParameter("function_id"));
				String value1 = request.getParameter("value");
				pw.println(dao.getSurveyList(value1,role_id,emp_id,function_id));
				
			}else if (reckon == 3) {
				String role_id=session.getAttribute("RoleID").toString();
				int emp_id=Integer.parseInt(session.getAttribute("EmployeeID").toString());
				pw.println(dao.getRoleList());
				}
				
			else if(reckon==4){
				String role_id=session.getAttribute("RoleID").toString();
				int emp_id=Integer.parseInt(session.getAttribute("EmployeeID").toString());
				String survName=request.getParameter("survName");
				String catName=request.getParameter("catName");
				//pw.println(survName+" "+catName);
				pw.println(dao.getQuestions(survName,catName));
				
			
			}else if(reckon==5){
				String role_id = session.getAttribute("RoleID").toString();
				int emp_id = Integer.parseInt(session
						.getAttribute("EmployeeID").toString());
				// pw.println(request.getParameter("selectedEmpId"));
				pw.println(dao.getDelUserData(Integer.parseInt(request.getParameter("selectedEmpId"))));
			}else if(reckon==6){				
				String role_id=session.getAttribute("RoleID").toString();
				int emp_id=Integer.parseInt(session.getAttribute("EmployeeID").toString());
				pw.println(dao.deleteUserUpdate(request.getParameter("val1"),request.getParameter("val2")));
				
			}else if(reckon==7){
				String role_id=session.getAttribute("RoleID").toString();
				int emp_id=Integer.parseInt(session.getAttribute("EmployeeID").toString());
				//pw.println(request.getParameter("empId"));
				pw.println(dao.idDuplicacyCheck(request.getParameter("empId")));
			
			}
			else if(reckon == 8){
				long l=Long.parseLong(request.getParameter("logonTime"));
				//pw.println("gagan = " + l);
				//pw.println(request.getParameter("password"));
				String str=dao.userAuthentication(request.getParameter("username"), request.getParameter("password"),l);
				//pw.println(str);
				 //pw.println("<script type=\"text/javascript\">");
			     //pw.println("alert('str = "+str+"');");
			     //pw.println("</script>");
				if(!str.equals("")){
				//pw.println(str);
				StringTokenizer st=new StringTokenizer(str,"/");
				
				int empID=Integer.parseInt(st.nextToken());
				String roleID=st.nextToken();
				
				session.setAttribute("EmployeeID",empID);
				session.setAttribute("RoleID",roleID);
				request.getRequestDispatcher("home.jsp").forward(request, response);
				//pw.println(request.getParameter("logonTime"));
				}
				else{
					pw.println("invalid");
				}
			}
			
			else if (reckon==9) {
                String role_id=session.getAttribute("RoleID").toString();
                int emp_id=Integer.parseInt(session.getAttribute("EmployeeID").toString());


                String value1 = request.getParameter("value");
                pw.println(dao.getSurveyListByAccess(value1,role_id,emp_id));
                
        }else if (reckon == 10) {
			String selectedRoleId = "";
			String role_id = session.getAttribute("RoleID").toString();
			int emp_id = Integer.parseInt(session
					.getAttribute("EmployeeID").toString());
			if (role_id.equals("SAD111")) {
				selectedRoleId = request.getParameter("selectedRoleId");
				pw.println(dao.getEmpList(selectedRoleId));
			} else if (role_id.equals("ADM121")) {

				pw.println(dao.getEmpList(selectedRoleId));
			}
		}
			else {
				pw.println("Phuddu!!");
			}

		}catch (SQLException ee) {

			pw.println(ee.getMessage());
		}
		catch (Exception ee) {

			pw.println(ee.getMessage());
		}

	}
}