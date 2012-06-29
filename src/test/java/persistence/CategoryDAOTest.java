package persistence;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class CategoryDAOTest {

	@Test
	public void listCategories() {
		CategoryDAO dao = new CategoryDAO();
		assertTrue(dao.list().size() > 0);
	}

}
