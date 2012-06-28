package persistence;

import static org.junit.Assert.*;

import org.junit.Test;

import persistence.UserDAO;

public class UserDAOTest {

	@Test
	public void testLogin() {
		UserDAO dao = new UserDAO();
		assertTrue(dao.login("teste@teste.com", "teste", 10.0f, 10.0f));
	}

	@Test
	public void testList() {
		UserDAO dao = new UserDAO();
		assertTrue(dao.login("teste1@teste1.com", "teste1", 10.0f, -10.0f));
		assertTrue(dao.login("teste2@teste2.com", "teste2", 20.0f, -20.0f));
		assertEquals(dao.list().size(),3);
	}

}
