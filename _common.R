set.seed(1112)
options(digits = 3)



knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  fig.width = 8,
  fig.asp = 0.618,  # 1 / phi
  fig.align = "center",
  message = F,
  warning = F
)

knitr::opts_knit$set(sql.max.print = 10)


library(RPostgreSQL)
library(DBI)

con <- dbConnect(DBI::dbDriver('PostgreSQL'), 
                 dbname = "analysis",
                 host = "localhost",
                 port = 5432,
                 user = "postgres",
                 password = "Yanqiushi123")

