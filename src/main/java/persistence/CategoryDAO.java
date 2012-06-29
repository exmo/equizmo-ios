package persistence;

import java.util.List;

import util.FileUtil;

public class CategoryDAO {

	public List<String> list() {
		return FileUtil.readRemoteAsStringList("https://raw.github.com/exmo/exmo.github.com/master/equizmo/categories.txt");
	}

}
