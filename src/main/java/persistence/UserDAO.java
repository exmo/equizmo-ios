package persistence;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import entity.User;

public class UserDAO {
	private static Map<String, User> userList = new HashMap<String, User>();

	public int login(String email, String name, Float latitude,
			Float longitude) {
		if (userList.containsKey(email))
			return userList.get(email).getPoints();
		userList.put(email, new User(email, name, latitude, longitude));
		return 0;
	}

	public User find(String email) {
		if (userList.containsKey(email))
			return userList.get(email);
		return null;
	}
	
	public ArrayList<User> list() {
		return new ArrayList<User>(userList.values());
	}

	public int ranking(String email) {
		return 1;
	}

}
