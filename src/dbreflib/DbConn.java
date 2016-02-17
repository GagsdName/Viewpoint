package dbreflib;
import java.sql.*;
import java.io.*;
public class DbConn
{
	public static Connection getConnection()
	{  Connection conn=null;
	try{
		String connectionString = "jdbc:mysql://localhost/survey_design";
		String dbUser = "root";
		String dbPassword = "root";
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(connectionString, dbUser, dbPassword); 
		System.out.println("Connection = " + conn);

	}catch(Exception e)
	{
		System.out.print(e);
	} 
	/*catch(ClassNotFoundException e)
	{
		System.out.print(e);
	}
	catch(SQLException ee)  
	{
		System.out.print(ee);
	}*/
	finally 
	{            return ( conn );  }
	}
}