

-- Q!
CREATE TABLE member1(
  member_id NUMBER(5), 
  member_name VARCHAR(30), 
  member_address VARCHAR(50), 
  acc_open_date DATE, 
  membership_type VARCHAR(20),
  fees_paid NUMBER(4),
  max_allowed_books NUMBER(2),
  penalty_amount NUMBER(7,2)
);



CREATE TABLE BOOKS1(
  book_no NUMBER(6),
  book_name VARCHAR(30),
  author_name VARCHAR(30),
  COST NUMBER(7,2),
  CATEGORY CHAR(10)
);


CREATE TABLE issue1(
  lib_issue_id NUMBER(10),
  book_no NUMBER(6),
  member_id NUMBER(5),
  issue_date DATE,
  return_date DATE
);


-- Q2
describe issue1;
desc  books1;
desc member1;

-- Q3
DROP TABLE member1;


-- Q4
CREATE TABLE member1(
  member_id NUMBER(5), 
  member_name VARCHAR(30), 
  member_address VARCHAR(50), 
  acc_open_date DATE, 
  membership_type VARCHAR(20),
  fees_paid NUMBER(4),
  max_allowed_books NUMBER(2),
  penalty_amount NUMBER(7,2),
  PRIMARY KEY(member_id),
  CHECK(membership_type IN ('Lifetime', 'Annual', 'Half Yearly', 'Quarterly'))
);


-- Viewing user constraints
--SELECT * 
--FROM ALL_CONSTRAINTS
--WHERE table_name = 'MEMBER1';


-- trying to insert row in member1 table
--insert into member1 values(1,'Raj','Mumbai','10-10-2012','2 days',200,2,12.3); (Will not work as check constrain oes not allow)
--insert into member1 values(1,'Raj','Mumbai','10-10-2012','Lifetime',200,2,12.3); (Works fine)



-- Q5
ALTER TABLE member1
MODIFY member_name VARCHAR(30);


-- Q6
ALTER TABLE ISSUE1 
ADD reference CHAR(30);


-- Q7
ALTER TABLE ISSUE1
DROP COLUMN reference;


-- Q8
ALTER TABLE issue1
RENAME TO lib_issue1;


desc lib_issue;



-- Q9
INSERT INTO member1(member_id, member_name, member_address, acc_open_date, membership_type, fees_paid, max_allowed_books, penalty_amount) 
            VALUES(1, 'Richa Sharma', 'PUNE', '10-DEC-05', 'Lifetime', 2500, 5, 50);
            
INSERT INTO member1(member_id, member_name, member_address, acc_open_date, membership_type, fees_paid, max_allowed_books, penalty_amount)             
            VALUES(2, 'Garima Sen', 'Pune', current_date, 'Annual', 1000, 3, NULL);
            
            
SELECT * 
FROM member1;
        
            
            
-- Q10
INSERT INTO member1 VALUES(3, 'Salman Khan', 'Mumbai', current_date, 'Half Yearly', 6000, 9, 120);
INSERT INTO member1 VALUES(4, 'Virat Kohli', 'Delhi', current_date, 'Lifetime', 5000, 7, NULL);
INSERT INTO member1 VALUES(5, 'Sachin Tendulkar', 'Mumbai', current_date, 'Annual', 5000, 7, 10);
INSERT INTO member1 VALUES(6, 'Sanjay Dutt', 'Mumbai', current_date, 'Quarterly', 3000, 4, 150);
INSERT INTO member1 VALUES(7, 'Shahrukh Khan', 'Mumbai', current_date, 'Lifetime', 4000, 5, NULL);
            
            
            
-- Q11
ALTER TABLE member1
MODIFY member_name VARCHAR(20);


-- Q12
INSERT INTO member1 VALUES(7, 'Shahrukh Khan', 'Mumbai', current_date, 'Lifetime', 4000, 110, NULL);
  -- This throws an error brecause the column can accept only 2 digit number and we atre trying to insert 3 digit number.
  
    
-- Q13
CREATE TABLE member101 as (SELECT * FROM member1);



-- Q14
ALTER TABLE member1 ADD CONSTRAINT max_allowed_books_cons CHECK(max_allowed_books < 100); 
ALTER TABLE member1 ADD CONSTRAINT  penalty_amount_cons CHECK(penalty_amount <= 1000);


-- Q15
DROP TABLE books1;


