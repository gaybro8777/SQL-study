select * from scott.dept t;

--count(ͳ����Ŀ��),sum����ͣ�,substr����ȡ��,avg��ȡƽ��ֵ��������ʹ��
select count(*),sum(t.sal),substr(avg(t.sal),0,7) from scott.emp t;

select sum(t.sal),avg(t.sal) from scott.emp t;

--ͳ�ƺ���count��ͳ��emp����Ŀ������14
select count(*) from scott.emp;

select t.empno,t.ename,t.sal from scott.emp t where t.ename='SMITH';

--DECODE���������÷�һ

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

--DECODE���������÷���
select t.empno,decode(empno,7369,'SMITH',7499,'ALLEN',7521,'WARD','UNKNOW') AS ENAME 
from scott.emp t WHERE rownum<=10;
