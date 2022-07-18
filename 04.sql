-- 4�� datatype ��ȯ 07/14

select hire_date
from employees
where hire_date = '2003/06/17';

select salary
from employees
where salary = '7000';

select hire_date || ''
from employees;

select salary || ''
from employees;

select to_char(hire_date)
from employees;

select to_char(sysdate, 'mm-dd-yyyy') -- fm from model
from dual;

--sp�� ���̸� ��¥�� ���ڷ� ǥ���Ѵ�.
select to_char(sysdate, 'YEAR MONTH DDsp DAY(DY)')
from dual;

select to_char(sysdate, 'Year Month Ddsp Day(Dy)')
from dual;

select to_char(sysdate, 'd')
from dual;

select last_name, hire_date, 
    to_char(hire_date, 'day'), 
    to_char(hire_date, 'd')
from employees;

-- ����] �� ���̺��� �����Ϻ��� �������� �����϶�.
select last_name, hire_date, 
    to_char(hire_date, 'day')
from employees
order by to_char(hire_date - 1, 'd');

-- 'NLS_DATE_LANGUAGE=korean' ������ ������ �°� ǥ���Ѵ�.

select to_char(sysdate, 'hh24:mi:ss am')
from dual;

select to_char(sysdate, 'DD "of" Month')
from dual;
-- fill mode, fm�� ������ ������ �ּ�ȭ�Ѵ�.
select to_char(hire_date, 'fmDD Month YY')
from employees;

-- ����] ������� �̸�, �Ի���, �λ������� ��ȸ�϶�.
--        �λ������� �Ի��� �� 3���� �� ù��° �������̴�.
--        ��¥�� YYYY.MM.DD �� ǥ���Ѵ�.
select last_name, to_char(hire_date, 'YYYY.MM.DD') hire_date,
to_char(next_day(add_months(hire_date, 3), 'monday'), 'YYYY.MM.DD') review_date
from employees;


select to_char(salary)
from employees;
-- ���ڸ� ���� �ڸ��� 9�� ������ ���� ���� ������ ���� 0�� ���� 0���� ä���.
select to_char(salary, '$99,999.99'), 
        to_char(salary, '$00,000.00')
from employees
where last_name = 'Ernst';

select '|' || to_char(12.12, '9999.999') || '|',
'|' || to_char(12.12, '0000.000') || '|'
from dual;

select '|' || to_char(12.12, 'fm9999.999') || '|',
'|' || to_char(12.12, 'fm0000.000') || '|'
from dual;

select to_char(1237, 'L9999')
from dual;

-- ����] <�̸�> earns <$,����> monthly but wants <$,����x3>. �� ��ȸ�϶�.
select last_name || ' earns ' || 
    to_char(salary, 'fm$99,999') || ' monthly but wants ' || 
    to_char(salary*3, 'fm$99,999') || '.'
from employees;


select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon dd, yyyy');

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'MON  dd yy');

-- Format eXtract �������� �����Ģ ����, �� ��¥�� ��ҹ��� �ȵ���
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'fxMON  dd yy');


select to_number('1237')
from dual;

select to_number('1,237.12')
from dual; -- error

select to_number('1,237.12', '9,999.99')
from dual;


-- null
-- �̱��� �Ķ���� null�� ���� ���� null
-- �׷��� �Ķ���� null�� ���� ����
-- nvl null�� �ٸ� ������ ��ü�Ѵ�. ���� ����
select nvl(null, 0)
from dual;

-- �˻簪�� Ÿ���� ��ü���� Ÿ���� Į���� �ϳ����� ���ƾ��Ѵ�.
select job_id, nvl(commission_pct, 0)
from employees;

-- ����] ������� �̸�, ����, ������ ��ȸ�϶�.
select last_name, job_id, 
    salary * 12 * (nvl(commission_pct, 0) + 1) ann_sal
from employees
order by ann_sal desc;

-- ����] ������� �̸�, Ŀ�̼����� ��ȸ�϶�.
--      Ŀ�̼��� ������, No Commission�� ǥ���Ѵ�.
select last_name, nvl(to_char(commission_pct), 'No Commission') commission_pct
from employees;

-- null�̸� 2��° �Ķ����, �ƴϸ� 3��° �Ķ���� ���
select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL') income
from employees;

