package persistence;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import util.FileUtil;
import util.XMLParserUtil;
import br.gov.frameworkdemoiselle.annotation.Startup;
import entity.Question;
import entity.Quiz;
import entity.User;

public class UserDAO {
    private static Map<String, User> userMap = new HashMap<String, User>();

	@Startup
	public void loadUsers() {
		String xml = FileUtil
				.readRemote("http://exmo.github.com/equizmo/users.xml");

		HashMap<String, Class> aliases = new HashMap<String, Class>();
		aliases.put("users", List.class);
		aliases.put("user", User.class);

		userMap.clear();
		List<User> userList = (ArrayList<User>) XMLParserUtil
				.read(xml, aliases);
		for (User user : userList) {
			userMap.put(user.getEmail(), user);
		}
	}
	
    public int login(String email, String name, Float latitude,
            Float longitude) {
        if (userMap.containsKey(email))
            return userMap.get(email).getPoints();
        userMap.put(email, new User(email, name, latitude, longitude));
        return 0;
    }

    public User find(String email) {
        if (userMap.containsKey(email))
            return userMap.get(email);
        return null;
    }
    
    public ArrayList<User> list() {
        return new ArrayList<User>(userMap.values());
    }

    public int ranking(String email) {
        return 1;
    }

    public void clear() {
        userMap.clear();
    }
}