
# Filtering

## The `WHERE` clause

## Operators 

### Comparison operators 


### Logical operators 

Logical operators enable users to combine multiple boolean expressions.  

- Binary operators `AND` and `OR`

- Unary operator `NOT`


Be mindful of order of operators: `NOT` (first), `AND` (second), `OR` (third). One workaround is to use parenthesis `()` to indicate order of operations, this makes queries more readable. 


```sql
SELECT CAST (region as varchar(5)),
       COALESCE(summary_level, '0'),
       avg(p0010001) AS pop
FROM us_counties_2010 
GROUP BY (region, summary_level)
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-1)4 records

|region |coalesce |    pop|
|:------|:--------|------:|
|3      |050      |  80503|
|4      |050      | 160593|
|2      |050      |  63438|
|1      |050      | 254918|

</div>



## Other relational operators  


## Missing values

Any rows in which the expression in the `WHERE` clause evaluate  to `false` and any rows in which it evaluates to `NULL`, are filtered out excluded from the result set. `Knitr`'s SQL engine displays `NULL` as `NA` in the resulting table, but remember in databases this is actually `NULL`.    

How many different games in the `inventory` table are located in Aisle 3 of the Dicey shop?

```sql
SELECT DISTINCT game
FROM inventory
WHERE shop = 'Dicey' AND aisle = 3
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-2)1 records

|game     |
|:--------|
|Monopoly |

</div>

The answer is at least 1. Since the row representing the game Clue in the shop Dicey has a missing value in the `aisle` column. You cannot rule out the possibility that this game is in Aisle 3.


```sql
SELECT * FROM inventory WHERE aisle IS NULL 
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-3)1 records

|shop  |game | qty| aisle| price|
|:-----|:----|---:|-----:|-----:|
|Dicey |Clue |   3|    NA|  9.99|

</div>

What if you wanted to write a `WHERE` clause to filter out the office in Illinois in the `offices` table, to return the three offices that are not in Illinois. You might try to write a `WHERE` clause like `WHERE state_province not <> 'Illinois'`. But this returns only two rows.  


```sql
SELECT * FROM offices WHERE state_province <> 'Illinois'
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-4)2 records

|office_id |city     |state_province |country |
|:---------|:--------|:--------------|:-------|
|a         |Istanbul |Istanbul       |tr      |
|c         |Rosario  |Santa Fe       |ar      |

</div>




Though row representing the Singapore office is not in the result set. That's because the state province value in that row is null, and "null not equal to Illinois" evaluates to null. So that row is excluded from the results set  


```sql
SELECT * FROM offices
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-5)4 records

|office_id |city      |state_province |country |
|:---------|:---------|:--------------|:-------|
|a         |Istanbul  |Istanbul       |tr      |
|b         |Chicago   |Illinois       |us      |
|c         |Rosario   |Santa Fe       |ar      |
|d         |Singapore |NA             |sg      |

</div>
But in this case, you know from context that this `NULL` value doesn't mean unknown, it means not applicable because Singapore does not have states or provinces. This is the type of situation where
the `IS DISTINCT FROM` operator is useful. 



```sql
SELECT * FROM offices WHERE state_province IS DISTINCT FROM 'Illinois'
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-6)3 records

|office_id |city      |state_province |country |
|:---------|:---------|:--------------|:-------|
|a         |Istanbul  |Istanbul       |tr      |
|c         |Rosario   |Santa Fe       |ar      |
|d         |Singapore |NA             |sg      |

</div>

The `IS DISTINCT FROM` operator is like the not equals operator `!=`, but it treats `NULL` values and
non `NULL` values as **explicitly unequal**. Whenever the operand on one side is `NULL` and the operand on the other side is not `NULL`, it evaluates to `true`. 


There is also a version of this operator that negates the result of the comparison, `IS NOT DISTINCT FROM`. This is like the equals operator, except when it compares a `NULL` value with a non-null value, it returns `false` instead of `NULL`. And when it compares two `NULL` values
it returns `true` instead of `NULL`. This shorthand notation for `IS NOT DISTINCT FROM`, `<=>` is supported by Hive, Impala, and MySQL. 


### Conditional functions  

- `if `

- `CASE`

- `nullif`

- `ifnull`

- `coalesce`




```sql
SELECT DISTINCT color 
FROM crayons 
WHERE red = 205
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-7)4 records

|color         |
|:-------------|
|Mahogany      |
|Silver        |
|Antique Brass |
|Wisteria      |

</div>



