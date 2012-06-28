package persistence;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

public class CategoryDAOTest {

	@Test
	public void addCategoryWithSuccessShouldReturnTrue() {
		CategoryDAO dao = new CategoryDAO();
		assertTrue(dao.add("Category 1"));
	}

	@Test
	public void addExistingCategoryShouldReturnFalse() {
		CategoryDAO dao = new CategoryDAO();
		assertFalse(dao.add("Category 1"));
	}

	@Test
	public void listCategories() {
		CategoryDAO dao = new CategoryDAO();
		dao.add("Category 1");
		dao.add("Category 2");
		assertEquals(dao.list().size(), 2);
		assertEquals("Category 1", dao.list().get(0));
		assertEquals("Category 2", dao.list().get(1));
	}

}
