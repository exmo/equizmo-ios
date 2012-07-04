package entity;


public class Question {
	private String enunciation;
	//private List<String> propositions = new ArrayList<String>();
	private String[] propositions; // = new ArrayList<String>();
	private int answer;

	public Question() {
		super();
	}
	
	public Question(String enunciation, String[] propositions, int answer) {
		super();
		this.enunciation = enunciation;
		this.propositions = propositions;
		this.answer = answer;
	}
	
	public String getEnunciation() {
		return enunciation;
	}

	public void setEnunciation(String enunciation) {
		this.enunciation = enunciation;
	}

	// public List<String> getPropositions() {
	// return propositions;
	// }
	//
	// public void setPropositions(List<String> propositions) {
	// this.propositions = propositions;
	// }

	public String[] getPropositions() {
		return propositions; //(String[]) propositions.toArray();
	}

	public void setPropositions(String[] propositions) {
		this.propositions = propositions; //Arrays.asList(propositions);
	}

	public int getAnswer() {
		return answer;
	}

	public void setAnswer(int answer) {
		this.answer = answer;
	}

}
