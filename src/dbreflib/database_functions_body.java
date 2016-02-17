package dbreflib;

import java.sql.*;
import dbreflib.URL.*;
public class database_functions_body {
	
	
	public static String getpublishedsurveys(String value) {
		Connection conn;
		Statement stmt;
		String str = "";
		try {
			conn = DbConn.getConnection();
			stmt = conn.createStatement();
			ResultSet rs = stmt
					.executeQuery("select Survey_Name from surveys where Category='"
							+ value + "' and Flag='active'");

			while (rs.next()) {

				str = str + "<option value='" + rs.getString(1) + "'>"
						+ rs.getString(1) + "</option>";
			}

		} catch (SQLException ee) {

		}

		return str;
	}
	
	

	public static String getcategory(String value) {
		Connection conn;
		Statement stmt;
		String str = "";
		try {
			conn = DbConn.getConnection();
			stmt = conn.createStatement();
			ResultSet rs = stmt
					.executeQuery("select Survey_Name from surveys where Category='"
							+ value + "'");

			while (rs.next()) {

				str = str + "<option value='" + rs.getString(1) + "'>"
						+ rs.getString(1) + "</option>";
			}

		} catch (SQLException ee) {

		}

		return str;
	}

	public static String getsurveys(String category,String role_id,int emp_id) {
		Connection conn;
		Statement stmt;
		String str = "", check, field;
		String survey_report_list="";
		if(role_id.equals("ADM121"))
		{
			survey_report_list="SELECT s.Survey_Name, COUNT( * ) no_of_questions FROM surveys s, survey_question_map sqm WHERE s.Survey_ID = sqm.Survey_ID AND s.Category ='"+category+"' and sqm.Flag='active' and s.Employee_ID='"+emp_id+"' GROUP BY s.Survey_Name union SELECT Survey_Name,0 no_of_questions from surveys where Survey_ID NOT IN(select Survey_ID from survey_question_map) and Category='"+category+"' and Employee_ID='"+emp_id+"' ";
		}
		else  if(role_id.equals("SAD111"))
		{
			survey_report_list="SELECT s.Survey_Name, COUNT( * ) no_of_questions FROM surveys s, survey_question_map sqm WHERE s.Survey_ID = sqm.Survey_ID AND s.Category ='"+category+"' and sqm.Flag='active' GROUP BY s.Survey_Name union SELECT Survey_Name,0 no_of_questions from surveys where Survey_ID NOT IN(select Survey_ID from survey_question_map) and Category='"+category+"' ";
		}
		try {
			conn =DbConn.getConnection();
			stmt = conn.createStatement();
			ResultSet rs = stmt
					.executeQuery(survey_report_list);
			str = "<table id='surveylist1'><tr><th>Survey Name</th><th>No of Questions</th><th>View</th><th>Publish/Unpublish</th></tr>";

			while (rs.next()) {

				check = check_survey_submission(rs.getString(1), category);
				if (check.equals("inactive")) {
					field = "<input type='image' name='edit' src=\"images/publishsurvey.png\" title=\"click to publish survey\" style='' onclick=\"publish_survey('"+ rs.getString(1) + "');\">";
				} else {
					field = "<input type='image' name='edit' src=\"images/icon-check.png\" style='' title=\"click to unpublish survey\" onclick=\"unpublish_survey('"+ rs.getString(1) + "');\">";
				}
				str = str+"<tr class='alt'><td>"
						+ rs.getString(1)
						+ "</td>"
						+ "<td>"
						+ rs.getString(2)
						+ "</td><td><form name='overstand'  method='post' action='createsurvey.html' onSubmit=\"popupform(this, 'join')\"><input type='hidden' name='surveyname'  value='"+rs.getString(1)+"' ><input type='hidden' name='category' value='"+category+"' ><input type='hidden' name='page_id' value='3'/><input type='hidden' name='page_id' value='3'/><input type='image' src=\"images/view.png\" id='view' title='Click to view survey' ></form></td><td><form name='field'>"+field+"</form></td></tr>";
			}
			
			str=str+"</table>";

		} catch (SQLException ee) {
			str="SQl Exception "+ee.getMessage();

		}
		catch (Exception ee) {
			str="Exception "+ee.getMessage();

		}

		return str;
	}




	public static String check_survey_submission(String surveyname,
			String category) {
		Connection conn;
		Statement stmt;
		String str = "";
		try {
			conn = DbConn.getConnection();
			stmt = conn.createStatement();
			ResultSet rs = stmt
					.executeQuery("select Flag from surveys where Category='"
							+ category + "' and Survey_Name='" + surveyname
							+ "'");

			while (rs.next()) {

				str = rs.getString(1);
			}

		} catch (SQLException ee) {
			str = "SQL Exception " + ee.getMessage();

		}

		catch (Exception ee) {
			str = "Exception " + ee.getMessage();

		}

		return str;
	}

	public static String publish_survey(String surveyname, String category) {
		Connection conn;
		Statement stmt;
		String str = "";
		try {
			conn =DbConn.getConnection();
			stmt = conn.createStatement();
			stmt.executeUpdate("update surveys set Flag='active' where Category='"
					+ category + "' and Survey_Name='" + surveyname + "'");

			str = "Successfully published the survey";

		} catch (SQLException ee) {
			str = "SQL Exception " + ee.getMessage();

		}

		catch (Exception ee) {
			str = "Exception " + ee.getMessage();

		}

		return str;
	}

