package business;

import java.util.List;

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
	
	public void refresh() {
		dao.loadQuizes();
	}
	
	public List<String> listCategories() {
		return dao.listCategories();
	}
}
