
# Data types 

The notion of data types underpin endless possibilities for type-specific operations. For example, we could extract the year component from a date, yet the same operation does not make any sense when applied to a string. On the other hand, regular expressions are designed for string matching problems and cannot be adapted to date. 

## Converting data types 

There is no guarantee that SQL will always correctly recognize the right data type for columns. 2020-07-30 means a date, but can be imported as a string. Since type-specific operations are only defined for certain data types. It's natural to think about converting some columnsn to the "right" data type. To change the data type of a column, we simply need to use the `column::datatype` format,
where column is the column name, and data type is the data type you want to change the column into.

`::`

`CAST`



```sql
SELECT shop, SUM((price IS  NULL)::int), COUNT(*) 
FROM inventory
GROUP BY shop
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-1)2 records

|shop      | sum| count|
|:---------|---:|-----:|
|Board 'Em |   1|     3|
|Dicey     |   0|     2|

</div>



## Date and time 

To see your current date settings, you can use the following command:


```sql
SHOW DateStyle
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-2)1 records

|DateStyle |
|:---------|
|ISO, MDY  |

</div>




```sql
SET DateStyle='ISO, MDY';
```

In addition to displaying dates that are input as strings, we can display the current date
very simply using the `current_date` keywords in Postgres. 

Additionally, the SQL standard offers a TIMESTAMP data type. A
timestamp represents a date and a time, down to a microsecond. This can be displayed via the `current_timestamp` keyword or the `NOW()` function. 

```sql
SELECT current_date, current_timestamp, NOW()
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-4)1 records

|date       |now                 |now                 |
|:----------|:-------------------|:-------------------|
|2020-07-30 |2020-07-30 11:39:36 |2020-07-30 11:39:36 |

</div>

Often, we will want to decompose our dates into their component parts. For example,
we may be interested in only the year and month, but not the day, for the monthly
analysis of our data. To do this, we can use the syntax `EXTRACT(component FROM date)`.


```sql
SELECT current_date,
  EXTRACT(year FROM current_date) AS year,
  EXTRACT(month FROM current_date) AS month,
  EXTRACT(day FROM current_date) AS day
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-5)1 records

|date       | year| month| day|
|:----------|----:|-----:|---:|
|2020-07-30 | 2020|     7|  30|

</div>

Similarly, we can abbreviate these components as `y, `mon`, and `d`,  


```sql
SELECT current_date,
  EXTRACT(y FROM current_date) AS year,
  EXTRACT(mon FROM current_date) AS month,
  EXTRACT(d FROM current_date) AS day
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-6)1 records

|date       | year| month| day|
|:----------|----:|-----:|---:|
|2020-07-30 | 2020|     7|  30|

</div>

We can also extract components like day of the week, week of the year, or quarter. Note that `dow` and `isodow` use different standard to extract day-of-week component. `dow` starts at 0 (Sunday) and goes up to Saturday, while `isodow` which starts at
1 (Monday) and goes up to 7 (Sunday)


```sql
SELECT current_date,
  EXTRACT(isodow FROM current_date) AS day_of_week,
  EXTRACT(week FROM current_date) AS week_of_year,
  EXTRACT(quarter FROM current_date) AS quarter
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-7)1 records

|date       | day_of_week| week_of_year| quarter|
|:----------|-----------:|------------:|-------:|
|2020-07-30 |           4|           31|       3|

</div>

