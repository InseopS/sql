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
where max(salary) > 10000; -- where�� group function�� ���� err
group by department_id