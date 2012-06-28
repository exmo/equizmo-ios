package business;

import java.util.ArrayList;

import javax.inject.Inject;

import persistence.UserDAO;
import entity.User;

public class UserBC {
	@Inject UserDAO dao;
	
	public boolean login(String email, String name, Float latitude, Float longitude) {
		return dao.login(email, name, latitude, longitude);
	}

	public ArrayList<User> list() {
		return dao.list();
	}

	public int ranking(String email) {
		return dao.ranking(email);
	}
}
