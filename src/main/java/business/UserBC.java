package business;

import java.util.ArrayList;

import javax.inject.Inject;

import persistence.UserDAO;
import entity.User;

public class UserBC {
	@Inject UserDAO dao;
	
	public int login(String email, String name, Float latitude, Float longitude) {
		return dao.login(email, name, latitude, longitude);
	}

	public int addPoints(String email, int points) {
		User u = dao.find(email);
		u.setPoints(u.getPoints() + points);
		return u.getPoints();
	}
	
	public ArrayList<User> list() {
		return dao.list();
	}

	public int ranking(String email) {
		return dao.ranking(email);
	}
}
