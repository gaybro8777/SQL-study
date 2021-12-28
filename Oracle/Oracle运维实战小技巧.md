# 前言





# 正文

## 一、基础优化篇

### 1、密码过期修改
```sql
--查询密码期限
SELECT *
  FROM dba_profiles s
 WHERE s.profile = 'DEFAULT'
   AND resource_name = 'PASSWORD_LIFE_TIME'
--修改密码期限为无限制
 ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;
```

### 2、空表无法导出

2.1、新增createsql.sql文件

```sql
   set heading off;
   set echo off;
   set feedback off;
   set termout on;
   spool C:\allocate.sql;
   select 'alter table '|| owner ||'.'||table_name||' allocate extent;' from dba_tables where SEGMENT_CREATED='NO';
   spool off;
```

2.2、连接sqlplus执行createsql.sql

2.3、在你设置的路径下形成allocate.sql

2.4、执行allocate.sql，解决Oracle空表无法导出的问题

## 二、实战参考篇

### 1、Oracle11g调优参考 

1.1、**真实运维场景**

基于真实运维场景进行分析，环境原因，不得在同一台服务器上建立双实例。结果在某一天，服务器日志量写入过多，导致服务器Oracle实例关闭后无法启动。建议：先清理日志，**清理日志之前先做好备份**，然后手动使用命令重启监听服务。**至于如何查询日志所在服务器位置，下面的Oracle常用动态性能视图有介绍**。



关于表空间：之前公司默认都使用USERS，临时表空间选择TEMP。

后面经过思考，不出问题还好；一出问题，排查起来就麻烦了。USERS下的tablespace显得太混乱了，个人建议单独创表空间，分工明确。




查看字符集，有助于解决中文乱码问题
```sql
--查看字符集
select userenv('language') from dual;
--设置默认字符集(linux)
export NLS_LANG="SIMPLIFIED CHINESE_CHINA.ZHS16GBK"
--设置默认字符集(win),在win用户环境变量加入配置
NLS_LANG="SIMPLIFIED CHINESE_CHINA.ZHS16GBK"
```

创建表空间，设置路径更具实际情况而定，表空间必须指定大小。
```sql
--创建表空间
create tablespace TEST DATAFILE 'D:\app\product\11.2.0\oradata\orcl\TEST.DBF' SIZE 256M;
```

删除表空间，会提示解除级联关系，否则无法删除
```sql
--删除表空间
drop tablespace TEST;
```
删除表空间下的索引，解决ORA-02429。
解除表的约束提示唯一主键有关联关系，删掉索引。以下为测试的示例，解除约束并删除。
```sql
--解除表的约束提示唯一主键有关联关系，删掉索引
alter table test.test01 drop constraint constraint_test01;
alter table test.test drop constraint sys_c0012187;
```

赋予表空间
```sql
--赋予表空间
alter user TEST default tablespace TEST;
```

表占用空间
```sql
--表占用空间
Select Segment_Name,Sum(bytes)/1024/1024 From User_Extents Group By Segment_Name;
```

表空间占用空间
```sql
--表空间占用空间
Select Tablespace_Name,Sum(bytes)/1024/1024 From Dba_Segments Group By Tablespace_Name;
```

会话相关信息
```sql
--会话相关信息
select username from v$session;
```

###  2、Oracle常用动态性能视图

```sql
--v$logfiles视图查看日志，有关实例重置日志组文件名及其位置信息
select member from v$logfile;
```

```sql
--关于数据库相关信息
select * from v$database;
```

```sql
--从控制文件中提取有关重做日志组的信息
select * from v$log;
```

```sql
--记录归档日志文件的基本信息
select * from v$archived_log;
```

```sql
--记录归档日志文件的路径信息
select * from v$archive_dest;
```

```sql
--控制文件相关信息
select * from v$controlfile;
```

记录实例基本信息
```sql
--记录实例基本信息
select * from v$instance;
```

数据库所有索引描述
```sql
--数据库所有索引描述
select * from dba_indexes;
```

```sql
--所有表及簇上压缩索引的列
select * from dba_ind_columns;
```

```sql
--所有用户触发器信息
select * from dba_triggers;
```

```sql
--所有用户存储过程信息
select * from dba_source;
```

```sql
--关于数据库文件信息
select * from dba_data_files;
```

```sql
--关于对象授权信息
--select * from dba_tab_grants;
select * from dba_tab_privs;
```

```sql
--数据库所有的对象
select * from dba_objects;
```

```sql
--数量比较大，慎重点查询所有
select count(*) from dba_objects;
select * from dba_object_tables;
```

```sql
--数据库中所有用户信息
select * from dba_users;
```


### 3、Oracle数据字典

```sql
--表空间信息
select * from dba_tablespaces;
select * from dba_tablespaces t where t.TABLESPACE_NAME='USERS';
```

```sql
--数据表描述
select * from dba_tables t where t.TABLE_NAME IN ('DEPT', 'EMP');
```

```sql
--视图信息
select * from dba_views;
```

```sql
--序列信息
select * from dba_sequences;
```

```sql
--用户表约束信息
select * from dba_constraints;
```

```sql
--所有表空间自由分区
select * from dba_free_space;
```

```sql
--sga分区大小
select * from v$sga;
--统计sga使用情况信息
select * from v$sgastat;
```

```sql
--会话相关信息
select * from v$session;
```

```sql
--sql语句信息
select * from v$sql;
--记录SQL语句的语句信息
select * from v$sqltext;
```

```sql
--显示实例当前有效的参数信息
select * from v$parameter;
```

```sql
--通过访问数据库会话，设置对象锁的所有信息
select * from v$lock;
--锁类型信息
select * from v$lock_type;
--v$lock_activity（活跃状态）
select * from v$lock_activity;
```



** TRUNCATE 与 DELETE，此处涉及到暂存以及回滚机制，使用TRUNCATE更彻底 **



**NOT EXISTS 与 NOT IN**

```sql
select * from scott.emp;
select * from scott.dept;
```

```sql
--NOT IN对数据库执行全表遍历，尽量避免使用
select empno, ename
  from scott.emp
 where empno not in (select deptno from scott.dept where loc = 'DALLAS');
```

 ```sql
--结果集过大，优化采用NOT EXISTS
select empno, ename
  from scott.emp
 where exists (select deptno from scott.dept where loc != 'DALLAS');
 ```

# 龙腾万里sky

<H3 align=center><a href="https://blog.csdn.net/Tolove_dream">by 龙腾万里sky 原创不易，白嫖有瘾</a></H3>
