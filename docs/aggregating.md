
# Aggregating

In each of the examples, the expression aggregates over all the rows, and returns a single row.
That's what makes these expressions **aggregate expressions**. They can combine values from multiple rows, aggregating them together. These are different from the expressions earlier like `round`, `strsub` , which operate independently on the values in each row. Those are called non-aggregate
expressions or **scalar expressions**. They return one value per row. One need to be careful about mixing aggregate and scalar operations. You can use aggregate and scalar operations together in
an expression as in the following examples.    


```sql
SELECT round(AVG(salary), 1) AS avg_salary FROM employees 
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-1)1 records

| avg_salary|
|----------:|
|      37081|

</div>


```sql
SELECT SUM(salary * 0.5) AS avg_half_salary FROM employees 
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-2)1 records

| avg_half_salary|
|---------------:|
|           92702|

</div>

Unfortunately, there are also invalid mix of aggregation expression and scalar expressions.


```sql
-- not run
SELECT salary - AVG(salary) FROM employees
```

This query will throw an error message like **"employees.salary must appear in the GROUP BY clause or be used in an aggregate function"**. For R users, this may be a bit confusing, since similar dplyr expresisons work just fine:  


```r
library(dplyr)
employees <- readr::read_csv("data/employees.csv")

employees %>%
  mutate(difference = salary - mean(salary))
#> # A tibble: 5 x 6
#>   empl_id first_name last_name salary office_id difference
#>     <dbl> <chr>      <chr>      <dbl> <chr>          <dbl>
#> 1       1 Ambrosio   Rojas      25784 c            -11297.
#> 2       2 Val        Snyder     37506 e               425.
#> 3       3 Virginia   Levitt     54523 b             17442.
#> 4       4 Sabahattin Tilki      28060 a             -9021.
#> 5       5 Lujza      Csizmadia  39530 b              2449.
```

For now, the workaround is to use **subqueries**. Later we will see another solution using window functions in Chapter \@ref(window-functions).






```sql
SELECT salary - 
  (SELECT AVG(salary) FROM employees)
  AS difference
FROM employees
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-5)5 records

| difference|
|----------:|
|     -11297|
|        425|
|      17442|
|      -9021|
|       2449|

</div>


Also, you cannot use scalar and aggregate expressions. For example, this query has two items in the `SELECT` list. 


```sql
-- not run
SELECT first_name, sum(salary) FROM employees
```

The first is just the column reference first name, that evaluates as a scalar expression. It returns a value for each row in the `employees` table. The second is the aggregate expression, sum salary. That returns just one row that aggregates all the salary values in the `employees` table.
We cannot use both of these types of expressions together in one select list.   


```sql
SELECT red, green, blue, greatest(red, green, blue) FROM crayons
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-7)Displaying records 1 - 10

| red| green| blue| greatest|
|---:|-----:|----:|--------:|
| 239|   219|  197|      239|
| 205|   149|  117|      205|
| 253|   217|  181|      253|
| 120|   219|  226|      226|
| 135|   169|  107|      169|
| 255|   164|  116|      255|
| 250|   231|  181|      250|
| 159|   129|  112|      159|
| 253|   124|  110|      253|
|  35|    35|   35|       35|

</div>





## The `GROUP BY` clause. 

No surprise, the `GROUP BY` clasue works hand in hand with aggregate expressions, as `group_by()` does with `summarize()` in dplyr.  


```sql
SELECT min_age, COUNT(*)
FROM games
WHERE list_price > 10
GROUP BY min_age;
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-8)2 records

| min_age| count|
|-------:|-----:|
|       8|     2|
|      10|     1|

</div>

Grouping expressions using column aliases, availabe in PostgreSQL, Impala, Mysql. 


```sql
SELECT list_price < 10 AS low_price, count(*) 
FROM games
GROUP BY low_price
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-9)2 records

|low_price | count|
|:---------|-----:|
|FALSE     |     3|
|TRUE      |     2|

</div>


