package persistence;

import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
	private static List<String> categoryList = new ArrayList<String>();

	public boolean add(String category) {
		if (categoryList.contains(category))
			return false;
		categoryList.add(category);
		return true;
	}

	public List<String> list() {
		
		//"https://raw.github.com/exmo/exmo.github.com/master/equizmo/categories.txt"
		return categoryList;
	}

}
