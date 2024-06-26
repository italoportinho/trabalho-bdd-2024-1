----------------------------------------------------------------------------------------------------------------
-- QUERY 6:
--  Quais os IDs de segmentos que possuíam o maior índice criminal (soma de ocorrências de todos os tipos de crime_frag_2010s)
--  , durante o mês de Novembro de 2010?
-- Time taken: 14.031 seconds, Fetched: 189 row(s)
-- 34854	11	2010	24
-- 224811	11	2010	12
-- 128172	11	2010	8
----------------------------------------------------------------------------------------------------------------
select        
    segment.id,
    time.month,
    time.year,
    sum(crime_frag_2010.total_feminicide) + 
    sum(crime_frag_2010.total_homicide) +
    sum(crime_frag_2010.total_felony_murder) +
    sum(crime_frag_2010.total_bodily_harm) +
    sum(crime_frag_2010.total_theft_cellphone) +
    sum(crime_frag_2010.total_armed_robbery_cellphone) +
    sum(crime_frag_2010.total_theft_auto) +
    sum(crime_frag_2010.total_armed_robbery_auto) as soma_total
from
    segment, crime_frag_2010, time

where 
    crime_frag_2010.segment_id = segment.id
    and crime_frag_2010.time_id = time.id
    and time.year = 2010
    and time.month = 11
group by segment.id, time.month, time.year order by soma_total DESC
;