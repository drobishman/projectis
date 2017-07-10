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
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * Entity bean with JPA annotations
 * Hibernate provides JPA implementation
 * @author adrian
 *
 */
@Entity
@Table(name="category")
public class Category {

	@Id
	@Column(name="id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	@ManyToMany(fetch = FetchType.LAZY, mappedBy = "categories")
	private Set<Poi> pois = new HashSet<Poi>();

	public Set<Poi> getPois() {
		return pois;
	}

	public void setPois(Set<Poi> pois) {
		this.pois = pois;
	}
	
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
	
	@Override
	public String toString(){
		//return "id="+id+", name="+name+"";
		
		JSONObject jo = new JSONObject();
		try {
			jo.put("id", this.getId());
			jo.put("name", this.getName());
			
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		return jo.toString();

	}
}