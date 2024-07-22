create database Joins;

use joins;

----users table

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    UserName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE
);

insert into users(UserName,Email) values('Raja','raja@gmail.com'),('Remo','remo@gmail.com'),('Priya','priya@gmail.com'),('Savitha','savitha@gmail.com'),('Kamal','kamal@gmail.com');

SELECT * FROM users
WHERE UserName NOT LIKE 'R%';


select* from Users;
----orders table

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    OrderDate DATE NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    UserID INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

INSERT INTO Orders (OrderDate, Amount, UserID)
VALUES 
('2024-07-22', 25000, 1),
('2024-07-23', 15000, 3),('2024-07-25', 2500, 1),
('2024-07-27', 150900, 1),('2024-07-26', 45000, 3),
('2024-07-28', 17000, 2),('2024-07-22', 95000, 1),
('2024-07-23', 150, 4),('2024-07-22', 2500, 5),
('2024-07-23', 15000, 5),('2024-07-22', 5000, 2),
('2024-07-23', 1500, 3);

drop table orders;

select*from Orders;

update orders set amount=35000 where orderID =3;

delete from orders where orderId=12;

select top 10 orderid from orders where amount>95000;

select top 10 * from orders order by amount desc;

DBCC CHECKIDENT ('Orders', NORESEED);

--- aggregate functions
select COUNT(OrderID) as Total_Orders from Orders where amount>10000;

select AVG(amount) as Income from Orders where amount>10000;

select sum(amount) as Income from Orders where amount>10000 and amount<15000;

select max(amount) from orders;

select min(amount) from orders;

--order by

select orderid,orderdate,userid from orders order by orderdate;

--group by having

SELECT UserID, SUM(Amount) AS TotalAmount FROM Orders GROUP BY UserID
HAVING SUM(Amount) > 20000;

select distinct(orderdate) as oneorder from orders;

---joins

--inner join
--Combines rows from two tables based on a common field.
select u.username,u.Email,o.orderId,o.orderdate,o.amount from orders o inner join users u on u.UserID=o.UserID;
--left join

---it will select the matched records from the right table and  the remaining record from the left table

select u.username,u.Email,o.orderId,o.orderdate,o.amount  from orders o left join users u on u.UserID=o.UserID;

--right join

---it will select the matched records from the left table and  the remaining record from the right table

select u.username,u.Email,o.orderId,o.orderdate,o.amount from orders o right join users u on u.UserID=o.UserID;

--full join

---it will select the matched records from the right table or from the left table

select u.username,u.Email,o.orderId,o.orderdate,o.amount  from orders o full join users u on u.UserID=o.UserID;


