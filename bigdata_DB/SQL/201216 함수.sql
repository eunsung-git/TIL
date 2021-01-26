--DROP TABLE STUDENT PURGE ;

CREATE TABLE STUDENT
(ID      NUMBER(2),
 NAME    VARCHAR2(9), 
 EMAIL   VARCHAR2(30), 
 PHONE   CHAR(13)) ; 
 
INSERT INTO STUDENT VALUES (1,'����ȣ','vjhlcoz@daum.net','010-4826-1948');
INSERT INTO STUDENT VALUES (2,'������','bfjcy@naver.com','010-5624-3215');
INSERT INTO STUDENT VALUES (3,'������','aposex@gmail.com','010-1259-8394');
INSERT INTO STUDENT VALUES (4,'������','qyjrcl@nate.com','010-1542-6332');
INSERT INTO STUDENT VALUES (5,'��¹�','vbwgb@naver.com','010-1094-8294');
INSERT INTO STUDENT VALUES (6,'������','jlqlqo@naver.com','010-9950-8901');
INSERT INTO STUDENT VALUES (7,'������','rnbaab@gmail.com','010-1700-4614');
INSERT INTO STUDENT VALUES (8,'�ǿ�ö','bwoii@naver.com','010-5893-7300');
INSERT INTO STUDENT VALUES (9,'�����','jszrux@gmail.com','010-5683-4188');
INSERT INTO STUDENT VALUES (10,'�����','xgykz@naver.com','010-2020-8820');
INSERT INTO STUDENT VALUES (11,'��ä��','miidtr@naver.com','010-4716-4290');
INSERT INTO STUDENT VALUES (12,'�ּ���','ozkng@gmail.com','010-4400-8160');
INSERT INTO STUDENT VALUES (13,'���ظ�','gasfmwy@naver.com','010-6412-9910');
INSERT INTO STUDENT VALUES (14,'�赿��','azufi@nate.com','010-9519-8283');
INSERT INTO STUDENT VALUES (15,'������','yvtljnq@naver.com','010-9490-7104');
INSERT INTO STUDENT VALUES (16,'����ȣ','wnnmy@gmail.com','010-5580-5992');
INSERT INTO STUDENT VALUES (17,'�켺ȣ','bduiu@nate.com','010-5808-3549');
INSERT INTO STUDENT VALUES (18,'��ȿ��','ekofk@naver.com','010-6550-6640');
INSERT INTO STUDENT VALUES (19,'��ä��','lndxfd@naver.com','010-2908-6720');
INSERT INTO STUDENT VALUES (20,'������','muypfnw@gmail.com','010-6703-5528');
INSERT INTO STUDENT VALUES (21,'������','lpqiyw@naver.com','010-9430-8655');
INSERT INTO STUDENT VALUES (22,'������','mtkhar@nate.com','010-1938-5745');
INSERT INTO STUDENT VALUES (23,'���볲','uwkpog@naver.com','010-1932-6957');
INSERT INTO STUDENT VALUES (24,'����ȣ','inntr@naver.com','010-5157-4726');

COMMIT ;

SELECT * FROM STUDENT ;

----------

SELECT ID
    ,REPLACE(NAME,SUBSTR(NAME,2,1),'*') NAME
    ,SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1) EMAIL
    ,REPLACE(PHONE,substr(PHONE,-4),'****') PHOME
FROM STUDENT;

SELECT EMAIL
    ,SUBSTR(EMAIL,INSTR(EMAIL,'@')+1) DOMAIN
FROM STUDENT;