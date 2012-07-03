package persistence;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import br.gov.frameworkdemoiselle.annotation.Startup;

import util.FileUtil;
import util.XMLParserUtil;

import entity.Question;
import entity.Quiz;

public class QuizDAO {
	private static Map<String, Quiz> quizMap = new HashMap<String, Quiz>();
	
	@Startup
	public void loadQuizes() {
		String xml = FileUtil.readRemote("https://raw.github.com/exmo/exmo.github.com/master/equizmo/quiz.xml");
		
		HashMap<String, Class> aliases = new HashMap<String, Class>();
		aliases.put("quizes", List.class);
		aliases.put("quiz", Quiz.class);
		aliases.put("question", Question.class);
		aliases.put("proposition", String.class);
		
		List<Quiz> quizList = (ArrayList<Quiz>)XMLParserUtil.read(xml, aliases);
		for (Quiz quiz : quizList) {
			quizMap.put(quiz.getCategory(), quiz);
		}
	}	
	
	public boolean add(Quiz quiz) {
		if (quizMap.containsKey(quiz.getCategory()))
			return false;
		quizMap.put(quiz.getCategory(), quiz);
		return true;
	}

	public Quiz quiz(String category) {
		return quizMap.get(category);
	}

}
