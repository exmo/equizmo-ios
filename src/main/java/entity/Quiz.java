package entity;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Quiz {
	private String category;
	private List<Question> questions = new ArrayList<Question>();
	
	public String getCategory() {
		return category;
	}
	
	public void setCategory(String category) {
		this.category = category;
	}
	
//	public List<Question> getQuestions() {
//		return questions;
//	}
//	
//	public void setQuestions(List<Question> questions) {
//		this.questions = questions;
//	}
	
	public Question[] getQuestions() {
		return (Question[]) questions.toArray();
	}

	public void setQuestions(Question[] questions) {
		this.questions = Arrays.asList(questions);
	}
}
