> Question 1
###  Recyclable and Low Fat Products

[Click here to see question](https://leetcode.com/problems/recyclable-and-low-fat-products/?envType=study-plan-v2&envId=top-sql-50 )

#### SOLUTION 

```sql
SELECT product_id
FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y';
```
