'use strict';

//TODO spostare il corpo delle funzioni di Callback in MapService e sistemare il menù

App.controller('PoiController', ['$scope', 'PoiService', 'MapService', '$compile', '$mdDialog', '$mdToast',
	function($scope, PoiService, MapService, $compile, $mdDialog, $mdToast){
	var self = this;
	//definizione array di POI e Marker del sistema 
	self.pois = [];
	$scope.markers = [];
	
	//definizione array di POI e Marker di Google quando cercati con searchbox o categoria
	$scope.gmarkers = [];
	
	//definizione array di POI e Marker di Google selezionando un punto sulla mappa
	self.gPoiClick = null;
	$scope.gMarkerClick = null;
	
	//test swipe
	$scope.onSwipeLeft = function(ev) {
	      alert('You swiped left!!');
	    };
	
	self.submit = submit;
	
	$scope.isLoading = true;
		
	//inizializzazione oggetti di google (mappa, infowindow, ecc.) dopo la risoluzione del promise
	MapService.mapsInitialized
	.then(
			function(){
				//instanzia mappa
				var mapOptions ={
						zoom: 11,
						center: new google.maps.LatLng(41.909986, 12.3959123)
				};

				$scope.map = new google.maps.Map(document.getElementById('map'), mapOptions);
				
				console.log('map zoom', $scope.map.getZoom());
				//instanzia il dialog 
				$scope.showDialog = showDialog;
				
				//instanzia infoWindow
				$scope.infoWindow = new google.maps.InfoWindow();
				
				//instanzia SearchBox
				$scope.input = document.getElementById('search_bar');
				$scope.searchBox = new google.maps.places.SearchBox($scope.input);

				//bounds per la barra di ricerca
				$scope.map.addListener('bounds_changed', function() {
					$scope.searchBox.setBounds($scope.map.getBounds())
				});
				
				//listener per l'evento di click (piazza un marker)
				$scope.map.addListener('click', function(e){
					var geocoder = new google.maps.Geocoder;
					geocoder.geocode({'location': e.latLng}, function(results, status){
						//se status è OK, passa i risultati alla funzione che costruirà il POI e piazzerà il marker
						if (status === 'OK')
							poiByClick(results, $scope.map, $scope.infoWindow);
						});
				});

				//listener per l'evento "click su una delle previsioni" che richiama la relativa 
				//funzione di callback definita più sotto
				$scope.searchBox.addListener('places_changed', searchBoxCallback);

				listCategories();
				listAllPois($scope.infoWindow);
				

				//-------------------function test 2------------------
				
				$scope.listPoisByCategories = function gPoisByCategory(category){
					console.log('listing by ',category);
					
					$scope.category = category;
					
					var mapBounds = $scope.map.getBounds();
					var center = mapBounds.getCenter();
					
					var nEast = mapBounds.getNorthEast();
					var point2 = new google.maps.LatLng(nEast.lat(), center.lng());
					
					
					var distance = google.maps.geometry.spherical.computeDistanceBetween(center, point2);
					console.log('distance from center', distance);
					var request = {
							location: center,
							radius: ''+distance,
							types: [category]
					};

					var service = new google.maps.places.PlacesService($scope.map);
					service.nearbySearch(request, nearbyCallback);
					
				}
				
				
				function nearbyCallback(results, status) {
					if (status === google.maps.places.PlacesServiceStatus.OK) {

						var places = [];
						places = results;
						self.gpois = MapService.gPoisBySearch(places, $scope.map);

						if (self.gpois.length != 0){
							//eliminazione vecchi marker di Google
							$scope.gmarkers.forEach(function(marker) {
								marker.setMap(null);
							});
							$scope.gmarkers = [];

							self.gpois.forEach(function(gpoi){
								createMarker(gpoi, $scope.infoWindow);
							});
						}

						listPoisByCategory($scope.category);
					}
				}
				
				$scope.isLoading = false;
			});

	
/*-----------------------fine promise-----------------------*/
	
	
	//funzione di Callback per le ricerche da search box
	function searchBoxCallback() {
		var places = [];
		places = $scope.searchBox.getPlaces();
		
		//altrimenti
		self.gpois = MapService.gPoisBySearch(places, $scope.map);

		if (self.gpois.length != 0){
			//eliminazione vecchi marker di Google
			$scope.gmarkers.forEach(function(marker) {
				marker.setMap(null);
			});
			$scope.gmarkers = [];
			
			var temPoi;
			//verifica che il POI risultato della ricerca non sia presente nel sistema
			var exist = false;
			self.gpois.forEach(function(gpoi){
				self.pois.forEach(function(poi){
					//se lo trova almeno una volta setta exist a true
					if (gpoi.id_places == poi.id_places) {
						exist = true;
						temPoi = poi;
					}
				});
				// !exist significa che non è presente nel sistema e quindi lo deve piazzare sulla mappa
				// altrimenti richiede il POI al sistema e lo disegna sulla mappa
				if(!exist)
					createMarker(gpoi, $scope.infoWindow);
				else
					createMarker(temPoi, $scope.infoWindow);
			});
		}
	}
	
	//-------------------------------------------------------
	//funzione che crea un POI e piazza un marker sull'eventodi click
	function poiByClick(results, map, infoWindow){
		var place = results[0];
		if (place.length = 0)
			return;
		
		//creazione POI di Google con marker e aggiunta all'array
		var cats = MapService.gCategories(place.types);
		var tmpName = place.address_components[1].short_name;
		tmpName = tmpName + ' '+place.address_components[0].short_name+'';
		self.gPoiClick = {id:0, id_places:place.place_id, categories:cats, name:tmpName, lat:place.geometry.location.lat(), lng:place.geometry.location.lng(), description:place.formatted_address};
		
		if ($scope.gMarkerClick != null)
			$scope.gMarkerClick.setMap(null);
		
		createMarker(self.gPoiClick, infoWindow);
		
	}
	
	//-------------------------------------------------------
	//funzione che richiama il Dialog pre-rendered per l'inserimento il salvataggio/modifica dei POI
	function showDialog($event, id, id_places, nameTmp, categories, lat, lng, descriptionTmp){
		var parentEl = angular.element(document.body);
		
		//conversione dei tipi di places in elementi id, nome_categoria congrui ai dati di TimeToGo
		var arrCats = categories.split("-");
		var i = arrCats.length;
	    arrCats.splice(i-1, 1);
		var cats = MapService.gCategories(arrCats);
		var name = unescape(nameTmp);
		var description = unescape(descriptionTmp);
		//creazione di un POI temporaneo per la memorizzazione dei dati
		$scope.tmpPoi = {id: id, idPlaces: id_places, name: name, categories: cats, lat: lat, lng: lng, description: description};		
		
		//apertura dialog
		$mdDialog.show({
			parent: parentEl,
			targetEvent: $event,
			contentElement: '#myDialog',
			locals: {
				tmpPoi: $scope.tmpPoi,
				items: $scope.items
			},
			controller: DialogController,
			clickOutsideToClose: true,
		});
		
		//funzione per la gestione delle variabili nel Dialog
		function DialogController($scope, $mdDialog, tmpPoi, items) {
			$scope.tmpPoi = tmpPoi;
			$scope.items = items;
			$scope.closeDialog = function() {
				$scope.poiForm.$setPristine();
				$mdDialog.hide();
			}
		}
	}
	
	function listAllPois(infoWindow){
		PoiService.listAllPois()
		.then(
				function(d){
					self.pois = [];
					self.pois = d;
					var i;
					for (i=0; i<self.pois.length; i++){
						createMarker(self.pois[i], infoWindow);
						$scope.openInfoWindow = function(e, selectedMarker){
							e.preventDefault();
							google.maps.event.trigger(selectedMarker, 'click');
						}
					}
					console.log('called listAllPois');
				},
				function(errResponse){
					console.error('Error Listing POIs');
				}
			);
	}
	
	function listPoisByCategory(catName){
		PoiService.listPoisByCategory(catName)
		.then(
				function(d){
					var pois = [];
					pois = d;
					
					//eliminazione vecchi marker 
					$scope.markers.forEach(function(marker) {
						marker.setMap(null);
					});
					$scope.markers = [];
					
					for (var i=0; i<pois.length; i++){
						createMarker(pois[i], $scope.infoWindow);
						$scope.openInfoWindow = function(e, selectedMarker){
							e.preventDefault();
							google.maps.event.trigger(selectedMarker, 'click');
						}
					}
					console.log('called pois by category');
				},
				function(errResponse){
					console.error('Error Listing POIs');
				}
			);
	}	
	
	function listCategories(){
		PoiService.listCategories()
		.then(
				function(d){
					var listCat = [];
					listCat = d;
					MapService.setCtgDictionary(listCat);
					console.log('called setDictionary');
				},
				function(errResponse){
					console.error('Error Listing POIs');
				}
			);
	}
	
	
	function adUpPoi(p){
		PoiService.adUpPoi(p)
		.then(
				function(){
					var strToast;
					$scope.poiForm.$setPristine();
					$mdDialog.hide();
					$scope.infoWindow.close();
					
					if (p.id==0){
						strToast = "Nuovo Luogo Salvato!";
						listCategories();
						}
					else
						strToast = "Luogo Modificato!";
					
					 $mdToast.show(
						      $mdToast.simple()
						        .textContent(strToast)
						        .hideDelay(3000)
						    );						
					
					listAllPois($scope.infoWindow);
				},
				function(errResponse){
					if (p.id==0)
						console.error('Error while creating POI!');
					else
						console.error('Error while updating POI!')
				}
			);
			
	}
	
	//funzione che crea e posiziona i Markers sulla mappa
	function createMarker(poi, infoWindow){
		
		var marker = new google.maps.Marker({
			map: $scope.map,
			position: new google.maps.LatLng(poi.lat, poi.lng),
			title: poi.name
		});
		
        
		google.maps.event.addListener(marker, 'click', function(){
          
			var el;
			var contentElement = document.createElement('div');
			contentElement.id = "iw-container";
			
			var name = escape(poi.name);
			console.log("after escaping", name);
			
			var title = "<h2 class='iw-title'>"+ poi.name +"</h2>";
			el = $compile(title)($scope);
		    $scope.$apply();
		    contentElement.appendChild(el[0]);
		    
			var description = '<p class="iw-content">'+ poi.description +'</p>';
			el = $compile(description)($scope);
		    $scope.$apply();
			contentElement.appendChild(el[0]);
						
			var btntxt = 'Edit';
			if (poi.id == 0) 
					btntxt = 'Save';
			
			var cats='';
			for (var i=0; i<poi.categories.length; i++)
				cats = cats + poi.categories[i].name + '-';
			
			var btn = '<button class="btn" style="margin: 20px auto 5px auto;" ng-click="showDialog($event,'+poi.id+', \''+poi.id_places+'\', \'' + name + '\', \'' + cats + '\','+ poi.lat +', '+ poi.lng +',\''+poi.description+'\')"><span>'+btntxt+'</span></button>';
			
		    el = $compile(btn)($scope);
		    $scope.$apply();
			contentElement.appendChild(el[0]);
			
			infoWindow.setContent(contentElement);
			infoWindow.open($scope.map, marker);
		});
		
		//preparazione dell'InfoWindow prima della visualizzazione
		google.maps.event.addListener(infoWindow,'domready', function() {
			var iwOuter = $('.gm-style-iw');
						
			var iwBackground = iwOuter.prev();
			
			// Removes background shadow DIV
			iwBackground.children(':nth-child(2)').css({'display' : 'none'});

			// Removes white background DIV
			iwBackground.children(':nth-child(4)').css({'display' : 'none'});

			// Changes the desired tail shadow color.
			iwBackground.children(':nth-child(3)').find('div').children().css({'background-color': ' #B2DFDB', 'z-index' : '1'});

			// Reference to the div that groups the close button elements.
			var iwCloseBtn = iwOuter.next();

			// Apply the desired effect to the close button
			iwCloseBtn.css({opacity: '1', right: '20px', top: '3px', border: '7px solid #009688', 'border-radius': '13px', 'box-shadow': '0 0 5px #3990B9'});

			// If the content of infowindow not exceed the set maximum height, then the gradient is removed.
			if($('.iw-content').height() < 140){
				$('.iw-bottom-gradient').css({display: 'none'});
			}

			// The API automatically applies 0.7 opacity to the button after the mouseout event. This function reverses this event to the desired value.
			iwCloseBtn.mouseout(function(){
				$(this).css({opacity: '1'});
			});
		});
		
		var str = '\u2022';
		
		if (poi.id == 0){
			marker.setIcon("https://mts.googleapis.com/vt/icon/name=icons/spotlight/spotlight-waypoint-b.png&text="+str+"&psize=35&font=fonts/Roboto-Regular.ttf&color=ff333333&ax=44&ay=48&scale=1");
			if (poi.categories[0].name == 'street_address' || poi.categories[0].name == 'route'){
				$scope.gMarkerClick = marker;
				console.log('gpoiclick after insert', $scope.gMarkerClick.title);
				google.maps.event.trigger($scope.gMarkerClick, 'click', {
					});
				}
				
			else{
				$scope.gmarkers.push(marker);
				console.log('gpois after insert', $scope.gmarkers.length);
				}
		}
			
		else{
			marker.setIcon("https://mts.googleapis.com/vt/icon/name=icons/spotlight/spotlight-waypoint-a.png&text="+str+"&psize=35&font=fonts/Roboto-Regular.ttf&color=ff333333&ax=44&ay=48&scale=1");
			$scope.markers.push(marker);
		}
			
	}

	function submit(poi){
		
		if (poi.id != 0){
			adUpPoi(poi);
			console.log('Updating POI', poi.id);
		}
		else{
			adUpPoi(poi);
			console.log('Creating POI', poi.id);
		}
	}
	
}]).config(function($mdThemingProvider) {

    // Configure a theme for the form-dialog 
	$mdThemingProvider.definePalette('colorPrimary', {
		'50':	'E0F2F1',
		'100':	'B2DFDB', //PrimaryLight
		'200':	'80CBC4',
		'300':	'4DB6AC',
		'400':	'26A69A',
		'500':	'009688', //Primary
		'600':	'00897B',
		'700':	'00796B', //PrimaryDark
		'800':	'00695C',
		'900':	'004D40',
		'A100': 'A7FFEB',
	    'A200': '64FFDA',
	    'A400': '1DE9B6',
	    'A700': '00BFA5',
	});
	
	$mdThemingProvider.definePalette('colorAccent', {
		'50':	'FFF3E0',
		'100':	'FFE0B2', 
		'200':	'FFCC80',
		'300':	'FFB74D',
		'400':	'FFA726',
		'500':	'FF9800', 
		'600':	'FB8C00',
		'700':	'F57C00', 
		'800':	'EF6C00',
		'900':	'E65100',
		'A100': 'FFD180',
	    'A200': 'FFAB40',
	    'A400': 'FF9100',
	    'A700': 'FF6D00', //Accent
	});

	  $mdThemingProvider.theme('form-head','default')
	    .primaryPalette('colorPrimary', {
	    	'default': '500', //colorPrimary
	    	'hue-1': '100', //colorPrimaryLight
	    	'hue-2': '700', //colorPrimaryDark
	    })
	    .backgroundPalette('colorPrimary', {
	    	'default': '500',
	    });
	  
	  $mdThemingProvider.theme('form-body','default')
	    .primaryPalette('colorAccent', {
	    	'default': 'A700', 
	    })
	    .backgroundPalette('colorPrimary', {
	    	'default': '100',
	    });
		
  });

