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
	private UserBC bc;
	
	@GET
	@Path("/addPoints/{email}/{points}")
	@Produces("application/json")
	public AddPointsResponse addPoints(@PathParam("email") String email, @PathParam("points") int points) {
		AddPointsResponse response = new AddPointsResponse();
		response.setPoints(bc.addPoints(email, points));
		return response;
	}	
	
	@GET
	@Path("/ranking/{offset}")
	@Produces("application/json")
	public RankingResponse ranking(@PathParam("offset") int offset) {
		RankingResponse response = new RankingResponse();
		response.setUsers(bc.ranking(offset));
		return response;
	}	
	
	@GET
	@Path("/ranking")
	@Produces("application/json")
	public RankingResponse ranking() {
		RankingResponse response = new RankingResponse();
		response.setUsers(bc.ranking());
		return response;
	}	
	
	public class  RankingResponse{
		private List<User> users;

		public List<User> getUsers() {
			return users;
		}

		public void setUsers(List<User> users) {
			this.users = users;
		}
	}
	
	public class  AddPointsResponse{
		private int points;

		public int getPoints() {
			return points;
		}

		public void setPoints(int points) {
			this.points = points;
		}		
	}
	
}