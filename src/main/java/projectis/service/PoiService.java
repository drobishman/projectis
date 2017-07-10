package projectis.service;

import java.util.List;

import projectis.model.*;

public interface PoiService {

	public void addPoi(Poi p);
	public void updatePoi(Poi p);
	public List<Poi> listPois();
	public Poi getPoiById(int id);
	public void removePoi(int id);
	public List<Poi> listPoisByCategory(String categoryName);
}
