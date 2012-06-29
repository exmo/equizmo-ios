package rest;

import java.util.List;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

import br.gov.frameworkdemoiselle.stereotype.ViewController;
import business.CategoryBC;

@Path("/category")
@ViewController
public class CategoryRS {
	@Inject CategoryBC bc;
	
	@GET
	@Path("/list")
	@Produces("application/json")
	public List<String> listAsJSON(){
		return bc.list();
	}	
}