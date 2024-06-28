----------------------------------------------------------------------------------------------------------------
-- QUERY 1:
-- Qual o total de crimes por tipo e por segmento das ruas do distrito de IGUATEMI durante o ano de 2016?
-- Time taken: 115.568 seconds, Fetched: 926 row(s) com UNION
-- Time taken: 221.386 seconds, Fetched: 926 row(s) com OR. o Hive infere um produto cartesiano e acaba com o desempenho
----------------------------------------------------------------------------------------------------------------
select
    crime.segment_id,
    sum(crime.total_feminicide),
    sum(crime.total_homicide),
    sum(crime.total_felony_murder),
    sum(crime.total_bodily_harm),
    sum(crime.total_theft_cellphone),
    sum(crime.total_armed_robbery_cellphone),
    sum(crime.total_theft_auto),
    sum(crime.total_armed_robbery_auto)
from
    vertice, district, segment, crime, time

where 
    crime.segment_id = segment.id
    and segment.start_vertice_id = vertice.id
    and vertice.district_id = district.id
    and district.name = 'IGUATEMI'
    and crime.time_id = time.id
    and time.year = 2016
    group by crime.segment_id
UNION
select
    crime.segment_id,
    sum(crime.total_feminicide),
    sum(crime.total_homicide),
    sum(crime.total_felony_murder),
    sum(crime.total_bodily_harm),
    sum(crime.total_theft_cellphone),
    sum(crime.total_armed_robbery_cellphone),
    sum(crime.total_theft_auto),
    sum(crime.total_armed_robbery_auto)
from
    vertice, district, segment, crime, time

where 
    crime.segment_id = segment.id
    and segment.final_vertice_id = vertice.id
    and vertice.district_id = district.id
    and district.name = 'IGUATEMI'
    and crime.time_id = time.id
    and time.year = 2016
    group by crime.segment_id
;


----------------------------------------------------------------------------------------------------------------
-- QUERY 2:
--  Qual o total de crimes por tipo e por segmento das ruas do distrito de IGUATEMI entre 2006 e 2016?
-- Time taken: 116.361 seconds, Fetched: 1554 row(s) UNION
-- Time taken: 227.531 seconds, Fetched: 1554 row(s) OR
----------------------------------------------------------------------------------------------------------------
select
    crime.segment_id,
    sum(crime.total_feminicide),
    sum(crime.total_homicide),
    sum(crime.total_felony_murder),
    sum(crime.total_bodily_harm),
    sum(crime.total_theft_cellphone),
    sum(crime.total_armed_robbery_cellphone),
    sum(crime.total_theft_auto),
    sum(crime.total_armed_robbery_auto)
from
    vertice, district, segment, crime, time

where 
    crime.segment_id = segment.id
    and segment.start_vertice_id = vertice.id
    and vertice.district_id = district.id
    and district.name = 'IGUATEMI'
    and crime.time_id = time.id
    and time.year between 2006 and 2016 
    group by crime.segment_id
UNION
select
    crime.segment_id,
    sum(crime.total_feminicide),
    sum(crime.total_homicide),
    sum(crime.total_felony_murder),
    sum(crime.total_bodily_harm),
    sum(crime.total_theft_cellphone),
    sum(crime.total_armed_robbery_cellphone),
    sum(crime.total_theft_auto),
    sum(crime.total_armed_robbery_auto)
from
    vertice, district, segment, crime, time

where 
    crime.segment_id = segment.id
    and segment.final_vertice_id = vertice.id
    and vertice.district_id = district.id
    and district.name = 'IGUATEMI'
    and crime.time_id = time.id
    and time.year between 2006 and 2016 
    group by crime.segment_id
;

----------------------------------------------------------------------------------------------------------------
-- QUERY 3:
--  Qual o total de ocorrências de Roubo de Celular e roubo de carro no bairro de SANTA EFIGÊNIA em 2015?
-- Time taken: 60.035 seconds, Fetched: 1 row(s)
-- Santa Efig�nia	2015	8100	6450	740	215
-- Time taken: 61.076 seconds, Fetched: 1 row(s)
-- com OR, não precisa mais de UNION
-- SET hive.strict.checks.cartesian.product=false;
----------------------------------------------------------------------------------------------------------------
select
    neighborhood.name,
    time.year,
    sum(crime.total_theft_cellphone),
    sum(crime.total_armed_robbery_cellphone),
    sum(crime.total_theft_auto),
    sum(crime.total_armed_robbery_auto)
from
    vertice, neighborhood, segment, crime, time

where 
    crime.segment_id = segment.id
    and (segment.start_vertice_id = vertice.id OR segment.final_vertice_id = vertice.id)
    and vertice.neighborhood_id = neighborhood.id
    --and neighborhood.name LIKE 'Santa Efig%'
    and neighborhood.id = 6
    and crime.time_id = time.id
    and time.year = 2015
group by neighborhood.name, time.year
UNION
select
    --neighborhood.name,
    time.year,
    sum(crime.total_theft_cellphone),
    sum(crime.total_armed_robbery_cellphone),
    sum(crime.total_theft_auto),
    sum(crime.total_armed_robbery_auto)