	public static String unpublish_survey(String surveyname, String category) {
		Connection conn;
		Statement stmt;
		String str = "";
		try {
			conn = DbConn.getConnection();
			stmt = conn.createStatement();
			stmt.executeUpdate("update surveys set Flag='inactive' where Category='"
					+ category + "' and Survey_Name='" + surveyname + "'");

			str = "Successfully unpublished the survey";

		} catch (SQLException ee) {
			str = "SQL Exception " + ee.getMessage();

		}

		catch (Exception ee) {
			str = "Exception " + ee.getMessage();

		}

		return str;
	}

	public static String getcategory() {
		Connection conn;
		Statement stmt;
		String str = "";
		try {
			conn = DbConn.getConnection();
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select * from Categories");

			while (rs.next()) {

				str = str + "<option value='" + rs.getString(1) + "'>"
						+ rs.getString(1) + "</option>";

			}

		} catch (SQLException ee) {

		}

		return str;
	}

	public static String getquestions(String surveyname, String category) {

		Connection conn;
		PreparedStatement pstmt, pstmt1;
		int qu = 0, mycount = 0;
		ResultSet rs, rs1;
		String str = "",str1="";

		try {

			conn = DbConn.getConnection();

			pstmt1 = conn
					.prepareStatement("select count(*) from surveys si,survey_question_map sqm,questions q where si.Survey_Name=? and si.Category=? and sqm.Survey_ID=si.Survey_ID and q.Question_ID=sqm.Question_ID and sqm.Flag=? ");

			pstmt1.setString(1, surveyname);
			pstmt1.setString(2, category);
			pstmt1.setString(3, "active");

			rs1 = pstmt1.executeQuery();
			while (rs1.next()) {
				mycount = rs1.getInt(1);
			}

			if (mycount > 0) {
				pstmt = conn
						.prepareStatement("select q.Question,q.Opt_1,q.Opt_2,q.Opt_3,q.Opt_4,q.Opt_5,q.Question_ID from surveys si,survey_question_map sqm,questions q where si.Survey_Name=? and si.Category=? and sqm.Survey_ID=si.Survey_ID and q.Question_ID=sqm.Question_ID and sqm.Flag=?");

				pstmt.setString(1, surveyname);
				pstmt.setString(2, category);

				pstmt.setString(3, "active");

				rs = pstmt.executeQuery();

				str = str+"<select id='action_type' onchange='action_choice()'><option value='Delete'>Delete</option><option value='Move'>Move</option></selection><input type='button' id='action_button' value='OK' onclick=\"action_execute()\" style='position:absolute;margin-left:0px;margin-top:-29px;position:absolute;background-color:3366FF;width:100px;height:28px'; />"+ "<input type='button' onClick=\"popup('popUpDiv');\" id=\"addquestion\" style='position:absolute;margin-left:1050px;margin-top:-30px;background-color:3366FF;width:100px;height:28px'' value='Add a Question'></a><table border=1 ><tr class=\"editquestion\"><th>Question No.</th><th>Question</th><th>Option1</th><th>Option2</th><th>Option3</th><th>Option4</th><th>Option5</th><th></th><th><input type='checkbox' name='checkall' value='yes' id=\"chk\" onclick=\"checkedAll();\"></th></tr><tr></tr>";
				while (rs.next()) {
					String k1=rs.getString(2);
					String k2=rs.getString(3);
					String k3=rs.getString(4);
					String k4=rs.getString(5);
					String k5=rs.getString(6);
					if(k1==null||k1.trim().equals("null"))
						k1="";
					if(k2==null||k2.trim().equals("null"))
						k2="";
					if(k3==null||k3.trim().equals("null"))
						k3="";
					if(k4==null||k4.trim().equals("null"))
						k4=" ";
					if(k5==null||k5.trim().equals("null"))
						k5="";
			
			//		if(rs.getString(2)==null||rs.getString(2).trim().equals("null"))
					qu++;
					str = str
							+ "<tr class='alt'>"
							+ "<td >"
							+ "Question "
							+ qu
							+ "</td>"
							+ "<td >"
							+ rs.getString(1)
							+ "</td>"
							+ "<td >"
							+ k1
							+ "</td>"
							+ "<td >"
							+ k2
							+ "</td>"
							+ "<td >"
							+ k3
							+ "</td>"
							+ "<td >"
							+ k4
							+ "</td>"
							+ "<td >"
							+ k5
							+ "</td>"
							+ "<td >"
							+ "<form name="
							+ rs.getString(7)
							+ " method=post action='"+dbreflib.URL.url+"editquestion.jsp'  >"
							+ "<input type=hidden  name='question_id' value='"
							+ rs.getString(7)
							+ "'><input type=hidden name='question' value='"
							+ rs.getString(1)
							+ "'>"
							+ "<input type=hidden name='option1' value='"
							+ rs.getString(2)
							+ "'>"
							+ "<input type=hidden name='option2' value='"
							+ rs.getString(3)
							+ "'>"
							+ "<input type=hidden name='option3' value='"
							+ rs.getString(4)
							+ "'>"
							+ "<input type=hidden name='option4' value='"
							+ rs.getString(5)
							+ "'>"
							+ "<input type=hidden name='option5' value='"
							+ rs.getString(6)
							+ "'>"
							+ "<input type=hidden name='surveyname' value='"
							+ surveyname
							+ "'>"
							+ "<input type=hidden name='category' value='"
							+ category
							+ "'>"
							+ "<input type='hidden' value='1' name='page_id'>"
							+ "<input type='image'  src=\"images/document-edit.png \" title=\"click to edit \"value=Edit  ></form>"
							+" </td>"
					        +"<td ><input TYPE=checkbox name='chk1' id=\"chk"+qu+"\" VALUE='"
							+ rs.getString(7)+ "' id='frm1'></td>";
			

				}
				

				qu = 0;

			}

			else if (mycount == 0) {
				str = str+"<input type='image' src='images/addquestion.png' title='Click to Add Question'onClick=\"popup('popUpDiv');\" id=\"addquestion\" style='position:absolute;margin-left:1150px;margin-top:-30px;''><label style='position:absolute;margin-left:1180px;margin-top:-30px;color:black;font-size:16px;'>Add Question</label>"
						+ "<table border=1' ><tr><th>No Question has been added yet.Please click on Add Question to add a Question.</th></tr></table>";
			}
		} catch (SQLException ee) {

			str = "SQl Eception" + ee.getMessage();
		}

		return str;
	}

