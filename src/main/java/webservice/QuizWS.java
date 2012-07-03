package webservice;

import java.util.List;

import javax.inject.Inject;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.servlet.annotation.WebServlet;

import business.QuizBC;
import entity.Quiz;
@WebService
@WebServlet("/quiz")
public class QuizWS {
	@Inject QuizBC bc;
	
	@WebMethod
	@WebResult(name="quiz")
	public Quiz giveMeAQuiz(@WebParam(name="category") String category) {
		return bc.quiz(category);
	}	
	
	@WebMethod
	@WebResult(name="category")
	public List<String> listCategories(){
		return bc.listCategories();
	}		
}


