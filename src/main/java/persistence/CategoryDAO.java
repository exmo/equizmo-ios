package persistence;

import java.util.ArrayList;
import java.util.List;

import br.gov.frameworkdemoiselle.annotation.Startup;

import entity.Quiz;

import util.FileUtil;
import util.XMLParserUtil;

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
