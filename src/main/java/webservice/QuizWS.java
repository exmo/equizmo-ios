package webservice;

import javax.inject.Inject;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.servlet.annotation.WebServlet;

import business.QuizBC;
import entity.Quiz;
@WebService//(targetNamespace="http://quiz-exmo.rhcloud.com/quiz")
@WebServlet("/quiz")
public class QuizWS {
	@Inject QuizBC bc;
	
	@WebMethod
	public boolean addQuiz(@WebParam(name="quiz") Quiz quiz) {
		return bc.add(quiz);
	}

	@WebMethod
	@WebResult(name="quiz")
	public Quiz giveMeAQuiz(@WebParam(name="category") String category) {
		return bc.quiz(category);
	}	
}


