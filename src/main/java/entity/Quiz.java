package entity;


public class Quiz {
	private String category;
	//private List<Question> questions = new ArrayList<Question>();
	private Question[] questions; // = new ArrayList<Question>();

	public Quiz() {
		super();
	}
	
	public Quiz(String category, Question[] questions) {
		super();
		this.category = category;
		this.questions = questions;
	}
	
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
