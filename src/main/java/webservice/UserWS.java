package webservice;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;
import javax.servlet.annotation.WebServlet;
@WebService
@WebServlet("/user")
public class UserWS {
	
	@WebMethod
	public boolean login(@WebParam(name="email") String email, @WebParam(name="name") String name){
		return true;
	}	

}