```sql
SELECT list_price < 10, COUNT(*) FROM games GROUP BY list_price < 10;
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-10)2 records

|?column? | count|
|:--------|-----:|
|FALSE    |     3|
|TRUE     |     2|

</div>


```sql
SELECT list_price > 20 AS over_20, max_players, COUNT(*)
FROM games
GROUP BY over_20, max_players;
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-11)3 records

|over_20 | max_players| count|
|:-------|-----------:|-----:|
|FALSE   |           4|     2|
|FALSE   |           6|     2|
|TRUE    |           5|     1|

</div>





 


```sql
SELECT shop, SUM((price IS  NULL)::int), count(*) 
FROM inventory
GROUP BY shop
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-12)2 records

|shop      | sum| count|
|:---------|---:|-----:|
|Board 'Em |   1|     3|
|Dicey     |   0|     2|

</div>


## NULL values in aggregation  

The `COUNT` function was designed to be consistent with these other aggregate functions
except in the case where you use `COUNT(*)`. So the general rule is that aggregate functions ignore `NULL` values, and the one exception to that rule is when you use `COUNT(*)`.   


With some SQL engines, you can specify more than one column reference or expression after the `DISTINCT` keyword in the `COUNT` function. This returns the number of unique combinations of the specified columns that exist in the data. This works in Hive, Impala, and MySQL, but **not** in PostgreSQL. 



```sql
-- this won't work in PostgreSQL
SELECT COUNT(DISTINCT red, green, blue) FROM crayons
```

Also, with some SQL engines, you can use more than one `COUNT(DISTINCT)` in a `SELECT` list,
like in this example which uses the crayons table.


```sql
-- PostgreSQL allows for multiple COUNT(DISTINCT) in one select list
SELECT 
  pack,
  COUNT(DISTINCT red) AS red_count,
  COUNT(DISTINCT green) AS green_count,
  COUNT(DISTINCT blue) AS blue_count
FROM crayons
GROUP BY pack
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-14)9 records

| pack| red_count| green_count| blue_count|
|----:|---------:|-----------:|----------:|
|    4|         4|           4|          4|
|    8|         4|           4|          4|
|   16|         6|           8|          7|
|   24|         7|           8|          8|
|   32|         8|           8|          8|
|   48|        14|          16|         14|
|   64|        15|          15|         16|
|   96|        21|          27|         26|
|  120|        21|          22|         24|

</div>

Here, the COUNT function is used three separate times in the `SELECT` list and the `DISTINCT` keyword is included in all three. So the result set has three columns giving the number of unique values in the red column, the number of unique values in the green column, and the number of unique values in the blue column. But with some other SQL engines including Impala, you are limited to only one` COUNT(DISTINCT)` per `SELECT` list. 

## The `HAVING` clause  

The `WHERE` clause is used before `GROUP BY` , because it makes more sense. The filter specified in the WHERE clause is used before grouping. After grouping, you can have a `HAVING` clause, which is similar to `WHERE` , except you can filter by aggregate values as well.


Often you'll want to include the aggregate expression that you use in the `HAVING` clause in the SELECT list as well. So you can see the values in the column you filtered by. In this example, the query filters by sum of price times quantity. It's good to see those sum of price times quantity values
for the rows that are included in the result set. So some of price times quantity is also used in the `SELECT` list.



```sql
SELECT shop, sum(qty * price)
FROM inventory
GROUP BY shop
HAVING sum(qty * price) > 300
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-15)1 records

|shop      | sum|
|:---------|---:|
|Board 'Em | 380|

</div>

But it's inconvenient to have to repeat the same expression in these two different places. So some SQL engines provide a shortcut that you can use to avoid this repetition. With some SQL engines, you can specify the aggregate expression in the `SELECT` list, give it an alias,
and then use that alias in the `HAVING` clause. That way you do not need to repeat the aggregate expression twice. This shortcut works with Impala, Hive, and MySQL, but not with PostgreSQL and some other SQL engines. If you're using a different SQL engine, trying to see if it works.   


```sql
-- this does not work in PostgreSQL 
SELECT shop, sum(qty * price) AS total
FROM inventory
GROUP BY shop
HAVING total > 300
```