-- Q16
CREATE TABLE BOOKS1(
  book_no NUMBER(6) PRIMARY KEY,
  book_name VARCHAR(30) NOT NULL,
  author_name VARCHAR(30),
  COST NUMBER(7,2),
  CATEGORY CHAR(10) CHECK(CATEGORY IN ('Science', 'Fiction', 'Database', 'RDBMS', 'Others'))
);


-- Q17
INSERT INTO BOOKS1 VALUES(101,'Let us C','Denice Ritchie',450,'Others');
INSERT INTO BOOKS1 VALUES(102,'Oracle – Complete Ref','Loni',550,'Database');
INSERT INTO BOOKS1 VALUES(103,'Mastering SQL','Loni',250,'Database');
INSERT INTO BOOKS1 VALUES(104,'PL SQL-Ref','Scott Urman',750,'Database');


select * from books1;


-- Q18
INSERT INTO books1 VALUES(&book_no, &book_name, &author_name, &cost, &category);

select * from books1;



-- Q19
CREATE TABLE book101 as (SELECT * FROM books WHERE 1=0);

SELECT * FROM BOOK101;

-- Q20
INSERT INTO book101 (SELECT * FROM books1);

--
SELECT * FROM book101;


-- Q21
COMMIT;


-- Q22
SELECT * FROM MEMBER101;
SELECT * FROM BOOK101;
SELECT * FROM LIB_ISSUE1;


-- Q23
INSERT  INTO books1 VALUES(106, 'National Geographic', 'Adis Scott', 1000, 'Science');


-- Q24
ROLLBACK;T


-- Q25
UPDATE books1 SET cost = 300, category = 'RDBMS'
WHERE book_no = 103;

select * from books1;


-- Q26 
ALTER TABLE lib_issue1 
RENAME TO issue1;


-- Q27
DROP TABLE ISSUE1;


-- Q28


CREATE TABLE issue1(
  lib_issue_id NUMBER(10) PRIMARY KEY,
  book_no NUMBER(6) REFERENCES books1(book_no),
  member_id NUMBER(5) REFERENCES member1(member_id),
  issue_date DATE,
  return_date DATE,
  CHECK(issue_date < return_date)
);


-- Q29
INSERT INTO issue1(lib_issue_id, book_no, member_id, issue_date) VALUES(7001,101,1,'10-dec-06');
INSERT INTO issue1(lib_issue_id, book_no, member_id, issue_date) VALUES(7002,102,2,'25-dec-06');
INSERT INTO issue1(lib_issue_id, book_no, member_id, issue_date) VALUES(7003,104,1,'15-jan-06');
INSERT INTO issue1(lib_issue_id, book_no, member_id, issue_date) VALUES(7004,101,1,'04-jul-06');
INSERT INTO issue1(lib_issue_id, book_no, member_id, issue_date) VALUES(7005,104,2,'15-nov-06');
INSERT INTO issue1(lib_issue_id, book_no, member_id, issue_date) VALUES(7006,101,3,'18-feb-06');
 
 
-- Q30 
COMMIT;
SELECT * from issue1;




-- Q31
select * from all_constraints where table_name = 'ISSUE1';

ALTER TABLE issue1
MODIFY CONSTRAINT SYS_C007370 DISABLE;

ALTER TABLE issue1
MODIFY CONSTRAINT SYS_C007371 DISABLE;

ALTER TABLE issue1
MODIFY CONSTRAINT SYS_C007368 DISABLE;

ALTER TABLE issue1
MODIFY CONSTRAINT SYS_C007369 DISABLE;


-- Q32
INSERT INTO issue1(lib_issue_id, book_no, member_id, issue_date) VALUES(7006,111,3,'18-feb-06');


-- Q33
ALTER TABLE issue1
MODIFY CONSTRAINT SYS_C007370 ENABLE;

ALTER TABLE issue1
MODIFY CONSTRAINT SYS_C007371 ENABLE;

ALTER TABLE issue1
MODIFY CONSTRAINT SYS_C007368 ENABLE;

ALTER TABLE issue1
MODIFY CONSTRAINT SYS_C007369 ENABLE;


-- Q34
DELETE FROM issue1 WHERE book_no = 111;



-- Q35 
DELETE FROM member1 WHERE member_id = 1;


-- Q36
UPDATE issue1 SET issue_date = issue_date + 15
WHERE lib_issue_id IN (7004,7005);


select * from issue1;


-- Q37
UPDATE member1 SET penalty_amount = 100
WHERE member_name LIKE '%Garima Sen';


