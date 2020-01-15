/*MySQL Week-1 Homework02 library Database 

Author: ilhan
Host: Localhost
Database: library*/;

-- Creating Database and before crate check if same database exist, if it is then drop
drop database IF exists library;
create database library;
use library;
-- ---------------------
-- Book Table
-- ---------------------
drop table if exists Book;
create table Book (
	ISBN varchar(20) not null,
	Title varchar(50) not null,
	PublishDate date default null,
	Edition tinyint default null,
	Publisher varchar(20) default null,
    primary key (ISBN)
)
default charset = utf8;
-- Populate Book Table
insert into Book values('ISBN01', 'Everything gonna be Okay!','08.08.19',2,'Apple'),
('ISBN02', 'Something gonna be fine!','20.08.01',2,'Hooray');

-- ---------------------
-- CopyBook Table
-- ---------------------
drop table if exists CopyBook;
create table CopyBook (
	CopyId int not null auto_increment,
    ISBN varchar(20) not null,
	InStock boolean default true,
	IsBooked boolean default false,
	Shelf varchar(2) default null,
	ShelfNo tinyint(20) default null,
    primary key (CopyId),
    constraint CopyBook_ISBNfk foreign key (ISBN) references Book(ISBN)
)
default charset = utf8;

insert into CopyBook(ISBN, Shelf, ShelfNo) values('ISBN01','AA', 2),
('ISBN02', 'AA', 3), ('ISBN02', 'AA', 4), ('ISBN02', 'AA', 5) ;

-- ---------------------
-- Type Table
-- ---------------------
drop table if exists Type;
create table Type (
	TypeId tinyint not null auto_increment,
    `Type` varchar(30) not null,
	PG tinyint default null,
    primary key (TypeId)
)
default charset = utf8;
insert into `Type`(`Type`) values('Horror'), ('Thriller'), ('Comics'),('Kids');
-- ---------------------
-- BookType Table
-- ---------------------
drop table if exists BookType;
create table BookType (
	ISBN varchar(20) not null,
	TypeId tinyint not null,
    primary key (ISBN, TypeId),
    constraint BookType_ISBNfk foreign key (ISBN) references Book(ISBN),
    constraint BookType_TypeIdfk foreign key (TypeId) references `Type`(TypeId)
)
default charset = utf8;

insert into BookType(ISBN, TypeId) values('ISBN01',1), ('ISBN02',2), ('ISBN01',2);

-- ---------------------
-- Author Table
-- ---------------------
drop table if exists Author;
create table Author (
	AuthorId int not null auto_increment,
    `Name` varchar(30) not null,
	`MidName` varchar(30) default null,
	`LastName` varchar(30) not null,
	CountryId smallint default null,
    primary key (AuthorId)
)
default charset = utf8;

insert into Author(`Name`, `LastName`, CountryId) values('Mickey','White', 2),
('John', 'Green', 3), ('Ali', 'Guclu', 4), ('Mohanad', 'Feyz', 5) ;

-- ---------------------
-- BookAuthors Table
-- ---------------------
drop table if exists BookAuthors;
create table BookAuthors (
	ISBN varchar(20) not null,
	AuthorId int not null,
    primary key (ISBN, AuthorId),
    constraint BookAuthors_ISBNfk foreign key (ISBN) references Book(ISBN),
    constraint BookAuthors_AuthorIdfk foreign key (AuthorId) references `Author`(AuthorId)
)
default charset = utf8;

insert into BookAuthors(ISBN, AuthorId) values('ISBN01',1), ('ISBN02',2), ('ISBN01',2);

-- ---------------------
-- Customer Table
-- ---------------------
drop table if exists Customer;
create table Customer (
	`email` varchar(30) not null,
	`Name` varchar(30) not null,
	`MidName` varchar(30) default null,
	`LastName` varchar(30) not null,
    Gender varchar(1) default null,
    BirthDate Date not null,
    BirthPlace varchar(30) default null,
    primary key (email)
)
default charset = utf8;
insert into Customer(`email`,`Name`, `LastName`, BirthDate) values('jasmine@example.com','Jasmine', 'Hayt','1988.05.23'),
('Claudia@example.com','Claudia', 'Zvenger','1988.05.23') ;

-- ---------------------
-- BookBoking Table
-- ---------------------
/*Trigger needed
when a copy of the book is borrowed and start dated recorded, trigger should update CopyBook IsBooked field
Before insert it checks from CopyBook table if the copy is available (is booked or not)
*/

drop table if exists BookBoking;
create table BookBoking (
	BookingId int not null auto_increment,
    `email` varchar(30) not null,
	CopyId int not null,
	StartDate date not null,
	ReturnDate date not null,
	Delay tinyint default null,
    primary key (BookingId),
    constraint BookBoking_emailfk foreign key (`email`) references Customer(`email`),
    constraint BookBoking_CopyIdfk foreign key (CopyId) references CopyBook(CopyId)
)
default charset = utf8;

insert into BookBoking(`email`, CopyId, StartDate, ReturnDate) values('jasmine@example.com',1, '2020.01.15','2020.01.25'),
('jasmine@example.com', 2, '2020.01.15','2020.01.25'),
('Claudia@example.com', 3, '2020.01.15','2020.01.25');
