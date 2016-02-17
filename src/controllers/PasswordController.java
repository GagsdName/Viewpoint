package controllers;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import dao.DaoClass;
import dbreflib.PasswordHashing;
import dbreflib.URL;
import dbreflib.database_functions_body;
public class PasswordController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		DaoClass dao=new DaoClass();
		PrintWriter pw=response.getWriter();
		String message;
		int empID;		
		if(Integer.parseInt(request.getParameter("identifier"))==0){
		try{
			empID=Integer.parseInt(request.getParameter("empID"));
			message=dao.resetPassword(request.getParameter("oldPass"), request.getParameter("newPass"), request.getParameter("conPass"), empID);
			
		}catch(Exception e){
			message="Error"+e.getMessage();
		}
		
		ModelAndView mAV= new ModelAndView("after_pass_reset");
		mAV.addObject("message", message);
		
		return mAV;
		}else{
			try{
			dao.resetPassword(request.getParameter("newPass"),Integer.parseInt(request.getParameter("empID")));
				/*ModelAndView mAV= new ModelAndView("../../DeleteUser");
				mAV.addObject("msg_id",1);
				mAV.addObject("reset_message", "Password has been reset");
				return mAV;*/
			pw.println("<html><script>alert('Successfully changed the Password');window.location = 'http://localhost:8081/Survey_Version2.0/DeleteUser.jsp'</script></html>");
			return null;
			}catch(Exception e){
				message=e.getMessage();
				ModelAndView mAV= new ModelAndView("after_pass_reset");
				mAV.addObject("message", message);
				return mAV;
			}
		}
		}

}
