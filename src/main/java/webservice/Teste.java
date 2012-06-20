package webservice;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;
import javax.servlet.annotation.WebServlet;
@WebService
@WebServlet("/hello")
public class Teste {
	
	@WebMethod
	public String sayHello(@WebParam(name="name") String name){
		return "Funcionou: "+name;
	}
	

}
