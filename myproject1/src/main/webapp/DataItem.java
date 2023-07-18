
public class DataItem {
	private String userId;
	private String password;
	private String name;
	
	public DataItem() {}
	
	public DataItem(String userId, String password, String name) {
		this.userId = userId;
		this.password = password;
		this.name = name;
	} 
	
	public String getId() {
		return userId;
	}
	
	public void setId(String userId) {
		this.userId = userId;
	}
	
	public String getPwd() {
		return password;
	}
	
	public void setPwd(String password) {
		this.password = password;
	}
	
	public String getname() {
		return name;
	}
	
	public void setname(String name) {
		this.name = name;
	}
}

