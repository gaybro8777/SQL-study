select * from scott.dept t;

--count(统计条目数),sum（求和）,substr（截取）,avg（取平均值）函数的使用
select count(*),sum(t.sal),substr(avg(t.sal),0,7) from scott.emp t;

select sum(t.sal),avg(t.sal) from scott.emp t;

--统计函数count，统计emp表条目数量：14
select count(*) from scott.emp;

select t.empno,t.ename,t.sal from scott.emp t where t.ename='SMITH';

--DECODE函数常见用法一

select 
sum(decode(ename,'SMITH',sal,0)) SMITH,
sum(decode(ename,'ALLEN',sal,0)) ALLEN,
sum(decode(ename,'WARD',sal,0)) WARD,
sum(decode(ename,'JONES',sal,0)) JONES,
sum(decode(ename,'MARTIN',sal,0)) MARTIN,
sum(decode(ename,'BLAKE',sal,0)) BLAKE,
sum(decode(ename,'CLARK',sal,0)) CLARK,
sum(decode(ename,'SCOTT',sal,0)) SCOTT,
sum(decode(ename,'KING',sal,0)) KING,
sum(decode(ename,'TURNER',sal,0)) TURNER
from scott.emp;

--DECODE函数常见用法二
select t.empno,decode(empno,7369,'SMITH',7499,'ALLEN',7521,'WARD','UNKNOW') AS ENAME 
from scott.emp t WHERE rownum<=10;
