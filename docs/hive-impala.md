# Using Apache Hive and Impala

use command line interface to query data

- Beeline for Hive, use JDBC

- Impala Shell for Impala, doesn't use ODBC or JDBC to connect to Impala. It uses a different interface called Apache Thrift

## Apache Hive

starting hive using beeline

```bash
beeline -u jdbc:hive2://localhost:10000/fly -n training -p training
```

- `-ur` url

- `-n` name

- `-p` password

query must end with a semicolon `;`.

Use `!quit` (without semicolon because it is not a query) to quit beeline




## Apache Impala


start 

```bash
impala-shell
```

use `-h` (help) to see additional arguments

```bash
impala-shell -h
```

use `-d` to set current database

```bash
impala-shell -d fun
```

use `quit;` (without exclamation, and with semicolon) to quit impala
