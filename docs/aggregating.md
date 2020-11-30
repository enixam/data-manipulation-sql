
# Aggregating

In each of the examples, the expression aggregates over all the rows, and returns a single row.  

That's what makes these expressions **aggregate expressions**. They can combine values from multiple rows, aggregating them together. These are different from the arithmetic operations like `+`, `-`, `*` and `/`, or functions like `ROUND`, `STRSUB` , which operate independently on the values in each row, and return a column whose length equals that of the whole table. Those are called **non-aggregate** expressions. 

One need to be careful about mixing aggregate and non-aggregate operations. You can use aggregate and non-aggregate operations together in an expression as in the following examples.    


```sql
SELECT ROUND(AVG(salary), 1) AS avg_salary 
FROM employees 
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-1)1 records

| avg_salary|
|----------:|
|      37081|

</div>


```sql
SELECT SUM(salary * 0.5) AS avg_half_salary 
FROM employees 
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-2)1 records

| avg_half_salary|
|---------------:|
|           92702|

</div>

Unfortunately, there are also invalid mix of aggregation expression and non-aggreagate expressions. Suppose we want to know the difference between one's salary and the highest salary in the table


```sql
-- not run
SELECT salary - max(salary) 
FROM employees
```

This query will throw an error message like **"employees.salary must appear in the GROUP BY clause or be used in an aggregate function"**. For R users, this may be a bit confusing, since similar dplyr expressions work just fine:  


```r
library(dplyr)
employees <- readr::read_csv("data/employees.csv")

employees %>%
  mutate(difference = salary - max(salary))
#> # A tibble: 5 x 6
#>   empl_id first_name last_name salary office_id difference
#>     <dbl> <chr>      <chr>      <dbl> <chr>          <dbl>
#> 1       1 Ambrosio   Rojas      25784 c             -28739
#> 2       2 Val        Snyder     37506 e             -17017
#> 3       3 Virginia   Levitt     54523 b                  0
#> 4       4 Sabahattin Tilki      28060 a             -26463
#> 5       5 Lujza      Csizmadia  39530 b             -14993
```

This is because the R language recycles the one element scalar `mean(salary)` to match its length to `salary`. SQL, on the other hand, does not know how to subtract one row from multiple rows. 

For now, the workaround is to use **subqueries**. Later we will see another solution using window functions in Chapter \@ref(window-functions).



```sql
SELECT salary - 
  (SELECT MAX(salary) FROM employees)
  AS difference
FROM employees
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-5)5 records

| difference|
|----------:|
|     -28739|
|     -17017|
|          0|
|     -26463|
|     -14993|

</div>


Also, you cannot select aggregating expressions and regular columns in parallel. For example, the following query has two items in the `SELECT` list. 


```sql
-- not run
SELECT first_name, max(salary) 
FROM employees
```

The first is just the column reference first name, that evaluates as a scalar expression. It returns a value for each row in the `employees` table. The second is the aggregate expression, max salary. That returns one row that aggregates all the salary values in the `employees` table.


## Aggregate Functions


There common aggregate functions for summary statistics like `MIN()`, `MAX()`, `AVG`, `SUM`.  


Additionally, there are two aggregate functions that do not perform direct computation based on values of columns.

`DISTINCT` can be used as keyword and functions alike. 

`COUNT`  

- `COUNT(*)`: Returns total number of records 

- `COUNT(column_name)`: Return number of **Non Null** values over the column salary. i.e 5.

- `COUNT(DISTINCT Salary)`:  Return number of **distinct Non Null** values over the column salary .i.e 4


`CASE WHEN` is often used in calculating proportions and percentages, the standard syntax is 



## Rowwise Aggregation

There are functions in SQL that are designed to perform computations per row, instead of across rows. For them, we need not to worry about the unmatched length problem. 

For example, there are non-aggregate `GREATEST()` for `MAX()`, and `LEAST` for `MIN()`


```sql
-- what is the dominant and least-used color for each crayon? 
SELECT 
  red, green, blue, 
  GREATEST(red, green, blue), 
  LEAST(red, green, blue)
FROM crayons
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-7)Displaying records 1 - 10

| red| green| blue| greatest| least|
|---:|-----:|----:|--------:|-----:|
| 239|   219|  197|      239|   197|
| 205|   149|  117|      205|   117|
| 253|   217|  181|      253|   181|
| 120|   219|  226|      226|   120|
| 135|   169|  107|      169|   107|
| 255|   164|  116|      255|   116|
| 250|   231|  181|      250|   181|
| 159|   129|  112|      159|   112|
| 253|   124|  110|      253|   110|
|  35|    35|   35|       35|    35|

