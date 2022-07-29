create user mybatis identified by mybatis;
grant connect, resource to mybatis;

select *
from users;

delete users
where user_id = 15;

commit;