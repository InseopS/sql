-- 1장 column 선택, select 07/13
select * from departments;

select department_id, location_id 
from departments;

select location_id, department_id
from departments;

desc departments
-- 과제] employees 구조를 확인하라.
desc employees
-- select 호출 시 임의의 테이블을 추가 할 수 있다.
select last_name, salary, salary + 300
from employees;
--과제] 사원들의 월급, 연봉을 조회하라.
select salary, salary * 12
from employees;

select last_name, salary, 12 * salary + 100
from employees;
select last_name, salary, 12 * (salary + 100)
from employees;

select last_name, job_id, commission_pct
from employees;
-- 연산자 중 하나라도 null이 들어가면 결과값은 null이다.
select last_name, job_id, 12 * salary + (salary * 12 * commission_pct)
from employees;
-- collum 명은 as 명 또는 as 생략하고 명만 넣어도 된다.
select last_name as name, commission_pct comn
from employees;
-- 명을 ""로 묶으면 대소문자 구분이 가능하다.
select last_name "Name", salary * 12 "Annual Salary"
from employees;
--과제] 사원들의 사번, 이름, 직업, 입사일(STARTDATE)을 조회하라.
select employee_id, last_name, job_id, hire_date startdate
from employees;
--과제] 사원들의 사번(Emp #), 이름(Name), 직업(Job), 입사일(Hire Date)을 조회하라.
select employee_id "Emp #", last_name "Name", job_id "Job", hire_date "Hire Date"
from employees;

-- 붙이기 연산자 || 확인
select last_name || job_id
from employees;
select last_name || ' is ' || job_id
from employees;
select last_name || ' is ' || job_id employee
from employees;
-- 붙이기에서는 null은 empty string으로 취급한다.
select last_name || null
from employees;
select last_name || commission_pct
from employees;
select last_name || salary
from employees;
select last_name || hire_date
from employees;
select last_name || (salary * 12)
from employees;
-- 과제] 사원들의 '이름, 직업' (Emp and Title)을 조회하라.
select last_name || ', ' || job_id "Emp and Title"
from employees;