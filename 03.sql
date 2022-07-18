-- 3장 single function 07/13
-- recode에 field가 하나다.
-- parameter도 recode도 최소 단위이다.
-- select + from이 최소 문법이다.

desc dual
select * from dual;
-- lower 모든 글자를 소문자로 변환한다.
select lower('SQL Course')
from dual;

-- initcap 단어에서 첫 글자만 대문자로 변환한다.
select initcap('SQL course')
from dual;

-- 데이터는 소대문자를 가린다.
select last_name
from employees
where last_name = 'higgins';
select last_name
from employees
where last_name = 'Higgins';

-- recode가 입력됐지만 lower에서 last_name의 
-- 필드값 하나만 사용하고 결과를 recode로 반환한다.
select last_name
from employees
where lower(last_name) = 'higgins';

-- concat 문자열을 연결시켜준다.
select concat('Hello', 'World')
from dual;

-- substr(str, a, b) str을 a 부터 b까지 잘라서 반환한다. b 생략 시 끝까지
select substr('HelloWorld', 2, 1)
from dual;
select substr('HelloWorld', -1, 1)
from dual;


-- length 문자열의 길이를 리턴한다.
select length('Hello')
from dual;

-- instr 문자열에서 해당하는 문자열이 시작되는 위치를 리턴한다.
select instr('Hello', 'l')
from dual;
select instr('Hello', 'w')
from dual;

-- lpad, rpad 원하는 필드의 값의 길이로 자르고 빈 공간을 지정값으로 채운다.
select lpad(salary, 5, '*')
from employees;
select rpad(salary, 5, '*')
from employees;

-- 과제] 사원들의 이름, 월급그래프를 조회하라.
--      그래프는 $1000 당 * 하나를 표시한다.
select last_name, rpad(' ', (salary / 1000) + 1, '*') "월급그래프"
from employees;

-- 과제] 위 그래프를 월급 기준 내림차순 정렬하라.
select last_name, rpad(' ', (salary / 1000) + 1, '*') "월급그래프"
from employees
order by "월급그래프" desc;

select replace('JACK and JUE', 'J', 'BL')
from dual;

-- trim 좌,우 양 끝의 특정 문자를 제거한 후 리턴한다.
select trim('H' from 'Hello')
from dual;
select trim('l' from 'Hello')
from dual;
select trim(' ' from ' Hello ')
from dual;
-- 과제] 위 query에서 ' '가 trim 됐음을 눈으로 확인 할 수 있게 조회하라.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;
/*
select*
from (
select ' Hello ' text 
from dual union all
select (length(' Hello ') || '글자에서 공백을 제거하여 ' || 
    length(trim(' ' from ' Hello ')) || '개 글자가 남았습니다.') t1 
from dual union all
select (trim(' ' from ' Hello ')) t3 
from dual
) 시험용;
*/

-- 07/14
select trim(' Hello World ')
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';

-- 과제] 아래 문장을 where 절을 like 로 refactoring 하라.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';

-- 과제] 이름이 J나 A나 M으로 시작하는 사원들의 이름, 이름의 글자수를  조회하라.
--      이름은 첫글자는 대문자, 나머지는 소문자로 출력한다.
select initcap (last_name) "이름", length(last_name) "이름의 글자수"
from employees
where last_name like 'J%' or
    last_name like 'A%' or
    last_name like 'M%';
    
-- round 반올림, trunc 내림, mod 나머지
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

-- 과제] 사원들의 이름, 월급, 15.5% 인상된 월급(New Salary, 정수),
--  인상액(increase)을 조회하라.
select last_name, salary, round(salary * 1.155) "New Salary", 
    round(salary * 0.155) "Increase"
from employees;

-- sysdate 서버 날짜 출력 사용빈도 높음
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

-- 과제] 90번 부서 사원들의 이름, 근속년수를 조회하라.
select last_name, trunc((sysdate - hire_date) / 365)
from employees;
--where department_id = 90;
-- months_between 월단위 차이 계산
select months_between('2022/12/31', '2021/12/31')
from dual;
-- add_months 몇 개월 후 날짜 계산
select add_months('2022/07/14', 1)
from dual;
-- 해당 다음 요일이 며칠인지 계산
select next_day('2022/07/28', 5)
from dual;
-- 해당 월의 마지막 날 계산
select last_day('2022/07/14')
from dual;

-- 과제] 20년 이상 재직한 사원들의 이름, 첫 월급일을 조회하라.
--      월급은 매월 말일에 지급한다.
select last_name, last_day(hire_date) "첫 월급일"
from employees
where months_between(sysdate, hire_date) >= 12 * 20;
-- where trunc((sysdate - hire_date) / 365) >= 20;