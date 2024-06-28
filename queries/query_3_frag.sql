----------------------------------------------------------------------------------------------------------------
-- QUERY 3:
--  Qual o total de ocorrências de Roubo de Celular e roubo de carro no bairro de SANTA EFIGÊNIA em 2015?
-- Santa Efig�nia	2015	7800	6170	690	175
-- Time taken: 58.702 seconds, Fetched: 1 row(s)
-- Santa Efig�nia	2015	7800	6170	690	175
-- Time taken: 51.987 seconds, Fetched: 1 row(s)
-- com OR, não precisa mais de UNION
-- SET hive.strict.checks.cartesian.product=false;
----------------------------------------------------------------------------------------------------------------

select
    neighborhood_frag.name,
    time_frag.year,
    sum(crime_frag_2015.total_theft_cellphone),
    sum(crime_frag_2015.total_armed_robbery_cellphone),
    sum(crime_frag_2015.total_theft_auto),
    sum(crime_frag_2015.total_armed_robbery_auto)
from
    vertice_frag_2, neighborhood_frag, segment_frag_2, crime_frag_2015, time_frag

where 
    crime_frag_2015.segment_id = segment_frag_2.id
    and (segment_frag_2.start_vertice_id = vertice_frag_2.id OR segment_frag_2.final_vertice_id = vertice_frag_2.id)
    and vertice_frag_2.neighborhood_id = neighborhood_frag.id
    and neighborhood_frag.name LIKE 'Santa Efig%'
    --and neighborhood_frag.id = 6
    and crime_frag_2015.time_id = time_frag.id
    and time_frag.year = 2015
group by neighborhood_frag.name, time_frag.year