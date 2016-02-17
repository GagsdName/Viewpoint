package dao;

//import java.io.PrintWriter;

import java.sql.*;

import org.apache.jasper.tagplugins.jstl.core.Out;

import dbreflib.DbConn;
import dbreflib.PasswordHashing;
public class DaoClass {
	Connection conn = DbConn.getConnection(); 
	Statement stmt, stmt1, stmt2;

	PreparedStatement pstmt,pstmt1;

	ResultSet rs, rs2, rs3;
	ResultSet rs1[] = new ResultSet[5];

	int var = 0;
	int total = 0;
	int count = 0;
	String str = "";

	public String getQuestions(String str1, String str2) throws SQLException {
int q=0;
		stmt = conn.createStatement();
		stmt1 = conn.createStatement();
System.out.println ("Connection = " + conn);
		rs = stmt
				.executeQuery("Select Survey_ID from surveys where Survey_Name='"
						+ str1
						+ "' and Category='"
						+ str2
						+ "' and Flag='active'");
		rs.absolute(1);
		int input = rs.getInt(1); // THIS IS THE SURVEY ID

		rs = stmt
				.executeQuery("Select Question_ID from survey_question_map where Survey_ID="
						+ input + " and Flag='active'");
		
	
	while (rs.next()) {
			q++;
			var = rs.getInt(1);
			//str=str+"<tr><td>Q_ID: "+var+"</td></tr>";
			rs2 = stmt1
					.executeQuery("Select * from questions where Question_ID="
							+ var);
			rs2.absolute(1);

			while (count < 5) {

				pstmt = conn
						.prepareStatement("select count(*) from submission where Survey_ID=? and Question_ID=? and Response=(Select Opt_"
								+ (count + 1)
								+ " from questions where Question_ID="
								+ var
								+ ")");
				pstmt.setInt(1, input);
				pstmt.setInt(2, var);

				rs1[count] = pstmt.executeQuery();
				rs1[count].absolute(1);
				total = total + rs1[count].getInt(1);

				 //str=str+"<tr><td>Option="+count+", Takers for the option="+rs1[count].getInt(1)+" Total no.: "+total+"</td></tr>";

				count++;
			}
			// count=0;
			// str+=total;

			String opt1 = rs2.getString("Opt_1");
			String opt2 = rs2.getString("Opt_2");
			String opt3 = rs2.getString("Opt_3");
			String opt4 = rs2.getString("Opt_4");
			String opt5 = rs2.getString("Opt_5");

			if (opt1 == null||opt1.trim().equals("null")||opt1.trim().equals("undefined"))
				opt1 = " ";
			if (opt2 == null||opt2.trim().equals("null")||opt2.trim().equals("undefined"))
				opt2 = " ";
			if (opt3 == null||opt3.trim().equals("null")||opt3.trim().equals("undefined"))
				opt3 = " ";
			if (opt4 == null||opt4.trim().equals("null")||opt4.trim().equals("undefined"))
				opt4 = " ";
			if (opt5 == null||opt5.trim().equals("null")||opt5.trim().equals("undefined"))
				opt5 = " ";
			if (total != 0) {
				int a = (rs1[0].getInt(1) * 100)/ total;
				int b = (rs1[1].getInt(1) * 100) / total;
				int c = (rs1[2].getInt(1) * 100)/ total;
				int d = (rs1[3].getInt(1) * 100) / total;
				int e = (rs1[4].getInt(1) * 100) / total;
				// str=str+"<tr><td>"+opt1+"</td><td> "+opt2+"</td><td>"+opt3+"</td><td>"+opt4+"</td><td>"+opt5+"</td></tr>";

				str = str+"<tr><th colspan='5' rowspan='2'>"+"<b>Que."+q+"</b>&nbsp;&nbsp;&nbsp;"
						
						+ rs2.getString("Question")
						+ "</td></tr><tr></tr>"
						+ "<tr ><td>"
						+ opt1
						+ "</td><td>"
						+ opt2
						+ "</td><td>"
						+ opt3
						+ "</td><td>"
						+ opt4
						+ "</td><td>"
						+ opt5
						+ "</td></tr><tr>"
						+ "<tr class='alt'><td colspan='5' cellpadding='10' ><b>Responses:</b>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;<a href='Review.jsp?opt1="
						+ a
						+ "&opt2="
						+ b
						+ "&opt3="
						+ c
						+ "&opt4="
						+ d
						+ "&opt5="
						+ e
						+ "&opt1text="
						+ opt1
						+ "&opt2text="
						+ opt2
						+ "&opt3text="
						+ opt3
						+ "&opt4text="
						+ opt4
						+ "&opt5text="
						+ opt5
						+ "'   onclick='getBar(this); return false;' title='place mouse-pointer here to view report' id='viewreport'><img src='images/report-icon.png' id='report-icon'/></a>Click on image to view report</th></tr>"
						+ "<tr><td>";
				if (!opt1.equals(" "))
					str = str + a + "%";

				str = str + "</td><td>";

				if (!opt2.equals(" "))
					str = str + b + "%";

				str = str + "</td><td>";

				if (!opt3.equals(" "))
					str = str + c + "%";

				str = str + "</td><td>";

				if (!opt4.equals(" "))
					str = str + d + "%";

				str = str + "</td><td>";

				if (!opt5.equals(" "))
					str = str + e + "%";

				str = str + "</td>";
				str = str
						+ "</tr>";

			} else {
				str = str
						+ "<tr>"+"<th colspan='5' rowspan='2' id='question' >"+"<b>Que."+q+"</b>&nbsp;&nbsp;&nbsp;"
						+ rs2.getString("Question")
						+ "</th></tr><tr></tr>"
						+ "<tr><td>"
						+ opt1
						+ "</td><td>"
						+ opt2
						+ "</td><td>"
						+ opt3
						+ "</td><td>"
						+ opt4
						+ "</td><td>"
						+ opt5
						+ "</td></tr><tr><td colspan='5' cellpadding='10' id='nosubmission'> No Submissions for this Question</td></tr>";
			}
			total = 0;
			count = 0;
		}
		
		return str;
	}

