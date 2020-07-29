# Write simple queries 


## The `WITH` clause

https://www.geeksforgeeks.org/sql-with-clause/  


```sql
WITH inventory_subset AS (
  SELECT * FROM inventory WHERE shop != 'Dicey'
)
SELECT * FROM inventory_subset
```

