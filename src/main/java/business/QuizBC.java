package business;

import javax.inject.Inject;

import persistence.QuizDAO;
import entity.Quiz;

public class QuizBC {
	@Inject QuizDAO dao;
	
	public boolean add(Quiz quiz) {
		return dao.add(quiz);
	}

	public Quiz quiz(String category) {
		return dao.quiz(category);
	}
}
