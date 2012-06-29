package business;

import java.util.List;

import javax.inject.Inject;

import persistence.CategoryDAO;
import br.gov.frameworkdemoiselle.stereotype.BusinessController;

@BusinessController
public class CategoryBC {
	@Inject
	CategoryDAO dao;

	public List<String> list() {
		return dao.list();
	}
}
