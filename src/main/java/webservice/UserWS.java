package webservice;

import java.util.ArrayList;

import javax.inject.Inject;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.servlet.annotation.WebServlet;

import business.UserBC;
import entity.User;
@WebService
@WebServlet("/user")
public class UserWS {
	@Inject UserBC bc;
	
	@WebMethod
	public boolean login(@WebParam(name="email") String email, @WebParam(name="name") String name, @WebParam(name="latitude") Float latitude, @WebParam(name="longitude") Float longitude){
		return bc.login(email, name, latitude, longitude);
	}	

	@WebMethod
	@WebResult(name="user", partName="usuarios")
	public  ArrayList<User> list(){
		return bc.list();
	}	
	
	@WebMethod
	public int ranking(@WebParam(name="email") String email){
		return bc.ranking(email);
	}		
}
