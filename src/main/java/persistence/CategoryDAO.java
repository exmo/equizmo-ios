package persistence;

import java.util.List;

import br.gov.frameworkdemoiselle.annotation.Startup;

import util.FileUtil;

public class CategoryDAO {
	List<String> categoryList;
	
	@Startup
	public void loadCategories() {
		categoryList = FileUtil.readRemoteAsStringList("https://raw.github.com/exmo/exmo.github.com/master/equizmo/categories.txt");
	}
	
	public List<String> list() {
		return categoryList;
	}

}
