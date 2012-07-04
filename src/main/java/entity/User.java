package entity;

public class User {
	private String email;
	private String name;
	private Float latitude;
	private Float longitude;
	private int points = 0;

	public User() {
		super();
	}
	
	public User(String email, String name, Float latitude, Float longitude) {
		super();
		this.email = email;
		this.name = name;
		this.latitude = latitude;
		this.longitude = longitude;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public Float getLatitude() {
		return latitude;
	}
	
	public void setLatitude(Float latitude) {
		this.latitude = latitude;
	}
	
	public Float getLongitude() {
		return longitude;
	}

	public void setLongitude(Float longitude) {
		this.longitude = longitude;
	}

	public int getPoints() {
		return points;
	}

	public void setPoints(int points) {
		this.points = points;
	}

}
