
-----
1. Get employees with salary greater then 70000 ??
Answer :-
select * from employees
where salary < 70000;
----------------------------------------------------------------------------------
2.Fetch employees from enginneering department ??
Answer :-
select * from employees
where department = 'enginneering';
---------------------------------------------------------------------------
3.Fetch all employees expect from HR Department 
Answer :-
select * from employees
where Department <> 'HR" ;-----------Explnaation :- (<> is a symbol not exists)
-----------------------------------------------------------------------------
4.Fetch ditinct Department names ??
Answer :-
select Distinct(department) from employees;
------------------------------------------------------------------------------
5. Renaming A coloumn In Exisiting Table ??
Answer :-
Alter Table employees 
rename coloumn name to Full_name ;----(Explanataion :- to rename the coloumn name we use this syntax )
----------------------------------------------------------------------------------------------------------------
6.Count total employees ??
Answer :- 
select count(*) as Total_ count  from employees ;
------------------------------------------------------------------------------------------------------------------
7.Count Employees In each department ?? --****
Answer :-
select department , count(*) as Emp_count 
 from employees ---                            -( Here we need to count total employees from each department )
group by departement ;
--------------------------------------------------------------------------------------------------------------------
8.write a query to display employee_id , employee name and 
salary by increasing the salary of 10000 for each employee ??
Answer :-
select employee_id , employee name ,
salary ,salary+10000
from employees ;
--------------------------------------------------------------------------------------------------------------------
9.write a query to display employee id , department and salary by giving the hike of 20% ??
Answer :-
select employee id,department ,salary ,round(salary+(salary*20/100),0)
from employees 
---------------------------------------------------------------------------------------------------------------------
10. HR 
WHich department has the highest average salary ??
or
Show average salaries by department , sorted highest first ??
or
Find the company's highest paying department ?

Answer :-
select department , round(avg(salary),0) as Highest average salary 
from employees
group by department 
order by salary desc;
--------------------------------------------------------------------------------------------------
11.Find Departments where average salary exceeds 80,000 ??
Answer :-
use hr
select Department , avg(Salary) as Average salary 
from employees
group by Department;
Having Average salary > 80000;
--------------------------------------------------------------------------------------------------
12.Write a query to display details of employees working  in sales or 
HR department */ ??
Answer :-
method 1 :-
select * from employees
where department = 'sales' or
department = 'hr';

method -2 
select * from employees
where department in ( 'sales','hr');
------------------------------------------------------------------------------------------------------
13.Write a query to display the details of employees earning in the 
Range of 80000 to 90000
Answer :-
select * from employees
where salary between (80000 and  90000);
----------------------------------------------------------------------------------------------------------
14.Display employee name , country ,gender , and position title for every employee
whose job title contains "manager/??
Answer :-
select name,country,gender,position title
from employees
where position title like %manager%;
--------------------------------------------------------------------------------------------------------
15. write an sql query to retrieve all unique country names from a table1 ?
Answer :-
select distinct (country) from employees
                         --------------------- 
2- write a sql query to count unique countries excluding dulicate and null values ??
Answer :-
select count(distinct country) from employees;
------------------------------------------------------------------------------------------------------
16.write a sql query to find all employees whose salary is missing but a country has already assigned ??
Answer :-
select * from employees
where salary is null 
and 
country is not null;
----------------------------------------------------------------------------------------------------------
17. write  a query to fetch the top 3 higest salary records (ignore nulls salaries)??
Answer :-
select * from employees 
where salary  is not null
order by salary desc 
limit 3;
-------------------------------------------------------------------------------------------------------------------
18. what is the difference between 
count(1) , count(*) , count('x'), count(cloumn)
ANswer :-
select count(*) from employees;

select count(1) from employees ;

select count('x') from employees; 

select count(salary) from employees;
--------------------------------------------------------------------------------------------------------------------
19.write a query to display the employees id , employee name , and annual salary of each department ??
Answer :-
select id , employee name ,salary , salary*12 as annual salary ----------(note annual salary is *12 with salary )
from employees;
---------------------------------------------------------------------------------------------------------------------
20.write a query to return all employees whose names start with the letter 'A'??
Answer :-
select * from employees 
where name like 'A%' ;
-----------------------------------------------------------------------------------------------------------------
21.write a query to identify duplicate values base on name,department and position title coloumns ??
Answer :-
select employee name , department , posiition title , count(*)as duplicate_coloumn 
from employees
group by employee name , department , posiition title 
having count(1)>1;
---------------------------------------------------------------------------------------------------
 22.Retrive the second highest salary without using top or limit ?
 Answer :-