-- Q38
Savepoint x;


-- Q39
DELETE FROM issue1
WHERE member_id = 1 AND issue_date < '10-dec-06';


-- Q40
DELETE FROM books1
WHERE category not in ('RDBMS', 'Database');


select * from books1;
select * from issue1;

-- Q41 
ROLLBACK to x;

-- Q42
COMMIT x;


-- Q43
DROP TABLE member101;


-- Q44
DROP TABLE book101;


--Q45
DESC member1;
DESC books1;
DESC issue1;

SELECT * FROM member1;
SELECT * FROM books1;
SELECT * FROM issue1;


-- Q46
CREATE SEQUENCE seq1
INCREMENT BY 2
START WITH 100
MINVALUE 100
MAXVALUE 200
CYCLE
CACHE 2;


-- q47
DROP SEQUENCE SEQ1;



-- Q48 
CREATE SEQUENCE BOOK_SEQ
INCREMENT BY 1
START WITH 101
MINVALUE 100
MAXVALUE 1000
NOCYCLE;


-- Q49
CREATE SEQUENCE member_seq
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 100
NOCYCLE;


-- Q50
DROP SEQUENCE book_seq;
DROP SEQUENCE member_seq;



--------------------------------------------------------------------------------------------
TASK 2
--------------------------------------------------------------------------------------------

-- Q1
SELECT * FROM books1 
WHERE author_name = 'Loni' AND cost < 600;



-- Q2
SELECT book_name FROM 
books1 LEFT JOIN issue1
ON books1.book_no = books1.book_no
WHERE return_date IS NULL
GROUP BY books1.book_no, book_name;



-- Q3
UPDATE issue1
SET return_date = '31-dec-06'
WHERE lib_issue_id NOT IN (7005,7006);


-- Q4
SELECT * 
FROM books1 b LEFT JOIN issue1 i
ON b.book_no = i.book_no
WHERE (return_date - issue_date) > 30;


-- Q5
SELECT * 
FROM books1
WHERE cost BETWEEN 500 AND 750 AND category = 'Database';


-- Q6
SELECT *
FROM books1
WHERE category IN ('Science', 'Database', 'Fiction', 'Management');


-- Q7
SELECT * 
FROM member1
ORDER BY penalty_amount DESC;


-- Q8
SELECT *
FROM books1
ORDER BY category ASC , cost DESC;


-- Q9
SELECT *
FROM books1
WHERE book_name LIKE '%SQL';


-- Q10
SELECT *
FROM member1
WHERE member_name LIKE 'R%i%' OR member_name LIKE 'G%i%';


-- Q11
SELECT INITCAP(book_name)AS book_name, UPPER(author_name) AS author_name
FROM books1
ORDER BY book_name DESC;


-- Q12
SELECT lib_issue_id, book_no, member_id, TO_CHAR(issue_date,'Day, Month, DD, YYYY'), TO_CHAR(return_date,'Day, Month, DD, YYYY') 
FROM issue1
WHERE member_id = 1;


-- Q13
SELECT books1.*, SUBSTR(category,1,1) as Category_initial
FROM books1;


-- Q14
SELECT *
FROM member1
WHERE EXTRACT(YEAR FROM acc_open_date) = '2006';


-- Q15
SELECT lib_issue_id, issue_date, return_date, 
  CASE
    WHEN return_date IS NULL 
      THEN current_date - issue_date
    ELSE return_date - issue_date
  END as issued_days_count

FROM issue1;


-- Q16
SELECT *
FROM member1
ORDER BY acc_open_date;


-- Q17
SELECT member_id, COUNT(lib_issue_id)issue_count
FROM issue1
WHERE member_id = 1
GROUP BY member_id;


-- Q18
SELECT SUM(penalty_amount) as total_penalty_amount
FROM member1;


-- Q19
SELECT COUNT(*) as total_members
FROM member1;


-- Q20
SELECT COUNT(*) AS total_books_issued
FROM issue1;

-- Q21
SELECT ROUND(AVG(fees_paid),2) as avg_fees_paid
FROM member1;


-- Q22
SELECT lib_issue_id, ROUND(ABS(MONTHS_BETWEEN(return_date,issue_date))) as months_issued
FROM issue1;


-- Q23
SELECT member_name, LENGTH(member_name) as name_length
FROM member1;


-- Q24
SELECT member_id, member_name, SUBSTR(membership_type,1,5) as membership_type
FROM member1;


