package rest;

import java.util.List;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

import business.UserBC;
import entity.User;

@Path("/user")
public class UserRS {

	@Inject 
	UserBC bc;
	
	@GET
	@Path("/addPoints/{email}/{points}")
	public int addPoints(@PathParam("email") String email, @PathParam("points") int points) {
		return bc.addPoints(email, points);
	}	
	
	@GET
	@Path("/ranking/{offset}")
	@Produces("application/json")
	public List<User> ranking(@PathParam("offset") Integer offset) {
		return bc.ranking(offset);
	}	
	
}