select max(salary) as second_highest_salary 
 from employees
where salary < (select max(salary) as second_highest_salary from employees);
------------------------------------------------------------------------------------------------
23.
window functions

/*
1. Row_number()--->>Foundation
2. sum() over() --->>Running totals
3. avg() over ()-->> moving averages
4. Rank() vs Dense_Rank () -> Dupliate salaries problem 
5.Lag() / lead() -> compare previous & next rows
6. Partition By -> reset calculations by category */

/* function_name (expression)
over(
      partition by coloumn_name 
	order by coloumn _name 
    );*/
23./* assign a unique number to each employee based on salary (highest first)*/
    Answer :-
    
    select Employee_Name , salary, department 
    row_number() over( partition by department order by salary desc)
    from employees;
-------------------------------------------------------------------------------------------------------------------------------------
24.Display each transition along with the cumulative (running_total) of sales amount, ordered by sale date and order ID */??
answer :-
select  sale_date , order_id , Amount
sum(amount) over(order by sale_date , order_id) as running_total 
from sales;
Note :- Running_total = sum() +over()
--------------------------------------------------------------------------------------------------------------------------
------------- row_number() vs Rank() vs dense_rank() -----------------------(importnat question)

25. How would you assign ranks when there are duplicate salaries ??
Answer :-
case :- 1
select employee_name , salary 
row_number over(order by salary desc) as RNk ------------ Note :-No gaps in the sequence (1, 2, 3, 4, ...).
from employees

CASE:2
select emloyee_name , salary 
Rank() over(order by salary desc) as RNk ---------------Note :-Skips subsequent ranks after a tie, creating gaps (1, 1, 3, 4, ...).
from employees

CASE:3
select emloyee_name , salary 
DENSE_RANK() over(order by salary desc) as RNk ------------Note :-No gaps in the sequence; the next rank is always consecutive (1, 1, 2, 3, ...).
from employees

--------------------------------------------------------------------------------------------------------------------------------------------------------
26. Compare  current value with previous 

/* Retrive employee salary history showing the current and immediately prceeding 
salary for each employee ??
Answer :-
select ID , employee_name , month_no , salary 
Lag(salary )                     --------------------------(Lag) is a syntax for previous month ...
over(partiton by Id order by month_no) as previous_salary 
from employees ;
---------------------------------------------------------------------------------------------------------------------
27./* find top 3 employees by salary in each department 
Note :- If two employees share same salary list time as well*/??
Answer :-
with cte as (
select FirstName ,Department,Salary,
rank() over(partition by Department order by salary  desc) as employees_salary 
from employees
)
select FirstName ,Department,Salary from cte
where employees_salary <=3;

we can also use subquery ------------------

Note :- This SQL query aims to find employees who have the 3rd highest salary within their respective departments.
 However, the provided query will fail because window functions (like rank()) cannot be used directly in a WHERE clause. 
 A subquery or Common Table Expression (CTE) is required to filter by the rank. 
 -----------------------------------------------------------------------------------------------------------------------------
 28. List all the employess whose salary higher than the company's average salary ??
 Answer :-
 
 select * from employees
 where salary > (select avg(salary) as Avg_salary  from employees);
 ----------------------------------------------------------------------------------------------------------------------------
 29. Write a query to find the name of employees who work in the same department----***( important questions)-------
 as the employee(s) with the highest salary in the company ??
 Answer :-
step 1 : with the highest salary in the company
step 2 :  same department as the employee
step 3 : find the name of employees
so , we need to divide it into 3 parts and we need to do in a subquery's
so we get a proper resolution 
Answer :-
case 1:-
select employee_name , department_name , salary 
from employees
where department in 
(select Department from employees) where salary = (select max(salary) as Highest_salary from employees));

case :2 ------------( By joining )--------------------------------------
SELECT e1.employee_name, e1.department_name, e1.salary
FROM employees e1
WHERE e1.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department_name = e1.department_name
);
_-------------------------------------------------------------------------------------------------------------------------------------------------
30.Display the employee's full name along with department and salary , ensuring the full name is shown even when last_name
is  NULL??
answer :-
select CONCAT(FirstName ,' ',LastName) as FullName 
from employees;
---------------------------------------------------------------------------------------------------------------------------------
31.User input data often contains extra spaces
How would you detect and clean such records ??*/
Answer :-
select ID,RIM(EMAIL) AS CLEAN_EMAIL ,
      LTRIM(FULL_NAME) AS CLEAN_NAME,
      RTRIM(COUNTRY) AS CLEAN_COUNTRY
      from employees;
