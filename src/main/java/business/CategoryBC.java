package business;

import java.util.List;

import javax.inject.Inject;

import persistence.CategoryDAO;
import br.gov.frameworkdemoiselle.stereotype.BusinessController;

@BusinessController
public class CategoryBC {
	@Inject
	CategoryDAO dao;

	public boolean add(String category) {
		return dao.add(category);
	}

	public List<String> list() {
		return dao.list();
	}

}
