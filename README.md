# 主流数据库

#### 介绍
SQL知识梳理
## MySQL

    ### MySQL主从复制

    ### MySQL快速生成并插入1kw条数据

    ### 学生表随机生成1000w数据

/** 创建表tolove **/

```
CREATE TABLE test.`tolove` (
  `ID` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `GIRE_NAME` VARCHAR(64) COLLATE utf8_bin DEFAULT NULL,
  `GIRL_AGE` VARCHAR(64) COLLATE utf8_bin DEFAULT NULL,
  `CUP_SIZE` VARCHAR(10) COLLATE utf8_bin DEFAULT NULL
) ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_bin

```


/** 创建函数 生成学号 **/

```
DELIMITER $
CREATE FUNCTION rand_number() RETURNS INT
BEGIN
	DECLARE i INT DEFAULT 0;
	SET i= FLOOR(1+RAND()*100);
	RETURN i;
END $
DELIMITER $
```


/** 创建函数 生成姓名随机字符串 **/

```
DELIMITER $
CREATE FUNCTION rand_name(n INT) RETURNS VARCHAR(255)
BEGIN
	DECLARE chars_str VARCHAR(100) DEFAULT 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
	DECLARE return_str VARCHAR(255) DEFAULT '';
	DECLARE i INT DEFAULT 0;
	WHILE i < n DO
	SET return_str = CONCAT(return_str,SUBSTRING(chars_str,FLOOR(1+RAND()*52),1));
	SET i = i+1;
	END WHILE;
	RETURN return_str;	
END $
DELIMITER $
```


/** 创建存储过程 **/

```
DELIMITER $
CREATE PROCEDURE insert_tolove(IN max_num INT(10))
BEGIN
	DECLARE i INT DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;
	START TRANSACTION;
	WHILE i< max_num DO
	INSERT INTO test.`tolove`(ID,GIRL_NAME,GIRL_AGE,CUP_SIZE) VALUES(NULL,rand_name(5),rand_number(),NULL);
	SET i = i + 1;
	END WHILE;
COMMIT;
END $
DELIMITER $
```



/** 调试 **/

```
SHOW FUNCTION STATUS;
UPDATE mysql.`proc` SET  Security_type='INVOKER';
SET GLOBAL event_scheduler=1;

COMMIT;

SELECT * FROM mysql.`event`;
```



/** 调用，生成1kw条数据 **/

```
CALL insert_tolove(1000*10000);
SELECT COUNT(*) FROM test.`tolove` t WHERE t.girl_age='16';
```


/** 验证是否输错 **/
`INSERT INTO test.`tolove`(ID,GIRL_NAME,GIRL_AGE,CUP_SIZE) VALUES(NULL,'1','1','A');`

## Oracle

    ### Oracle11g调优参考

    ### Oracle常用动态性能视图 

    ### Oracle高级应用

一、Oracle初始化参数分类

1. 1、基本参数和高级参数两类
1. 1.1、基本参数：是一组可调整的参数
1. 1.2、高级参数：是一组精细调整的参数
1. 1.3、按环境关系分类
1. 1.3.1、起源参数：由另外的参数计算得到，这些参数的值不需要在参数文件中改变或指定
1. 1.3.2、带GC前缀的全局高速缓存参数：即全局高速缓存，这些参数通常在多个实例并行的环境下使用
1. 1.3.3、与操作系统有关的参数：如参数DB_FILE_MULTIBLOCK_READ_COUNT与主机的操作系统对磁盘的I/O有关
1. 1.3.4、可变参数：与系统性能有关。部分可变参数用来设置容量限制，但不影响Oracle系统性能
1. 1.3.5、异类服务参数：可用于设置网关的参数，如使用DBMS_HS包等


二、主要系统调优参数介绍

1. Oracle11g的初始化参数存放在初始化参数文件SPFILE中，SPFILE是一个二进制文件，只能有Oracle系统进行读写。
1. 如果对其中的参数进行修改，可将所修改的参数写到SPFILE文件中或仅使用当前Oracle实例有效而不必写到初始化
1. 文件中。
1. 
1. 在Oracle11g中与系统优化有关的主要参数如下：
1. buffer_pool_keep：保留池大小（从DB_BLOCK_BUFFERS分配）。目的是将对象保留在内存中，以到达减少I/O;
1. buffer_pool_recycle：循环池大小（从DB_BLOCK_BUFFERS分配）。目的是使用对象后将其清除，以便重复使用内存;
1. control_file_record_keep_time：控制文件中可重新使用部分中的记录必须保留的最短时间（天数）;



三、系统全局区（SGA）优化
1. Oracle11g虽然增加了内存的自动调整，但是有必要详细了解Oracle内存的调整方法与技巧，因为更具针对性和实用性。


四、优化SQL语句

1. 1、建议：不使用"*"代表所有列名，举个例子，如果海量数据，查询会导致数据库直接崩溃。
1. 2、使用TRUNCATE代替DELETE
1. 3、在确保完整的情况下多用commit语句
1. 4、尽量减少表的查询次数
1. 5、使用NOT EXISTS代替NOT IN
1. 6、表连接优化
1. 7、合理使用索引
1. 8、避免全表扫描大表
1. 9、优化器的使用：比如EXPLAIN PLAN执行计划
1. 10、SQL调优顾问


五、Oracle数据备份与恢复


六、数据导入导出


七、Oracle11g闪回技术


## DM8
### DM dts迁移工具 迁移数据到MySQL

```
/** 通过DM数据库迁移工具迁移的数据 **/
/** student 100w**/
SELECT COUNT(*) FROM test.`student`;
UPDATE test.`student` s SET s.`stu_age`='18' WHERE s.`stu_name` LIKE 'A%';
UPDATE test.`student` s SET s.`stu_sex`='女';
```



```
SELECT COUNT(*) FROM test.student t WHERE t.`stu_name` LIKE 'A%'

/** test 1000w **/
SELECT COUNT(*) FROM test.`test`;
```


#### 软件架构
软件架构说明


#### 安装教程

1.  xxxx
2.  xxxx
3.  xxxx

#### 使用说明

1.  xxxx
2.  xxxx
3.  xxxx

#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request


#### 特技

1.  使用 Readme\_XXX.md 来支持不同的语言，例如 Readme\_en.md, Readme\_zh.md
2.  Gitee 官方博客 [blog.gitee.com](https://blog.gitee.com)
3.  你可以 [https://gitee.com/explore](https://gitee.com/explore) 这个地址来了解 Gitee 上的优秀开源项目
4.  [GVP](https://gitee.com/gvp) 全称是 Gitee 最有价值开源项目，是综合评定出的优秀开源项目
5.  Gitee 官方提供的使用手册 [https://gitee.com/help](https://gitee.com/help)
6.  Gitee 封面人物是一档用来展示 Gitee 会员风采的栏目 [https://gitee.com/gitee-stars/](https://gitee.com/gitee-stars/)
