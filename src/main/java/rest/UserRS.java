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
	@Produces("application/json")
	public int addPoints(@PathParam("email") String email, @PathParam("points") int points) {
		return bc.addPoints(email, points);
	}	
	
	@GET
	@Path("/ranking/{offset}")
	@Produces("application/json")
	public Ranking ranking(@PathParam("offset") Integer offset) {
		Ranking r = new Ranking();
		r.setLista(bc.ranking(offset));
		return r;
	}	
	
	public class  Ranking{
		private List<User> lista;

		public List<User> getLista() {
			return lista;
		}

		public void setLista(List<User> lista) {
			this.lista = lista;
		}
		
	}
	
}