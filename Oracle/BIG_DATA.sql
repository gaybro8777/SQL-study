/** Oracle11g R2 for Windows10���� **/
--������
CREATE TABLE test.student
(
    ID NUMBER not null primary key,
    STU_NAME VARCHAR2(60) not null,
    STU_AGE NUMBER(4,0) NOT NULL,
    STU_SEX VARCHAR2(2) not null
)

--ѧ�����������200w����
insert into test.student
select rownum,dbms_random.string('*',dbms_random.value(6,10)),dbms_random.value(14,16),
'Ů' from dual
connect by level<=2000000

select count(*) from test.student t where t.stu_age='16';

select t.*, t.rowid from TEST.STUDENT t where t.stu_age<16

update test.student set stuid=rownum where 1=1
--�޸��������14-16��֮��
update test.student set stu_age=dbms_random.value(14,16) where 1=1


--delete from test.student;
commit;


/** ���Բ���1kw���� ---begin **/
--������
CREATE TABLE test.test
(
    id NUMBER not null primary key,
    stu_name NVARCHAR2(60) not null,
    score NUMBER(4,0) NOT NULL,
    createtime TIMESTAMP (6) not null
)


--ģ�����200w������(36s),�������ܲ���,����1kw���ݳ���connect by�ڴ治��
insert into test.test
select rownum,dbms_random.string('*',dbms_random.value(6,20)),dbms_random.value(0,20),
sysdate from dual
connect by level<=2000000


--drop table test.test;
--drop table test.test01;

--�ύ
commit;

create table test.test01 as select * from test.test;

--(200w)
select count(*) from test.test;
--(1000w)
select count(*) from test.test01;

--(6s,8s,7s,7s),ִ��4��
insert into test.test01 select * from test.test
--ͳ��
select count(distinct id) from test.test01

--�Ż�id
update test.test01 set id=rownum where 1=1
--����idΪ����
ALTER TABLE test.test01 ADD CONSTRAINT constraint_test01 PRIMARY KEY (id);

/** ���Բ���1kw���� ---end **/
/** Oracle11g R2 for Windows10���� **/

