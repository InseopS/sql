-- 4장 datatype 변환 07/14

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

--sp를 붙이면 날짜로 문자로 표기한다.
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

-- 과제] 위 테이블을 월요일부터 오름차순 정렬하라.
select last_name, hire_date, 
    to_char(hire_date, 'day')
from employees
order by to_char(hire_date - 1, 'd');

-- 'NLS_DATE_LANGUAGE=korean' 요일을 지역에 맞게 표기한다.

select to_char(sysdate, 'hh24:mi:ss am')
from dual;

select to_char(sysdate, 'DD "of" Month')
from dual;
-- fill mode, fm을 넣으면 공백을 최소화한다.
select to_char(hire_date, 'fmDD Month YY')
from employees;

-- 과제] 사원들의 이름, 입사일, 인사평가일을 조회하라.
--        인사평가일은 입사한 지 3개월 후 첫번째 월요일이다.
--        날짜는 YYYY.MM.DD 로 표시한다.
select last_name, to_char(hire_date, 'YYYY.MM.DD') hire_date,
to_char(next_day(add_months(hire_date, 3), 'monday'), 'YYYY.MM.DD') review_date
from employees;


select to_char(salary)
from employees;
-- 앞자리 숫자 자리로 9를 넣으면 들어올 값이 없으면 비우고 0을 쓰면 0으로 채운다.
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

-- 과제] <이름> earns <$,월급> monthly but wants <$,월급x3>. 로 조회하라.
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

-- Format eXtract 절대적인 포멧규칙 강제, 단 날짜의 대소문은 안따짐
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
-- 싱글은 파라메터 null이 오면 리턴 null
-- 그룹은 파라메터 null이 오면 무시
-- nvl null을 다른 값으로 교체한다. 사용빈도 높음
select nvl(null, 0)
from dual;

-- 검사값과 타입이 교체값의 타입은 칼럼이 하나여서 같아야한다.
select job_id, nvl(commission_pct, 0)
from employees;

-- 과제] 사원들의 이름, 직업, 연봉을 조회하라.
select last_name, job_id, 
    salary * 12 * (nvl(commission_pct, 0) + 1) ann_sal
from employees
order by ann_sal desc;

-- 과제] 사원들의 이름, 커미션율을 조회하라.
--      커미션이 없으면, No Commission을 표시한다.
select last_name, nvl(to_char(commission_pct), 'No Commission') commission_pct
from employees;

-- null이면 2번째 파라메터, 아니면 3번째 파라메터 출력
select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL') income
from employees;

select job_id, nvl2(commission_pct, 'SAL+COMM', 0) income
from employees;

-- null if 두개 값이 같으면 null을 리턴하고, 다르면 앞의 값을 리턴한다.
select first_name, last_name,
    nullif(length(first_name),length(last_name))
from employees;

select to_char(null), to_number(null), to_date(null)
from dual;

-- coalesce 처음으로 null이 아닌 값을 리턴한다.
select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees;


-- decode 07/15 --기준 값, 리턴 값
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

-- 과제] 사원들의 직업, 직업별 등급을 조회하라.
--      기본 등급은 null 이다.
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

-- case 대상 when 이면 then 이다.
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
from employees; -- error 기준값과 비교값의 타입이 다르다.

select case salary when 1 then '1'
                    when 2 then '2'
                    else 0
        end grade
from employees; -- error 리턴값의 타입이 서로 다르다.

select case salary when 1 then '1'
                    when 2 then 2
                    else '0'
        end grade
from employees; -- error 리턴값의 타입이 서로 다르다.
-- if 문법처럼 사용 가능하다.
select last_name, salary,
    case when salary < 5000 then 'low'
        when salary < 10000 then 'medium'
        when salary < 20000 then 'high'
        else 'good'
    end grade
from employees;

-- 과제] 이름, 입사일, 요일을 월요일부터 요일순으로 조회하라.
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
    when '월요일' then 1
    when '화요일' then 2
    when '수요일' then 3
    when '목요일' then 4
    when '금요일' then 5
    when '토요일' then 6
    else 7
end;
-- order by case end 시험


-- 과제] 이름, 입사일, 요일을 월요일부터 요일순으로 조회하라.
select last_name, hire_date,
    case to_char(hire_date, 'd')
        when '2' then '1.월요일'
        when '3' then '2.화요일'
        when '4' then '3.수요일'
        when '5' then '4.목요일'
        when '6' then '5.금요일'
        when '7' then '6.토요일'       
        else '7.일요일'
    end 요일
from employees
order by 요일;
*/


-- 과제] 2005년 이전에 입사한 사원들에겐 100만원 상품권,
--      2005년 후에 입사한 사원들에게 10만원 상품권을 지급한다.
--      사원들의 이름, 입사일, 상품권금액을 조회하라.

select last_name, hire_date, 
    case when hire_date <= '2005/12/31' then '100만원'
    else '10만원' end gift
from employees;