	public static String submitquestion(String question, String option1,
			String option2, String option3, String option4, String option5,
			String surveyname, String category) {

		Connection conn;
		PreparedStatement pstmt1, pstmt2;
		String str = "";
		ResultSet rs;
		int auto_id;

		try {
			conn = DbConn.getConnection();
			pstmt1 = conn
					.prepareStatement(
							"insert into questions (Question,Opt_1,Opt_2,Opt_3,Opt_4,Opt_5) values (?,?,?,?,?,?)",
							Statement.RETURN_GENERATED_KEYS);
			pstmt1.setString(1, question);
			pstmt1.setString(2, option1);
			pstmt1.setString(3, option2);
			pstmt1.setString(4, option3);
			pstmt1.setString(5, option4);
			pstmt1.setString(6, option5);

			pstmt1.executeUpdate();

			rs = pstmt1.getGeneratedKeys();
			rs.next();
			auto_id = rs.getInt(1);

			pstmt2 = conn
					.prepareStatement("insert into survey_question_map(Question_ID,Survey_ID,Flag) values (?,(select Survey_ID from surveys where Survey_Name=? and category=? ),Flag=?)");
			pstmt2.setInt(1, auto_id);
			pstmt2.setString(2, surveyname);
			pstmt2.setString(3, category);
			pstmt2.setString(4, "active");
			pstmt2.executeUpdate();

			str = "Successfully inserted the Question";

		} catch (SQLException ee) {
			str = "Insert my Query Failed";
			str = str + ee.getMessage();
		}

		catch (Exception ee) {
			str = "Unable to add the Question in to the database";
			str = str + ee.getMessage();
		}
		return str;
	}

	public static String updatequestion(String question, String option1,
			String option2, String option3, String option4, String option5,
			int question_id,String surveyname,String category) {

		Connection conn;
		PreparedStatement pstmt1,pstmt2;
        ResultSet rs;
        int check=0;
		String str = "",question_entry_check;

		try {
			conn =DbConn.getConnection();
            question_entry_check="select count(*) from survey_question_map where Question_ID=?";
            pstmt2=conn.prepareStatement(question_entry_check);
            pstmt2.setInt(1,question_id);
            rs=pstmt2.executeQuery();
           while( rs.next())
           {
        	   check=rs.getInt(1); 
           }
            
            if(check==1)
            {
            
			pstmt1 = conn
					.prepareStatement("update questions set Question=?,Opt_1=?,Opt_2=?,Opt_3=?,Opt_4=?,Opt_5=? where Question_ID=?");

			pstmt1.setString(1, question);
			pstmt1.setString(2, option1);
			pstmt1.setString(3, option2);
			pstmt1.setString(4, option3);
			pstmt1.setString(5, option4);
			pstmt1.setString(6, option5);
			pstmt1.setInt(7, question_id);
			pstmt1.executeUpdate();

			str = "Successfully Updated the Question";
            }
            else if(check>1)
            {
            	int auto_id;
            	conn = DbConn.getConnection();
    			pstmt1 = conn
    					.prepareStatement(
    							"insert into questions (Question,Opt_1,Opt_2,Opt_3,Opt_4,Opt_5) values (?,?,?,?,?,?)",
    							Statement.RETURN_GENERATED_KEYS);
    			pstmt1.setString(1, question);
    			pstmt1.setString(2, option1);
    			pstmt1.setString(3, option2);
    			pstmt1.setString(4, option3);
    			pstmt1.setString(5, option4);
    			pstmt1.setString(6, option5);

    			pstmt1.executeUpdate();

    			rs = pstmt1.getGeneratedKeys();
    			rs.next();
    			auto_id = rs.getInt(1);

    			pstmt2 = conn
    					.prepareStatement("update survey_question_map set Question_ID=? where Survey_ID=(select Survey_ID from surveys where Survey_Name=? and Category=?) and Question_ID=?");
    			pstmt2.setInt(1, auto_id);
    			pstmt2.setString(2, surveyname);
    			pstmt2.setString(3, category);
    			pstmt2.setInt(4, question_id);
    			pstmt2.executeUpdate();

    			str = "Successfully updated the Question";

            	
            }

		} catch (SQLException ee) {
			str = "Update  Query Failed ";
			str = str + ee.getMessage();
		}

		catch (Exception ee) {
			str = "Unable to update";
			str = str + ee.getMessage();
		}

		return str;
	}
	public static String deletequestion(String surveyname,
			String category,String question_id[]) {
		Connection conn;
		PreparedStatement pstmt1;

		String str = "";
		int count=0;

		try {
			conn = DbConn.getConnection();
			for(int i=0;i<question_id.length;i++)
			{
				
			int my=Integer.parseInt(question_id[i]);
			pstmt1 = conn
					.prepareStatement("update survey_question_map  set Flag=? where Survey_ID=(select Survey_ID from surveys where Survey_Name=? and Category=? ) and Question_ID=?");
			pstmt1.setString(1, "inactive");
			pstmt1.setString(2, surveyname);
			pstmt1.setString(3, category);
			pstmt1.setInt(4,my);
			pstmt1.executeUpdate();
			count++;
			}
			// str="Surveyname"+surveyname+"Category "
			// +category+"Question Id"+question_id;
			str = count+" Question/Questions has been set to inactive mod";
			

		} catch (SQLException ee) {
			str = "Delete Query Failed";
			str = str + ee.getMessage();

		} catch (NumberFormatException ee) {
			str = "Number Format Unable to delete ";
			str =str+ee.getLocalizedMessage();
		}
		catch (Exception ee) {
			str = "Unable to delete ";
			str =ee.getLocalizedMessage();
		}
		return str;
	}
	
