
# Miscellaneous query techniques


# Subqueries 

We have encountered subqueries where we are interested the difference between one's salary and the highest salary in the `employees` table. 


```sql
SELECT salary - 
  (SELECT MAX(salary) FROM employees)
  AS difference
FROM employees
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-1)5 records

| difference|
|----------:|
|     -28739|
|     -17017|
|          0|
|     -26463|
|     -14993|

</div>


A subquery is nested inside another query. Typically, it’s used for a
calculation or logical test that provides a value or set of data to be passed
into the main portion of the query. Its syntax is not unusual: we just
enclose the subquery in parentheses and use it where needed. For
example, we can write a subquery that returns multiple rows and treat the results as a table in the FROM clause of the main query. 

Or we can create a
scalar subquery that returns a single value and use it as part of an expression
to filter rows via WHERE , IN , and HAVING clauses. These are the most common
uses of subqueries.

Adding a subquery to a `WHERE` clause can be useful in query statements
other than SELECT .


```sql
SELECT *
FROM employees
WHERE salary >= (SELECT AVG(salary) FROM employees)
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-2)3 records

| empl_id|first_name |last_name | salary|office_id |
|-------:|:----------|:---------|------:|:---------|
|       2|Val        |Snyder    |  37506|e         |
|       3|Virginia   |Levitt    |  54523|b         |
|       5|Lujza      |Csizmadia |  39530|b         |

</div>
### Create derived tables 