	public String getCategoryList() throws SQLException {
		str = "";
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select * from Categories");

		while (rs.next()) {
			str = str + "<option value='" + rs.getString(1) + "'>"
					+ rs.getString(1) + "</option>";
		}
		return str;
	}

	public String getSurveyList(String string) throws SQLException {
		str = "";
		stmt = conn.createStatement();
		rs = stmt
				.executeQuery("select Survey_Name from surveys where Category='"
						+ string + "' and Flag='active'");

		while (rs.next()) {

			str = str + "<option value='" + rs.getString(1) + "'>"
					+ rs.getString(1) + "</option>";
		}
		return str;
	}
	public String getSurveyList(String string,String role_id,int emp_id,int function_id) throws SQLException {
		str = "";
		String get_surveys="";
		if(function_id==0)
		{
		if(role_id.equals("ADM121"))
		{
			get_surveys="select Survey_Name from surveys where Category='"
					+ string + "' and Flag='active' and Employee_ID='"+emp_id+"'";
		}
		else if(role_id.equals("SAD111"))
		{
			get_surveys="select Survey_Name from surveys where Category='"
					+ string + "' and Flag='active'";
		}
		}
		else if(function_id==1)
		{
			if(role_id.equals("ADM121") || role_id.equals("SAD111") || role_id.equals("USR131"))
			{
				get_surveys="select Survey_Name from surveys where Category='"
						+ string + "' and Flag='active'";
			}
			
		}
			
		stmt = conn.createStatement();
		rs = stmt.executeQuery(get_surveys);

		while (rs.next()) {

			str = str + "<option value='" + rs.getString(1) + "'>"
					+ rs.getString(1) + "</option>";
		}
		return str;
	}
	public String getRoleList() throws SQLException {
		str = "";
		stmt = conn.createStatement();
		
			rs = stmt.executeQuery("select * from user_role where Role_ID not like 'SAD111'");
		
		while (rs.next()) {

			str = str + "<option value=" + rs.getString("Role_ID") + ">"
					+ rs.getString("Role_Name") + "</option>";
		}

		return str;
	}

