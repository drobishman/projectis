package projectis.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="users")
public class User {

	@Id
	@GeneratedValue
	private Integer id;

	private String login;

	private String password;

	private String firstname;

	private String lastname;

	private double phone;

	private String email;

	@ManyToOne(cascade={CascadeType.PERSIST,CascadeType.REMOVE})
	@JoinColumn(name="agent_id", nullable=true)
	private User agent;

	@OneToMany(mappedBy="agent")
	private Set<User> customers = new HashSet<User>();

	@OneToOne( cascade = {CascadeType.PERSIST})
	@JoinTable(name="user_roles",
	joinColumns = {@JoinColumn(name="user_id", referencedColumnName="id")},
	inverseJoinColumns = {@JoinColumn(name="role_id", referencedColumnName="id")}
			)
	private Role role;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}


	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public double getPhone() {
		return phone;
	}

	public void setPhone(double phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Set<User> getCustomers() {
		return customers;
	}

	public void setCustomers(Set<User> customers) {
		this.customers = customers;
	}

	public User getAgent() {
		return agent;
	}

	public void setAgent(User agent) {
		this.agent = agent;
	}
}
