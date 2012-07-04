package business;

import static org.junit.Assert.assertEquals;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;

import br.gov.frameworkdemoiselle.junit.DemoiselleRunner;

@RunWith(DemoiselleRunner.class)
public class UserBCTest {
	@Inject UserBC bc;
	
	@Test
	public void testAddPoints() {
		bc.login("john@email.com","John Travolta",10f,-10f);
		assertEquals(20,bc.addPoints("john@email.com", 20));
		assertEquals(50,bc.addPoints("john@email.com", 30));
	}

}