</div>


This is much like the rowwise mechanism introduced since dplyr 1.0 


```r
crayon <- readr::read_csv("data/crayons.csv")
crayon %>%
  rowwise() %>% 
  mutate(dominant = max(c(red, green, blue)),
         `least used` = min(c(red, green, blue)))
#> # A tibble: 120 x 8
#> # Rowwise: 
#>    color            hex      red green  blue  pack dominant `least used`
#>    <chr>            <chr>  <dbl> <dbl> <dbl> <dbl>    <dbl>        <dbl>
#>  1 Almond           EFDBC5   239   219   197   120      239          197
#>  2 Antique Brass    CD9575   205   149   117   120      205          117
#>  3 Apricot          FDD9B5   253   217   181    24      253          181
#>  4 Aquamarine       78DBE2   120   219   226   120      226          120
#>  5 Asparagus        87A96B   135   169   107    64      169          107
#>  6 Atomic Tangerine FFA474   255   164   116    96      255          116
#>  7 Banana Mania     FAE7B5   250   231   181   120      250          181
#>  8 Beaver           9F8170   159   129   112   120      159          112
#>  9 Bittersweet      FD7C6E   253   124   110    64      253          110
#> 10 Black            232323    35    35    35     8       35           35
#> # ... with 110 more rows
```



## The `GROUP BY` Clause

No surprise, the `GROUP BY` clasue works hand in hand with aggregate expressions, as `group_by()` does with `summarize()` in dplyr.  


```sql
SELECT min_age, COUNT(*)
FROM games
WHERE list_price > 10
GROUP BY min_age;
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-9)2 records

| min_age| count|
|-------:|-----:|
|       8|     2|
|      10|     1|

</div>

Grouping expressions using column aliases, available in PostgreSQL, Impala, Mysql. 


```sql
SELECT list_price < 10 AS low_price, count(*) 
FROM games
GROUP BY low_price
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-10)2 records

|low_price | count|
|:---------|-----:|
|FALSE     |     3|
|TRUE      |     2|

</div>


```sql
SELECT list_price < 10, COUNT(*) FROM games GROUP BY list_price < 10;
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-11)2 records

|?column? | count|
|:--------|-----:|
|FALSE    |     3|
|TRUE     |     2|

</div>


```sql
SELECT (list_price) > 20 AS over_20, max_players, COUNT(*)
FROM games
GROUP BY over_20, max_players;
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-12)3 records

|over_20 | max_players| count|
|:-------|-----------:|-----:|
|FALSE   |           4|     2|
|FALSE   |           6|     2|
|TRUE    |           5|     1|

</div>




One of the major limitations of the `GROUP BY` clause is that it left you few choices in the `SELECT` list: **either an aggregate expression or columns that appear in `GROUP BY`**  


## Common Aggregating Functions



## `NULL` in Aggregation  

The `COUNT` function was designed to be consistent with these other aggregate functions
except in the case where you use `COUNT(*)`. So the general rule is that aggregate functions ignore `NULL` values, and the one exception to that rule is when you use `COUNT(*)`.   


With some SQL engines, you can specify more than one column reference or expression after the `DISTINCT` keyword in the `COUNT` function. This returns the number of unique combinations of the specified columns that exist in the data. This works in Hive, Impala, and MySQL, but **not** in PostgreSQL. 



```sql
-- this won't work in PostgreSQL
SELECT COUNT(DISTINCT red, green, blue) F
ROM crayons
```

Also, with some SQL engines, you can use more than one `COUNT(DISTINCT)` in a `SELECT` list, like in this example which uses the crayons table.


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

Here, the `COUNT` function is used three separate times in the `SELECT` list and the `DISTINCT` keyword is included in all three. So the result set has three columns giving the number of unique values in the red column, the number of unique values in the green column, and the number of unique values in the blue column. But with some other SQL engines including Impala, you are limited to only one` COUNT(DISTINCT)` per `SELECT` list. 




## Find distinct combinations 


Suppose we want to find distinct combinations of state and county in the census (which should not be repeated). `GROUP BY ` can be used for this sort of task. 


```sql
SELECT state_us_abbreviation, geo_name
FROM us_counties_2010
GROUP BY state_us_abbreviation, geo_name
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-15)Displaying records 1 - 10

|state_us_abbreviation |geo_name            |
|:---------------------|:-------------------|
|TX                    |Glasscock County    |
|UT                    |Box Elder County    |
|AR                    |Calhoun County      |
|KY                    |Breckinridge County |
|NY                    |Lewis County        |
|NE                    |Thomas County       |
|CO                    |Douglas County      |
|AR                    |Hot Spring County   |
|NE                    |Garden County       |
|IA                    |Mitchell County     |

</div>





Unlike in dplyr, `distinct` cannot be used in conjunction with `group by ` in SQL 


```r
# this works in 
us_counties_2010 <- readr::read_csv("data/us_counties_2010.csv")
us_counties_2010 %>% 
  group_by(state_us_abbreviation) %>% 
  distinct(geo_name)
