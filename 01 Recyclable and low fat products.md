
###01 Recyclable and Low Fat Products

[Click here to see question](https://leetcode.com/problems/recyclable-and-low-fat-products/?envType=study-plan-v2&envId=top-sql-50 )

###### Solution

```sql
SELECT product_id
FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y';
```


### 02 Find Customer Referee

[Click here to see question](https://leetcode.com/problems/find-customer-referee/description/?envType=study-plan-v2)

###### Solution

```sql
SELECT name
FROM Customer
WHERE referee_id <> 2 OR referee_id IS NULL;
```



###  03 Big Countries

[Click here to see question](https://leetcode.com/problems/big-countries/description/?envType=study-plan-v2&envId=top-sql-50)

###### Solution

```sql
SELECT name, population, area
FROM World
WHERE area >= 3000000 OR
population >= 25000000;
```


###  04 Article Views I

[Click here to see question](https://leetcode.com/problems/article-views-i/?envType=study-plan-v2&envId=top-sql-50)

###### Solution

```sql
SELECT DISTINCT(author_id) as id
FROM Views
WHERE author_id = viewer_id
ORDER BY author_id;
```



###05 Invalid Tweets

[Click here to see question](https://leetcode.com/problems/invalid-tweets/description/?envType=study-plan-v2&envId=top-sql-50)

###### Solution

```sql
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15;
```



###  06 Replace Employee ID With The Unique Identifier

[Click here to see question](https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/?envType=study-plan-v2&envId=top-sql-50)

###### Solution

```sql
SELECT unique_id, name
FROM Employees E LEFT JOIN EmployeeUNI EU
ON E.id = EU.id;
```



### 07 Product Sales Analysis I

[Click here to see question](https://leetcode.com/problems/product-sales-analysis-i/description/?envType=study-plan-v2&envId=top-sql-50)


###### Solution

```sql
SELECT product_name, year, price
FROM Sales S LEFT JOIN Product P
ON S.product_id = P.product_id;
```



### 08 Customer Who Visited but Did Not Make Any Transactions

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




### 09 Rising Temperature

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



### 10 Average Time of Process per Machine

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



### 11 Employee Bonus

[Click here to see question](https://leetcode.com/problems/employee-bonus/description/?envType=study-plan-v2&envId=top-sql-50)

###### Solution

```sql
SELECT name, bonus
FROM Employee E LEFT JOIN Bonus B
ON E.empId = B.empId
WHERE bonus < 1000 OR bonus IS NULL;
```



