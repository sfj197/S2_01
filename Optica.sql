create database optica character set utf8mb4;
use optica;

create table customer (
Customer_Id int not null auto_increment primary key,
name_ varchar(30) not null,
SurName varchar(50) not null,
SurName2 varchar(50) not null,
Phone_Number int not null,
Email varchar(100) not null,
Registation_date date not null,
Recom_Customer_id int,
index Recom_Customer_id(Recom_Customer_id asc),

constraint fk_Customer_Customer1
foreign key(Recom_Customer_id)
references customer(Customer_Id)
on delete cascade
on update cascade
)
engine = InnoDB
default character set = utf8mb4;

create table Address (
Address_Id int not null auto_increment primary key,
Street varchar(100) not null,
Number_ int not null,
Floor int not null,
City varchar(100) not null,
Zip_Code int not null,
Customer_Id int not null,
index Customer_Id(Customer_id asc),

constraint fk_Address_Customer1
foreign key(Customer_Id) references customer(Customer_Id)
on delete cascade
on update cascade
)
engine= InnoDB
default character set = utf8mb4;

create table supplier (
name varchar(50) not null,
Phone_Number int not null,
Fax int,
NIF int not null primary key,
Address_Id int not null,
unique index NIF_Unique (NIF asc),
index Address_Id (Address_Id asc),
constraint fk_Supplier_Address
foreign key(Address_Id) references address(Address_Id) 
on delete cascade
on update cascade
)
engine = InnoDB
default character set  = utf8mb4;

create table Brand(
Brand_Id int  not null auto_increment primary key,
Name varchar(20) not null,
NIF int not null,
index NIF(NIF asc),

constraint fk_Brand_Supplier
foreign key (NIF) references Supplier (NIF)
on delete cascade
on update cascade
)
engine= InnoDB
default character set = utf8mb4;


create table Glasses(
Glasses_Id int not null auto_increment primary key,
Brand varchar(20) not null,
Graduation float not null,
Frame enum('floating','pasta','metal'),
Color_Frame varchar(10) not null,
Color_Lens varchar(20) not null,
Price float not null,
Brand_Id int not null,
index Brand_Id(Brand_Id asc),
constraint fk_Glasses_Brand
foreign key(Brand_Id) references Brand(Brand_Id)
on delete cascade
on update cascade
)
engine = InnoDB
default character set = utf8mb4;


create table Employee(
Employee_Id int not null auto_increment primary key,
Name varchar(60) not null,
SurName varchar(60) not null,
SurName2 varchar(60) not null
)
engine = InnoDB
default character set = utf8mb4;

create table Orders(
Order_Id int not null auto_increment primary key,
Sales_Check date not null,
Employee_Id int not null,
Customer_Id int not null,
Glasses_Id int not null,

index Employee_Id(Employee_Id asc),
index Customer_Id(Customer_Id asc),
index Glasses_Id(Glasses_Id asc),

constraint fk_Order_Employee
foreign key(Employee_Id) references Employee(Employee_Id)
on delete cascade
on update cascade,

constraint fk_Oder_Customer
foreign key(Customer_Id) references Customer(Customer_Id)
on delete cascade
on update cascade,

constraint fk_Order_Glasses
foreign key(Glasses_Id) references Glasses(Glasses_Id)
on delete cascade
on update cascade
)
engine = InnoDB
default character set = utf8mb4;

insert into customer values(1,'Andres','Perez','Ortiz',697431001,'Andres@gmail.com','2020-01-02',1);
insert into customer values(2,'Antonio','Yague','Perez',697431001,'Antonio@gmail.com','2020-01-02',2);
insert into customer values(3,'Ana','Felip','Mellado',697431001,'Ana@gmail.com','2020-01-02',3);

insert into Address values(1,'Orista',24,2,'Barcelona',08033,1);
insert into Address values(2,'Aragon',25,2,'Madrid',08034,2);
insert into Address values(3,'Valecia',26,2,'Barcelona',08030,3);

insert into supplier values('Ray Ban',123456,123456,43214,1);
insert into supplier values('Math',123456,123456,43215,2);
insert into supplier values('Adidas',123456,123456,43216,3);

insert into Brand values(1,'Ray Ban',43214);
insert into Brand values(2,'Math',43215);
insert into Brand values(3,'Adidas',43214);

insert into Glasses values(1,'Ray ban',2.5,'pasta','red','grey',120,1);
insert into Glasses values(2,"Adidas",1.75,'metal','green','grey',130,2);
insert into Glasses values(3,"nike",1.2,'pasta','yellow','grey',100,3);

insert into Employee values(1,'Jorge','Mellado','Garcia');
insert into Employee values(2,'Pedro','Ortiz','Nieto');
insert into Employee values(3,'Silvia','Dania','Perez');

insert into Orders values(1,'2019-02-10',1,1,2);
insert into Orders values(2,'2020-03-20',2,2,2);
insert into Orders values(3,'2023-06-15',1,1,3);

select * from Orders
 where Customer_Id = 1 and Sales_Check between '2019-02-10' and '2023-06-15';
 
select glasses.* , employee.Employee_Id from orders
inner join employee
on orders.Employee_Id=employee.Employee_Id
inner join glasses
on glasses.Glasses_Id=orders.Glasses_Id
where employee.name ='jorge'
and Sales_Check between '2019-02-10' and '2020-02-10';

select supplier.name from orders
inner join glasses
on orders.Glasses_Id = glasses.Glasses_Id
inner join brand
on glasses.Brand_Id = brand.Brand_Id
inner join supplier
on brand.NIF = supplier.NIF;