package projectis.dao;

import projectis.model.User;

public interface UserDAO {
	
	public User getUser(String login, String password);
	
	public User getUser(int id, String password);
	
	public User getUser(String login);
	
	public void setUser(User user);
	
	public void removeUser(User user);
	
	public void updateUser(User user);

}
