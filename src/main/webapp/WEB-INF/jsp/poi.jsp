<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<html>
<head>
<title>Poi Page</title>
<style type="text/css">
.tg {
	border-collapse: collapse;
	border-spacing: 0;
	border-color: #ccc;
}

.tg td {
	font-family: Arial, sans-serif;
	font-size: 14px;
	padding: 10px 5px;
	border-style: solid;
	border-width: 1px;
	overflow: hidden;
	word-break: normal;
	border-color: #ccc;
	color: #333;
	background-color: #fff;
}

.tg th {
	font-family: Arial, sans-serif;
	font-size: 14px;
	font-weight: normal;
	padding: 10px 5px;
	border-style: solid;
	border-width: 1px;
	overflow: hidden;
	word-break: normal;
	border-color: #ccc;
	color: #333;
	background-color: #f0f0f0;
}

.tg .tg-4eph {
	background-color: #f9f9f9
}

.dialogdemoBasicUsage #popupContainer {
	position: relative;
}

.dialogdemoBasicUsage .footer {
	width: 100%;
	text-align: center;
	margin-left: 20px;
}

.dialogdemoBasicUsage .footer, .dialogdemoBasicUsage .footer>code {
	font-size: 0.8em;
	margin-top: 50px;
}

.dialogdemoBasicUsage button {
	width: 115px;
  
}

.dialogdemoBasicUsage div#status {
	color: #c60008;
}

.dialogdemoBasicUsage .dialog-demo-prerendered md-checkbox {
	margin-bottom: 0;
}
</style>

<!-- Angular Material style sheet -->
<link rel="stylesheet"
	href="http://ajax.googleapis.com/ajax/libs/angular_material/1.1.1/angular-material.min.css">

</head>

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

	<script>
		<jsp:directive.include file="../../js/app-dialogs.js"/>
	</script>
	
<body>
	<h1>Add a Poi</h1>

	<div ng-app="MyApp">
		<div ng-controller="dialogCtrl"
			class="md-padding dialogdemoBasicUsage" id="popupContainer"
			ng-cloak="">
			<div class="dialog-demo-content" layout="row" layout-wrap
				layou-margin layout-align="center">
				<md-button class="md-primary md-raised"
					ng-click="showDialog($event)">Add a POI</md-button>
			</div>
			
			<div ng-controller="dialogCtrl">
				<p>{{msg}}</p>
			</div>
			
			<div ng-if="status" id="status">
				<b layout="row" layout-align="center center" class="md-padding">
					{{status}} </b>
			</div>
		</div>
		
		<script type="text/ng-template" id="formdialog.html">
		<div ng-controller="dialogCtrl" layout="column" ng-cloak="" class="md-inline-form inputdemoBasicUsage" ng-app="MyApp">

  			<md-content layout-padding="">
   				<div>
					<p>This is a {{item}}</p>
      				<form name="poiForm">
						<md-input-container style="display: none;">
        					<label>ID</label>
        					<input ng-model="poi.id">
      					</md-input-container>

						<md-input-container style="display: none;">
        					<label>ID_Places</label>
        					<input ng-model="poi.id_places">
      					</md-input-container>

						<md-input-container style="display: none;">
        					<label>Categories</label>
        					<input ng-model="poi.categories">
      					</md-input-container>

 						<md-input-container>
        					<label>Name</label>
        					<input ng-model="poi.name">
      					</md-input-container>

        				<div layout-gt-xs="row">
          					<md-input-container class="md-block" flex-gt-xs="">
            					<label>Lat (Disabled)</label>
            					<input ng-model="poi.lat" disabled="">
         					</md-input-container>

          					<md-input-container class="md-block" flex-gt-xs="">
            					<label>Lng (Disabled)</label>
            					<input ng-model="poi.lng" disabled="">
         					</md-input-container>
        				</div>

						<md-input-container class="md-block">
          					<label>Description</label>
          					<textarea ng-model="user.biography" md-maxlength="150" rows="5" md-select-on-focus=""></textarea>
        				</md-input-container>

						<md-button class="md-primary md-raised" ng-click="">Save</md-button>
      				</form>
    			</div>
  			</md-content>

		</div>
	</script>

	</div>

	<c:url var="addAction" value="/poi/add"></c:url>

	<form:form action="${addAction}" commandName="poi">
		<table>
			<c:if test="${!empty poi.name}">
				<tr>
					<td><form:label path="id">
							<spring:message text="ID" />
						</form:label></td>
					<td><form:input path="id" readonly="true" size="8"
							disabled="true" /> <form:hidden path="id" /></td>
				</tr>
			</c:if>
			<tr>
				<td><form:label path="idPlaces">
						<spring:message text="idPlaces" />
					</form:label></td>
				<td><form:input path="idPlaces" /></td>
			</tr>

			<tr>
				<td><form:label path="name">
						<spring:message text="Name" />
					</form:label></td>
				<td><form:input path="name" /></td>
			</tr>
			<tr>
				<td><form:label path="lat">
						<spring:message text="Lat" />
					</form:label></td>
				<td><form:input path="lat" /></td>
			</tr>
			<tr>
				<td><form:label path="lng">
						<spring:message text="Lng" />
					</form:label></td>
				<td><form:input path="lng" /></td>
			</tr>
			<tr>
				<td><form:label path="description">
						<spring:message text="Description" />
					</form:label></td>
				<td><form:input path="description" /></td>
			</tr>
			<tr>
				<td colspan="2"><c:if test="${!empty poi.name}">
						<input type="submit" value="<spring:message text="Edit Poi"/>" />
					</c:if> <c:if test="${empty poi.name}">
						<input type="submit" value="<spring:message text="Add Poi"/>" />
					</c:if></td>
			</tr>
		</table>
	</form:form>
	<br>
	<h3>Poi List</h3>
	<c:if test="${!empty listPois}">
		<table class="tg">
			<tr>
				<th width="80">Poi ID</th>
				<th width="120">Plces id</th>
				<th width="120">Category names</th>
				<th width="120">Poi Name</th>
				<th width="120">lat</th>
				<th width="120">lng</th>
				<th width="120">Description</th>
				<th width="60">Edit</th>
				<th width="60">Delete</th>
			</tr>
			<c:forEach items="${listPois}" var="poi">
				<tr>
					<td>${poi.id}</td>
					<td>${poi.idPlaces}</td>
					<td><c:forEach items="${poi.categories}" var="category">
							<p>${category.name}</p>
						</c:forEach></td>
					<td>${poi.name}</td>
					<td>${poi.lat}</td>
					<td>${poi.lng}</td>
					<td>${poi.description}</td>
					<td><a href="<c:url value='/edit/${poi.id}' />">Edit</a></td>
					<td><a href="<c:url value='/remove/${poi.id}' />">Delete</a></td>
				</tr>
			</c:forEach>
		</table>
	</c:if>

	
</body>
</html>