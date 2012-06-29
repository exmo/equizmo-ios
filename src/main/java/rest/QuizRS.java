package rest;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

import br.gov.frameworkdemoiselle.stereotype.ViewController;
import business.QuizBC;
import entity.Quiz;

@Path("/quiz")
@ViewController
public class QuizRS {
	@Inject QuizBC bc;
	
	@GET
	@Path("/get/{category}")
	@Produces("application/json")
	public Quiz giveMeAQuiz(@PathParam("category") String category) {
		return bc.quiz(category);
	}		
}