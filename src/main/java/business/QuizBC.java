package business;

import javax.inject.Inject;

import org.slf4j.Logger;

import persistence.QuizDAO;
import br.gov.frameworkdemoiselle.annotation.Startup;
import entity.Quiz;

public class QuizBC {
	@Inject QuizDAO dao;
	@Inject Logger log;
	
	@Startup
	public void loadData() {
		log.info("Loading initial data");
	}
	
	public boolean add(Quiz quiz) {
		return dao.add(quiz);
	}

	public Quiz quiz(String category) {
		return dao.quiz(category);
	}
}
