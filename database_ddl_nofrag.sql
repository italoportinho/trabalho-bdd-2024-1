CREATE DATABASE IF NOT EXISTS trabalho_bdd_nofrag;

USE trabalho_bdd_nofrag;

CREATE TABLE IF NOT EXISTS "time"(
    id int,
    period string,
    day int,
    month int,
    year int,
    weekday string
)

CREATE TABLE IF NOT EXISTS neighborhood(
    id int,
    name string,
    geometry string
)

CREATE TABLE IF NOT EXISTS district(
    id int,
    name string,
    geometry string
)

CREATE TABLE IF NOT EXISTS vertice(
    id int,
    label int,
    district_id int,
    neighborhood_id int,
    zone_id int
)

CREATE TABLE IF NOT EXISTS segment(
    id int,
    geometry string,
    oneway varchar(3),
    length decimal(10,2),
    final_vertice_id int,
    start_vertice_id int
)

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