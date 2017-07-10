<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>TimeToGo - Home</title>
<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="theme-color" content="#00796B">

<style>
<jsp:directive.include file="../../css/home-style.css"/>

</style>
<link href='https://fonts.googleapis.com/css?family=Muli' rel='stylesheet'>
  
<!-- Angular Material style sheet -->

<link rel="stylesheet"
	href="http://ajax.googleapis.com/ajax/libs/angular_material/1.1.1/angular-material.min.css">

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">

 
<!-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD2NoTGib5RRk9eheJkTuasA1mY5_s27kI&libraries=places" async defer ></script> -->	

</head>

<body>

	<script src="//code.jquery.com/jquery-1.12.4.js"></script>
	<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<!-- Angular Material requires Angular.js Libraries -->
	<script
		src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular.min.js"></script>
	<script
		src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular-animate.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular-route.min.js"></script>
	<script
		src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular-aria.min.js"></script>
	<script
		src="http://ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular-messages.min.js"></script>

	<!-- Angular Material Library -->
	<script
		src="http://ajax.googleapis.com/ajax/libs/angular_material/1.1.0/angular-material.min.js"></script>

	<script><jsp:directive.include file="../../js/app.js"/></script>
	<script><jsp:directive.include file="../../js/service/poi_service.js"/></script>
	<script><jsp:directive.include file="../../js/service/map_service.js"/></script>
	<script><jsp:directive.include file="../../js/controller/poi_controller.js"/></script>

	<div ng-app="isApp" ng-controller="PoiController as ctrl" class="ng-cloak">
		
	<div id="header" class="header">
	<span id="nav-title" style="font-size: 30px; padding-left: 5px; cursor: pointer; color: #E0E0E0;" onclick="openNav()">&#9776;
	</span>
	
	<div id="Sidenav" class="sidenav">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
		<p>Choose a category...</p>
		<c:forEach items="${listCategories}" var="category">
			<a href="#" ng-click='listPoisByCategories("${category.name}")'>${category.name}</a>
		</c:forEach>
	</div>
	
	<h1 id="title">TimeToGo</h1>
			
	<input type="text" id="search_bar" placeholder="Insert your search here" size="28"/>
	
	</div>
	
	<script language="javascript">
	
		function openNav(){
			if (screen.width <= 400)
				document.getElementById("Sidenav").style.width="250px";
			else
				document.getElementById("Sidenav").style.width="330px";
			}

		function closeNav(){
			document.getElementById("Sidenav").style.width="0px";
			}
		
	</script>
		
<div>
	<div id="loading-bar" ng-show="isLoading">
		<md-progress-circular md-diameter="100"></md-progress-circular><br>
		<span id="header-label">Loading...</span>
	</div>
	<div id="map"></div>
	</div>
	
	
	
	
	 <div style="visibility: hidden" id=dialog>
    <div class="md-dialog-container" id="myDialog">
      <md-dialog class="mdDialog">
      <!-- ng-controller="PoiController as ctrl" da aggiungere al div qui sotto se ci sono problemi-->
        <div layout="column" ng-cloak="" class="md-inline-form inputdemoBasicUsage">
        <md-content md-theme="form-head">
       		<span ng-if="tmpPoi.id == 0" text-align="center" style="padding-left: 5px; font-size: 22px;"><b>Save POI</b></span>
        	<span ng-if="tmpPoi.id != 0" text-align="center" style="padding-left: 5px; font-size: 22px;"><b>Edit POI</b></span>  
        </md-content >
        <md-content md-theme="form-body" style="height: auto">
      				<form name="poiForm" ng-submit="ctrl.submit(tmpPoi)" style="padding: 5px;">
						<md-input-container style="display: none;">
        					<label>ID</label>
        					<input ng-model="tmpPoi.id">
      					</md-input-container>

						<md-input-container style="display: none;">
        					<label>ID_Places</label>
        					<input ng-model="tmpPoi.id_places">
      					</md-input-container>

 						<md-input-container>
        					<label>Name</label>
        					<input ng-model="tmpPoi.name" md-maxlength="50" maxlength="50"/>
      					</md-input-container>
      					
        				<div layout-gt-xs="row">
          					<md-input-container class="md-block" flex-gt-xs="">
            					<label>Lat (Disabled)</label>
            					<input ng-model="tmpPoi.lat" disabled="">
         					</md-input-container>

          					<md-input-container class="md-block" flex-gt-xs="">
            					<label>Lng (Disabled)</label>
            					<input ng-model="tmpPoi.lng" disabled="">
         					</md-input-container>
        				</div>

						<md-input-container class="md-block">
          					<label>Description</label>
          					<textarea ng-model="tmpPoi.description" md-maxlength="100" maxlength="100" rows="5" md-select-on-focus="">
          					<span class="highlight"></span><span class="bar"></span>
          					</textarea>
        				</md-input-container>

						<button type="submit" class="btn" style="margin: 20px auto;">
							<span ng-if="tmpPoi.id == 0">Save</span>
							<span ng-if="tmpPoi.id != 0">Edit</span>
						</button>
      				</form>
      				</md-content>
    			</div>

      </md-dialog>
    </div>
  </div>

</div>
</body>
</html>