	public static String questionbank(String surveyname, String category) {
		Connection conn;
		PreparedStatement pstmt1, pstmt;
		int check;

		String str = "";

		try {
			conn = DbConn.getConnection();
			pstmt = conn
					.prepareStatement("SELECT exists(select DISTINCT q.Question, q.Opt_1, q.Opt_2, q.Opt_3, q.Opt_4, q.Opt_5, sqm.Question_ID "
							+ "FROM survey_question_map sqm, questions q, surveys s WHERE s.Survey_ID = sqm.Survey_ID AND sqm.Question_ID = "
							+ "q.Question_ID AND sqm.Question_ID NOT  IN ( SELECT Question_ID FROM survey_Question_map WHERE Survey_ID ="
							+ " ( SELECT Survey_ID FROM surveys WHERE Survey_Name =? AND Category =  ? )  AND Flag = ?))");
			pstmt.setString(1, surveyname);
			pstmt.setString(2, category);
			pstmt.setString(3, "active");

			ResultSet rs1 = pstmt.executeQuery();
			rs1.next();
			check = rs1.getInt(1);
			if (check == 1) {
				pstmt1 = conn
						.prepareStatement("SELECT DISTINCT q.Question, q.Opt_1, q.Opt_2, q.Opt_3, q.Opt_4, q.Opt_5, sqm.Question_ID "
								+ "FROM survey_question_map sqm, questions q, surveys s WHERE s.Survey_ID = sqm.Survey_ID AND sqm.Question_ID = "
								+ "q.Question_ID AND sqm.Question_ID NOT  IN ( SELECT Question_ID FROM survey_Question_map WHERE Survey_ID ="
								+ " ( SELECT Survey_ID FROM surveys WHERE Survey_Name =? AND Category =  ? )  AND Flag = ?)");

				pstmt1.setString(1, surveyname);
				pstmt1.setString(2, category);
				pstmt1.setString(3, "active");
int qu=0;
				// str="Surveyname"+surveyname+"Category "
				// +category+"Question Id"+question_id;
				ResultSet rs = pstmt1.executeQuery();
				while (rs.next()) {qu++;
					str = str + "<tr class='alt'><td>" + rs.getString(1) + "</td><td>"
							+ rs.getString(2) + "</td><td>" + rs.getString(3)
							+ "</td><td>" + rs.getString(4) + "</td><td> "
							+ rs.getString(5) + "</td><td> " + rs.getString(6)
							+ "</td><td> " + rs.getString(7) + "</td><td>"

							+ "<span style=\"display:none;\"><input TYPE=checkbox name='chk1' id=\"chk"+qu+"\"VALUE='"
							+ rs.getString(7) + "'>" + "</span><img name=\"gag\"id=\"CheckboxImageID"+qu+"\" src=\"images/checkbox_unchecked.png\" width=\"20\" height=\"20\" onclick=\"CheckboxClicked1('CheckboxImageID"+qu+"','chk"+qu+"')\" style=\"cursor:pointer;\"></td></tr>";
				}
			} else {
				str = str + "<tr class='alt'><td style='border:0px'>"
						+ "<strong>No Suggestion Found</strong>" + "</tr></td>";
			}
		} catch (SQLException ee) {
			str = "Unable to get Question due to Sql Exception";
			str = str + ee.getMessage();

		} catch (Exception ee) {
			str = "Unable to get Question";
			str = str + ee.getMessage();
		}
		return str;
	}

