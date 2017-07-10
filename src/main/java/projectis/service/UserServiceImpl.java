package projectis.service;

import org.springframework.transaction.annotation.Transactional;

import projectis.dao.UserDAO;
import projectis.model.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Transactional
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO userDAO;
	
public User getUser(String login) {
		
		return userDAO.getUser(login);
	}

	public User getUser(String login, String password) {
		
		return userDAO.getUser(login,password);
	}

	public User getUser(int id, String password) {
		return userDAO.getUser(id, password);
	}

	public void setUser(User user){

		userDAO.setUser(user);

	}

	public void removeUser(User user){

		userDAO.removeUser(user);

	}

	public void updateUser(User user){

		userDAO.updateUser(user);
	}
}
