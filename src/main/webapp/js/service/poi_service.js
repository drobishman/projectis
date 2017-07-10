'use strict';

App.factory('PoiService', ['$http', '$q', function($http, $q){
	
	var self = this;
	self.poi = {id:null, id_places:null, categories:null, name:'', lat:null, lng:null, description:''};
	self.pois=[];
	
	var REST_SERVICE_URI = '${pageContext.request.contextPath}';
	
	var factory={
			listAllPois: listAllPois,
			listCategories: listCategories,
			adUpPoi: adUpPoi,
			listPoisByCategory: listPoisByCategory
	}
	
	return factory;
	
	function listAllPois(){
		var URL = REST_SERVICE_URI+'/listAllPois';
		var deferred = $q.defer();
		$http.get(URL)
		.then(
				function(response){
					deferred.resolve(response.data);
				},
				function(errResponse){
					console.error('Error listing POIs');
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;
	}
	
	//listpoisbycategory
	function listPoisByCategory(catName){
		var URL = REST_SERVICE_URI+'/listpoisbycategory/'+catName;
		var deferred = $q.defer();
		$http.get(URL)
		.then(
				function(response){
					deferred.resolve(response.data);
				},
				function(errResponse){
					console.error('Error listing POIs');
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;
	}
	
	function listCategories(){
		var URL = REST_SERVICE_URI+'/listcategories';
		var deferred = $q.defer();
		$http.get(URL)
		.then(
				function(response){
					deferred.resolve(response.data);
				},
				function(errResponse){
					console.error('Error listing POIs');
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;
	}
	
	function adUpPoi(p){
		var deferred = $q.defer();
		$http.post(REST_SERVICE_URI+'/poi/adup/', p)
		.then(
				function(response){
					deferred.resolve(response.data);
				},
				function(errResponse){
					console.error('POIService Error!');
					deferred.reject(errResponse);
				}
			);
		return deferred.promise;
	}
	
}]);