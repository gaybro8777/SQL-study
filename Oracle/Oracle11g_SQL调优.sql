/** Oracle11g调优参考  **/
/** 日志量写入过多，导致服务器Oracle实例关闭后无法启动；
建议，先清理日志，然后手动使用命令重启监听服务 **/


/** Oracle常用动态性能视图 **/
--v$logfiles视图查看日志，有关实例重置日志组文件名及其位置信息
select member from v$logfile;
--关于数据库相关信息
select * from v$database;
--从控制文件中提取有关重做日志组的信息
select * from v$log;
--记录归档日志文件的基本信息
select * from v$archived_log;
--记录归档日志文件的路径信息
select * from v$archive_dest;
--控制文件相关信息
select * from v$controlfile;
--记录实例基本信息
select * from v$instance;
--数据库所有索引描述
select * from dba_indexes;
--所有表及簇上压缩索引的列
select * from dba_ind_columns;
--素有用户触发器信息
select * from dba_triggers;
--所有用户存储过程信息
select * from dba_source;
--关于数据库文件信息
select * from dba_data_files;
--关于对象授权信息
--select * from dba_tab_grants;
select * from dba_tab_privs;
--数据库所有的对象
select * from dba_objects;
select count(*) from dba_objects;--71941,数量比较大，慎重点查询所有
select * from dba_object_tables;
--数据库中所有用户信息
select * from dba_users;


/** Oracle数据字典 **/
--表空间信息
select * from dba_tablespaces;
--数据表描述
select * from dba_tables t where t.TABLE_NAME IN('DEPT','EMP');
--视图信息
select * from dba_views;
--序列信息
select * from dba_sequences;
--用户表约束信息
select * from dba_constraints;
--所有表空间自由分区
select * from dba_free_space;
--sga分区大小
select * from v$sga;
--统计sga使用情况信息
select * from v$sgastat;
--会话相关信息
select * from v$session;
--sql语句信息
select * from v$sql;
--记录SQL语句的语句信息
select * from v$sqltext;
--显示实例当前有效的参数信息
select * from v$parameter;
--通过访问数据库会话，设置对象锁的所有信息
select * from v$lock;
--锁类型信息
select * from v$lock_type;
--v$lock_activity
select * from v$lock_activity;

 /** TRUNCATE 与 DELETE **/
 
 /** NOT EXISTS 与 NOT IN **/
select * from scott.emp; 
select * from scott.dept;
--NOT IN对数据库执行全表遍历，尽量避免使用
select empno,ename from scott.emp where empno 
not in(select deptno from scott.dept where loc='DALLAS');
--结果集过大，优化采用NOT EXISTS
select empno,ename from scott.emp where 
exists(select deptno from scott.dept where loc != 'DALLAS');
