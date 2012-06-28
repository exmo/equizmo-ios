package persistence;

import java.util.HashMap;
import java.util.Map;

import entity.Quiz;

public class QuizDAO {
	private static Map<String, Quiz> quizList = new HashMap<String, Quiz>();
	
	public boolean add(Quiz quiz) {
		if (quizList.containsKey(quiz.getCategory()))
			return false;
		quizList.put(quiz.getCategory(), quiz);
		return true;
	}

	public Quiz quiz(String category) {
		return quizList.get(category);
	}
}
