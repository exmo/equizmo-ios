package business;

import static org.junit.Assert.*;

import org.junit.Test;

public class UserBCTest {

	@Test
	public void testLogin() {
		UserBC bc = new UserBC();
		assertTrue(bc.login("teste@teste.com", "teste", 10.0f, 10.0f));
	}

	@Test
	public void testList() {
		UserBC bc = new UserBC();
		assertTrue(bc.login("teste@teste.com", "teste2", 10.0f, -10.0f));
		assertTrue(bc.login("teste2@teste2.com", "teste2", 20.0f, -20.0f));
		assertEquals(bc.list().size(),2);
	}

}
