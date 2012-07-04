package rest;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

import business.UserBC;

@Path("/user")
public class UserRS {
<<<<<<< HEAD
    @Inject 
    UserBC bc;
    
    @GET
    @Path("/addPoints/{email}/{points}")
    public int addPoints(@PathParam("email") String email, @PathParam("points") int points) {
        return bc.addPoints(email, points);
    }        
=======
	@Inject 
	UserBC bc;
	
	@GET
	@Path("/addPoints/{email}/{points}")
	public int addPoints(@PathParam("email") String email, @PathParam("points") int points) {
		return bc.addPoints(email, points);
	}		
>>>>>>> d0586c3c0143f27ddf36726eb485e7af53233a93
}