-- Q25
SELECT issue_date, LAST_DAY(ISSUE_DATE) AS LAST_DAY_OF_MONTH
FROM issue1;


-- Q26
SELECT category, COUNT(book_no) as book_count
FROM books1
GROUP BY category;


-- Q27
SELECT book_no, count(lib_issue_id) as issue_count
FROM issue1
GROUP BY book_no;


-- Q28
SELECT MAX(penalty_amount) as max_amount, MIN(penalty_amount) as MIn_amount, SUM(penalty_amount) as Total_amount, AVG(penalty_amount) as avg_amount
FROM member1;


-- Q29
SELECT member_id, COUNT(lib_issue_id) AS book_count
FROM issue1
GROUP BY member_id
HAVING COUNT(lib_issue_id) > 2;


-- Q30 
SELECT member_id, book_no, COUNT(lib_issue_id) as book_issue_count
FROM  issue1
GROUP BY member_id, book_no
ORDER BY book_issue_count DESC;


-- Q31
SELECT EXTRACT(YEAR FROM issue_date) AS YEAR_, EXTRACT(MONTH FROM issue_date) as MONTH_, COUNT(lib_issue_id) as issue_count
FROM issue1
GROUP BY EXTRACT(YEAR FROM issue_date), EXTRACT(MONTH FROM issue_date)
ORDER BY issue_count DESC;





--------------------------------------------------------------------------------------------
TASK 3
--------------------------------------------------------------------------------------------

-- Q1
WITH CTE AS(
  SELECT DISTINCT BOOK_NO FROM issue1
)

SELECT * FROM books1
WHERE book_no NOT IN (SELECT * FROM CTE);



-- Q2
WITH CTE AS (
  SELECT DISTINCT member_id FROM issue1
)
SELECT * FROM member WHERE member_id IN (SELECT * FROM CTE);


-- Q3
--max
WITH CTE AS (SELECT MAX(COUNT(lib_issue_id)) FROM issue1 GROUP BY member_id)

SELECT MEMBER_ID, COUNT(lib_issue_id) as book_count 
FROM issue1
GROUP BY  member_id
HAVING COUNT(lib_issue_id) = (SELECT * FROM CTE);


--min
WITH CTE AS (SELECT MIN(COUNT(lib_issue_id)) FROM issue1 GROUP BY member_id)

SELECT MEMBER_ID, COUNT(lib_issue_id) as book_count 
FROM issue1
GROUP BY  member_id
HAVING COUNT(lib_issue_id) = (SELECT * FROM CTE);


-- Q4
SELECT i.book_no, book_name, issue_date
FROM issue1 i LEFT JOIN books1 b
ON i.book_no = b.book_no
WHERE EXTRACT(MONTH FROM issue_date) = 12
AND category = 'Database';

-- Q5
SELECT m.member_id, m.member_name, COUNT(i.lib_issue_id) as book_issue_cnt
FROM issue1 i LEFT JOIN member1 m
ON i.member_id = m.member_id
GROUP BY m.member_id, m.member_name
ORDER BY book_issue_cnt;


-- Q6
SELECT b.book_no, book_name, issue_date, return_date
FROM issue1 i LEFT JOIN member1 m
ON i.member_id = m.member_id
LEFT JOIN books b
ON i.book_no = b.book_no
WHERE member_name LIKE 'Richa Sharma';



-- Q7 
SELECT DISTINCT member_id, category
FROM issue1 i LEFT JOIN books1 b
ON i.book_no = b.book_no
WHERE category = 'Database';


-- Q8
WITH CTE AS (SELECT category, max(cost) as cost FROM books1 GROUP BY category)

SELECT book_no, book_name, cost, category
FROM books1
WHERE (category,cost) IN (SELECT category,cost from cte);


-- Q9
SELECT * FROM member1
WHERE member_id NOT IN(SELECT DISTINCT member_id FROM issue1);



-- Q10
WITH CTE AS (SELECT member_id, COUNT(lib_issue_id) as issue_cnt
FROM issue1
GROUP BY member_id
)

SELECT * 
FROM member1 m LEFT JOIN CTE C
ON m.member_id = c.member_id
WHERE issue_cnt > max_allowed_books ;



-- Q11
SELECT * FROM member1 WHERE member_id IN 
(SELECT DISTINCT member_id FROM issue1 WHERE book_no IN
(SELECT book_no
FROM issue1 i JOIN member1 m
ON i.member_id = m.member_id
WHERE member_name LIKE 'Garima%'))

