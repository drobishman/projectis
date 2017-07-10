package projectis.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import projectis.model.Category;

@Repository
public class CategoryDAOImpl implements CategoryDAO{
	

	private static final Logger logger = LoggerFactory.getLogger(CategoryDAOImpl.class);

	@Autowired
	private SessionFactory sessionFactory;

	@SuppressWarnings("unchecked")
	@Override
	public List<Category> listCategories() {
		Session session = this.sessionFactory.getCurrentSession();
		List<Category> categoryList = session.createQuery("from Category").list();
		
		List<Category> unique = new ArrayList<Category>();
		
		for(Category category: categoryList){
			 if (!unique.contains(category)) {
		            unique.add(category);
		          }
		}
		
		for(Category p : unique){
			logger.info("Category List::"+p);
		}
		return unique;
	}

}
