
# Data types 

## Converting data types 

To change the data type of a column, we simply need to use the `column::datatype` format,
where column is the column name, and data type is the data type you want to change the
column to.

`::`

`CAST`

## Type-specific operations

### Date and time 

 To see your current settings, you can use the following command:


```sql
SHOW DateStyle
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-1)1 records

|DateStyle |
|:---------|
|ISO, MDY  |

</div>




```sql
SET DateStyle='ISO, MDY';
```



```sql
SELECT current_date, current_timestamp, NOW()
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-3)1 records

|date       |now                 |now                 |
|:----------|:-------------------|:-------------------|
|2020-07-29 |2020-07-30 00:46:45 |2020-07-30 00:46:45 |

</div>



```sql
SELECT current_date,
  EXTRACT(year FROM current_date) AS year,
  EXTRACT(month FROM current_date) AS month,
  EXTRACT(day FROM current_date) AS day
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-4)1 records

|date       | year| month| day|
|:----------|----:|-----:|---:|
|2020-07-29 | 2020|     7|  29|

</div>



