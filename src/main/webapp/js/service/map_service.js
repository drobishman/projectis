'use strict';

App.factory('MapService', function($window, $q){
	
	self.ctgDcitionary = [];
	//oggetto per caricare la mappa in defer
	var mapsDefer = $q.defer();
	
	//URL per la mappa async da Google che accetta una funzione di Callback
	var asyncUrl = 'https://maps.googleapis.com/maps/api/js?key=AIzaSyBAXYTEfUq2B6V1WkRcLXtEDWXgWsEcfAQ&libraries=geometry,places,geocoder&callback=';
	
	//caricamento async
	var asyncLoad = function(asyncUrl, callbackName){
		var script = document.createElement('script');
		script.src = asyncUrl + callbackName;
		$window.document.body.appendChild(script);
	};
	
	//funzione callback - "risolve" il promise dopo che la mappa è stata caricata con successo
	$window.googleMapsInitialized = function(){
		mapsDefer.resolve();
		}
	
	//caricamento google maps
	asyncLoad(asyncUrl,'googleMapsInitialized');
	
	//funzione che setta il dizionario necessario alla funzione gPoiCategories 
	function setCtgDictionary(listCat){
		var i = 0;
		var ctgName;
		for(i=0; i < listCat.length; i++){
			ctgName = listCat[i].name;
			self.ctgDcitionary[ctgName] = listCat[i].id;
		}
			
	}
	
	
	//funzione che prende in input i tipi dei luoghi di places e li "traduce" nella coppia di valori (id, category)
	//presenti nel nostro DB
	function gCategories(types){
		
		var cats = [];
		var id = 0;
		var ctgID;
		var ctgDictionary = self.ctgDictionary;
		
		for (var i=0; i<types.length; i++){
			ctgID = self.ctgDcitionary[types[i]];			
			cats[i] = {id: ctgID, name: types[i]};
		}
		
		return cats;
	}
	
	//funzione che piazza marker sulla mappa in base ai risultatidella ricerca tramite search box
	function gPoisBySearch(places, map){
		
		//se la ricerca non ha prodotto risultati, chiude la funzione
		if (places.length == 0)
			return;
		
		var gpois = [];

		//disegno sulla mappa tutti i POI ottenuti con la Search Box
		var bounds = new google.maps.LatLngBounds();
		places.forEach(function(place) {
			//controlla se il place ha geometry per il deisgno sulla mappa
			if (!place.geometry) {
				alert("Luogo senza geometry");
				return;
			}

			//creazione POI di Google con marker e aggiunta all'array
			var cats = gCategories(place.types);
			
			var tmpDescription = place.formatted_address != null ? place.formatted_address : '';
			
			//creaazione del POI di Google come nel nostro sistema
			var gpoi = {id:0, id_places:place.place_id, categories:cats, name:place.name, lat:place.geometry.location.lat(), lng:place.geometry.location.lng(), description:tmpDescription}
			gpois.push(gpoi);

			if (place.geometry.viewport) {
				bounds.union(place.geometry.viewport);
			} else {
				bounds.extend(place.geometry.location);
			}

		});
		map.fitBounds(bounds);
		console.log('pois by search', gpois.length);
		
		return gpois;
	}
	
	//funziona che ritorna un array dei POI di Google vicini alla posizione dell'utente
	/*
	function listGPoiByCategory(map, category){
		var gpois = [];
		
		var rome = new google.maps.LatLng(41.909986, 12.3959123);
		
		var request = {
			    location: rome,
			    radius: '500',
			    types: ['store']
			  };
		
		var placeService = new google.maps.places.PlacesService(map);
		placeService.nearbySearch(request, function(results, status){
			if (status === google.maps.places.PlacesServiceStatus.OK)
				gpois = results;				
		});
		return gpois; 
	}
	*/
		
	return{
		mapsInitialized : mapsDefer.promise,
		gCategories : gCategories,
		//gPoisByCategory : listGPoiByCategory,
		gPoisBySearch: gPoisBySearch,
		setCtgDictionary: setCtgDictionary,
	};
	
	
});