AND member_name NOT LIKE 'Garima%';



-- Q12
SELECT BOOK_NO, BOOK_NAME, cost FROM books1 
WHERE book_no IN
(SELECT book_no FROM issue1 WHERE return_date - issue_date > 30);



-- Q13
SELECT author_name
FROM books1
GROUP BY author_name
HAVING count(book_no) > 1;


-- Q14
-- MAX
SELECT * FROM
(SELECT member_id, COUNT(lib_issue_id) as issue_cnt
FROM issue1 GROUP BY member_id
ORDER BY issue_cnt DESC)
WHERE ROWNUM = 1;

-- MIN
SELECT * FROM
(SELECT member_id, COUNT(lib_issue_id) as issue_cnt
FROM issue1 GROUP BY member_id
ORDER BY issue_cnt asc)
WHERE ROWNUM = 1;



-- Q15
SELECT *
FROM
(SELECT * FROM books1
ORDER BY cost DESC)
WHERE ROWNUM <= 3;


--OR
SELECT * FROM
(SELECT book_no, book_name, cost, RANK() OVER (ORDER BY cost DESC) as rank_
FROM books1)
WHERE rank_ <= 3;




--------------------------------------------------------------------------------------------
TASK 4
--------------------------------------------------------------------------------------------

-- Q1
CREATE VIEW member_issue_view AS 
  ( SELECT m.*, i.lib_issue_id, i.book_no, i.issue_date, i.return_date 
    FROM member1 m JOIN issue1 i 
    ON m.member_id = i.member_id
  );
  
SELECT * FROM member_issue_view;


-- Q2
CREATE VIEW annual_members AS (SELECT * FROM member1 WHERE membership_type = 'Annual');
SELECT * FROM annual_members;


-- Q3
CREATE VIEW lifetime_members AS (SELECT * FROM member1 WHERE membership_type = 'Lifetime')
WITH CHECK OPTION;

SELECT * FROM lifetime_members;

-- Fails
--INSERT INTO lifetime_members VALUES(8, 'Shahrukh Khan', 'Mumbai', current_date, 'Annual', 400, 11, NULL);

-- Success
INSERT INTO lifetime_members VALUES(8, 'Shahrukh Khan', 'Mumbai', current_date, 'Lifetime', 400, 11, NULL);



-- Q4
CREATE VIEW science_books AS 
(
  SELECT * FROM books WHERE category = 'Science'
) WITH READ ONLY;

SELECT * FROM science_books;



-- Q5 
CREATE VIEW books_issued_members AS
(SELECT m.member_id, member_name, book_no, issue_date FROM member1 m LEFT JOIN issue1 i ON m.member_id = i.member_id);

SELECT * FROM BOOKS_ISSUED_MEMBERS;


-- Q6
CREATE VIEW issued_books AS (SELECT i.book_no, book_name, member_id, issue_date
FROM issue1 i LEFT JOIN books1 b
ON i.book_no = b.book_no);

SELECT * FROM issued_books;



-- Q7
CREATE VIEW issue_info AS
(
  SELECT i.book_no, b.book_name, i.member_id, m.member_name, i.issue_date, i.return_date
  FROM issue1 i JOIN books1 b ON i.book_no = b.book_no
  JOIN member1 m ON i.member_id = m.member_id
  WHERE TO_CHAR(return_date,'Month') IN ('June ', 'December ')
);

SELECT * FROM issue_info;



-- Q8



-- Deleting duplicate elements
CREATE TABLE R1(ENO NUMBER(3),ENAME VARCHAR2(20),SAL NUMBER(4));


INSERT INTO R1 VALUES(1,'VIRAT',2000);
INSERT INTO R1 VALUES(2,'RAVI',1000);
INSERT INTO R1 VALUES(2,'RAVI',1000);
INSERT INTO R1 VALUES(3,'MSD',3000);
INSERT INTO R1 VALUES(4,'SUNIL',2000);
INSERT INTO R1 VALUES(5,'ROHIT',2000);
INSERT INTO R1 VALUES(5,'ROHIT',2000);

COMMIT;


SELECT rowid,r1.* FROM R1;

delete from r1 where r1.rowid in (select a.rowid from r1 a join r1 b on a.eno = b.eno and a.ename = b.ename and a.sal = b.sal and a.rowid > b.rowid );




  
  