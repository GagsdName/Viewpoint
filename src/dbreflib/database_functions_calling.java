package dbreflib;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

public class database_functions_calling extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	String value;
	int id;

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session=request.getSession();
		PrintWriter pw = response.getWriter();
	id = Integer.parseInt(request.getParameter("id"));
			
	
		String role_id;
        int emp_id;
        role_id=(String) session.getAttribute("RoleID");
        emp_id=Integer.parseInt(session.getAttribute("EmployeeID").toString());
		if (id == 1) {

			pw.println(database_functions_body.getcategory());
		}

		else if (id == 2) {
			value = request.getParameter("value");
			pw.println(database_functions_body.getcategory(value));
		}

		else if (id == 3) {
			String surveyname, category;
			surveyname = request.getParameter("surveyname");
			category = request.getParameter("category");

			pw.println(database_functions_body.getquestions(surveyname,
					category));

		}

		else if (id == 4) {
			String question, option1, option2, option3, option4, option5, surveyname, category;
			question = request.getParameter("myquestion");
			option1 = request.getParameter("myoption1");
			option2 = request.getParameter("myoption2");
			option3 = request.getParameter("myoption3");
			option4 = request.getParameter("myoption4");
			option5 = request.getParameter("myoption5");
			surveyname = request.getParameter("surveyname");
			category = request.getParameter("category");
			pw.println(database_functions_body.submitquestion(question,
					option1, option2, option3, option4, option5, surveyname,
					category));
		}

		else if(id==5)
		  {
			  int question_id;
		
				question_id = Integer.parseInt(request.getParameter("question_id"));
				
			
					String question,option1,option2,option3,option4,option5,surveyname,category;
						question = request.getParameter("myquestion");
						option1 = request.getParameter("myoption1");
						option2 = request.getParameter("myoption2");
						option3 = request.getParameter("myoption3");
						option4 = request.getParameter("myoption4");
						option5 = request.getParameter("myoption5");
						surveyname = request.getParameter("surveyname");
						category= request.getParameter("category");
						//pw.print("Surveyname="+surveyname+" Category="+category+" Qiestion_Id="+question_id);
						pw.println(database_functions_body.updatequestion(question, option1, option2, option3, option4, option5, question_id,surveyname,category));
		      
				
	      }
		else if(id==6)
		  {
			  String surveyname,category;
				surveyname=request.getParameter("surveyname");
				category=request.getParameter("category");
				pw.println("<script type='text/javascript' src='validation.js'></script><link href=\"page.css\" rel=\"stylesheet\" type=\"text/css\" /><table border='1' id='questionbank'><tr><th>Question</th><th>Option 1</th><th>Option 2</th><th>Option 3</th><th>Option 4</th><th>Option 5</th><th>Question ID</th><th>Select All<br><span style=\"display:none;\"><input TYPE=checkbox name='checkall'  id=\"chk\" onclick=\"checkedAll();\"></span><img id=\"CheckboxImageID\" src=\"images/checkbox_unchecked.png\" width=\"20\" height=\"20\" onclick=\"CheckboxClicked('CheckboxImageID','chk')\" style=\"cursor:pointer;\"></th></tr><tr><form name='question_bank' action='databse_functions_calling' onsubmit='return check_form();' method='post'><input type='hidden' value='7' name='id'><input type='hidden' name='surveyname' value='"+surveyname+"'><input type='hidden' name='category' value="+category+">");
				pw.println(database_functions_body.questionbank(surveyname,category));
				pw.println("<tr><INPUT TYPE='image' src='images/import.png' id='import'/><label>Import Selected Questions</label></tr></form></table>");
		  }
		  
		  else if(id==7)
		  {
			  String[] question_bank;
			  String surveyname,category;
			  surveyname=request.getParameter("surveyname");
				category=request.getParameter("category");
			  question_bank=request.getParameterValues("chk1");
			 
			 pw.println(database_functions_body.question_bank_entry(surveyname, category, question_bank)); 
			      
			  
			  
		  }
		  else if(id==8)
		  {
			  String my_question_id;
			String[] question_id;
			  String surveyname,category;
			  my_question_id=request.getParameter("question_id").trim();
				surveyname=request.getParameter("surveyname");
				category=request.getParameter("category");
			question_id=my_question_id.split("-");
			
				
	pw.println(database_functions_body.deletequestion(surveyname, category,question_id));
				
		  }
		
		else if (id == 9) {
			String surveyname, category;
			surveyname = request.getParameter("surveyname");
			category = request.getParameter("category");

			pw.println(database_functions_body.delete_survey(surveyname,
					category));
		}

		else if (id == 10) {
			String surveyname, category, check;
			surveyname = request.getParameter("surveyname");
			category = request.getParameter("category");
			check = database_functions_body.check_survey_submission(surveyname,
					category);
			if (check.equals("inactive")) {
				pw.print("<input type='image' src='images/publishsurvey.png' onclick=' return publish_survey();' id='publish' ><label>Publish Survey</label></form>");
				// pw.print(check);
			} else {
				pw.print("<input type='image' src=\"images/icon-check.png\" onclick=' return unpublish_survey();' id='unpublish'><label>Unpublish Survey</label></form>");
				// pw.print(check);
			}

		}

		else if (id == 11) {
			String surveyname, category;
			surveyname = request.getParameter("surveyname");
			category = request.getParameter("category");

			pw.println(database_functions_body.publish_survey(surveyname,
					category));
		}

		else if (id == 12) {
			String surveyname, category;
			surveyname = request.getParameter("surveyname");
			category = request.getParameter("category");

			pw.println(database_functions_body.unpublish_survey(surveyname,
					category));
		}

		else if (id == 13) {
			String category;

			category = request.getParameter("category");
			// pw.println("jaspreet");

			pw.println(database_functions_body.getsurveys(category,role_id,emp_id));
			// pw.println("<form><input type='button' value='hello' /></form>");
		}
		
		else if (id == 14) {
			value = request.getParameter("value");
			pw.println(database_functions_body.getpublishedsurveys(value));
		}
		else if(id==15)
		{
			pw.println(database_functions_body.get_surveys_for_user_mapping(emp_id,role_id));
		}
		else if(id==16)
		{
			pw.println(database_functions_body.get_users(role_id,emp_id));
		}
		else if(id==17)
		{
			int user_emp_id=Integer.parseInt(request.getParameter("user_emp_id"));
			pw.println(database_functions_body.update_surveys_of_user_mapping(emp_id,role_id,user_emp_id));
		}
		
		else if(id==18)
		{
			String surveys_checkbox[]=null;
			try{
				surveys_checkbox=request.getParameterValues("surveys_checkbox");	
			}
	catch(Exception ee)
	{
		
	}
		int user_emp_id=Integer.parseInt(request.getParameter("userlist"));
		//pw.println("Length "+surveys_checkbox.length);
		//pw.print("Employee Id "+ user_emp_id);
	
		pw.println("<html><script>alert('"+database_functions_body.update_user_access(surveys_checkbox,user_emp_id)+"');window.location = '"+URL.url+"edit_access_for_surveys.jsp'</script></html>");
		}
		else if(id==19)
		{
			String category_name=request.getParameter("category_name");

			 pw.println(database_functions_body.create_category(category_name));
			
		}
		
		else if(id==20)
		{
			String category_name=request.getParameter("category_name");
			 pw.println(database_functions_body.delete_category(category_name));
				
		}
		
		else if(id==21){
			String survey = request.getParameter("surveyname");
			//pw.println(survey);
			pw.println(database_functions_body.getTargetSurvey(survey, request.getParameter("category") ,emp_id, role_id));
	}else if(id==22){
		String curr_survey, curr_category, targ_survey, targ_category, question_id[],my_question_id;
		curr_survey=request.getParameter("curr_survey");
		curr_category=request.getParameter("curr_category");
		targ_survey=request.getParameter("targ_survey");
		targ_category=request.getParameter("targ_category");
		my_question_id=request.getParameter("question_id").trim();
		question_id=my_question_id.split("-");
		pw.println(database_functions_body.moveQuestions(curr_survey,curr_category,targ_survey,targ_category,question_id));
	}
		
	else if(id==23){
		String surveyname, category;
		surveyname = request.getParameter("surveyname");
		category = request.getParameter("category");

		pw.println(database_functions_body.checkquestions(surveyname,
				category));
	}

	}
}