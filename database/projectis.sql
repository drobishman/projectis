DROP DATABASE IF EXISTS projectis;
CREATE DATABASE projectis;
USE projectis;

CREATE TABLE users (
id int(6) NOT NULL AUTO_INCREMENT, 
login varchar(50) NOT NULL, 
password varchar(20) NOT NULL, 
firstname char(20) NOT NULL, 
lastname char(20) NOT NULL, 
phone double NOT NULL, 
email char(50) NOT NULL, 
agent_id int(6), 
PRIMARY KEY (id),
FOREIGN KEY (agent_id) REFERENCES users(id) ON DELETE SET NULL
);
CREATE TABLE roles (
id int(6) NOT NULL AUTO_INCREMENT, 
role char(20) NOT NULL, 
PRIMARY KEY (id)
);
CREATE TABLE user_roles (
user_id int(6) NOT NULL, 
role_id int(6) NOT NULL,
FOREIGN KEY (user_id) REFERENCES users(id),
FOREIGN KEY (role_id)  REFERENCES roles(id)
);

CREATE TABLE category (
id int(11) unsigned NOT NULL AUTO_INCREMENT,
name varchar(50)NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE poi (
id int(11) unsigned NOT NULL AUTO_INCREMENT,
id_places varchar(100),
name varchar(50) NOT NULL,
lat double NOT NULL,
lng double NOT NULL,
description varchar(100),
PRIMARY KEY(id)
);

CREATE TABLE poi_category(
poi_id int(11) unsigned NOT NULL,
category_id int(11) unsigned NOT NULL,
FOREIGN KEY(category_id) REFERENCES category(id),
FOREIGN KEY(poi_id) REFERENCES poi(id)
);


INSERT INTO category VALUES (null, "accounting");
INSERT INTO category VALUES (null, "airport");
INSERT INTO category VALUES (null, "amusement_park");
INSERT INTO category VALUES (null, "aquarium");
INSERT INTO category VALUES (null, "art_gallery");
INSERT INTO category VALUES (null, "atm");
INSERT INTO category VALUES (null, "bakery");
INSERT INTO category VALUES (null, "bank");
INSERT INTO category VALUES (null, "bar");
INSERT INTO category VALUES (null, "beauty_salon");
INSERT INTO category VALUES (null, "bicycle_store");
INSERT INTO category VALUES (null, "book_store");
INSERT INTO category VALUES (null, "bowling_alley");
INSERT INTO category VALUES (null, "bus_station");
INSERT INTO category VALUES (null, "cafe");
INSERT INTO category VALUES (null, "campground");
INSERT INTO category VALUES (null, "car_dealer");
INSERT INTO category VALUES (null, "car_rental");
INSERT INTO category VALUES (null, "car_repair");
INSERT INTO category VALUES (null, "car_wash");
INSERT INTO category VALUES (null, "casino");
INSERT INTO category VALUES (null, "cemetery");
INSERT INTO category VALUES (null, "church");
INSERT INTO category VALUES (null, "city_hall");
INSERT INTO category VALUES (null, "clothing_store");
INSERT INTO category VALUES (null, "convenience_store");
INSERT INTO category VALUES (null, "courthouse");
INSERT INTO category VALUES (null, "dentist");
INSERT INTO category VALUES (null, "department_store");
INSERT INTO category VALUES (null, "doctor");
INSERT INTO category VALUES (null, "electrician");
INSERT INTO category VALUES (null, "electronics_store");
INSERT INTO category VALUES (null, "embassy");
INSERT INTO category VALUES (null, "establishment");
INSERT INTO category VALUES (null, "finance");
INSERT INTO category VALUES (null, "fire_station");
INSERT INTO category VALUES (null, "florist");
INSERT INTO category VALUES (null, "food");
INSERT INTO category VALUES (null, "funeral_home");
INSERT INTO category VALUES (null, "furniture_store");
INSERT INTO category VALUES (null, "gas_station");
INSERT INTO category VALUES (null, "general_contractor");
INSERT INTO category VALUES (null, "grocery_or_supermarket");
INSERT INTO category VALUES (null, "gym");
INSERT INTO category VALUES (null, "hair_care");
INSERT INTO category VALUES (null, "hardware_store");
INSERT INTO category VALUES (null, "health");
INSERT INTO category VALUES (null, "hindu_temple");
INSERT INTO category VALUES (null, "home_goods_store");
INSERT INTO category VALUES (null, "hospital");
INSERT INTO category VALUES (null, "insurance_agency");
INSERT INTO category VALUES (null, "jewelry_store");
INSERT INTO category VALUES (null, "laundry");
INSERT INTO category VALUES (null, "lawyer");
INSERT INTO category VALUES (null, "library");
INSERT INTO category VALUES (null, "liquor_store");
INSERT INTO category VALUES (null, "local_government_office");
INSERT INTO category VALUES (null, "locksmith");
INSERT INTO category VALUES (null, "lodging");
INSERT INTO category VALUES (null, "meal_delivery");
INSERT INTO category VALUES (null, "meal_takeaway");
INSERT INTO category VALUES (null, "mosque");
INSERT INTO category VALUES (null, "movie_rental");
INSERT INTO category VALUES (null, "movie_theater");
INSERT INTO category VALUES (null, "moving_company");
INSERT INTO category VALUES (null, "museum");
INSERT INTO category VALUES (null, "night_club");
INSERT INTO category VALUES (null, "painter");
INSERT INTO category VALUES (null, "park");
INSERT INTO category VALUES (null, "parking");
INSERT INTO category VALUES (null, "pet_store");
INSERT INTO category VALUES (null, "pharmacy");
INSERT INTO category VALUES (null, "physiotherapist");
INSERT INTO category VALUES (null, "place_of_worship");
INSERT INTO category VALUES (null, "plumber");
INSERT INTO category VALUES (null, "police");
INSERT INTO category VALUES (null, "post_office");
INSERT INTO category VALUES (null, "real_estate_agency");
INSERT INTO category VALUES (null, "restaurant");
INSERT INTO category VALUES (null, "roofing_contractor");
INSERT INTO category VALUES (null, "rv_park");
INSERT INTO category VALUES (null, "school");
INSERT INTO category VALUES (null, "shoe_store");
INSERT INTO category VALUES (null, "shopping_mall");
INSERT INTO category VALUES (null, "spa");
INSERT INTO category VALUES (null, "stadium");
INSERT INTO category VALUES (null, "storage");
INSERT INTO category VALUES (null, "store");
INSERT INTO category VALUES (null, "subway_station");
INSERT INTO category VALUES (null, "synagogue");
INSERT INTO category VALUES (null, "taxi_stand");
INSERT INTO category VALUES (null, "train_station");
INSERT INTO category VALUES (null, "transit_station");
INSERT INTO category VALUES (null, "travel_agency");
INSERT INTO category VALUES (null, "university");
INSERT INTO category VALUES (null, "veterinary_care");
INSERT INTO category VALUES (null, "zoo");


INSERT INTO poi VALUES (null, "place1", "SOGENE", 41.854431,12.605243,"ciao");
INSERT INTO poi VALUES (null, "place4", "Anagnina", 41.8426285,12.5842282,"metro");
INSERT INTO poi VALUES (null, "place5", "La Romanina", 41.850973,12.5967737,"Centro Commerciale");

INSERT INTO poi_category VALUES (1,1);
INSERT INTO poi_category VALUES (2,2);
INSERT INTO poi_category VALUES (3,2);
insert into roles values (null,'administrator');
insert into roles values (null,'agent');
insert into roles values (null,'user');
insert into users values(null,'adrian.drob88@gmail.com','ciao','adrian','drob',123456789,'adrian.drob88@gmail.com',null);
insert into users values(null,'ameluzio90@gmail.com','ciao','alessandro','meluzio',123456789,'ameluzio89@gmail.com',1);
insert into users values(null,'andrea.bei@capgemini.com','andrea','andrea','bei',123456789,'andrea.bei@capgemini.com',1);
insert into user_roles values (1,1);
insert into user_roles values (2,2);
insert into user_roles values (3,1);