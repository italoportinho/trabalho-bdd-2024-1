----------------------------------------------------------------------------------------------------------------
-- QUERY 6:
--  Quais os IDs de segmentos que possuíam o maior índice criminal (soma de ocorrências de todos os tipos de crime_frag_2010s)
--  , durante o mês de Novembro de 2010?
-- Time taken: 14.031 seconds, Fetched: 189 row(s) usando a segment original
-- 34854	11	2010	24
-- 224811	11	2010	12
-- 128172	11	2010	8
-- Time taken: 28.455 seconds, Fetched: 187 row(s) fazendo união dos fragmentos de  segment
-- 34854	11	2010	24
-- 224811	11	2010	12
-- 129781	11	2010	8
----------------------------------------------------------------------------------------------------------------
select        
    segment_frag_1.id,
    time_frag.month,
    time_frag.year,
    sum(crime_frag_2010.total_feminicide) + 
    sum(crime_frag_2010.total_homicide) +
    sum(crime_frag_2010.total_felony_murder) +
    sum(crime_frag_2010.total_bodily_harm) +
    sum(crime_frag_2010.total_theft_cellphone) +
    sum(crime_frag_2010.total_armed_robbery_cellphone) +
    sum(crime_frag_2010.total_theft_auto) +
    sum(crime_frag_2010.total_armed_robbery_auto) as soma_total
from
    segment_frag_1, crime_frag_2010, time_frag

where 
    crime_frag_2010.segment_id = segment_frag_1.id
    and crime_frag_2010.time_id = time_frag.id
    and time_frag.year = 2010
    and time_frag.month = 11
group by segment_frag_1.id, time_frag.month, time_frag.year 
UNION
select        
    segment_frag_2.id,
    time_frag.month,
    time_frag.year,
    sum(crime_frag_2010.total_feminicide) + 
    sum(crime_frag_2010.total_homicide) +
    sum(crime_frag_2010.total_felony_murder) +
    sum(crime_frag_2010.total_bodily_harm) +
    sum(crime_frag_2010.total_theft_cellphone) +
    sum(crime_frag_2010.total_armed_robbery_cellphone) +
    sum(crime_frag_2010.total_theft_auto) +
    sum(crime_frag_2010.total_armed_robbery_auto) as soma_total
from
    segment_frag_2, crime_frag_2010, time_frag

where 
    crime_frag_2010.segment_id = segment_frag_2.id
    and crime_frag_2010.time_id = time_frag.id
    and time_frag.year = 2010
    and time_frag.month = 11
group by segment_frag_2.id, time_frag.month, time_frag.year 

order by soma_total DESC
;