from
    vertice, neighborhood, segment, crime, time

where 
    crime.segment_id = segment.id
    and segment.final_vertice_id = vertice.id
    and vertice.neighborhood_id = neighborhood.id
    --and neighborhood.name = 'Santa Efig�nia'
    and neighborhood.id = 6
    and crime.time_id = time.id
    and time.year = 2015
group by --neighborhood.name, 
time.year
;

----------------------------------------------------------------------------------------------------------------
-- QUERY 4:
--  Qual o total de crimes por tipo em vias de mão única da cidade durante o ano de 2012?
-- 2012	yes	0	1625	160	0	210770	177610	80885	74665
-- Time taken: 89.83 seconds, Fetched: 1 row(s)
----------------------------------------------------------------------------------------------------------------
select    
    time.year as ano,
    segment.oneway as mao_dupla,
    sum(crime.total_feminicide) as feminicidio,
    sum(crime.total_homicide) as homicidio,
    sum(crime.total_felony_murder) as assassinato,
    sum(crime.total_bodily_harm) as lesao_corporal,
    sum(crime.total_theft_cellphone) as furto_celular,
    sum(crime.total_armed_robbery_cellphone) as roubo_celular,
    sum(crime.total_theft_auto) as furto_carro,
    sum(crime.total_armed_robbery_auto) as roubo_carro
from
    segment, crime, time

where 
    crime.segment_id = segment.id
    and segment.oneway = 'yes'
    and crime.time_id = time.id
    and time.year = 2012
group by time.year, segment.oneway
;

----------------------------------------------------------------------------------------------------------------
-- QUERY 5:
--  Qual o total de roubos de carro e celular em todos os segmentos durante o ano de 2017?
-- 2017	421435	609435	214560	171480
-- Time taken: 22.42 seconds, Fetched: 1 row(s)
----------------------------------------------------------------------------------------------------------------
select
    time.year as ano,
    sum(crime.total_theft_cellphone) as furto_cel,
    sum(crime.total_armed_robbery_cellphone) as roubo_cel,
    sum(crime.total_theft_auto) as furto_carro,   
    sum(crime.total_armed_robbery_auto) as roubo_carro
from
    crime, time

where crime.time_id = time.id
    and time.year = 2017
group by time.year
;

----------------------------------------------------------------------------------------------------------------
-- QUERY 6:
--  Quais os IDs de segmentos que possuíam o maior índice criminal (soma de ocorrências de todos os tipos de crimes)
--  , durante o mês de Novembro de 2010?
-- Time taken: 110.422 seconds, Fetched: 189 row(s)
-- 34854	11	2010	24
-- 224811	11	2010	12
-- 128172	11	2010	8
----------------------------------------------------------------------------------------------------------------
select        
    segment.id,
    time.month,
    time.year,
    sum(crime.total_feminicide) + 
    sum(crime.total_homicide) +
    sum(crime.total_felony_murder) +
    sum(crime.total_bodily_harm) +
    sum(crime.total_theft_cellphone) +
    sum(crime.total_armed_robbery_cellphone) +
    sum(crime.total_theft_auto) +
    sum(crime.total_armed_robbery_auto) as soma_total
from
    segment, crime, time

where 
    crime.segment_id = segment.id
    and crime.time_id = time.id
    and time.year = 2010
    and time.month = 11
group by segment.id, time.month, time.year order by soma_total DESC

;


----------------------------------------------------------------------------------------------------------------
-- QUERY 7:
--  Quais os IDs dos segmentos que possuíam o maior índice criminal (soma de ocorrências de todos os tipos de crimes) 
--  durante os finais de semana do ano de 2018?
-- Time taken: 104.654 seconds, Fetched: 100 row(s)
-- 160538	2018	1294
-- 160606	2018	599
-- 160607	2018	539
-- 132899	2018	438
-- 172841	2018	423
-- 155778	2018	398
-- 22731	2018	381
-- 131081	2018	351
-- 202703	2018	329
-- 201751	2018	318
-- 111697	2018	312
-- 127455	2018	310
-- 219011	2018	309
-- 205851	2018	294
-- 113146	2018	290
-- 127782	2018	260
-- 59483	2018	253
-- 172454	2018	253
-- 174522	2018	243
-- 155260	2018	242
-- 219103	2018	223
-- 111676	2018	214
-- 226199	2018	210
-- 224922	2018	208
-- 138518	2018	206
-- 172820	2018	205
-- 224945	2018	204
----------------------------------------------------------------------------------------------------------------
select        
    segment.id,
    time.year,
    sum(crime.total_feminicide) + 
    sum(crime.total_homicide) +
    sum(crime.total_felony_murder) +
    sum(crime.total_bodily_harm) +
    sum(crime.total_theft_cellphone) +
    sum(crime.total_armed_robbery_cellphone) +
    sum(crime.total_theft_auto) +
    sum(crime.total_armed_robbery_auto) as soma_total
from
    segment, crime, time

where 
    crime.segment_id = segment.id
    and crime.time_id = time.id
    and time.year = 2018
    and time.weekday IN ('saturday', 'monday') 
group by segment.id, time.year order by soma_total DESC LIMIT 100
;