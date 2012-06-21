package business;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import entity.User;

public class UserBC {
	private static Map<String, User> userList = new HashMap<String, User>();
	
	public boolean login(String email, String name, Float latitude, Float longitude) {
		
		if (userList.get(email) != null)
			userList.put(email, new User(email, name, latitude, longitude));
		return true;
	}

	public ArrayList<User> list() {
		return (ArrayList<User>) userList.values();
	}

	public int ranking(String email) {
		return 1;
	}

}
