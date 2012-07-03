package persistence;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import br.gov.frameworkdemoiselle.annotation.Startup;

import util.FileUtil;
import util.XMLParserUtil;

import entity.Question;
import entity.Quiz;

public class QuizDAO {
	private static Map<String, Quiz> quizMap = new HashMap<String, Quiz>();

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Startup
	public void loadQuizes() {
		String xml = FileUtil
				.readRemote("http://exmo.github.com/equizmo/quiz.xml");

		HashMap<String, Class> aliases = new HashMap<String, Class>();
		aliases.put("quizes", List.class);
		aliases.put("quiz", Quiz.class);
		aliases.put("question", Question.class);
		aliases.put("proposition", String.class);

		quizMap.clear();
		List<Quiz> quizList = (ArrayList<Quiz>) XMLParserUtil
				.read(xml, aliases);
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

	public List<String> listCategories() {
		return new ArrayList<String>(quizMap.keySet());
	}
}
