-- 5�� group function 07/15 parameter recode�� n�� �̻� ���´�.
-- return ���� �ϳ���� single���� �������� �ִ�.
select avg(salary), max(salary), sum(salary)
from employees;

select min(hire_date), max(hire_date)
from employees;

-- ����] �ְ���ް� �ּҿ����� ������ ��ȸ�϶�.
select max(salary) - min(salary)
from employees;

-- count �ش��ϴ� record ������ �����Ѵ�. ���� ����
select count (*)
from employees;

-- ����] 70�� �μ����� ������� ��ȸ�϶�.
select count (*)
from employees
where department_id = 70;

select count (employee_id)
from employees;
-- null�� ī���� ���� �ʴ´�. (*) ��� �� null�� ī���� ��
select count (manager_id) 
from employees;

select avg(commission_pct)
from employees;

-- ����] ������ ��� Ŀ�̼����� ��ȸ�϶�.
select avg(nvl(commission_pct, 0))
from employees;

-- distinct �ߺ����Ÿ� ���ش�.
select avg(salary)
from employees;

select avg(distinct salary)
from employees;

select avg(all salary)
from employees;

-- ����] ������ ��ġ�� �μ� ������ ��ȸ�϶�.
select count(distinct department_id)
from employees;

-- ����] �Ŵ��� ���� ��ȸ�϶�.
select count(distinct manager_id)
from employees;


select department_id, count(employee_id)
from employees
group by department_id
order by department_id;

select employee_id
from employees
where department_id = 30;

-- group by�� ���� ���� �Ϲ� column job_id�� ��� �Ұ�
-- group function�� lable ������ �� �׷�ȭ�� �Ϲ� colum�� select ����̴�.
select department_id, job_id, count(employee_id)
from employees
group by department_id
order by department_id; -- error

-- ����] ������ ������� ��ȸ�϶�.
select job_id, count(employee_id)
from employees
group by job_id;

-- having �׷� �� ���� �˻�
-- �׷��� �켱 �����ϰ� �˻�
select department_id, max(salary)
from employees
group by department_id
having department_id > 50;
-- �˻��ϰ� �׷� ����
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
having max_sal > 10000; -- ������ ��� �Ұ�

select department_id, max(salary)
from employees
where max(salary) > 10000 -- where�� group function�� ���� err
group by department_id;

-- 07/18
select job_id, sum(salary) payroll
from employees
where job_id not like '%REP%'
group by job_id
having sum(salary) > 13000
order by payroll;

-- ����] �Ŵ���ID, �Ŵ����� ���� ������ �� �ּҿ����� ��ȸ�϶�.
--      �ּҿ����� $6,000 �ʰ����� �Ѵ�.
select manager_id, min(salary)
from employees
--where manager_id is not null
group by manager_id
having min(salary) > 6000 and manager_id is not null
order by 2 desc;

select max(avg(salary))
from employees
group by department_id;

select sum(max(avg(salary)))
from employees
group by department_id; -- error, to deeply �׷��Լ��� 2��ø���� �����ϴ�.

select department_id, round(avg(salary))
from employees
group by department_id;

select department_id, round(avg(salary))
from employees; -- error, �׷��Լ��� ���ԵǸ� group by�� �ʿ��ϴ�.

-- ����] 2001�� 2002�� 2003�⵵ �� �Ի��� ���� ã�´�.
select sum(decode(to_char(hire_date, 'yyyy'), '2001', 1, 0)) "2001",
    sum(decode(to_char(hire_date, 'yyyy'), '2002', 1, 0)) "2002",
    sum(decode(to_char(hire_date, 'yyyy'), '2003', 1, 0)) "2003"
from employees;

select count(case when hire_date like '2001%' then 1 else null end) "2001",
    count(case when hire_date like '2002%' then 1 else null end) "2002",
    count(case when hire_date like '2003%' then 1 else null end) "2003"
from employees;

-- ����] ������, �μ��� �������� ��ȸ�϶�.
--      �μ��� 20, 50, 80 �̴�.
/*
select job_id, sum(case when department_id = 20 then salary else 0 end) "20",
sum(case when department_id = 50 then salary else 0 end) "50",
sum(case when department_id = 80 then salary else 0 end) "80"
from employees
group by job_id, department_id
having department_id in (20, 50, 80);
*/
select job_id, sum(decode(department_id, 20, salary)) "20",
    sum(decode(department_id, 50, salary)) "50",
    sum(decode(department_id, 80, salary)) "80"
from employees
group by job_id;