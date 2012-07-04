package persistence;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;

import br.gov.frameworkdemoiselle.junit.DemoiselleRunner;

@RunWith(DemoiselleRunner.class)
public class UserDAOTest {

	@Inject 
	UserDAO dao;
	
	@Test
	public void testLogin() {
		assertEquals(0, dao.login("teste@teste.com", "teste", 10.0f, 10.0f));
	}

	@Test
	public void testList() {
		assertEquals(0, dao.login("teste1@teste1.com", "teste1", 10.0f, -10.0f));
		assertEquals(0, dao.login("teste2@teste2.com", "teste2", 20.0f, -20.0f));
		assertTrue(dao.list().size() > 0);
	}
	
	@Test
	public void testLoad() {
		dao.loadUsers();
		assertTrue(dao.list().size() > 0);
	}

}
