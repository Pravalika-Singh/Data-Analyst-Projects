Create Database employee ; 

Use employee;

-- Q3

Select  EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
		from emp_record_table order by DEPT; 

-- Q4

Select  EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING,
Case
		When EMP_RATING < 2 then 'Less Than 2'
		When EMP_RATING < 4 then 'Between two and four'
		else 'Greater than 4'
End as Rating
		from emp_record_table order by DEPT; 

-- Q5

select concat(first_name," ",Last_name) as Name 
		from emp_record_table
        where DEPT = 'Finance';

-- Q6

select m.FIRST_NAME as manager_name, count(*) No_Emps_reporting
from emp_record_table as e
join emp_record_table as m
on m.emp_id=e.MANAGER_ID
group by manager_name
having No_emps_reporting > 0;

-- Q7

select * from emp_record_table where DEPT = 'Healthcare'
UNION
select * from emp_record_table where DEPT = 'Finance';

-- Q8

select EMP_ID, FIRST_NAME, LAST_NAME, Role,DEPT, EMP_RATING,
		max(emp_rating) over(partition by DEPT) max_rating
	from emp_record_table;

-- Q9

select EMP_ID, FIRST_NAME, LAST_NAME, ROLE,
		min(Salary) over( partition by ROLE) Min_Salary,
		max(Salary) over( partition by ROLE) MAX_Salary
	from emp_record_table;

select role,min(Salary) Min_Salary ,Max(Salary) MAX_Salary from emp_record_table
		group by ROLE;

-- Q10

select emp_ID, First_Name, Exp, Rank() over(order by Exp desc) Rank_Exp
		from emp_record_table;
        
-- Q11

create VIEW VempSalAbove6k AS
select EMP_ID,FIRST_NAME,LAST_NAME,SALARY,COUNTRY 
		from emp_record_table 
		where SALARY > 6000;
        
select * from VempSalAbove6k;

-- Q12

select * from emp_record_table where EMP_ID in(
select Emp_ID from emp_record_table where Exp > 10);

-- Q13

USE `employee`;
DROP procedure IF EXISTS `employee`.`emp_3plusexp`;
;

DELIMITER $$
USE `employee`$$
CREATE PROCEDURE `emp_3plusexp`()
BEGIN
	select * from emp_record_table where Exp > 3;
END$$

DELIMITER ;
;
call emp_3plusexp;

-- Q14

SELECT DS.EMP_ID, DS.FIRST_NAME, DS.LAST_NAME, DS. EXP, DS.ROLE AS CURRENT_ROLE,
		Check_Job_Profile(DS.EXP, DS.ROLE) AS ROLE_VALIDATION
		FROM emp_record_table DS
		order by EXP desc, CURRENT_ROLE asc;

-- Q15


select * from emp_record_table where FIRST_NAME = 'Eric';

CREATE INDEX Idx_Fname on emp_record_table(First_Name);

-- alter table emp_record_table drop INDEX Idx_Fname;

-- Q16

select *,
		SALARY *.05* EMP_RATING as Bonus
		from emp_record_table;

-- Q17

select CONTINENT, COUNTRY, avg(Salary) as AVg_Salary
		from emp_record_table
		group by CONTINENT, COUNTRY with rollup;