	public String getDelUserData(int empID) throws SQLException {
		str = "";
		pstmt = conn
				.prepareStatement("Select * from users where Employee_ID=?");
		pstmt.setInt(1, empID);
		rs = pstmt.executeQuery();
		str = str+"<tr><th>User Name</th><th>User ID</th><th>Reset Password</th><th>Delete User</th></tr>";
		while (rs.next()) {
			str = str
					+ "<tr class='alt'><td>"
					+ rs.getString("Employee_Name")
					+ "</td><td>"
					+ empID
					+ "</td><td><a href='#' id='passChange' onclick=\"popup('popUpDiv')\"><img src=\"images/newsletter_icon.jpg\"></a></td><td><a href='' id='del' onClick='return deleteUser("
					+ rs.getString("Employee_ID")
					+ ")' ><img src=\"images/deletequestion.png\"></a></td></tr>";

		}
		
		/* for displaying in the tabular form
		 * pstmt=conn.prepareStatement(
		 * "SELECT Role_ID, COUNT( * ) my_count FROM (SELECT urm.Role_ID, u.Employee_ID, u.Flag FROM users u, user_role_map urm WHERE u.Employee_ID = urm.Employee_ID) AS t GROUP BY Role_ID"
		 * ); rs=pstmt.executeQuery();
		 * 
		 * while(rs.next()){
		 * //str=str+"<tr><td>"+rs.getString("Role_ID")+"</td></tr>";
		 * count=rs.getInt("my_count");
		 * if(rs.getString("Role_ID").equals("ADM121")){
		 * //str="Admin Acknowledged"; //break;
		 * 
		 * pstmt1=conn.prepareStatement(
		 * "Select * from user_role_map where Role_ID=?"); pstmt1.setString(1,
		 * "ADM121"); rs2=pstmt1.executeQuery(); while(rs2.next()){
		 * rs3=conn.prepareStatement("select * from users where Employee_ID=" +
		 * rs2.getInt("Employee_ID") + " and Flag='active' ").executeQuery();
		 * //check=0; while(rs3.next()){ if(check==0){
		 * str=str+"<tr><td rowspan='"+count+"'>Admin</td><td>" +
		 * rs3.getString("Employee_Name") + "</td><td>" +
		 * rs3.getString("Employee_ID") +
		 * "</td><td>Change Password</td><td><a href='' onClick='return deleteUser("
		 * + rs3.getString("Employee_ID") + ")' >Delete User</a></td></tr>";
		 * check++; }else{ str = str + "<tr><td>" +
		 * rs3.getString("Employee_Name") + "</td><td>" +
		 * rs3.getString("Employee_ID") +
		 * "</td><td>Change Password</td><td><a href='' onClick='return deleteUser("
		 * + rs3.getString("Employee_ID") + ")' >Delete User</a></td></tr>"; } }
		 * } } }
		 */

		
		return str;
	}


	public String deleteUserUpdate(String empId, String roleId)
			throws SQLException {
		pstmt = conn
				.prepareStatement("update users set Flag='inactive' where Employee_ID="
						+ empId);
		pstmt.executeUpdate();
		return "The selected user has been deleted!";// getDelUserData(roleId);
	}
	
	public int idDuplicacyCheck(String empId) throws SQLException{
		pstmt=conn.prepareStatement("Select count(*) from users where Employee_ID=?");
		pstmt.setInt(1, Integer.parseInt(empId));
		rs=pstmt.executeQuery();
		rs.absolute(1);
		if(rs.getInt(1)==0)
			return 0;
		else
			return 1;
					
	}
	
