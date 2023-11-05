.open restaurant.db
.mode column

-- create table customers
CREATE TABLE IF NOT EXISTS customers 
  (cust_id INTEGER PRIMARY KEY, 
  cust_name varchar, 
  cust_city varchar,
  cust_tel varchar);
INSERT OR REPLACE INTO customers (cust_id, cust_name, cust_city, cust_tel) VALUES
(1, 'John','New York', '123-456-7890'),
(2, 'Mary','Los Angeles','987-654-3210'),
(3, 'Peter','Chicago', '543-210-9876'),
(4, 'Susan','Houston', '765-432-1098'),
(5, 'David','Phoenix', '901-234-5678'),
(6, 'Jane','New York', '876-543-2109'),
(7, 'Michael','Los Angeles', '654-321-0987'),
(8, 'Sarah','Chicago', '432-109-8765'),
(9, 'William','Houston', '321-098-7654'),
(10,'Elizabeth','Phoenix', '210-987-6543');
ALTER TABLE customers RENAME COLUMN cust_id TO c_id;

--create table menus
CREATE TABLE IF NOT EXISTS menus 
  (menus_id INTEGER PRIMARY KEY, 
  menus_name varchar, 
  menus_price float);
INSERT OR IGNORE INTO menus (menus_id,menus_name, menus_price) VALUES
(1, "Pizza", 15.00),
(2, "Pasta", 10.00),
(3, "Salad",5.00 ),
(4, "Sandwich", 10.00),
(5, "Burger",12.00),
(6, "Tacos", 8.00),
(7, "Ice cream", 3.00);

--create table transaction
CREATE TABLE IF NOT EXISTS transac 
  (transac_id INTEGER PRIMARY KEY, 
  s_id int, 
  cust_id int,
  menu_id int,
  tips int,
  paying_method varchar,
  paying_date date);
INSERT OR REPLACE INTO transac (transac_id, s_id, cust_id, menu_id, tips, paying_method, paying_date) VALUES
(1,1,3,3,5 ,"mobile banking",2023-01-01),
(2,2,4,5,10,"credit card",2023-01-15),
(3,4,5,2,0,"cash" ,2023-02-02),
(4,2,1,4,2,"mobile banking" , 2023-03-08),
(5,4,2,7,1,"credit card",2023-04-14),
(6,3,5,6,5,"mobile banking" , 2023-05-01),
(7,5,1,1,10,"credit card",2023-05-17),
(8,4,2,2,0,"cash"  ,2023-01-03),
(9,1,3,5,2,"mobile banking" , 2023-01-20),
(10,3,4,3,1,"credit card",2023-02-05),
(11,3,5,7,5,"mobile banking" , 2023-03-10),
(12,1,1,6,10 ,"credit card",2023-04-17),
(13,2,2,1,0,"cash"  ,2023-05-06),
(14,5,3,4,2,"mobile banking" , 2023-05-19),
(15,5,4,5,1,"credit card",2023-01-05),
(16,2,5,2,5,"mobile banking" , 2023-01-22),
(17,3,1,3,10 ,"credit card",2023-02-07),
(18,4,2,7,0,"cash"  ,2023-03-12),
(19,1,3,1,2,"mobile banking" , 2023-04-19),
(20,5,4,6,1,"credit card",2023-05-07),
(21,3,5,3,5,"mobile banking" , 2023-05-20);
ALTER TABLE transac RENAME COLUMN s_id TO staff_id;
--create table staffs
CREATE TABLE IF NOT EXISTS staffs 
  (s_id  INTEGER PRIMARY KEY, 
  s_name varchar, 
  s_city varchar,
  s_tel varchar,
  hire_date date);
INSERT OR IGNORE INTO staffs (s_id, s_name, s_city, s_tel, hire_date) VALUES
(1, 'John Doe', 'San Francisco', '(415) 555-1212', 2022-01-01),
(2, 'Jane Doe', 'San Jose', '(408) 555-2323', 2022-02-02),
(3, 'Bill Smith', 'Oakland', '(510) 555-3434', 2022-03-03),
(4, 'Mary Jones', 'Berkeley', '(510) 555-4545', 2022-04-04),
(5, 'David Brown', 'San Rafael', '(415) 555-5656', 2022-05-05);


select menus_name,count(menus_id) Best_Seller 
  from (select menus_id, menus_name from menus left outer join transac on menus.menus_id = transac.menu_id)
group by menus_id
ORDER BY 2 DESC
LIMIT 3;

--identify the top-spending customers
select cust_name, sum (menus_price) top_spending from(
select 
  transac.transac_id,
  customers.c_id,
  customers.cust_name,
  menus.menus_price
from customers
join transac on transac.cust_id = customers.c_id
join menus on transac.menu_id = menus.menus_id)
group by c_id
ORDER BY 2 DESC
LIMIT 3;

--identify The staff with the highest tips
select s_name , sum(tips) from(
select 
  transac.transac_id,
  staffs.s_id,
  staffs.s_name,
  transac.tips
from staffs
join transac on transac.staff_id = staffs.s_id)
group by s_id
order by 2 desc
limit 3
;
