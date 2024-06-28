----------------------------------------------------------------------------------------------------------------
-- QUERY 7:
--  Quais os IDs dos segmentos que possuíam o maior índice criminal (soma de ocorrências de todos os tipos de crimes) 
--  durante os finais de semana do ano de 2018?
-- Reconstruindo a tabela segment fazendo a união de seus fragmentos.
-- Time taken: 42.114 seconds, Fetched: 100 row(s)
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

----------------------------------------------------------------------------------------------------------------
select        
    segment_frag_1.id,
    time_frag.year,
    sum(crime_frag_2018.total_feminicide) + 
    sum(crime_frag_2018.total_homicide) +
    sum(crime_frag_2018.total_felony_murder) +
    sum(crime_frag_2018.total_bodily_harm) +
    sum(crime_frag_2018.total_theft_cellphone) +
    sum(crime_frag_2018.total_armed_robbery_cellphone) +
    sum(crime_frag_2018.total_theft_auto) +
    sum(crime_frag_2018.total_armed_robbery_auto) as soma_total
from
    segment_frag_1, crime_frag_2018, time_frag

where 
    crime_frag_2018.segment_id = segment_frag_1.id
    and crime_frag_2018.time_id = time_frag.id
    and time_frag.year = 2018
    and time_frag.weekday IN ('saturday', 'monday') 
group by segment_frag_1.id, time_frag.month, time_frag.year 
UNION
select        
    segment_frag_2.id,
    time_frag.year,
    sum(crime_frag_2018.total_feminicide) + 
    sum(crime_frag_2018.total_homicide) +
    sum(crime_frag_2018.total_felony_murder) +
    sum(crime_frag_2018.total_bodily_harm) +
    sum(crime_frag_2018.total_theft_cellphone) +
    sum(crime_frag_2018.total_armed_robbery_cellphone) +
    sum(crime_frag_2018.total_theft_auto) +
    sum(crime_frag_2018.total_armed_robbery_auto) as soma_total
from
    segment_frag_2, crime_frag_2018, time_frag

where 
    crime_frag_2018.segment_id = segment_frag_2.id
    and crime_frag_2018.time_id = time_frag.id
    and time_frag.year = 2018
    and time_frag.weekday IN ('saturday', 'monday') 
group by segment_frag_2.id, time_frag.year
order by soma_total DESC LIMIT 100
;

-----------------------------------------------------------------------------
-- Usando a tabela segment original não fragmentada.
-- Time taken: 27.222 seconds, Fetched: 100 row(s)
select        
    segment.id,
    time_frag.year,
    sum(crime_frag_2018.total_feminicide) + 
    sum(crime_frag_2018.total_homicide) +
    sum(crime_frag_2018.total_felony_murder) +
    sum(crime_frag_2018.total_bodily_harm) +
    sum(crime_frag_2018.total_theft_cellphone) +
    sum(crime_frag_2018.total_armed_robbery_cellphone) +
    sum(crime_frag_2018.total_theft_auto) +
    sum(crime_frag_2018.total_armed_robbery_auto) as soma_total
from
    segment, crime_frag_2018, time_frag

where 
    crime_frag_2018.segment_id = segment.id
    and crime_frag_2018.time_id = time_frag.id
    and time_frag.year = 2018
    and time_frag.weekday IN ('saturday', 'monday') 
group by segment.id, time_frag.month, time_frag.year 
order by soma_total DESC LIMIT 100
;