	public static String question_bank_entry(String surveyname,
			String category, String question_bank[]) {

		Connection conn;
		PreparedStatement pstmt1, pstmt2;

		String str = "";
		int a = 0, count = 0;

		try {
			conn = DbConn.getConnection();
			for (int i = 0; i < question_bank.length; i++) {
				int me = Integer.parseInt(question_bank[i]);
				String check_query = "select count(*) from survey_question_map where Survey_ID=(select Survey_ID from surveys where Survey_Name=? and Category=?) and Question_ID=? and Flag=?";
				pstmt2 = conn.prepareStatement(check_query);
				pstmt2.setString(1, surveyname);
				pstmt2.setString(2, category);
				pstmt2.setInt(3, me);
				pstmt2.setString(4, "inactive");

				ResultSet rs = pstmt2.executeQuery();
				while (rs.next()) {
					a = rs.getInt(1);

				}
				if (a == 0) {
					pstmt1 = conn
							.prepareStatement("insert into survey_question_map (Survey_ID,Question_ID,Flag) values((select Survey_ID from surveys where Survey_Name=? and Category=?),?,?)");
					pstmt1.setString(1, surveyname);
					pstmt1.setString(2, category);
					pstmt1.setInt(3, me);
					pstmt1.setString(4, "active");

					pstmt1.executeUpdate();
					count = count + 1;

				} else if (a == 1) {
					pstmt1 = conn
							.prepareStatement("update survey_question_map set Flag=? where Survey_ID=(select Survey_ID from surveys where Survey_Name=? and Category=?) and Question_ID=? and Flag=?");

					pstmt1.setString(1, "active");
					pstmt1.setString(2, surveyname);
					pstmt1.setString(3, category);
					pstmt1.setInt(4, me);
					pstmt1.setString(5, "inactive");

					pstmt1.executeUpdate();
					count = count + 1;
				}
			}
			str = "<html><form name='myform' action='createsurvey.html' method='post'><input type='hidden' value='"
					+ surveyname
					+ "' name='surveyname'><input type='hidden' value='"
					+ category
					+ "' name='category'> <input type='hidden' value='0' name='page_id'></form> <script>alert('"
					+ count
					+ " Question Inserted  Successfully'); document.myform.submit();</script> </html>";

			// str="Surveyname"+surveyname+"Category "
			// +category+"Question Id"+question_id;

		} catch (SQLException ee) {
			str = "Unable to insert due to SQL Exception";
			str = str + ee.getMessage();

		} catch (Exception ee) {
			str = "Unable to insert";
			str = str + ee.getMessage();
		}
		return str;

	}