	public String userAuthentication(String username, String pswd,long time) throws SQLException{
		str="";
		pstmt=conn.prepareStatement("Select * from users  where Email=? and Password=? and Flag='active'");
		pstmt.setString(1, username);
		pstmt.setString(2, PasswordHashing.generateHash(pswd));
		//System.out.println("Password = "+PasswordHashing.generateHash(pswd));
		rs=pstmt.executeQuery();
		
		if(rs.next()){
			//System.out.println("time = "+time);
			//System.out.println("time1 = "+rs.getLong("LastLogon"));
			if (time > rs.getLong("LastLogon")) {
				pstmt1 = conn.prepareStatement("Select * from user_role_map  where Employee_ID=?");
				pstmt1.setInt(1, rs.getInt("Employee_ID"));
				rs2 = pstmt1.executeQuery();
				rs2.absolute(1);
				str = str + rs.getInt("Employee_ID") + "/"
						+ rs2.getString("Role_ID");
			}
			}
		
		if(str!=""){
		
			pstmt1=conn.prepareStatement("Update users set LastLogon=? where Employee_ID=?");
			pstmt1.setLong(1,time);
			pstmt1.setInt(2,rs.getInt("Employee_ID"));
			pstmt1.executeUpdate();
		}
	
		return str;
		
	}
	public String getSurveyListByAccess(String category,String role_id,int emp_id) throws SQLException {
        str = "";
        String get_surveys="";
        

                if(role_id.equals("ADM121") || role_id.equals("SAD111") || role_id.equals("USR131"))
                {
                        get_surveys="select s.Survey_Name from surveys s,survey_user_map sum where s.Category='"
                                        + category + "' and s.Flag='active' and s.Survey_ID=sum.Survey_ID and sum.Employee_ID="+emp_id+"";
                }
                else
                {
                        str="Access Denied!!!";
                }
                

                
        stmt = conn.createStatement();
        rs = stmt.executeQuery(get_surveys);

        while (rs.next()) {

                str = str + "<option value='" + rs.getString(1) + "'>"
                                + rs.getString(1) + "</option>";
        }
        return str;
}
	public String resetPassword(String oldPass, String newPass, String conPass,
			int empID) throws SQLException {
		str = "";

		pstmt = conn
				.prepareStatement("Select * from users where Employee_ID=?");
		pstmt1 = conn
				.prepareStatement("Update users set Password=? where Employee_ID=?");
		pstmt.setInt(1, empID);
		rs = pstmt.executeQuery();
		if (rs.next()) {

			if (rs.getString("Password").equals(
					PasswordHashing.generateHash(oldPass))) {
				if (newPass.equals(conPass)) {
					pstmt1.setString(1, PasswordHashing.generateHash(newPass));
					pstmt1.setInt(2, rs.getInt("Employee_ID"));
					pstmt1.executeUpdate();
					str = "Your password has been reset.";
					rs.close();
					pstmt.close();
					pstmt1.close();
				} else {
					str = "The new password does not match the password confirmed.";
					rs.close();
					pstmt.close();
					pstmt1.close();
				}
			} else {
				str = "The old password entered does not match the existing password.";
				rs.close();
				pstmt.close();
				pstmt1.close();
			}

		}
		return str;
	}
	public void resetPassword(String new_password,int empID) throws SQLException{
		str="";
		pstmt=conn.prepareStatement("update users set Password=? where Employee_ID=?");
		pstmt.setString(1, PasswordHashing.generateHash(new_password));
		pstmt.setInt(2,empID);
		pstmt.executeUpdate();
	}
	public String getEmpList(String selectedRoleId) throws SQLException {
		str = "";
		if(selectedRoleId==""||selectedRoleId==null){
		pstmt = conn
				.prepareStatement("Select u.Employee_ID,urm.Employee_ID, u.Employee_Name from users u, user_role_map urm where u.Employee_ID=urm.Employee_ID and urm.Role_ID=? and u.Flag=?");
		pstmt.setString(1, "USR131");
		pstmt.setString(2, "active");
		rs = pstmt.executeQuery();
		while (rs.next()) {
			str = str + "<option value=" + rs.getInt("Employee_ID") + ">"
					+ rs.getString("Employee_Name") + "</option>";
		}
		}else{
			pstmt = conn
					.prepareStatement("Select u.Employee_ID,urm.Employee_ID, u.Employee_Name from users u, user_role_map urm where u.Employee_ID=urm.Employee_ID and urm.Role_ID=? and u.Flag=?");
			pstmt.setString(1, selectedRoleId);
			pstmt.setString(2, "active");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				str = str + "<option value=" + rs.getInt("Employee_ID") + ">"
						+ rs.getString("Employee_Name") + "</option>";
			}
		}
		if(str!="")
			return str;
		else
			return "<option value=0>No Employee</option>";
	}
	
}
