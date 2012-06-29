package webservice;

import java.util.List;

import javax.inject.Inject;
import javax.jws.WebMethod;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.servlet.annotation.WebServlet;

import business.CategoryBC;

@WebService
@WebServlet("/category")
public class CategoryWS {
	@Inject CategoryBC bc;
	
	@WebMethod
	@WebResult(name="category")
	public List<String> list(){
		return bc.list();
	}	
}
