-- 3�� single function 07/13
-- recode�� field�� �ϳ���.
-- parameter�� recode�� �ּ� �����̴�.
-- select + from�� �ּ� �����̴�.

desc dual
select * from dual;
-- lower ��� ���ڸ� �ҹ��ڷ� ��ȯ�Ѵ�.
select lower('SQL Course')
from dual;

-- initcap �ܾ�� ù ���ڸ� �빮�ڷ� ��ȯ�Ѵ�.
select initcap('SQL course')
from dual;

-- �����ʹ� �Ҵ빮�ڸ� ������.
select last_name
from employees
where last_name = 'higgins';
select last_name
from employees
where last_name = 'Higgins';

-- recode�� �Էµ����� lower���� last_name�� 
-- �ʵ尪 �ϳ��� ����ϰ� ����� recode�� ��ȯ�Ѵ�.
select last_name
from employees
where lower(last_name) = 'higgins';

-- concat ���ڿ��� ��������ش�.
select concat('Hello', 'World')
from dual;

-- substr(str, a, b) str�� a ���� b���� �߶� ��ȯ�Ѵ�. b ���� �� ������
select substr('HelloWorld', 2, 1)
from dual;
select substr('HelloWorld', -1, 1)
from dual;


-- length ���ڿ��� ���̸� �����Ѵ�.
select length('Hello')
from dual;

-- instr ���ڿ����� �ش��ϴ� ���ڿ��� ���۵Ǵ� ��ġ�� �����Ѵ�.
select instr('Hello', 'l')
from dual;
select instr('Hello', 'w')
from dual;

-- lpad, rpad ���ϴ� �ʵ��� ���� ���̷� �ڸ��� �� ������ ���������� ä���.
select lpad(salary, 5, '*')
from employees;
select rpad(salary, 5, '*')
from employees;

-- ����] ������� �̸�, ���ޱ׷����� ��ȸ�϶�.
--      �׷����� $1000 �� * �ϳ��� ǥ���Ѵ�.
select last_name, rpad(' ', (salary / 1000) + 1, '*') "���ޱ׷���"
from employees;

-- ����] �� �׷����� ���� ���� �������� �����϶�.
select last_name, rpad(' ', (salary / 1000) + 1, '*') "���ޱ׷���"
from employees
order by "���ޱ׷���" desc;

select replace('JACK and JUE', 'J', 'BL')
from dual;

-- trim ��,�� �� ���� Ư�� ���ڸ� ������ �� �����Ѵ�.
select trim('H' from 'Hello')
from dual;
select trim('l' from 'Hello')
from dual;
select trim(' ' from ' Hello ')
from dual;
-- ����] �� query���� ' '�� trim ������ ������ Ȯ�� �� �� �ְ� ��ȸ�϶�.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;
/*
select*
from (
select ' Hello ' text 
from dual union all
select (length(' Hello ') || '���ڿ��� ������ �����Ͽ� ' || 
    length(trim(' ' from ' Hello ')) || '�� ���ڰ� ���ҽ��ϴ�.') t1 
from dual union all
select (trim(' ' from ' Hello ')) t3 
from dual
) �����;
*/

-- 07/14
select trim(' Hello World ')
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';

-- ����] �Ʒ� ������ where ���� like �� refactoring �϶�.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';

-- ����] �̸��� J�� A�� M���� �����ϴ� ������� �̸�, �̸��� ���ڼ���  ��ȸ�϶�.
--      �̸��� ù���ڴ� �빮��, �������� �ҹ��ڷ� ����Ѵ�.
select initcap (last_name) "�̸�", length(last_name) "�̸��� ���ڼ�"
from employees
where last_name like 'J%' or
    last_name like 'A%' or
    last_name like 'M%';
    
-- round �ݿø�, trunc ����, mod ������
select round(45.926, 2)
from dual;
select trunc(45.926, 2)
from dual;
select mod(1600, 300)
from dual;

select round(45.923, 0), round(45.923)
from dual;
select trunc(45.923, 0), trunc(45.923)
from dual;

-- ����] ������� �̸�, ����, 15.5% �λ�� ����(New Salary, ����),
--  �λ��(increase)�� ��ȸ�϶�.
select last_name, salary, round(salary * 1.155) "New Salary", 
    round(salary * 0.155) "Increase"
from employees;

-- sysdate ���� ��¥ ��� ���� ����
select sysdate
from dual;

select sysdate + 1
from dual;

select sysdate - 1
from dual;

select sysdate - sysdate
from dual;

select last_name, sysdate - hire_date
from employees
where department_id = 90;

/*
select last_name, mod(round(sysdate - hire_date), 365)
from employees
where department_id = 90;
*/

-- ����] 90�� �μ� ������� �̸�, �ټӳ���� ��ȸ�϶�.
select last_name, trunc((sysdate - hire_date) / 365)
from employees;
--where department_id = 90;
-- months_between ������ ���� ���
select months_between('2022/12/31', '2021/12/31')
from dual;
-- add_months �� ���� �� ��¥ ���
select add_months('2022/07/14', 1)
from dual;
-- �ش� ���� ������ ��ĥ���� ���
select next_day('2022/07/28', 5)
from dual;
-- �ش� ���� ������ �� ���
select last_day('2022/07/14')
from dual;

-- ����] 20�� �̻� ������ ������� �̸�, ù �������� ��ȸ�϶�.
--      ������ �ſ� ���Ͽ� �����Ѵ�.
select last_name, last_day(hire_date) "ù ������"
from employees
where months_between(sysdate, hire_date) >= 12 * 20;
-- where trunc((sysdate - hire_date) / 365) >= 20;