package projectis.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import projectis.model.User;

@Repository
public class UserDAOImpl implements UserDAO {

	@Autowired
	private SessionFactory sessionFactory;

	private Session openSession() {
		return sessionFactory.getCurrentSession();
	}

	@SuppressWarnings("unchecked")
	public User getUser(String login, String password) {
		List<User> userList = new ArrayList<User>();
		Query query = openSession().createQuery("from User u where u.login = :login"
				+ " and u.password = :password");
		query.setParameter("login", login);
		query.setParameter("password", password);
		userList = query.list();
		if (userList.size() > 0)
			return userList.get(0);
		else
			return null;	
	}

	@SuppressWarnings("unchecked")
	public User getUser(String login) {
		List<User> userList = new ArrayList<User>();
		Query query = openSession().createQuery("from User u where u.login = :login");
		query.setParameter("login", login);
		userList = query.list();
		if (userList.size() > 0)
			return userList.get(0);
		else
			return null;	
	}

	@SuppressWarnings("unchecked")
	public User getUser(int id, String password) {
		List<User> userList = new ArrayList<User>();
		Query query = openSession().createQuery("from User u where u.id = :id"
				+ " and u.password = :password");
		query.setParameter("id", id);
		query.setParameter("password", password);
		userList = query.list();
		if (userList.size() > 0)
			return userList.get(0);
		else
			return null;	
	}

	public void setUser(User user){
		openSession().clear();
		openSession().save(user);
	}

	public void removeUser(User user){
		openSession().clear();
		openSession().delete(user);
	}

	public void updateUser(User user){
		openSession().clear();
		openSession().update(user);
	}
}
