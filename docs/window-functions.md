
# Window Functions

https://www.postgresql.org/docs/current/functions-window.html  

A window function performs a calculation across a set of table rows that are somehow related to the current row. This is comparable to the type of calculation that can be done with an aggregate function. However, window functions do not cause rows to become grouped into a single output row like non-window aggregate calls would. Instead, the rows retain their separate identities. Behind the scenes, the window function is able to access more than just the current row of the query result.

```sql 
SELECT {columns},
  {window_func} OVER (PARTITION BY {partition_key} ORDER BY {order_key})
FROM table1
```



```sql
SELECT * FROM iris
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-1)Displaying records 1 - 10

|id | sepal_length| sepal_width| petal_length| petal_width|species |
|:--|------------:|-----------:|------------:|-----------:|:-------|
|1  |          5.1|         3.5|          1.4|         0.2|setosa  |
|2  |          4.9|         3.0|          1.4|         0.2|setosa  |
|3  |          4.7|         3.2|          1.3|         0.2|setosa  |
|4  |          4.6|         3.1|          1.5|         0.2|setosa  |
|5  |          5.0|         3.6|          1.4|         0.2|setosa  |
|6  |          5.4|         3.9|          1.7|         0.4|setosa  |
|7  |          4.6|         3.4|          1.4|         0.3|setosa  |
|8  |          5.0|         3.4|          1.5|         0.2|setosa  |
|9  |          4.4|         2.9|          1.4|         0.2|setosa  |
|10 |          4.9|         3.1|          1.5|         0.1|setosa  |

</div>



```sql
SELECT 
  id, petal_length,
  AVG(petal_length) OVER(PARTITION BY species) AS species_petal_length 
FROM iris
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-2)Displaying records 1 - 10

|id | petal_length| species_petal_length|
|:--|------------:|--------------------:|
|1  |          1.4|                 1.46|
|2  |          1.4|                 1.46|
|3  |          1.3|                 1.46|
|4  |          1.5|                 1.46|
|5  |          1.4|                 1.46|
|6  |          1.7|                 1.46|
|7  |          1.4|                 1.46|
|8  |          1.5|                 1.46|
|9  |          1.4|                 1.46|
|10 |          1.5|                 1.46|

</div>

## Create Rankings



```sql
SELECT 
  id, 
  petal_length,
  species, 
  RANK() OVER(ORDER BY petal_length DESC)
FROM iris
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-3)Displaying records 1 - 10

|  id| petal_length|species   | rank|
|---:|------------:|:---------|----:|
| 119|          6.9|virginica |    1|
| 118|          6.7|virginica |    2|
| 123|          6.7|virginica |    2|
| 106|          6.6|virginica |    4|
| 132|          6.4|virginica |    5|
| 108|          6.3|virginica |    6|
| 110|          6.1|virginica |    7|
| 136|          6.1|virginica |    7|
| 131|          6.1|virginica |    7|
| 126|          6.0|virginica |   10|

</div>


```sql
SELECT 
  id, 
  petal_length,
  species, 
  DENSE_RANK() OVER(ORDER BY petal_length DESC)
FROM iris
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-4)Displaying records 1 - 10

|  id| petal_length|species   | dense_rank|
|---:|------------:|:---------|----------:|
| 119|          6.9|virginica |          1|
| 118|          6.7|virginica |          2|
| 123|          6.7|virginica |          2|
| 106|          6.6|virginica |          3|
| 132|          6.4|virginica |          4|
| 108|          6.3|virginica |          5|
| 110|          6.1|virginica |          6|
| 136|          6.1|virginica |          6|
| 131|          6.1|virginica |          6|
| 126|          6.0|virginica |          7|

</div>



```sql
SELECT 
  id, 
  petal_length,
  species, 
  RANK() OVER(PARTITION BY species ORDER BY petal_length DESC)
FROM iris
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-5)Displaying records 1 - 10

| id| petal_length|species | rank|
|--:|------------:|:-------|----:|
| 45|          1.9|setosa  |    1|
| 25|          1.9|setosa  |    1|
| 21|          1.7|setosa  |    3|
| 19|          1.7|setosa  |    3|
|  6|          1.7|setosa  |    3|
| 24|          1.7|setosa  |    3|
| 12|          1.6|setosa  |    7|
| 26|          1.6|setosa  |    7|
| 44|          1.6|setosa  |    7|
| 30|          1.6|setosa  |    7|

</div>




```r
# dplyr
readr::read_csv("data/iris.csv") %>% 
  mutate(rank = rank(desc(petal_length))) %>% 
  group_by(species) %>% 
  arrange(rank) %>% 
  select(id, petal_length, rank)
#> # A tibble: 150 x 4
#> # Groups:   species [3]
#>    species      id petal_length  rank
#>    <chr>     <dbl>        <dbl> <dbl>
#>  1 virginica   119          6.9   1  
#>  2 virginica   118          6.7   2.5
#>  3 virginica   123          6.7   2.5
#>  4 virginica   106          6.6   4  
#>  5 virginica   132          6.4   5  
#>  6 virginica   108          6.3   6  
#>  7 virginica   110          6.1   8  
#>  8 virginica   131          6.1   8  
#>  9 virginica   136          6.1   8  
#> 10 virginica   101          6    10.5
#> # ... with 140 more rows
```


