CREATE DATABASE IF NOT EXISTS trabalho_bdd_frag_partition;

USE trabalho_bdd_frag_partition;

CREATE TABLE IF NOT EXISTS time(
    id int,
    period string,
    day int,
    month int, 
    weekday string
)
    partitioned by (year int)
    row format delimited
    fields terminated by ';'
    lines terminated by '\n'
    stored as textfile location 'hdfs://namenode:8020/user/hive/warehouse/trabalho_bdd_frag_partition.db/time'
;
CREATE TABLE IF NOT EXISTS neighborhood(
    id int
)
    partitioned by (name string)
    row format delimited
    fields terminated by ';'
    lines terminated by '\n'
    stored as textfile location 'hdfs://namenode:8020/user/hive/warehouse/trabalho_bdd_frag_partition.db/neighborhood'
;

CREATE TABLE IF NOT EXISTS district(
    id int,
    geometry string
)
    partitioned by (name string)
    row format delimited
    fields terminated by ';'
    lines terminated by '\n'
    stored as textfile location 'hdfs://namenode:8020/user/hive/warehouse/trabalho_bdd_frag_partition.db/district'
;

CREATE TABLE IF NOT EXISTS vertice_frag_1(
    id int,
    label int,
    district_id int,
    neighborhood_id int,
    zone_id int
)

    row format delimited
    fields terminated by ';'
    lines terminated by '\n'
    stored as textfile location 'hdfs://namenode:8020/user/hive/warehouse/trabalho_bdd_frag_partition.db/vertice_frag_1'
;

CREATE TABLE IF NOT EXISTS vertice_frag_2(
    id int,
    label int,
    district_id int,
    neighborhood_id int,
    zone_id int
)

    row format delimited
    fields terminated by ';'
    lines terminated by '\n'
    stored as textfile location 'hdfs://namenode:8020/user/hive/warehouse/trabalho_bdd_frag_partition.db/vertice_frag_2'
;

CREATE TABLE IF NOT EXISTS vertice_frag_3(
    id int,
    label int,
    district_id int,
    neighborhood_id int,
    zone_id int
)

    row format delimited
    fields terminated by ';'
    lines terminated by '\n'
    stored as textfile location 'hdfs://namenode:8020/user/hive/warehouse/trabalho_bdd_frag_partition.db/vertice_frag_3'
;


CREATE TABLE IF NOT EXISTS segment_frag_1(
    id int,
    geometry string,
    oneway varchar(3),
    length decimal(10,2),
    final_vertice_id int,
    start_vertice_id int
)

    row format delimited
    fields terminated by ';'
    lines terminated by '\n'
    stored as textfile location 'hdfs://namenode:8020/user/hive/warehouse/trabalho_bdd_frag_partition.db/segment_frag_1'
;

CREATE TABLE IF NOT EXISTS segment_frag_2(
    id int,
    geometry string,
    oneway varchar(3),
    length decimal(10,2),
    final_vertice_id int,
    start_vertice_id int
)

    row format delimited
    fields terminated by ';'
    lines terminated by '\n'
    stored as textfile location 'hdfs://namenode:8020/user/hive/warehouse/trabalho_bdd_frag_partition.db/segment_frag_2'
;

CREATE TABLE IF NOT EXISTS crime(
    id int,
    total_feminicide int,
    total_homicide int,
    total_felony_murder int,
    total_bodily_harm int,
    total_theft_cellphone int,
    total_armed_robbery_cellphone int,
    total_theft_auto int,
    total_armed_robbery_auto int,
    segment_id int,
    time_id int
)    
    row format delimited
    fields terminated by ';'
    lines terminated by '\n'
    stored as textfile location 'hdfs://namenode:8020/user/hive/warehouse/trabalho_bdd_frag_partition.db/crime'
;