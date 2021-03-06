--- 
title: "SQL cookbook"
author: "Qiushi Yan"
date: "2020-11-28"
site: bookdown::bookdown_site
documentclass: book
bibliography: [references.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: enixam/data-manipulation-sql
description: "This book introduces essential SQL commands for data maninpulation, as well as presenting equivalent dplyr code for complex queries."
---

# Preface {-}



This document includes query solutions and techniques to common questions in data analysis. Queries will typically be interpreted with the `PostgreSQL` dialect in `knitr`'s `sql` engine. I include `dplyr` code when there could be some interesting comparison between these two tools sharing similar philosophy. 


Before each chapter, the following command is automatically evaluated:  



```r
library(RPostgreSQL)
library(DBI)

con <- dbConnect(dbDriver('PostgreSQL'), # SQL engine
                 dbname = dbname, # database name
                 host = "localhost", # either localhost or a database url
                 port = 5432, # the defualt port
                 user = user, # username
                 password = password) # password
```

By default, `SELECT` queries will display the first 10 records of their results within the document, in other words `LIMIT 10` is appended to each query, this is controlled via `knitr::opts_knit$set(sql.max.print = 10)`.  


References include:  



- [SQL Tutorial](https://www.sqltutorial.org/)  

- [Practical SQL A Beginner’s Guide to Storytelling with Data](https://www.amazon.com/Practical-SQL-Beginners-Guide-Storytelling-ebook/dp/B07197G78H/ref=sr_1_1?dchild=1&keywords=Practical+SQL+A+Beginner%E2%80%99s+Guide+to+Storytelling+with+Data&qid=1587971106&sr=8-1) [@debarros2018practical]  

- [SQL for Data Analytics: Perform fast and efficient data analysis with the power of SQL](https://www.amazon.com/SQL-Data-Analytics-efficient-analysis-ebook/dp/B07QVQGBXB/ref=sr_1_1?dchild=1&keywords=SQL+for+Data+Analytics&qid=1587971254&sr=8-1) [@malik2019sql]

- [Analyzing Big Data with SQL](https://www.coursera.org/learn/cloudera-big-data-analysis-sql-queries/), a coursera course  