	public static String delete_survey(String surveyname, String category) {

		Connection conn;
		PreparedStatement pstmt1;
		String str = "";
		try

		{
			conn = DbConn.getConnection();
			pstmt1 = conn
					.prepareStatement("update surveys set Flag=? where Survey_Name=? and Category=?");
			pstmt1.setString(1, "inactive");
			pstmt1.setString(2, surveyname);
			pstmt1.setString(3, category);
			pstmt1.executeUpdate();
			str = "<html><script>alert('The Survey is Unpublished');window.location = '"+dbreflib.URL.url+"unpublish_survey.jsp';</script>";

		}

		catch (SQLException ee) {
			str = "SQL Exception " + ee.getMessage();
		} catch (Exception ee) {
			str = "Exception " + ee.getMessage();
		}

		return str;
	}

public static String get_username(int emp_id) {

	Connection conn;
	PreparedStatement pstmt1;
	String str = "";
	try

	{
		conn = DbConn.getConnection();
		pstmt1 = conn
				.prepareStatement("select Employee_Name from users where Employee_ID=? and Flag=?");
		pstmt1.setInt(1,emp_id);
		pstmt1.setString(2,"active");
		
		ResultSet rs=pstmt1.executeQuery();
		rs.next();
		str=rs.getString(1);
		

	}

	catch (SQLException ee) {
		str = "SQL Exception " + ee.getMessage();
	} catch (Exception ee) {
		str = "Exception " + ee.getMessage();
	}

	return str;
}
public static String get_surveys_for_user_mapping(int emp_id, String role_id){

	Connection conn;
	PreparedStatement pstmt1,pstmt2;
	String str1 = "",str="";
	int count1=0;

try
	{
		conn = DbConn.getConnection();
		str="<label>Select privileges for Surveys</label><table border=1><tr><th>Category</th><th>Survey Name</th><th><input TYPE=checkbox name='checkall'  id=\"chk\" onclick=\"checkedAllSurveys();\"></span></th></tr>";
		pstmt2=conn.prepareStatement("select Category from categories");
		ResultSet rs4=pstmt2.executeQuery();
		while(rs4.next())
		{
		if(role_id.equals("SAD111"))
		{
		pstmt1 = conn
				.prepareStatement("select Survey_Name,Survey_ID,mycount from surveys,(Select count(*) mycount from surveys where Category=? and Flag='active')  as t where Category=? and Flag=?");
		pstmt1.setString(1,rs4.getString(1));
		pstmt1.setString(2,rs4.getString(1));
		pstmt1.setString(3,"active");
		
		}
		else
		{
			pstmt1 = conn
					.prepareStatement("select Survey_Name,Survey_ID,mycount from surveys,(Select count(*) mycount from surveys where Category=?  and Flag=? and Employee_ID=?)  as t where Category=? and Flag=? and Employee_ID=?");
			pstmt1.setString(1,rs4.getString(1));

			pstmt1.setString(2,"active");
			pstmt1.setInt(3,emp_id);
			pstmt1.setString(4,rs4.getString(1));

			pstmt1.setString(5,"active");
			pstmt1.setInt(6,emp_id);
			
		}
		
		ResultSet rs1=pstmt1.executeQuery();
		
		
		while(rs1.next())
		{
			if(count1==0)
			{
				str1=str1+"<tr class='alt'><td rowspan="+rs1.getString(3)+">"+rs4.getString(1)+"</td><td>"+rs1.getString(1)+"</td><td><input TYPE=checkbox name='surveys_checkbox'  VALUE='"
						+ rs1.getString(2)+ "' id='surveys_checkbox"+count1+"'></td></tr>";
				
			}
			else
			{
				str1=str1+"<tr class='alt'><td>"+rs1.getString(1)+"</td><td><input TYPE=checkbox name='surveys_checkbox'  VALUE='"
						+ rs1.getString(2)+ "' id='surveys_checkbox"+count1+"'></td></tr>";
			}
		
			count1++;
		}
		str=str+str1;
		str1="";
		count1=0;
		}
		
		str=str+"</table>";

	}

	catch (SQLException ee) {
		str = "SQL Exception " + ee.getMessage();
	} catch (Exception ee) {
		str = "Exception " + ee.getMessage();
	}

	return str;
}




public static String get_users(String role_id,int emp_id) {

	Connection conn;
	PreparedStatement pstmt1;
	String str = "<option value=''>Select a User</option>";
	String select_user_query="";
	if(role_id.equals("ADM121"))
	{
		select_user_query="select u.Employee_Name,u.Employee_ID from users u,user_role_map urm  where u.Flag=? and urm.Employee_ID=u.Employee_ID and not urm.Role_ID=?";
	}
	else 
	{
		select_user_query="select u.Employee_Name,u.Employee_ID from users u,user_role_map urm  where u.Flag=? and urm.Employee_ID=u.Employee_ID and not urm.Role_ID=? union select Employee_Name,Employee_ID from users where Employee_ID=? ";
	}
			
	try

	{
		conn = DbConn.getConnection();
		pstmt1 = conn
				.prepareStatement(select_user_query);
		
		pstmt1.setString(1, "active");
		pstmt1.setString(2, "SAD111");
		pstmt1.setInt(3,emp_id);
		ResultSet rs=pstmt1.executeQuery();
		while(rs.next())
		{
			str=str+"<option value='"+rs.getString(2)+"'>"+rs.getString(1)+"</option>";
		}
		
	}

	catch (SQLException ee) {
		str = "SQL Exception " + ee.getMessage();
	} catch (Exception ee) {
		str = "Exception " + ee.getMessage();
	}

	return str;
}
public static String update_surveys_of_user_mapping(int emp_id, String role_id,int user_emp_id){

	Connection conn;
	PreparedStatement pstmt1,pstmt2,stmt1;
	String str1 = "",str5="",str="";
	int count1=0,count5=0,count6=0,count7=0;
	str="<label>Select priveleges for Surveys</label><br><table cellspacing='0px'><tr><th>Category</th><th>Survey Name</th><th><input TYPE=checkbox name='checkall'  id=\"chk\" onclick=\"checkedAllSurveys();\"></span></th></tr>";

try
	{
		conn = DbConn.getConnection();
		pstmt2=conn.prepareStatement("select Category from categories");
		ResultSet rs4=pstmt2.executeQuery();
		while(rs4.next())
		{
		
		if(role_id.equals("SAD111"))
		{
			String query="select distinct s.Survey_Name,s.Survey_ID,mycount from surveys s,survey_user_map sm,(select count(*) mycount from(select distinct   s.Survey_ID  from surveys s,survey_user_map sm where s.Category=? and s.Flag=?  and s.Survey_ID not in (select Survey_ID from survey_user_map where Employee_ID=?)) as t1) as t where s.Category=? and s.Flag=?  and s.Survey_ID not in (select Survey_ID from survey_user_map where Employee_ID=?)";
			
			String query2="select s.Survey_Name,s.Survey_ID,mycount from surveys s,(select count(*) mycount from surveys where Category=? and Survey_ID in(select Survey_ID from survey_user_map where Employee_ID=?)  ) as t where s.Category=? and s.Survey_ID in (select Survey_ID from survey_user_map where Employee_ID=?)";
			stmt1 = conn.prepareStatement(query2);
			stmt1.setString(1,rs4.getString(1));
			stmt1.setInt(2,user_emp_id);
		
			stmt1.setString(3,rs4.getString(1));
			stmt1.setInt(4,user_emp_id);
		
			
					
			pstmt1 = conn
					.prepareStatement(query);
			pstmt1.setString(1,rs4.getString(1));
			pstmt1.setString(2,"active");
			pstmt1.setInt(3,user_emp_id);
			pstmt1.setString(4,rs4.getString(1));
			pstmt1.setString(5,"active");
		    pstmt1.setInt(6,user_emp_id);

			
		}
		else
		{
			String query="select distinct s.Survey_Name,s.Survey_ID,mycount from surveys s,survey_user_map sm,(select count(*) mycount from(select distinct   s.Survey_ID  from surveys s,survey_user_map sm where s.Category=? and s.Flag=? and s.Employee_ID=? and s.Survey_ID not in (select Survey_ID from survey_user_map where Employee_ID=?)) as t1) as t where s.Category=? and s.Flag=? and s.Employee_ID=? and s.Survey_ID not in (select Survey_ID from survey_user_map where Employee_ID=?)";
			String query2="select s.Survey_Name,s.Survey_ID,mycount from surveys s,(select count(*) mycount from surveys where Category=? and Survey_ID in(select Survey_ID from survey_user_map where Employee_ID=?) and Employee_ID=? ) as t where s.Category=? and s.Survey_ID in (select Survey_ID from survey_user_map where Employee_ID=?) and Employee_ID=?";
			stmt1 = conn.prepareStatement(query2);
			stmt1.setString(1,rs4.getString(1));
			stmt1.setInt(2,user_emp_id);
			stmt1.setInt(3,emp_id);
			stmt1.setString(4,rs4.getString(1));
			stmt1.setInt(5,user_emp_id);
			stmt1.setInt(6,emp_id);
			
			
			pstmt1 = conn
					.prepareStatement(query);
			pstmt1.setString(1,rs4.getString(1));
			pstmt1.setString(2,"active");
			pstmt1.setInt(3,emp_id);
			pstmt1.setInt(4,user_emp_id);
			pstmt1.setString(5,rs4.getString(1));
			pstmt1.setString(6,"active");
			pstmt1.setInt(7,emp_id);
			pstmt1.setInt(8,user_emp_id);
			
			
			
			
			
			

		}
		
		
		
		ResultSet rs5=stmt1.executeQuery();
		
		
		
		ResultSet rs1=pstmt1.executeQuery();
		
	
		
		while(rs5.next())
		{
			count5=rs5.getInt(3);
			str5=str5+"<tr class='alt'><td>"+rs5.getString(1)+"</td><td><input TYPE=checkbox name='surveys_checkbox'  VALUE='"
						+ rs5.getString(2)+ "' id='surveys_checkbox"+(count1+count5)+"' checked></td></tr>";
		}
		
		
		

		
		
		
		while(rs1.next())
		{
			if(count1==0)
			{
				str1=str1+"<tr class='alt'><td rowspan="+(Integer.parseInt(rs1.getString(3))+count5)+">"+rs4.getString(1)+"</td><td>"+rs1.getString(1)+"</td><td><input TYPE=checkbox name='surveys_checkbox'  VALUE='"
						+ rs1.getString(2)+ "' id='surveys_checkbox"+count1+"'></td></tr>";
				
			}
			else
			{
				str1=str1+"<tr class='alt'><td>"+rs1.getString(1)+"</td><td><input TYPE=checkbox name='surveys_checkbox'  VALUE='"
						+ rs1.getString(2)+ "' id='surveys_checkbox"+count1+"'></td></tr>";
			}
		
			count1++;
		}
		if(count1==0)
		{
			ResultSet rs9=stmt1.executeQuery();
			while(rs9.next())
			{
				if(count1==0)
				{
			
				str1="<tr class='alt'><td rowspan="+count5+">"+rs4.getString(1)+"</td><td>"+rs9.getString(1)+"</td><td><input TYPE=checkbox name='surveys_checkbox'  VALUE='"
							+ rs9.getString(2)+ "' id='surveys_checkbox"+(count1+count5+count6+count7)+"' checked></td></tr>";
				}
				else
				{
					str1=str1+"<tr class='alt'><td>"+rs9.getString(1)+"</td><td><input TYPE=checkbox name='surveys_checkbox'  VALUE='"
							+ rs9.getString(2)+ "' id='surveys_checkbox"+(count1+count5+count6+count7)+"' checked></td></tr>";
				}
				count1++;
			}
			
			
	
		}
		else
		{
		str1=str1+str5;
		}
		str=str+str1;
		str1="";
		str5="";
		count1=0;
		count5=0;
		}
		
		str=str+"</table>";

	}

	catch (SQLException ee) {
		str = "SQL Exception " + ee.getMessage();
	} catch (Exception ee) {
		str = "Exception " + ee.getMessage();
	}

	return str;
}

public static String update_user_access(String surveys_checkbox[],int user_emp_id)
{
	String str="";
	Connection conn;
	PreparedStatement pstmt1,pstmt2;

	try
	{
		conn = DbConn.getConnection();
		
		pstmt1=conn.prepareStatement("delete from survey_user_map  where Employee_ID=?");
		pstmt1.setInt(1,user_emp_id);
		pstmt1.executeUpdate();
		try
		{
		
		for(int i=0;i<surveys_checkbox.length;i++)
		{
			pstmt2=conn.prepareStatement("insert into survey_user_map (Survey_ID,Employee_ID)  values(?,?)");
			pstmt2.setInt(1,Integer.parseInt(surveys_checkbox[i]) );
			pstmt2.setInt(2,user_emp_id);
			pstmt2.executeUpdate();
			str="Succesfully made the changes";
			
		}
		
		
		}
		catch(Exception ee)
		{
			str="Succesfully made the changes";
		}
		
		}
	catch (SQLException ee) {
		str = "SQL Exception " + ee.getMessage();
	} catch (Exception ee) {
		str = "Exception " + ee.getMessage();
	}
	

	return str;
}
public static String create_category(String category_name)
{
	String str="";
	PreparedStatement pstmt,pstmt2;
	Connection conn;
	try
	{
		conn=DbConn.getConnection();
		pstmt2=conn.prepareStatement("select count(*) mycount from categories where Category=?");
		pstmt2.setString(1,category_name);
		ResultSet rs=pstmt2.executeQuery();
		rs.absolute(1);
		if(rs.getInt(1)==0)
		{
		pstmt=conn.prepareStatement("INSERT INTO categories (Category) VALUES (?)");
		pstmt.setString(1,category_name);
		pstmt.executeUpdate();
		str="Successfully added the Category";
		}
		else
		{
			str="Insertion Failed as this Category already exists!";
		}
	}
	catch (SQLException ee) 
	{
		str = "SQL Exception " + ee.getMessage();
	}
	catch (Exception ee) 
	{
		str = "Exception " + ee.getMessage();
	}
	return str;
}

public static String delete_category(String category_name)
{
	String str="";
	PreparedStatement pstmt;
	Connection conn;
	try
	{
		conn=DbConn.getConnection();
		
		pstmt=conn.prepareStatement("delete from categories where Category=?");
		pstmt.setString(1,category_name);
		pstmt.executeUpdate();
		str="Successfully deleted the Category";
	}
	catch (SQLException ee) 
	{
		str = "SQL Exception " + ee.getMessage();
	}
	catch (Exception ee) 
	{
		str = "Exception " + ee.getMessage();
	}
	return str;
}


public static String moveQuestions(String old_surveyname,String old_category,String new_surveyname, String new_category, String question_id[]){
	Connection conn;
	PreparedStatement pstmt1, pstmt2,pstmt3, pstmt4;
	
	String str ="";
	//String str = old_surveyname+" "+old_category+" "+new_surveyname+" "+new_category+" "+question_id;
	
	
	
	int count=0;

	try {
		conn = DbConn.getConnection();
		
		//Query for  checking whether the selected/ current question already exists in the target survey
				pstmt2=conn.prepareStatement("select * from survey_question_map where Survey_ID=(select Survey_ID from surveys where Survey_Name=? and Category=?) and Question_ID=?");
				pstmt2.setString(1,new_surveyname);
				pstmt2.setString(2,new_category);
				//3rd parameter in the loop
		
		
		
		// Query for deletion from the current survey
					pstmt1 = conn 
							.prepareStatement("delete from survey_question_map where Survey_ID=(select Survey_ID from surveys where Survey_Name=? and Category=? ) and Question_ID=?");
				
					pstmt1.setString(1,old_surveyname);
					pstmt1.setString(2,old_category);
					//3rd parameter in the loop
		
		//Query for insertion into the target survey
					pstmt3 = conn
							.prepareStatement("insert into survey_question_map (Survey_ID, Question_ID, Flag) values((select Survey_ID from surveys where Survey_Name=? and Category=?),?,?)");
					pstmt3.setString(1,new_surveyname);
					pstmt3.setString(2,new_category);
					//3rd parameter in the loop
					pstmt3.setString(4,"active");
		
		
		for(int i=0;i<question_id.length;i++)
		{
			
		int my=Integer.parseInt(question_id[i]);
		
		
		pstmt1.setInt(3,my);// for 1st prepareStatemenmt
		
		pstmt2.setInt(3,my);// for 2nd prepareStatemenmt
		ResultSet rs=pstmt2.executeQuery();		
		
		pstmt3.setInt(3, my);// for 3rd prepareStatemenmt
				
		
			if (rs.next()) {
				//return rs.getString("Flag")+" combinatin exists";
				if(rs.getString("Flag").equals("inactive")){
					
					conn.prepareStatement(
							"update survey_question_map  set Flag='active' where Survey_ID=(select Survey_ID from surveys where Survey_Name='"
									+ new_surveyname
									+ "' and Category='"
									+ new_category
									+ "' ) and Question_ID="
									+ my).executeUpdate();
											
				count++;
				}
				continue; //skip move in case of duplicacy*/
			} 
			else{
				conn.setAutoCommit(false);
				pstmt1.executeUpdate();
				pstmt3.executeUpdate();
				conn.commit();
				count++;
			}
		}
		if(count==0)
			str="Selected question already exists in the target survey";
		else if(count<question_id.length)
			str="Some questions already exist in the targeted survey. "+count+" Question/Questions have been moved";
		else
			str = count+"Question/Questions have been moved";
	}catch(SQLException ee){
		str ="error1: "+ee.getMessage();
	}catch(Exception ee){
		str ="error2: "+ee.getMessage();
	}
	return str;
}

public static String getTargetSurvey(String curr_survey, String category, int empId, String roleId) {
	Connection conn;
	Statement stmt;
	String str = "";
	ResultSet rs=null;
	try {
		conn = DbConn.getConnection();
		stmt = conn.createStatement();
		if(roleId.equals("ADM121"))
			 rs = stmt
					.executeQuery("select Survey_Name from surveys where Category='"
							+ category + "' and Survey_Name not like '"+curr_survey+"' and Employee_ID = "+empId);
		else if(roleId.equals("SAD111"))
			 rs = stmt
				.executeQuery("select Survey_Name from surveys where Category='"
						+ category + "' and Survey_Name not like '"+curr_survey+"'");
			
		while (rs.next()) {

			str = str + "<option value='" + rs.getString(1) + "'>"
					+ rs.getString(1) + "</option>";
		}

	} catch (Exception ee) {
			str=ee.getMessage();
	}

	return str;
}

public static int checkquestions(String surveyname, String category)
{
	Connection conn;
	PreparedStatement pstmt, pstmt1;
	int mycount = -1;
	ResultSet rs;
	

	try {

		conn = DbConn.getConnection();

		pstmt1 = conn
				.prepareStatement("select count(*) from surveys si,survey_question_map sqm,questions q where si.Survey_Name=? and si.Category=? and sqm.Survey_ID=si.Survey_ID and q.Question_ID=sqm.Question_ID and sqm.Flag=? ");

		pstmt1.setString(1, surveyname);
		pstmt1.setString(2, category);
		pstmt1.setString(3, "active");

		rs = pstmt1.executeQuery();
		while (rs.next()) {
			mycount = rs.getInt(1);
		}

		if (mycount > 0) {
			                return 1;
		                  }
		else
		{
			return 0;
		}
	}
	 catch (Exception ee) {
			return -1;
	}
}
}