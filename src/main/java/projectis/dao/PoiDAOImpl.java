package projectis.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import projectis.model.Poi;

@Repository
public class PoiDAOImpl implements PoiDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(PoiDAOImpl.class);

	@Autowired
	private SessionFactory sessionFactory;
	
	private Session openSession() {
		return sessionFactory.getCurrentSession();
	}
	
	@Override
	public void addPoi(Poi p) {
		Session session = this.sessionFactory.getCurrentSession();
		session.save(p);
		logger.info("Poi saved successfully, Poi Details="+p);
		
	}

	@Override
	public void updatePoi(Poi p) {
		Session session = this.sessionFactory.getCurrentSession();
		session.update(p);
		logger.info("Poi updated successfully, Poi Details="+p);
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Poi> listPois() {
		Session session = this.sessionFactory.getCurrentSession();
		List<Poi> poisList = session.createQuery("from Poi").list();
		for(Poi p : poisList){
			logger.info("Poi List::"+p);
		}
		return poisList;
	}

	@Override
	public Poi getPoiById(int id) {
		Session session = this.sessionFactory.getCurrentSession();		
		Poi p = (Poi) session.load(Poi.class, new Integer(id));
		logger.info("Poi loaded successfully, Poi details="+p);
		return p;
	}

	@Override
	public void removePoi(int id) {
		Session session = this.sessionFactory.getCurrentSession();
		Poi p = (Poi) session.load(Poi.class, new Integer(id));
		if(null != p){
			session.delete(p);
		}
		logger.info("Poi deleted successfully, poi details="+p);
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Poi> listPoisByCategory(String categoryName) {
		Session session = this.sessionFactory.getCurrentSession();
		List<Poi> poisList = new ArrayList<Poi>();
		
		//vecchia query: select p from Poi p, Category c where c.name = :categoryName and p.id = c.poi.id
		Query query = session.createQuery("select p from Poi p join p.categories c where c.name =:categoryName");
		query.setParameter("categoryName", categoryName);
		
		poisList = query.list();
		
		logger.info("Poi by category id successfully loaded, pois details="+poisList);
		
		/*System.out.println(poisList.get(0).getId() +"\n"
				+ poisList.get(0).getIdPlaces() + "\n"
				+ poisList.get(0).getLat() + "\n"
				+ poisList.get(0).getLng() + "\n"
				+ poisList.get(0).getDescription() + "\n"
				+ poisList.get(0).getCategories().toString() + "");
		*/        
		return poisList;
	}

}
