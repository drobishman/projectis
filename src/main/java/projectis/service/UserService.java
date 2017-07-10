package projectis.service;

import projectis.model.User;

public interface UserService {
	
	public User getUser(String login);
	
	public User getUser(String login, String password);
	
	public User getUser(int id, String password);
	
	public void setUser(User user);
	
	public void removeUser(User user);
	
	public void updateUser(User user);

}
