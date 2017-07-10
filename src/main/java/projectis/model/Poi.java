package projectis.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * Entity bean with JPA annotations
 * Hibernate provides JPA implementation
 * @author adrian
 *
 */
@Entity
@Table(name="poi")
public class Poi {

	@Id
	@Column(name="id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	@ManyToMany(fetch = FetchType.LAZY, cascade=CascadeType.ALL)
	@JoinTable(name="poi_category", 
		joinColumns = {@JoinColumn(name = "poi_id" )},
		inverseJoinColumns = {@JoinColumn(name="category_id")})
	private Set<Category> categories = new HashSet<Category>();

	@Column(name="id_places")
	private String idPlaces;
	
	private String name;
	private double lat;
	private double lng;
	private String description;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}


	public double getLat() {
		return lat;
	}

	public void setLat(double lat) {
		this.lat = lat;
	}

	public double getLng() {
		return lng;
	}

	public void setLng(double lng) {
		this.lng = lng;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	public Set<Category> getCategories() {
		return categories;
	}

	public void setCategories(Set<Category> categories) {
		this.categories = categories;
	}
	
	@Override
	public String toString(){
		
		//return "id="+id+", name="+name+", lat="+lat+", long=" +lng+", description=" +description+"";
		JSONObject jo = new JSONObject();
		try {
			jo.put("id", this.getId());
			jo.put("id_places", this.getIdPlaces());
			jo.put("name", this.getName());
			jo.put("lat", this.getLat());
			jo.put("lng", this.getLng());
			jo.put("description", this.getDescription());
			jo.put("categories",(JSONArray)new JSONArray (this.getCategories().toString()));
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		return jo.toString();
	}

	public String getIdPlaces() {
		return idPlaces;
	}

	public void setIdPlaces(String idPlaces) {
		this.idPlaces = idPlaces;
	}
}