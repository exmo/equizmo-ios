package business;

import javax.inject.Inject;

import org.slf4j.Logger;

import persistence.QuizDAO;
import br.gov.frameworkdemoiselle.annotation.Startup;
import entity.Question;
import entity.Quiz;

public class QuizBC {
	@Inject QuizDAO dao;
	@Inject Logger log;
	
	@Startup
	public void init() {
		log.info("Loading initial Quiz data");
				
		Quiz quiz1 = new Quiz("Categoria 1", 
				new Question[]{
					new Question("Questão 1", new String[]{"Opção1","Opção2","Opção3"}, 0),
					new Question("Questão 2", new String[]{"Alternativa A","Alternativa B","Alternativa C"} , 1),
					new Question("Questão 3", new String[]{"Verdadeiro","Falso"} , 2),
					});
		dao.add(quiz1);

		Quiz quiz2 = new Quiz("Categoria 2", 
				new Question[]{
					new Question("Enunciado 1", new String[]{"Opção 1","Opção 2","Opção 3"}, 0),
					new Question("Enunciado 2", new String[]{"Letra A","Letra B","Letra C"} , 1),
					new Question("Enunciado 3", new String[]{"Verdade","Mentira"} , 2),
					});
		dao.add(quiz2);
	}
	
	public boolean add(Quiz quiz) {
		return dao.add(quiz);
	}

	public Quiz quiz(String category) {
		return dao.quiz(category);
	}
}
