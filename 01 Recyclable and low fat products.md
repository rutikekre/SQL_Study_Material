
### 01. Recyclable and Low Fat Products

[Click here to see question](https://leetcode.com/problems/recyclable-and-low-fat-products/?envType=study-plan-v2&envId=top-sql-50 )

###### Solution

```sql
SELECT product_id
FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y';
```


*---------------------------------------------------*


### 02. Find Customer Referee

[Click here to see question](https://leetcode.com/problems/find-customer-referee/description/?envType=study-plan-v2)

###### Solution

```sql
SELECT name
FROM Customer
WHERE referee_id <> 2 OR referee_id IS NULL;
```


*---------------------------------------------------*


###  03. Big Countries

[Click here to see question](https://leetcode.com/problems/big-countries/description/?envType=study-plan-v2&envId=top-sql-50)

###### Solution

```sql
SELECT name, population, area
FROM World
WHERE area >= 3000000 OR
population >= 25000000;
```


*---------------------------------------------------*


###  04. Article Views I

[Click here to see question](https://leetcode.com/problems/article-views-i/?envType=study-plan-v2&envId=top-sql-50)

###### Solution

```sql
SELECT DISTINCT(author_id) as id
FROM Views
WHERE author_id = viewer_id
ORDER BY author_id;
```


*---------------------------------------------------*


### 05. Invalid Tweets

[Click here to see question](https://leetcode.com/problems/invalid-tweets/description/?envType=study-plan-v2&envId=top-sql-50)

###### Solution

```sql
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15;
```


*---------------------------------------------------*


###  06. Replace Employee ID With The Unique Identifier

[Click here to see question](https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/?envType=study-plan-v2&envId=top-sql-50)

###### Solution

```sql
SELECT unique_id, name
FROM Employees E LEFT JOIN EmployeeUNI EU
ON E.id = EU.id;
```


*---------------------------------------------------*


### 07. Product Sales Analysis I

[Click here to see question](https://leetcode.com/problems/product-sales-analysis-i/description/?envType=study-plan-v2&envId=top-sql-50)


###### Solution

```sql
SELECT product_name, year, price
FROM Sales S LEFT JOIN Product P
ON S.product_id = P.product_id;
```


*---------------------------------------------------*


### 08. Customer Who Visited but Did Not Make Any Transactions

[Click here to see question](https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/description/?envType=study-plan-v2&envId=top-sql-50)


###### Solution

```sql
SELECT customer_id, COUNT(count_no_trans) as count_no_trans

 FROM

(SELECT customer_id, coalesce(transaction_id,0) as count_no_trans
FROM Visits V LEFT JOIN Transactions T
ON V.visit_id = T.visit_id
WHERE transaction_id IS NULL) Q1

GROUP BY customer_id;
```


*---------------------------------------------------*


### 09. Rising Temperature

[Click here to see question](https://leetcode.com/problems/rising-temperature/?envType=study-plan-v2&envId=top-sql-50)

###### Solution

```sql
SELECT id
FROM (
    SELECT id, recordDate, temperature, 
    LAG(recordDate) OVER(ORDER BY recordDate) as last_date, 
    LAG(temperature) OVER(ORDER BY recordDate) as last_temp
    FROM Weather
    ) Q1
    
WHERE DATEDIFF(recordDate,last_date) = 1 AND temperature > last_temp;
```


*---------------------------------------------------*


### 10. Average Time of Process per Machine

[Click here to see question](https://leetcode.com/problems/average-time-of-process-per-machine/description/?envType=study-plan-v2&envId=top-sql-50)

###### Solution

```sql
WITH CTE as (
    SELECT A1.machine_id, A2.timestamp - A1.timestamp as times
    FROM Activity A1 
    LEFT JOIN Activity A2
    ON A1.machine_id = A2.machine_id AND A1.process_id = A2.process_id AND A1.activity_type = 'start' AND A2.activity_type = 'end'
    WHERE A1.activity_type <> 'end'
)

SELECT machine_id, ROUND(AVG(times),3) as processing_time
FROM CTE
GROUP BY machine_id;
```


*---------------------------------------------------*


### 11. Employee Bonus

[Click here to see question](https://leetcode.com/problems/employee-bonus/description/?envType=study-plan-v2&envId=top-sql-50)

###### Solution

```sql
SELECT name, bonus
FROM Employee E LEFT JOIN Bonus B
ON E.empId = B.empId
WHERE bonus < 1000 OR bonus IS NULL;
```


*---------------------------------------------------*


### 12. Students and Examinations
[Click here to see question](https://leetcode.com/problems/students-and-examinations/?envType=study-plan-v2&envId=top-sql-50)


#### Solution

```sql
WITH CTE as (
    SELECT * 
    FROM Students S1 JOIN Subjects S2 
    ON 1=1
)

SELECT C.student_id, C.student_name, C.subject_name, COUNT(E.subject_name) as attended_exams
FROM CTE C LEFT JOIN Examinations E
ON C.student_id = E.student_id AND C.subject_name = E.subject_name
GROUP BY C.student_id, C.student_name, C.subject_name
ORDER BY student_id,subject_name;
```


*---------------------------------------------------*


### 13. Managers with at Least 5 Direct Reports
[Click here to see question](https://leetcode.com/problems/managers-with-at-least-5-direct-reports/?envType=study-plan-v2&envId=top-sql-50)

#### Solution

```sql
SELECT E1.name
FROM Employee E1 LEFT JOIN Employee E2
ON E1.id = E2.managerId
GROUP BY E1.id,E1.name
HAVING COUNT(E2.id) >= 5;
```


*---------------------------------------------------*


###  14. Confirmation Rate
[Click here to see question](https://leetcode.com/problems/confirmation-rate/?envType=study-plan-v2&envId=top-sql-50)

#### Solution

```sql
WITH CTE1 as( 
    SELECT user_id, COUNT(action) as cnf_count
    FROM Confirmations
    WHERE action = 'confirmed'
    GROUP BY user_id),

CTE2 as(
    SELECT user_id, COUNT(action) as total_count
    FROM Confirmations
    GROUP BY user_id),

CTE3 as(
SELECT C1.user_id, cnf_count, total_count
FROM CTE1 C1 LEFT JOIN CTE2 C2
ON C1.user_id = C2.user_id )

SELECT S.user_id, COALESCE(ROUND(cnf_count/ total_count,2), 0) as confirmation_rate
FROM Signups S LEFT JOIN CTE3 C
ON S.user_id = C.user_id;
```


*---------------------------------------------------*


###  15. Not Boring Movies
[Click here to see question](
    https://leetcode.com/problems/not-boring-movies/description/?envType=study-plan-v2&envId=top-sql-50)

#### Solution

```sql
SELECT *
FROM Cinema
WHERE description <> 'boring' AND MOD(id,2) <> 0
ORDER BY rating desc;
```


*---------------------------------------------------*


###  16. Average Selling Price
[Click here to see question](
    https://leetcode.com/problems/average-selling-price/?envType=study-plan-v2&envId=top-sql-50)

#### Solution

```sql
WITH CTE AS (
    SELECT P.product_id, units, (units * price) as total_price
    FROM Prices P LEFT JOIN UnitsSold U
    ON P.product_id = U.product_id AND purchase_date BETWEEN start_date AND end_date
)

SELECT product_id, COALESCE(ROUND(SUM(total_price)/SUM(units),2),0) as average_price
FROM CTE
GROUP BY product_id;
```


*---------------------------------------------------*


###  17. Project Employees I
[Click here to see question](
    https://leetcode.com/problems/project-employees-i/description/?envType=study-plan-v2&envId=top-sql-50)

#### Solution

```sql
SELECT project_id, ROUND(AVG(experience_years),2) as average_years
FROM Project P LEFT JOIN Employee E
ON P.employee_id = E.employee_id
GROUP BY project_id;
```



*---------------------------------------------------*


###  18. Percentage of Users Attended a Contest
[Click here to see question](
    https://leetcode.com/problems/percentage-of-users-attended-a-contest/?envType=study-plan-v2&envId=top-sql-50)

#### Solution

```sql
SELECT contest_id, ROUND((COUNT(user_id) / (SELECT COUNT(user_id) FROM Users))* 100, 2) as percentage
FROM Register
GROUP BY contest_id
ORDER BY percentage DESC,contest_id ASC;
```



*---------------------------------------------------*


###  19. Queries Quality and Percentage
[Click here to see question](
    https://leetcode.com/problems/queries-quality-and-percentage/?envType=study-plan-v2&envId=top-sql-50)

#### Solution

```sql
WITH CTE AS(
    SELECT query_name, (rating/position) as quality, CASE WHEN rating < 3 THEN 1 ELSE 0 END as poor_quality
    FROM Queries
)

SELECT query_name, ROUND(AVG(quality),2) as quality, ROUND(AVG(poor_quality) * 100,2) as poor_query_percentage 
FROM CTE
WHERE query_name IS NOT NULL
GROUP BY query_name;
```


*---------------------------------------------------*


###  20. Monthly Transactions I
[Click here to see question](
    https://leetcode.com/problems/monthly-transactions-i/description/?envType=study-plan-v2&envId=top-sql-50)

#### Solution

```sql
WITH CTE1 AS (
    SELECT CONCAT(CONCAT(year(trans_date),'-'),CASE WHEN month(trans_date) < 10 THEN CONCAT('0',month(trans_date)) ELSE month(trans_date) END) as month,
    country, COUNT(state) as trans_count,SUM(amount) as trans_total_amount
    FROM Transactions
    GROUP BY year(trans_date), month(trans_date),country
),

CTE2 AS(
    SELECT CONCAT(
        CONCAT(
            year(trans_date),'-'),
            CASE WHEN month(trans_date) < 10 
            THEN CONCAT('0',month(trans_date)) 
            ELSE month(trans_date) 
            END) as month,
    country, 
    CASE WHEN state = 'approved' THEN 1 ELSE 0 END as approved_count,
    CASE WHEN state = 'approved' THEN amount ELSE 0 END as
    approved_total_amount

    FROM Transactions
),

CTE3 AS (
    SELECT month,
        country,
        SUM(approved_count) as approved_count,
        SUM(approved_total_amount) as approved_total_amount
    FROM CTE2
    GROUP BY month,country
)

SELECT CTE1.month, CTE1.country, 
    AVG(trans_count) as trans_count, 
    AVG(approved_count) as approved_count, 
    AVG(trans_total_amount) as trans_total_amount, 
    AVG(approved_total_amount) as approved_total_amount

FROM CTE1, CTE3

WHERE (CTE1.month = CTE3.month AND CTE1.country = CTE3.country) OR (CTE1.month = CTE3.month AND CTE1.country IS NULL)

GROUP BY CTE1.month, CTE1.country;
```



*---------------------------------------------------*


###  21. Immediate Food Delivery II
[Click here to see question](
   https://leetcode.com/problems/immediate-food-delivery-ii/?envType=study-plan-v2&envId=top-sql-50)

#### Solution

```sql
WITH FirstOrder AS(
    SELECT customer_id, MIN(order_date) as first_order_date
    FROM Delivery
    GROUP BY customer_id
),

ImmOrders AS(
    SELECT COUNT(*) as imm_cust
    FROM Delivery D JOIN FirstOrder F
    ON D.customer_id = F.customer_id
    AND  first_order_date = order_date
    WHERE order_date = customer_pref_delivery_date
),

TotalCust AS(
    SELECT COUNT(DISTINCT customer_id) as total_cust
    FROM Delivery
)

SELECT ROUND((imm_cust / total_cust)*100,2) as immediate_percentage
FROM ImmOrders,TotalCust;
```



*---------------------------------------------------*


###  22. Game Play Analysis IV
[Click here to see question](
   https://leetcode.com/problems/game-play-analysis-iv/description/?envType=study-plan-v2&envId=top-sql-50)

#### Solution

```sql
WITH FirstLogin AS(
    SELECT player_id, MIN(event_date) as first_login
    FROM activity
    GROUP BY player_id
),

CTE1 AS (
    SELECT F1.player_id, COUNT(A1.player_id) as cnt
    FROM FirstLogin F1 LEFT JOIN Activity A1
    ON F1.player_id = A1.player_id AND F1.first_login < A1.event_date AND (DATEDIFF(F1.first_login,A1.event_date) = -1 OR DATEDIFF(F1.first_login,A1.event_date) = 1)
    GROUP BY A1.player_id
),

CTE2 AS(SELECT COUNT(player_id) as cnt
    FROM CTE1
    WHERE CTE1.cnt >= 1
),

CTE3 AS(
    SELECT COUNT(DISTINCT player_id) as cnt
    FROM Activity
)

SELECT ROUND((CTE2.cnt/CTE3.cnt),2) as fraction 
FROM CTE2, CTE3;
```


*---------------------------------------------------*


###  23. Number of Unique Subjects Taught by Each Teacher

[Click here to see question](
   https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/?envType=study-plan-v2&envId=top-sql-50)

#### Solution

```sql
SELECT teacher_id ,COUNT(DISTINCT subject_id) as cnt
FROM Teacher
GROUP BY teacher_id;
```


*---------------------------------------------------*


###  24. User Activity for the Past 30 Days I

[Click here to see question](
  https://leetcode.com/problems/user-activity-for-the-past-30-days-i/description/?envType=study-plan-v2&envId=top-sql-50)

#### Solution

```sql
SELECT activity_date as day, COUNT(DISTINCT user_id) as active_users
FROM Activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY day
```


*---------------------------------------------------*


###  25. Product Sales Analysis III

[Click here to see question](
 https://leetcode.com/problems/product-sales-analysis-iii/description/?envType=study-plan-v2&envId=top-sql-50)

#### Solution

```sql
SELECT product_id, year as first_year, quantity, price
FROM (
        SELECT P.product_id, year, quantity, price , RANK() OVER(PARTITION BY p.product_id ORDER BY S.year ASC) as rn 
        FROM Product P LEFT JOIN Sales S
        ON P.product_id = S.product_id
        WHERE S.year IS NOT NULL
    ) sq

WHERE rn = 1;
```


*---------------------------------------------------*


###  26. Classes More Than 5 Students

[Click here to see question](
 https://leetcode.com/problems/classes-more-than-5-students/?envType=study-plan-v2&envId=top-sql-50)

#### Solution

```sql
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;
```


*---------------------------------------------------*


###  27. Find Followers Count

[Click here to see question](
 https://leetcode.com/problems/find-followers-count/?envType=study-plan-v2&envId=top-sql-50)

#### Solution

```sql
SELECT user_id, COUNT(follower_id) as followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id;
```


*---------------------------------------------------*


###  29. Customers Who Bought All Products
[Click here to see question](
 https://leetcode.com/problems/customers-who-bought-all-products/description/?envType=study-plan-v2&envId=top-sql-50)

#### Solution

```sql
SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*)FROM Product WHERE Product_key IS NOT NULL);
```


*---------------------------------------------------*


###  30.  The Number of Employees Which Report to Each Employee
[Click here to see question](
 https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/?envType=study-plan-v2&envId=top-sql-50)

#### Solution

```sql
SELECT * 
FROM (
        SELECT E1.employee_id, E1.name, COUNT(E2.employee_id) as reports_count, ROUND(AVG(E2.age)) as average_age
        FROM Employees E1 LEFT JOIN Employees E2
        ON E1.employee_id = E2.reports_to
        GROUP BY E1.employee_id, E1.name 
    ) as sq
WHERE reports_count > 0
ORDER BY employee_id;
```


*---------------------------------------------------*


###  31. Primary Department for Each Employee
[Click here to see question](
 https://leetcode.com/problems/primary-department-for-each-employee/description/?envType=study-plan-v2&envId=top-sql-50)

#### Solution

```sql
WITH CTE1 as (
    SELECT employee_id, COUNT(department_id) as cnt
    FROM Employee
    GROUP BY employee_id
)

SELECT E1.employee_id, E1.department_id
FROM Employee E1 LEFT JOIN CTE1 C1
ON E1.employee_id = C1.employee_id
WHERE cnt = 1 OR primary_flag = 'Y';
```


*---------------------------------------------------*


###  32. Triangle Judgement
[Click here to see question](
 https://leetcode.com/problems/triangle-judgement/description/?envType=study-plan-v2&envId=top-sql-50)

#### Solution

```sql
SELECT x,y,z, (CASE WHEN X+Y>Z AND Y+Z>X AND X+Z>Y THEN 'Yes' ELSE 'No' END) as Triangle
FROM Triangle;
```


*---------------------------------------------------*


###  33. Consecutive Numbers
[Click here to see question](
https://leetcode.com/problems/consecutive-numbers/description/?envType=study-plan-v2&envId=top-sql-50)

#### Solution

```sql
SELECT DISTINCT L1.num as ConsecutiveNums
FROM Logs L1, Logs L2, Logs L3
WHERE L1.num = L2.num AND L2.num = L3.num
AND L1.id = L2.id-1 AND L1.id = L3.id+1;
```


*---------------------------------------------------*


###  34. Product Price at a Given Date
[Click here to see question](
https://leetcode.com/problems/product-price-at-a-given-date/?envType=study-plan-v2&envId=top-sql-50)

#### Solution

```sql
SELECT product_id, 10 as price FROM products
WHERE product_id NOT IN(SELECT DISTINCT product_id FROM products WHERE change_date <= '2019-08-16')

UNION

SELECT product_id, new_price as price FROM products
WHERE (product_id,change_date) IN (SELECT  product_id, max(change_date) as date FROM products WHERE change_date <= '2019-08-16' group by product_id);
```



*---------------------------------------------------*


###  35. Last Person to Fit in the Bus
[Click here to see question](
https://leetcode.com/problems/last-person-to-fit-in-the-bus/?envType=study-plan-v2&envId=top-sql-50)

#### Solution

```sql
WITH CTE AS (
    SELECT Q1.turn, Q1.person_name
    FROM Queue Q1 LEFT JOIN Queue Q2
    ON Q1.turn >= Q2.turn
    GROUP BY Q1.turn, Q1.person_id, Q1.person_name
    HAVING SUM(Q2.weight) <= 1000
)

SELECT person_name
FROM CTE
WHERE turn = (SELECT MAX(turn) FROM CTE);
```