#> # A tibble: 3,143 x 2
#> # Groups:   state_us_abbreviation [51]
#>    geo_name        state_us_abbreviation
#>    <chr>           <chr>                
#>  1 Autauga County  AL                   
#>  2 Baldwin County  AL                   
#>  3 Barbour County  AL                   
#>  4 Bibb County     AL                   
#>  5 Blount County   AL                   
#>  6 Bullock County  AL                   
#>  7 Butler County   AL                   
#>  8 Calhoun County  AL                   
#>  9 Chambers County AL                   
#> 10 Cherokee County AL                   
#> # ... with 3,133 more rows
```


```sql
-- sql does not have a "grouped" distinct
-- not run
SELECT DISTINCT(geo_name) 
FROM us_counties_2010
GROUP BY state_us_abbreviation
```



A workaround is using the `array` data type (Section \@ref(array))


```sql
SELECT  state_us_abbreviation, ARRAY_AGG(DISTINCT geo_name)
FROM us_counties_2010
GROUP BY state_us_abbreviation
LIMIT 1 
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-18)1 records

|state_us_abbreviation |array_agg                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|:---------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|AK                    |{"Aleutians East Borough","Aleutians West Census Area","Anchorage Municipality","Bethel Census Area","Bristol Bay Borough","Denali Borough","Dillingham Census Area","Fairbanks North Star Borough","Haines Borough","Hoonah-Angoon Census Area","Juneau City and Borough","Kenai Peninsula Borough","Ketchikan Gateway Borough","Kodiak Island Borough","Lake and Peninsula Borough","Matanuska-Susitna Borough","Nome Census Area","North Slope Borough","Northwest Arctic Borough","Petersburg Census Area","Prince of Wales-Hyder Census Area","Sitka City and Borough","Skagway Municipality","Southeast Fairbanks Census Area","Valdez-Cordova Census Area","Wade Hampton Census Area","Wrangell City and Borough","Yakutat City and Borough","Yukon-Koyukuk Census Area"} |

</div>

## Percentages 

A common used of `CASE` is to compute percentage or proportion. And the trick is to let `CASE` do the group by job manually. Suppose we want to know each school's share in the total salary.   


```sql
SELECT 
  sum(CASE WHEN school = 'F.D. Roosevelt HS' THEN salary ELSE 0 END
) / (sum(salary) * 1.0) as porp_fd,
  sum(CASE WHEN school = 'Myers Middle School' THEN salary ELSE 0 END
) / (sum(salary) * 1.0) as prop_myers
FROM teachers
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-19)1 records

| porp_fd| prop_myers|
|-------:|----------:|
|   0.531|      0.469|

</div>

The command can be easily adapted to, say, compute relative frequency. The following SQL command calculates the relative frequency of each school's teacher


```sql
SELECT 
  sum(CASE WHEN school = 'F.D. Roosevelt HS' THEN 1 ELSE 0 END
) / (count(*) * 1.0) as freq_fd,
  sum(CASE WHEN school = 'Myers Middle School' THEN 1 ELSE 0 END
) / (count(*) * 1.0) as freq_myers
FROM teachers
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-20)1 records

| freq_fd| freq_myers|
|-------:|----------:|
|     0.5|        0.5|

</div>

Yet this requires us to know all levels of school, use repeated syntax, and results in a wide data from that is often not suitable for data analysis. So this computing strategy is only useful when care about a single level or a small number of levels. 

An alternative is using aggregated subqueries (Section \@ref(filtering-by-aggregation))


```sql
SELECT school, 
      sum(salary) / (max(total_salary) * 1.0) as salary_prop,
      count(*) / (max(total_count) * 1.0) as rel_freq
FROM teachers, 
    (SELECT sum(salary) as total_salary, count(*) as total_count
    FROM teachers) as t
GROUP BY school
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-21)2 records

|school              | salary_prop| rel_freq|
|:-------------------|-----------:|--------:|
|F.D. Roosevelt HS   |       0.531|      0.5|
|Myers Middle School |       0.469|      0.5|

</div>
The trick is to first create the aggregation needed (in this case, total salary and counts) with aggregating subqueries, and rely on `GROUP BY` to do the calculation. Since total salary and count are scalar columns, take their max is simply to satisfy the requirements of `GROUP BY`. 







