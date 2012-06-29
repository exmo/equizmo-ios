package persistence;

import java.util.ArrayList;
import java.util.List;

import util.FileUtil;

public class CategoryDAO {
	private static List<String> categoryList = new ArrayList<String>();

	public List<String> list() {
		return FileUtil.readRemoteAsStringList("https://raw.github.com/exmo/exmo.github.com/master/equizmo/categories.txt");
	}

}
