package business;

import static org.junit.Assert.assertEquals;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;

import br.gov.frameworkdemoiselle.junit.DemoiselleRunner;
import entity.User;

@RunWith(DemoiselleRunner.class)
public class UserBCTest {
    @Inject UserBC bc;
    
    @Test
    public void testAddPoints() {
        bc.login("john@email.com","John Travolta",10f,-10f);
        assertEquals(20,bc.addPoints("john@email.com", 20));
        assertEquals(50,bc.addPoints("john@email.com", 30));
    }

    @Test
    public void testRanking() {
    	bc.clear();
        bc.login("john@email.com","John Travolta",10f,-10f);
        bc.login("olivia@email.com","Olivia Newton John",10f,-10f);
        bc.login("cage@email.com","Nicolas Cage",10f,-10f);
        bc.login("nicole@email.com","Nicole Kidman",10f,-10f);
        bc.addPoints("john@email.com", 20);
        bc.addPoints("olivia@email.com", 40);
        bc.addPoints("cage@email.com", 30);
        bc.addPoints("nicole@email.com", 10);
        List<User> fullRanking = bc.ranking();
        assertEquals(4,fullRanking.size());
        assertEquals("Olivia Newton John",fullRanking.get(0).getName());
        assertEquals("Nicolas Cage",fullRanking.get(1).getName());
        assertEquals("John Travolta",fullRanking.get(2).getName());
        assertEquals("Nicole Kidman",fullRanking.get(3).getName());
        List<User> top2ranking = bc.ranking(2);
        assertEquals(2,top2ranking.size());
        assertEquals("Olivia Newton John",top2ranking.get(0).getName());
        assertEquals("Nicolas Cage",top2ranking.get(1).getName());        
    }
}