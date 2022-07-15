-- 5장 group function 07/15 parameter recode가 n개 이상 들어온다.
-- return 값이 하나라는 single과의 공통점이 있다.
select avg(salary), max(salary), sum(salary)
from employees;

select min(hire_date), max(hire_date)
from employees;

-- 과제] 최고월급과 최소월급의 차액을 조회하라.
select max(salary) - min(salary)
from employees;

-- count 해당하는 record 갯수를 리턴한다. 사용빈도 높음
select count (*)
from employees;

-- 과제] 70번 부서원이 몇명인지 조회하라.
select count (*)
from employees
where department_id = 70;

select count (employee_id)
from employees;
-- null은 카운터 되지 않는다. (*) 사용 시 null도 카운터 함
select count (manager_id) 
from employees;

select avg(commission_pct)
from employees;

-- 과제] 조직의 평균 커미션율을 조회하라.
select avg(nvl(commission_pct, 0))
from employees;

-- distinct 중복제거를 해준다.
select avg(salary)
from employees;

select avg(distinct salary)
from employees;

select avg(all salary)
from employees;

-- 과제] 직원이 배치된 부서 개수를 조회하라.
select count(distinct department_id)
from employees;

-- 과제] 매니저 수를 조회하라.
select count(distinct manager_id)
from employees;


select department_id, count(employee_id)
from employees
group by department_id
order by department_id;

select employee_id
from employees
where department_id = 30;

-- group by에 들어가지 않은 일반 column job_id는 사용 불가
-- group function과 lable 역할을 할 그룹화한 일반 colum만 select 대상이다.
select department_id, job_id, count(employee_id)
from employees
group by department_id
order by department_id; -- error

-- 과제] 직업별 사원수를 조회하라.
select job_id, count(employee_id)
from employees
group by job_id;

-- having 그룹 내 조건 검색
-- 그룹을 우선 생성하고 검색
select department_id, max(salary)
from employees
group by department_id
having department_id > 50;
-- 검색하고 그룹 생성
select department_id, max(salary)
from employees
where department_id > 50
group by department_id;

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;

select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000; -- 별명은 사용 불가

select department_id, max(salary)
from employees
where max(salary) > 10000; -- where에 group function이 들어가서 err
group by department_id