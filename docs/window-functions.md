
# Window functions




```sql
SELECT office_id, first_name, salary, sum(salary) OVER (PARTITION BY office_id ORDER BY salary)
AS avg_salary
FROM employees
ORDER BY office_id
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-1)5 records

|office_id |first_name | salary| avg_salary|
|:---------|:----------|------:|----------:|
|a         |Sabahattin |  28060|      28060|
|b         |Lujza      |  39530|      39530|
|b         |Virginia   |  54523|      94053|
|c         |Ambrosio   |  25784|      25784|
|e         |Val        |  37506|      37506|

</div>



```sql
SELECT * FROM customers
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-2)4 records

|cust_id |name    |country |
|:-------|:-------|:-------|
|a       |Arfa    |pk      |
|b       |Brendon |us      |
|c       |Chiyo   |ja      |
|d       |Dikembe |ug      |

</div>




## Statisticcs with window functions  