Note :- Trim - removes the spaces throught
        Ltrim - removes the spaces at left side 
        RTrim - removes the spaces at right side 
------------------------------------------------------------------------------------------------------------------
32. How to change the upper case ,lower case ??
Answer :-
UPPER CASE :-
select ID,employee_name , UPPER(COUNTRY) AS UP_COUNTRY
FROM EMPLOYEES

lower case :-
select ID,employee_name , Lower(COUNTRY) AS LW_COUNTRY
FROM EMPLOYEES
----------------------------------------------------------------------------------------
33.Extract the username part of the email ( everything before@*/)??
Answer :-
select trim(substring_index(email,'@',1))as username 
from users;
note :- @- find adress
		1 - starts from first letter till @ 
        input :- tharun .krishna@gmail.com
        output :- tharun .krishna
        trim :- it will clean the whole spaces 
-----------------------------------------------------------------------------------------
curdate vs current_date 
now vs current_timestamp 

select curdate() as datecur,
now() as noww, 
current_date() as curdate,
current_timestamp() as currentt;

34.How many orders were completed today ??
Answer :-
select count(*) as total_count 
from employees
where orders_satus = 'completed'
and order_date = current_date();
-------------------------------------------------------------------------------------------------------------
35. /* How would you extract year , month , and Day from order_date ??
Answer :-

case :1 
select 
year(DOJ) as Order_year,
Month(DOJ) as order_month ,
day(DOJ) as order_date 
from employees;

case -2 
select 
EXTRACT (year from DOJ) as order_year,
EXTRACT(month from DOJ) as order_month ,
EXTRACT( Day from DOJ) as order_day 
from employees;
-----------------------------------------------------------------------------------------------------------

----DATEDIF() VS TIMESTAMP()

----SYNTAX , DATEDIF (date1 , date2 )

--------syntax , timestamp(unit,datetime1, datetime2 );

36. calculate employee tenure in years till today ??
Answer :-
select DATEDIFF(CURDATE(),DOJ) 
FROM EMPLOYEES;

FOR YEAR :-
SELECT TIMESTAMPDIFF( YEAR,DOJ,CURDATE())
FROM EMPLOYEES;

FOR MONTH :-
SELECT TIMESTAMPDIFF( MONTH,DOJ,CURDATE())
FROM EMPLOYEES;

FOR DAY :-
SELECT TIMESTAMPDIFF( DAY,DOJ,CURDATE())
FROM EMPLOYEES;
-------------------------------------------------------------------------------
37. WRITE A query to calculate how many hours each order took for deluivery ??
Answer :-
select timestampdiff(hour ,order_date , order_time) 
from employees;
------------------------------------------------------------------------------
38. calculate delivery time in hours 
show only orders that took more than 12 hours */
ANswer :-
select timestampdiff(hour ,order_date , order_time) as total_hours
from employees
where  timestampdiff(hour ,order_date , order_time)>12 ;
----------------------------------------------------------------------------------------------------------------------
1) LAST_DAY () , SYNTAX :- LAST_DAY(DATE)
SELECT LAST_DAY(CURDATE());----------IT WILL RETURN'S LAST DAY OF THE MONTH 

2) DATE_ADD OR ADDDATE()
--SYNTAX, DATE_ADD(DATE , INTERVAL VALUE UNIT ----------------IT WILL ADD THE DATES IF 7 SEVEN DAYS WILL BE ADDED OR -7 IT WILL ADD -7 DAYS BACK 

SELECT DATE_ADD(CURDATE(), INTERVAL 7 DAY);
SELECT DATE_ADD(CURDATE(), INTERVAL -7 DAY);


3) DATE_FORMAT()
--SYNTAX, DATE_FORMAT(DATE , FORMAT_STRING)
SELECT DATE_FORMAT(CURDATE() ,'%D'-'%M'-'%Y');
-----------------------------------------------------------------------------------------------------
39. /* Management wants to clasify employees as :
High salary , Medium salary , low salary */??
Answer :-

----case statement 

---syntax 
/*case 
when condition1 then reult1
when condition2 then result2
else default_result 
end*/

Answer :-
select Employee_name , department, salary 
case 
when salary > 90000 then 'High salary'
when salary between 60000 and 79999
then 'Medium salary'
ELSE 'LOW SALARY'
END AS SALARY_CATEGORY 
FROM EMPLOYEES ;
--------------------------------------------------------------------------------------------------------------
