package rest;

import java.util.List;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

import br.gov.frameworkdemoiselle.stereotype.Controller;
import business.QuizBC;
import entity.Quiz;

@Path("/quiz")
@Controller
public class QuizRS {
	@Inject QuizBC bc;
	
	@GET
	@Path("/get/{category}")
	@Produces("application/json; charset=UTF-8")
	public Quiz giveMeAQuizAsJSON(@PathParam("category") String category) {
		return bc.quiz(category);
	}		
	
	@GET
	@Path("/listCategories")
	@Produces("application/json; charset=UTF-8")
	public List<String> listCategories(){
		return bc.listCategories();
	}
	
	@GET
	@Path("/refresh")
	public void refresh() {
		bc.refresh();
	}
}