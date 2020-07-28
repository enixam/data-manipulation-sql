

# Basic query


<div style="overflow-x:auto;">

```sql
SELECT * FROM us_counties_2010
```


<div class="knitsql-table">


Table: (\#tab:unnamed-chunk-1)Displaying records 1 - 10

|geo_name        |state_us_abbreviation |summary_level | region| division|state_fips |county_fips |  area_land| area_water| population_count_100_percent| housing_unit_count_100_percent| internal_point_lat| internal_point_lon| p0010001| p0010002| p0010003| p0010004| p0010005| p0010006| p0010007| p0010008| p0010009| p0010010| p0010011| p0010012| p0010013| p0010014| p0010015| p0010016| p0010017| p0010018| p0010019| p0010020| p0010021| p0010022| p0010023| p0010024| p0010025| p0010026| p0010047| p0010063| p0010070| p0020001| p0020002| p0020003| p0020004| p0020005| p0020006| p0020007| p0020008| p0020009| p0020010| p0020011| p0020012| p0020028| p0020049| p0020065| p0020072| p0030001| p0030002| p0030003| p0030004| p0030005| p0030006| p0030007| p0030008| p0030009| p0030010| p0030026| p0030047| p0030063| p0030070| p0040001| p0040002| p0040003| p0040004| p0040005| p0040006| p0040007| p0040008| p0040009| p0040010| p0040011| p0040012| p0040028| p0040049| p0040065| p0040072| h0010001| h0010002| h0010003|
|:---------------|:---------------------|:-------------|------:|--------:|:----------|:-----------|----------:|----------:|----------------------------:|------------------------------:|------------------:|------------------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|
|Autauga County  |AL                    |050           |      3|        6|01         |001         | 1539582278|   25775735|                        54571|                          22135|               32.5|              -86.6|    54571|    53702|    42855|     9643|      232|      474|       32|      466|      869|      814|      219|      262|      177|       11|       50|       32|       19|        9|       16|        0|        0|        5|        5|        8|        1|       49|        6|        0|        0|    54571|     1310|    53261|    52500|    42154|     9595|      217|      467|       22|       45|      761|      719|       36|        6|        0|        0|    39958|    39530|    31910|     6767|      180|      346|       23|      304|      428|      404|       22|        2|        0|        0|    39958|      828|    39130|    38746|    31461|     6738|      169|      341|       15|       22|      384|      363|       19|        2|        0|        0|    22135|    20221|     1914|
|Baldwin County  |AL                    |050           |      3|        6|01         |003         | 4117521611| 1133190229|                       182265|                         104061|               30.7|              -87.7|   182265|   179542|   156153|    17105|     1216|     1348|       89|     3631|     2723|     2583|      658|     1035|      336|       35|      311|       63|       34|        7|       38|       12|        0|       15|       11|       14|       14|      128|       11|        1|        0|   182265|     7992|   174273|   171976|   152200|    16966|     1146|     1340|       79|      245|     2297|     2205|       87|        5|        0|        0|   140367|   138905|   122238|    12272|      923|     1002|       70|     2400|     1462|     1398|       60|        3|        1|        0|   140367|     5186|   135181|   133937|   119671|    12193|      876|      994|       62|      141|     1244|     1198|       46|        0|        0|        0|   104061|    73180|    30881|
|Barbour County  |AL                    |050           |      3|        6|01         |005         | 2291818968|   50864716|                        27457|                          11829|               31.9|              -85.4|    27457|    27199|    13180|    12875|      114|      107|       29|      894|      258|      254|       76|       49|        7|        2|       34|       54|        2|        4|        7|        0|        1|        2|        1|        5|       10|        3|        0|        0|        1|    27457|     1387|    26070|    25861|    12837|    12820|       60|      107|       24|       13|      209|      206|        2|        0|        0|        1|    21442|    21275|    10855|     9647|       86|       80|       24|      583|      167|      163|        3|        0|        0|        1|    21442|      925|    20517|    20382|    10624|     9605|       47|       80|       21|        5|      135|      132|        2|        0|        0|        1|    11829|     9820|     2009|
|Bibb County     |AL                    |050           |      3|        6|01         |007         | 1612480789|    9289057|                        22915|                           8981|               33.0|              -87.1|    22915|    22712|    17381|     5047|       64|       22|       13|      185|      203|      195|       50|       77|       16|        3|       16|        9|       13|        5|        4|        0|        0|        2|        0|        0|        0|        8|        0|        0|        0|    22915|      406|    22509|    22328|    17191|     5024|       64|       22|        7|       20|      181|      175|        6|        0|        0|        0|    17714|    17584|    13403|     3975|       47|       14|       11|      134|      130|      128|        2|        0|        0|        0|    17714|      310|    17404|    17284|    13247|     3963|       47|       14|        5|        8|      120|      119|        1|        0|        0|        0|     8981|     7953|     1028|
|Blount County   |AL                    |050           |      3|        6|01         |009         | 1669961855|   15157440|                        57322|                          23887|               34.0|              -86.6|    57322|    56638|    53068|      761|      307|      117|       38|     2347|      684|      662|      112|      330|       74|        8|      102|       12|        2|        0|        6|        3|        0|        2|        4|        7|        0|       21|        1|        0|        0|    57322|     4626|    52696|    52129|    50952|      724|      285|      115|       18|       35|      567|      547|       19|        1|        0|        0|    43216|    42810|    40515|      549|      227|       91|       23|     1405|      406|      394|       12|        0|        0|        0|    43216|     2724|    40492|    40141|    39285|      524|      212|       89|       14|       17|      351|      341|       10|        0|        0|        0|    23887|    21578|     2309|
|Bullock County  |AL                    |050           |      3|        6|01         |011         | 1613056905|    6056528|                        10914|                           4493|               32.1|              -85.7|    10914|    10828|     2507|     7666|       23|       20|       43|      569|       86|       82|       12|       28|        3|        0|        3|        8|        5|        2|        9|        0|        0|        3|        0|        0|        9|        4|        0|        0|        0|    10914|      777|    10137|    10078|     2392|     7637|       20|       20|        4|        5|       59|       56|        3|        0|        0|        0|     8484|     8432|     2164|     5838|       21|       17|       31|      361|       52|       49|        3|        0|        0|        0|     8484|      485|     7999|     7963|     2102|     5821|       18|       17|        3|        2|       36|       33|        3|        0|        0|        0|     4493|     3745|      748|
|Butler County   |AL                    |050           |      3|        6|01         |013         | 2011976894|    2726814|                        20947|                           9964|               31.8|              -86.7|    20947|    20786|    11399|     9095|       60|      177|        7|       48|      161|      153|       58|       41|       17|        1|       13|       10|        4|        3|        3|        0|        0|        3|        0|        0|        0|        8|        0|        0|        0|    20947|      191|    20756|    20614|    11324|     9047|       59|      174|        7|        3|      142|      139|        3|        0|        0|        0|    15891|    15811|     9109|     6504|       44|      119|        3|       32|       80|       76|        4|        0|        0|        0|    15891|      130|    15761|    15694|     9062|     6468|       43|      117|        3|        1|       67|       65|        2|        0|        0|        0|     9964|     8491|     1473|
|Calhoun County  |AL                    |050           |      3|        6|01         |015         | 1569189995|   16624267|                       118572|                          53289|               33.8|              -85.8|   118572|   116597|    88840|    24382|      540|      845|       96|     1894|     1975|     1848|      676|      520|      223|       49|      143|       67|       48|       20|       46|        8|        2|        4|       17|       17|        8|      109|       17|        0|        1|   118572|     3893|   114679|   112975|    87285|    24177|      480|      830|       94|      109|     1704|     1602|       93|        8|        0|        1|    91446|    90441|    70313|    17746|      451|      665|       70|     1196|     1005|      939|       62|        3|        0|        1|    91446|     2473|    88973|    88088|    69294|    17621|      409|      653|       69|       42|      885|      826|       56|        2|        0|        1|    53289|    47331|     5958|
|Chambers County |AL                    |050           |      3|        6|01         |017         | 1545009282|   17048142|                        34215|                          17004|               32.9|              -85.4|    34215|    33830|    20112|    13257|       69|      168|       10|      214|      385|      373|      162|      101|       27|        1|       37|       11|       10|        0|       22|        0|        0|        0|        0|        1|        1|       11|        1|        0|        0|    34215|      536|    33679|    33352|    19893|    13206|       57|      166|        7|       23|      327|      317|       10|        0|        0|        0|    26512|    26332|    16182|     9798|       58|      138|        6|      150|      180|      173|        6|        1|        0|        0|    26512|      364|    26148|    25995|    16037|     9761|       48|      136|        3|       10|      153|      148|        5|        0|        0|        0|    17004|    13933|     3071|
|Cherokee County |AL                    |050           |      3|        6|01         |019         | 1434075952|  119858898|                        25989|                          16267|               34.1|              -85.7|    25989|    25602|    24081|     1208|      135|       54|        1|      123|      387|      376|       94|      206|       19|       12|       35|        9|        0|        0|        0|        0|        0|        0|        0|        1|        0|       11|        0|        0|        0|    25989|      320|    25669|    25322|    23929|     1206|      122|       49|        1|       15|      347|      337|       10|        0|        0|        0|    20423|    20216|    19090|      909|      105|       35|        1|       76|      207|      202|        5|        0|        0|        0|    20423|      171|    20252|    20051|    19005|      909|       99|       32|        1|        5|      201|      196|        5|        0|        0|        0|    16267|    10626|     5641|

</div>
<div>