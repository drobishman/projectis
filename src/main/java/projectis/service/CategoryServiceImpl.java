package projectis.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import projectis.dao.CategoryDAO;
import projectis.model.Category;

@Service
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	private CategoryDAO categoryDAO;
	
	@Override
	@Transactional
	public List<Category> listCategories() {
		return this.categoryDAO.listCategories();
	}

}
