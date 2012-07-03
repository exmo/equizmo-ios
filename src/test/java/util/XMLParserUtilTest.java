package util;

import static org.junit.Assert.assertEquals;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.junit.BeforeClass;
import org.junit.Test;

import entity.Question;
import entity.Quiz;

public class XMLParserUtilTest {
	private static List<Quiz> quizList = new ArrayList<Quiz>();
	@SuppressWarnings("rawtypes")
	private static HashMap<String, Class> aliases = new HashMap<String, Class>();
	private static String xml;
	
	@SuppressWarnings("rawtypes")
	@BeforeClass
	public static void setUp() {
		Quiz quiz1 = new Quiz("c1", new Question[] {
				new Question("q1", new String[] { "o1", "o2", "o3" }, 0),
				new Question("q2", new String[] { "a1", "a2", "a3" }, 1) });
		quizList.add(quiz1);

		Quiz quiz2 = new Quiz("c2", new Question[] { new Question("q2",
				new String[] { "l1", "l2", "l3" }, 2) });
		quizList.add(quiz2);
		
		aliases = new HashMap<String, Class>();
		aliases.put("quizes", List.class);
		aliases.put("quiz", Quiz.class);
		aliases.put("question", Question.class);
		aliases.put("proposition", String.class);
		 
		xml = "<?xml version=\"1.0\" ?><quizes><quiz><category>c1</category><questions>" + 
				"<question><enunciation>q1</enunciation><propositions>" + 
				"<proposition>o1</proposition><proposition>o2</proposition><proposition>o3</proposition></propositions>" +
				"<answer>0</answer></question>" + 
				"<question><enunciation>q2</enunciation><propositions>" + 
				"<proposition>a1</proposition><proposition>a2</proposition><proposition>a3</proposition></propositions>" + 
				"<answer>1</answer></question></questions></quiz>" +
				"<quiz><category>c2</category><questions><question><enunciation>q2</enunciation><propositions>" +
				"<proposition>l1</proposition><proposition>l2</proposition><proposition>l3</proposition></propositions>" +
				"<answer>2</answer></question></questions></quiz></quizes>";
	}
	
	@Test 
	public void readRemote() {
		String xml = FileUtil.readRemote("https://raw.github.com/exmo/exmo.github.com/master/equizmo/quiz.xml");
		System.out.println(xml);
	}

	@Test
	public void testWriteXML() {
		String result  = XMLParserUtil.write(quizList, aliases);
		System.out.println(result);
		assertEquals(xml, result);
	}

	@SuppressWarnings("unchecked")
	@Test
	public void testReadXML() {
		List<Quiz> expectedQuizList = ((ArrayList<Quiz>)XMLParserUtil.read(xml, aliases));
		Quiz q1 = expectedQuizList.get(0);
		assertEquals("c1",q1.getCategory());
		assertEquals("q1",q1.getQuestions()[0].getEnunciation());
		assertEquals("o1",q1.getQuestions()[0].getPropositions()[0]);
		assertEquals("o2",q1.getQuestions()[0].getPropositions()[1]);
		assertEquals("o3",q1.getQuestions()[0].getPropositions()[2]);
		assertEquals(0,q1.getQuestions()[0].getAnswer());
		assertEquals("q2",q1.getQuestions()[1].getEnunciation());
		assertEquals("a1",q1.getQuestions()[1].getPropositions()[0]);
		assertEquals("a2",q1.getQuestions()[1].getPropositions()[1]);
		assertEquals("a3",q1.getQuestions()[1].getPropositions()[2]);
		assertEquals("q2",q1.getQuestions()[1].getEnunciation());
		assertEquals(0,q1.getQuestions()[0].getAnswer());
		
		Quiz q2 = expectedQuizList.get(1);
		assertEquals("c2",q2.getCategory());
		assertEquals("q2",q2.getQuestions()[0].getEnunciation());
		assertEquals("l1",q2.getQuestions()[0].getPropositions()[0]);
		assertEquals("l2",q2.getQuestions()[0].getPropositions()[1]);
		assertEquals("l3",q2.getQuestions()[0].getPropositions()[2]);
		assertEquals(2,q2.getQuestions()[0].getAnswer());
	}
}
