

# SQL basics


## DDL


- `CREATE`: to create objects (table or database) in RDBMS

- `ALTER`: alters the structure of database

- `DROP`: delete objects from database

- `RENAME`: rename an objects

### Creating tables 

```sql
CREATE TABLE {table_name} (
{column_name_1} {data_type_1} {column_constraint_1},
{column_name_2} {data_type_2} {column_constraint_2},
{column_name_3} {data_type_3} {column_constraint_3},
…
{column_name_last} {data_type_last} {column_constraint_last},
)
```

Common data types are: 


The available constraints in SQL are:

`NOT NULL`: This constraint tells that we cannot store a null value in a column. That is, if a column is specified as NOT NULL then we will not be able to store null in this particular column any more.

`UNIQUE`: This constraint when specified with a column, tells that all the values in the column must be unique. That is, the values in any row of a column must not be repeated.

`PRIMARY KEY`: A primary key is a field which can uniquely identify each row in a table. And this constraint is used to specify a field in a table as primary key.

`FOREIGN KEY`: A Foreign key is a field which can uniquely identify each row in a another table. And this constraint is used to specify a field as Foreign key.

`CHECK`: This constraint helps to validate the values of a column to meet a particular condition. That is, it helps to ensure that the value stored in a column meets a specific condition.

`DEFAULT`: This constraint specifies a default value for the column when no value is specified by the user.



### Deleting tables 




## DML


- `INSERT`: insert data into a table

- `UPDATE`: update existing data within a table

- `DELETE`: deletes all records from a table, space 

Some would argue that `SELECT` should fall into the DML category. However, I think it is to our best advantage to make `SELECT` a standalone type of statements, DQL (database query language). Later chapters of this document is really focused on syntax and functions that can make the most of DQL. 

### Inserting rows

```sql
INSERT INTO table_name(column1, column2 , column3,..) 
VALUES(value1, value2, value3..);
```




## Creating views 

### Deleting views

### Updating views
