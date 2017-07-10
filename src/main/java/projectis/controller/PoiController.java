package projectis.controller;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import projectis.model.Category;
import projectis.model.Poi;
import projectis.service.CategoryService;
import projectis.service.PoiService;
import projectis.service.UserService;

@Controller
public class PoiController {
	
	@Autowired
	UserService userService;

	private PoiService poiService;
	private CategoryService categoryService;

	@Autowired(required=true)
	@Qualifier(value="poiService")
	public void setPoiService(PoiService ps){
		this.poiService = ps;
	}
	
	@Autowired(required=true)
	@Qualifier(value="categoryService")
	public void setCategoryService(CategoryService cs){
		this.categoryService = cs;
	}

	@RequestMapping(value = "/pois", method = RequestMethod.GET)
	public String listPois(Model model) {
		model.addAttribute("poi", new Poi());
		model.addAttribute("listCategories", this.categoryService.listCategories());
		model.addAttribute("listPois", this.poiService.listPois());
		return "poi";
	}

	//For add and update poi both
	@RequestMapping(value= "/poi/add", method = RequestMethod.POST)
	public String addPoi(@ModelAttribute("Poi") Poi p){
		
		Set<Category> set = new HashSet<Category>();
		Category category = new Category();
		category.setName("accounting");
		category.setId(1);
		Category category2 = new Category();
		category2.setName("ciaone hahaha");
		set.add(category2);
		
		
		
		p.setCategories(set);
		System.out.println(p.toString());
		
		if(p.getId() == 0){
			//new poi, add it
			this.poiService.addPoi(p);
		}else{
			//existing person, call update
			this.poiService.updatePoi(p);
		}
		 
		return "redirect:/index";

	}
	
	//------------------------------------Add/Update POI----------------------------------
	
	@RequestMapping(value="/poi/adup/", method = RequestMethod.POST)
	public ResponseEntity<Void> adUpPoi(@RequestBody Poi p){
		
		System.out.println(p.toString());
		
		if(p.getId()==0){
			this.poiService.addPoi(p);
		}else{
			this.poiService.updatePoi(p);
		}
		
		return new ResponseEntity<Void>(HttpStatus.OK);
	}
	
	@RequestMapping("/remove/{id}")
    public String removePoi(@PathVariable("id") int id){
		
        this.poiService.removePoi(id);
        return "redirect:/pois";
    }
	
	 @RequestMapping("/edit/{id}")
	    public String editPoi(@PathVariable("id") int id, Model model){
	        model.addAttribute("poi", this.poiService.getPoiById(id));
	        model.addAttribute("listCategories", this.categoryService.listCategories());
	        model.addAttribute("listPois", this.poiService.listPois());
	        return "poi";
	    }
		
	 
	 @RequestMapping(value="/", method=RequestMethod.GET)
		public ModelAndView homePage() {
			return new ModelAndView("login-form");
		}

		@RequestMapping(value="/index", method=RequestMethod.GET)
		public ModelAndView indexPage(Model model) {
			model.addAttribute("listCategories", this.categoryService.listCategories());
			return new ModelAndView("home");
		}

		@RequestMapping(value="/user", method=RequestMethod.GET)
		public ModelAndView userPage() {
			return new ModelAndView("user");
		}

		@RequestMapping(value="/agent", method=RequestMethod.GET)
		public ModelAndView agentPage() {
			return new ModelAndView("agent");
		}

		@RequestMapping(value="/administrator", method=RequestMethod.GET)
		public ModelAndView administratorPage() {
			return new ModelAndView("administrator");
		}
		
		 @RequestMapping(value="/listcategories", method=RequestMethod.GET, produces = "application/json")
		    public  @ResponseBody String listCategories(){
				
		        List<Category> listCategories = this.categoryService.listCategories();
		        
		        return listCategories.toString();
		    }
		 
		 @RequestMapping(value="/listpoisbycategory/{category.name}", method=RequestMethod.GET, produces = "application/json")
		    public  @ResponseBody String listPoisByCategory(@PathVariable("category.name") String categoryName){
				
		        List<Poi> listPois = this.poiService.listPoisByCategory(categoryName);
		        
		        return listPois.toString();
		    }
		 
		 //ritorna la lista di tutti i POI nel DB 
		 @RequestMapping(value = "/listAllPois", method = RequestMethod.GET)
		    public ResponseEntity<String> listAllPois() {
		        String pois = poiService.listPois().toString();
		        if(pois.isEmpty()){
		            return new ResponseEntity<String>(HttpStatus.NO_CONTENT);//You many decide to return HttpStatus.NOT_FOUND
		        }
		        return new ResponseEntity<String>(pois, HttpStatus.OK);
		    }

}
