package daoforsurvey;
import java.sql.*;
import java.io.*;
public class DAOSurvey {

	public Connection getData()throws IOException,SQLException
	{
		Connection con=null;
		  try{
			  String connectionString = "jdbc:mysql://localhost/survey_design";
			String dbUser = "root";
			String dbPassword ="";
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(connectionString, dbUser, dbPassword); 
			     
		}
		  catch(Exception e)
		  {
			  System.out.println(e.getMessage());
		  }
		return con;
	}
}