select job_id, nvl2(commission_pct, 'SAL+COMM', 0) income
from employees;

-- null if �ΰ� ���� ������ null�� �����ϰ�, �ٸ��� ���� ���� �����Ѵ�.
select first_name, last_name,
    nullif(length(first_name),length(last_name))
from employees;

select to_char(null), to_number(null), to_date(null)
from dual;

-- coalesce ó������ null�� �ƴ� ���� �����Ѵ�.
select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees;


-- decode 07/15 --���� ��, ���� ��
select last_name, salary,
    decode(trunc(salary / 2000),
    0, 0.00, 
    1, 0.09,
    2, 0.20,
    3, 0.30,
    4, 0.40,
    5, 0.42,
    6, 0.44,
        0.45) tax_rate
from employees
where department_id = 80;

select decode(salary, 'a', 1)
from employees;

select decode(salary, 'a', 1, 0)
from employees;

select decode(job_id, 1, 1)
from employees; -- error, invalid number

select decode(hire_date, 'a', 1)
from employees;

select decode(hire_date, 1, 1)
from employees;

-- ����] ������� ����, ������ ����� ��ȸ�϶�.
--      �⺻ ����� null �̴�.
--      IT_PROG     A
--      AD_PRES     B
--      ST_MAN      C
--      ST_CLERK    D

select last_name, job_id, decode(job_id,
        'IT_PROG', 'A',
        'AD_PRES', 'B',
        'ST_MAN', 'C',
        'ST_CLERK', 'D') grade
from employees;

-- case ��� when �̸� then �̴�.
select last_name, job_id, salary,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'AD_PRES' then 1.05 * salary
    else salary end revised_salary
from employees;

select case job_id when '1' then 1
                    when '2' then 2
                    else 0
        end grade
from employees;

select case salary when 1 then '1'
                    when 2 then '2'
                    else '0'
        end grade
from employees;

select case salary when '1' then '1'
                    when '2' then '2'
                    else '0'
        end grade
from employees; -- error ���ذ��� �񱳰��� Ÿ���� �ٸ���.

select case salary when 1 then '1'
                    when 2 then '2'
                    else 0
        end grade
from employees; -- error ���ϰ��� Ÿ���� ���� �ٸ���.

select case salary when 1 then '1'
                    when 2 then 2
                    else '0'
        end grade
from employees; -- error ���ϰ��� Ÿ���� ���� �ٸ���.
-- if ����ó�� ��� �����ϴ�.
select last_name, salary,
    case when salary < 5000 then 'low'
        when salary < 10000 then 'medium'
        when salary < 20000 then 'high'
        else 'good'
    end grade
from employees;

-- ����] �̸�, �Ի���, ������ �����Ϻ��� ���ϼ����� ��ȸ�϶�.
select last_name, hire_date, to_char(hire_date, 'fmday') day
from employees
order by case day
        when 'monday' then 1
        when 'tuesday' then 2
        when 'wednesday' then 3
        when 'thursday' then 4
        when 'friday' then 5
        when 'saturday' then 6
        else 7
    end ;

/*
select last_name, hire_date, to_char(hire_date, 'day','NLS_DATE_LANGUAGE=korean') day
from employees
order by case day
    when '������' then 1
    when 'ȭ����' then 2
    when '������' then 3
    when '�����' then 4
    when '�ݿ���' then 5
    when '�����' then 6
    else 7
end;
-- order by case end ����


-- ����] �̸�, �Ի���, ������ �����Ϻ��� ���ϼ����� ��ȸ�϶�.
select last_name, hire_date,
    case to_char(hire_date, 'd')
        when '2' then '1.������'
        when '3' then '2.ȭ����'
        when '4' then '3.������'
        when '5' then '4.�����'
        when '6' then '5.�ݿ���'
        when '7' then '6.�����'       
        else '7.�Ͽ���'
    end ����
from employees
order by ����;
*/


-- ����] 2005�� ������ �Ի��� ����鿡�� 100���� ��ǰ��,
--      2005�� �Ŀ� �Ի��� ����鿡�� 10���� ��ǰ���� �����Ѵ�.
--      ������� �̸�, �Ի���, ��ǰ�Ǳݾ��� ��ȸ�϶�.

select last_name, hire_date, 
    case when hire_date <= '2005/12/31' then '100����'
    else '10����' end gift
from employees;