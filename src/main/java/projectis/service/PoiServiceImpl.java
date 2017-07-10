package projectis.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import projectis.dao.PoiDAO;
import projectis.model.Poi;

@Service
public class PoiServiceImpl implements PoiService {
	
	@Autowired
	private PoiDAO poiDAO;

	@Override
	@Transactional
	public void addPoi(Poi p) {
		this.poiDAO.addPoi(p);
		
	}

	@Override
	@Transactional
	public void updatePoi(Poi p) {
		this.poiDAO.updatePoi(p);
		
	}

	@Override
	@Transactional
	public List<Poi> listPois() {
		return this.poiDAO.listPois();
	}

	@Override
	@Transactional
	public Poi getPoiById(int id) {
		return this.poiDAO.getPoiById(id);
	}

	@Override
	@Transactional
	public void removePoi(int id) {
		this.poiDAO.removePoi(id);
		
	}
	
	@Override
	@Transactional
	public List<Poi> listPoisByCategory(String categoryName) {
		return this.poiDAO.listPoisByCategory(categoryName);
	}

}
