/*MySQL Week-2 Homework04 TravelAgency Database 

Author: ilhan
Host: Localhost
Date: 25-Jan-2020
Database: agency*/;

-- Creating Database and before crate check if same database exist, if it is then drop
drop database IF exists agency;
create database agency;
use agency;
-- ---------------------
-- Customer Table
-- ---------------------
drop table if exists Customer;
create table Customer (
	userName varchar(30) not null,
	firstName Varchar(30) not null,
	surName Varchar(30) not null,
	gender Varchar(1),
	birthDate Date,
	birthPlace Varchar(30),
	countryOrigin Varchar(30),
    primary key (userName)
)
default charset = utf8;
-- Populate Customer Table
insert into Customer values('user01', 'Jamie','White','m','83.08.01','New Jersey', 'United States'),
('user02', 'Jasmine','Black','m','83.05.01','New Jersey', 'United States'),
('user03', 'Ali','Beyaz','f','82.03.01','New Jersey', 'Turkey'),
('user04', 'Hale','Kara','m','83.11.01','New Jersey', 'Turkey'),
('user05', 'Robin','Wit','f','80.08.01','New Jersey', 'Belgium'),
('user06', 'Nathalie','Zwarte','m','85.02.01','New Jersey', 'Belgium'),
('user07', 'Ruby','Hooy','f','83.01.01','New Jersey', 'Spain'),
('user08', 'Borja','Coach','m','81.06.01','Madrid', 'Spain'),
('user09', 'Fransua','Bonjour','m','83.08.01','New Jersey', 'France'),
('user10', 'Elen','Voala','f','88.09.01','New Jersey', 'France');

-- ---------------------
-- CustomerPassword Table
-- ---------------------
drop table if exists CustomerPassword;
create table CustomerPassword (
	passId Int not null auto_increment,
	userName varchar(30) not null,
	passPhrase Varchar(400) not null,
	dateChanged Date not null,
	passActive Boolean default false,
    primary key (passId),
    constraint CustomerPassword_userNamefk foreign key (userName) references Customer(userName)
)
default charset = utf8;

insert into CustomerPassword(userName, passPhrase, dateChanged, passActive) 
values ('user02', 'JasmineBlack','83.05.01', true),
('user03', 'AliBeyaz','82.03.01',true),
('user04', 'HaleKara','83.11.01',true),
('user05', 'RobinWit','80.08.01',true),
('user06', 'NathalieZwarte','85.02.01',true),
('user07', 'RubyHooy','83.01.01',true),
('user08', 'BorjaCoach','81.06.01',true),
('user09', 'FransuaBonjour','83.08.01',true),
('user10', 'ElenVoala','88.09.01',true),
('user01', 'JamieWhite','83.05.01', true);

-- ---------------------
-- Contact Table
-- ---------------------
drop table if exists Contact;
create table Contact (
	userName varchar(30) not null,
	emailMain varchar(50) not null,
	phoneMain varchar(12) not null,
	emailSlave varchar(50),
	phoneSlave varchar(12),
    primary key (userName, emailMain),
    constraint Contact_userNamefk foreign key (userName) references Customer(userName)
)
default charset = utf8;
insert into Contact(userName, emailMain, phoneMain)
values ('user01', 'jamie@example.com','123456789'),
('user02', 'jasmine@example.com','123456789'),
('user03', 'ali@example.com','123456789'),
('user04', 'hale@example.com','123456789'),
('user05', 'robin@example.com','123456789'),
('user06', 'nathalie@example.com','123456789'),
('user07', 'ruby@example.com','123456789'),
('user08', 'borja@example.com','123456789'),
('user09', 'fransua@example.com','123456789'),
('user10', 'elen@example.com','123456789');

-- ---------------------
-- Country Table
-- ---------------------
drop table if exists Country;
create table Country (
	countryCode varchar(3) not null,
	country Varchar(55) not null,
	region Varchar(30),
	primary key (countryCode)
)
default charset = utf8;

insert into Country
select c.Code, c.Name,c.Region  from world.country c;

-- ---------------------
-- City Table
-- ---------------------
drop table if exists City;
create table City (
	cityId int not null,
    `Name` varchar(35) not null,
	countryCode varchar(3) not null,
    primary key (cityId),
	constraint City_countryCodefk foreign key (countryCode) references Country(countryCode)
)
default charset = utf8;

insert into City
select ci.ID, ci.Name,ci.CountryCode from world.city ci;

-- ---------------------
-- Package Table
-- ---------------------
drop table if exists Package;
create table Package (
	packageId Int not null auto_increment,
	packageName Varchar(30) not null,
	duration tinyint,
    primary key (packageId)
)
default charset = utf8;

insert into Package (packageName, duration)
values('superEurope01',7), ('superEurope02',5), ('superEurope03',5),
('allAboutParis',3), ('PremiumEuropa',10), ('USADream',15),
('AllBelgic',7), ('Brussels',2), ('SpainWind',10);

-- ---------------------
-- Destination Table
-- ---------------------
drop table if exists Destination;
create table Destination (
	packageId Int not null,
    cityId int not null,
    primary key (packageId, cityId),
	constraint Destination_packageIdfk foreign key (packageId) references Package(packageId),
    constraint Destination_cityIdfk foreign key (cityId) references City(cityId)
)
default charset = utf8;

-- insert into Destination
-- values(1,); /*Later on polpulate data here.*/

-- ---------------------
-- Trip Table
-- ---------------------
drop table if exists Trip;
create table Trip (
	tripId Int not null auto_increment,
	userName varchar(30) not null,
	packageId int not null,
	startDate Date not null,
	endDate Date not null,
	price int,

    primary key (tripId),
	constraint Trip_packageIdfk foreign key (packageId) references Package(packageId),
    constraint Trip_userNamefk foreign key (userName) references Customer(userName)
)
default charset = utf8;

-- ---------------------
-- Hotel Table
-- ---------------------
drop table if exists Hotel;
create table Hotel (
	hotelId Int not null auto_increment,
	cityId int not null,
	stars tinyint,
	rooms varchar(30),

    primary key (hotelId),
	constraint Hotel_cityIdfk foreign key (cityId) references City(cityId)
)
default charset = utf8;

-- ---------------------
-- Reservation Table
-- ---------------------
drop table if exists Reservation;
create table Reservation (
	reservationId Int not null auto_increment,
	tripId Int not null,
	hotelId Int not null,
	startDate Date not null,
	endDate Date not null,
	-- Price Int
    primary key (reservationId),
	constraint Reservation_tripIdfk foreign key (tripId) references Trip(tripId),
    constraint Reservation_hotelIdfk foreign key (hotelId) references Hotel(hotelId)
)
default charset = utf8;

-- ---------------------
-- Payment Table
-- ---------------------
drop table if exists Payment;
create table Payment (
	paymentId Int not null auto_increment,
	tripId Int not null,
	paid boolean default false,
	
    primary key (paymentId),
	constraint Payment_tripIdfk foreign key (tripId) references Trip(tripId)
)
default charset = utf8;
