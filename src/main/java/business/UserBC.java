package business;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.inject.Inject;

import persistence.UserDAO;
import entity.User;

public class UserBC {
    @Inject
    UserDAO dao;

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

    public List<User> ranking() {
    	return ranking(dao.list().size());
    }
    
    public List<User> ranking(int n) {
        ArrayList<User> users = dao.list();

        Collections.sort(users, new Comparator<User>() {
            public int compare(User u1, User u2) {
            	return (u1.getPoints()>u2.getPoints() ? -1 : (u1.getPoints()==u2.getPoints() ? 0 : 1));
            }
        });
        
        if (n >= users.size())
        	return users;
        else 
        	return users.subList(0, n);
    }
    
    public void clear() {
    	dao.clear();
    }
}