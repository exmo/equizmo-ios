package entity;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Question {
	private String enunciation;
	//private List<String> propositions = new ArrayList<String>();
	private int answer;

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

//	public String[] getPropositions() {
//		return (String[]) propositions.toArray();
//	}
//
//	public void setPropositions(String[] propositions) {
//		this.propositions = Arrays.asList(propositions);
//	}

	public int getAnswer() {
		return answer;
	}

	public void setAnswer(int answer) {
		this.answer = answer;
	}
}
