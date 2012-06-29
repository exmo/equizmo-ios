package entity;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Quiz {
	private String category;
	//private List<Question> questions = new ArrayList<Question>();
	private Question[] questions; // = new ArrayList<Question>();
	
	public String getCategory() {
		return category;
	}
	
	public void setCategory(String category) {
		this.category = category;
	}
	
	public Question[] getQuestions() {
		return questions; //(Question[]) questions.toArray();
	}

	public void setQuestions(Question[] questions) {
		this.questions = questions; //Arrays.asList(questions);
	}
}
