package webservice.rest;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

@Path("/meuamigo/{maneh}")
public class Rest {

	@GET
	@Produces("text/plain")
	public String getText(@PathParam("maneh") String nome){
		return nome+" não manja nada!!!";
	}
	
}
