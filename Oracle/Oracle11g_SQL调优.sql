/** Oracle11g���Ųο�  **/
/** ��־��д����࣬���·�����Oracleʵ���رպ��޷�������
���飬��������־��Ȼ���ֶ�ʹ������������������ **/


/** Oracle���ö�̬������ͼ **/
--v$logfiles��ͼ�鿴��־���й�ʵ��������־���ļ�������λ����Ϣ
select member from v$logfile;
--�������ݿ������Ϣ
select * from v$database;
--�ӿ����ļ�����ȡ�й�������־�����Ϣ
select * from v$log;
--��¼�鵵��־�ļ��Ļ�����Ϣ
select * from v$archived_log;
--��¼�鵵��־�ļ���·����Ϣ
select * from v$archive_dest;
--�����ļ������Ϣ
select * from v$controlfile;
--��¼ʵ��������Ϣ
select * from v$instance;
--���ݿ�������������
select * from dba_indexes;
--���б�����ѹ����������
select * from dba_ind_columns;
--�����û���������Ϣ
select * from dba_triggers;
--�����û��洢������Ϣ
select * from dba_source;
--�������ݿ��ļ���Ϣ
select * from dba_data_files;
--���ڶ�����Ȩ��Ϣ
--select * from dba_tab_grants;
select * from dba_tab_privs;
--���ݿ����еĶ���
select * from dba_objects;
select count(*) from dba_objects;--71941,�����Ƚϴ����ص��ѯ����
select * from dba_object_tables;
--���ݿ��������û���Ϣ
select * from dba_users;


/** Oracle�����ֵ� **/
--��ռ���Ϣ
select * from dba_tablespaces;
--���ݱ�����
select * from dba_tables t where t.TABLE_NAME IN('DEPT','EMP');
--��ͼ��Ϣ
select * from dba_views;
--������Ϣ
select * from dba_sequences;
--�û���Լ����Ϣ
select * from dba_constraints;
--���б�ռ����ɷ���
select * from dba_free_space;
--sga������С
select * from v$sga;
--ͳ��sgaʹ�������Ϣ
select * from v$sgastat;
--�Ự�����Ϣ
select * from v$session;
--sql�����Ϣ
select * from v$sql;
--��¼SQL���������Ϣ
select * from v$sqltext;
--��ʾʵ����ǰ��Ч�Ĳ�����Ϣ
select * from v$parameter;
--ͨ���������ݿ�Ự�����ö�������������Ϣ
select * from v$lock;
--��������Ϣ
select * from v$lock_type;
--v$lock_activity
select * from v$lock_activity;

 /** TRUNCATE �� DELETE **/
 
 /** NOT EXISTS �� NOT IN **/
select * from scott.emp; 
select * from scott.dept;
--NOT IN�����ݿ�ִ��ȫ���������������ʹ��
select empno,ename from scott.emp where empno 
not in(select deptno from scott.dept where loc='DALLAS');
--����������Ż�����NOT EXISTS
select empno,ename from scott.emp where 
exists(select deptno from scott.dept where loc != 'DALLAS');
