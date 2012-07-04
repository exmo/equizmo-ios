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
	public ResponseAddPoints addPoints(@PathParam("email") String email, @PathParam("points") int points) {
		ResponseAddPoints r = new ResponseAddPoints();
		r.setPoints(bc.addPoints(email, points));
		return r;
	}	
	
	@GET
	@Path("/ranking/{offset}")
	@Produces("application/json")
	public ResponseRanking ranking(@PathParam("offset") Integer offset) {
		ResponseRanking r = new ResponseRanking();
		r.setLista(bc.ranking(offset));
		return r;
	}	
	
	public class  ResponseRanking{
		private List<User> lista;

		public List<User> getLista() {
			return lista;
		}

		public void setLista(List<User> lista) {
			this.lista = lista;
		}
	}
	
	public class  ResponseAddPoints{
		private Integer points;

		public Integer getPoints() {
			return points;
		}

		public void setPoints(Integer points) {
			this.points = points;
		}

		
	}
	
}