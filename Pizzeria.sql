create database Pizzeria;
use Pizzeria;

create table Categories(
Categorie_Id int not null auto_increment primary key,
Name varchar(30)
)
engine= InnoDB
default character set = utf8mb4;

create table Province(
Province_Id int not null auto_increment primary key,
Name varchar(20) not null
)
engine= InnoDB
default character set = utf8mb4;

create table Locality(
Locality_Id int not null auto_increment primary key,
Name varchar(20) not null,
Province_Id int not null,
index Province_Id (Province_Id asc),
constraint fk_Locality_Province
foreign key (Province_Id)
references Province(Province_Id)
on delete no action
on update no action
)
engine= InnoDB
default character set = utf8mb4;

create table Address(
Address_Id int not null auto_increment primary key,
Street varchar(50) not null,
Number int not null,
Floor int not null,
Door int not null,
ZipCode int not null,
Locality_Id int not null,
index Locality_Id(Locality_Id asc),
constraint fk_Direccion_Locality
foreign key(Locality_Id)
references Locality(Locality_Id)
on delete no action
on update no action
)
engine= InnoDB
default character set = utf8mb4;

create table Customer(
Customer_Id int not null auto_increment primary key,
Name varchar(15) not null,
SurName varchar(15) not null,
SurName2 varchar(15) not null,
Phone_Number int not null,
Address_Id int not null,
index Address_Id (Address_Id asc),
constraint fk_Customer_Address
foreign key(Address_Id)
references Address(Address_Id)
on delete cascade
on update cascade
)
engine= InnoDB
default character set = utf8mb4;

create table Employee(
Name varchar(15) not null,
SurName varchar(15) not null,
SurName2 varchar(15) not null,
NIF int not null primary key,
Phone_Number int not null,
WorkStation enum ('cooker','deliverier')
)
engine= InnoDB
default character set = utf8mb4;

create table Stores(
Store_Id int not null auto_increment primary key,
Address_Id int not null,
NIF int not null,
index Address_Id(Address_Id asc),
constraint fk_stores_Address
foreign key(Address_Id)
references address(address_id)
on delete cascade
on update cascade,
index NIF(NIF asc),
constraint fk_Stores_Employee
foreign key(NIF)
references Employee(NIF)
on delete cascade
on update cascade
)
engine= InnoDB
default character set = utf8mb4;


create table Home_Delivery(
HD_Id int not null auto_increment primary key,
NIF int not null,
Date datetime not null,
index NIF (NIF asc),
constraint fk_HD_Employee
foreign key(NIF)
references Employee(NIF)
on delete cascade
on update cascade
)
engine= InnoDB
default character set = utf8mb4;

create table Orders(
Order_Id int not null auto_increment primary key,
Date_Hour DateTime not null,
NIF int not null,
Customer_Id int not null,
HD_Id int,
Store_Id int not null,
index NIF(NIF asc),
constraint fk_Order_employee
foreign key(NIF)
references Employee(NIF)
on delete no action
on update no action,
index Customer_Id(Customer_Id asc),
constraint fk_Orders_Customer
foreign key(Customer_Id)
references Customer(Customer_Id)
on delete no action
on update no action,
index HD_Id(HD_Id asc),
constraint fk_Orders_HD
foreign key(HD_Id)
references Home_Delivery(HD_Id)
on delete cascade
on update cascade,
index Store_Id(Store_Id asc),
constraint fk_Orders_Stores
foreign key(Store_Id)
references Stores(Store_Id)
on delete cascade
on update cascade
)
engine= InnoDB
default character set = utf8mb4;

create table Products(
Product_Id int not null auto_increment primary key,
Name varchar(20) not null,
Description text,
Photo blob ,
Price float not null,
Categorie_Id int,
index Categorie_Id(Categorie_Id asc),
constraint fk_Product_Categorie
foreign key(Categorie_Id)
references Categories(Categorie_Id)
on delete no action
on update no action
)
engine= InnoDB
default character set = utf8mb4;

create table Orders_has_products(
Product_Id int not null ,
Order_Id int not null ,
Quantity int not null,

primary key(Product_Id,Order_id),
index Product_Id(Product_Id asc),
constraint fk_OHP_Product
foreign key(Product_Id)
references Products(Product_Id)
on delete no action
on update no action,
index Order_Id(Order_Id asc),
constraint fk_OHP_Orders
foreign key(Order_Id)
references orders(Order_Id)
on delete cascade
on update cascade
)
engine= InnoDB
default character set = utf8mb4;

insert into province values(1,'barcelona');
insert into province values(2,'madrid');

insert into locality values(1,'cornella',1);
insert into locality values(2,'esplugas',1);

insert into employee values('jorge','ortiz','perez',53631863,933537488,'deliverier');
insert into employee values('yago','rodriguez','perez',53631864,933537488,'deliverier');
insert into employee values('pedro','ortiz','sanchez',53631865,933537486,'cooker');
insert into employee values('antonio','ortiz','perez',53631866,933537487,'cooker');

insert into home_delivery values(1,53631863,'2023-12-18');
insert into home_delivery values(2,53631863,'2023-12-19');
insert into home_delivery values(3,53631864,'2023-12-12');

insert into Categories values(1,'drink');
insert into Categories values(2,'food');

insert into products values(1,'Coke','Refresh',null,2,1);
insert into products values(2,'Hamburger','meat',null,4,2);
insert into products values(3,'Fanta','Refresh',null,2,1);
insert into products values(4,'nachos','snack',null,2,2);


insert into address values(1,'aragon',2,2,3,08030,1);
insert into address values(2,'javier',3,4,3,08030,1);
insert into address values(3,'avenida',2,2,3,08031,2);
insert into address values(4,'calle',3,4,3,08031,2);

insert into stores values(1,1,53631863);
insert into stores values(2,2,53631864);
insert into stores values(3,2,53631863);

insert into customer values(1,'jorge','ortiz','perez',69742888,1);
insert into customer values(2,'pedro','ortiz','perez',69742888,2);
insert into customer values(3,'andres','ortiz','perez',69742888,3);
insert into customer values(4,'ana','ortiz','perez',69742888,4);


insert into orders_has_products values(1,1,4);
insert into orders_has_products values(2,1,3);
insert into orders_has_products values(1,2,2);


insert into orders values(1,'2023-12-18 18:23:24',53631863,1,1,1);
insert into orders values(2,'2023-12-17 18:23:24',53631864,1,2,2);
insert into orders values(3,'2023-12-16 18:23:24',53631863,1,1,3);

select*from products;

Select sum(orders_has_products.quantity),categories.name,locality.name 
from orders_has_products
inner join products
on orders_has_products.product_id = products.product_id
inner join categories
on products.categorie_id = categories.categorie_id
inner join orders
on orders_has_products.order_id = orders.order_id
inner join stores
on orders.store_id = stores.store_id
inner join address
on stores.address_id = address.address_id
inner join locality
on address.locality_id = locality.locality_id
where categories.name = 'drink'
and locality.name = 'cornella';
select order_id,name,surname from orders
inner join employee
on orders.NIF = employee.NIF
where employee.name 
regexp ('jorge');


