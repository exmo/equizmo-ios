package business;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;

import persistence.CategoryDAO;
import br.gov.frameworkdemoiselle.annotation.Startup;
import br.gov.frameworkdemoiselle.stereotype.BusinessController;

@BusinessController
public class CategoryBC {
	@Inject
	CategoryDAO dao;
	
	@Inject Logger log;

	@Startup
	public void init() {
		log.info("Loading initial Category data");

		dao.add("Categoria 1");
		dao.add("Categoria 2");
		dao.add("Categoria 3");
	}
	
	public boolean add(String category) {
		return dao.add(category);
	}

	public List<String> list() {
		return dao.list();
	}

}
