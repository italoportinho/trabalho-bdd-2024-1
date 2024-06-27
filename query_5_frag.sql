----------------------------------------------------------------------------------------------------------------
-- QUERY 5:
--  Qual o total de roubos de carro e celular em todos os segmentos durante o ano de 2017?
-- 2017	421435	609435	214560	171480
-- Time taken: 14.23 seconds, Fetched: 1 row(s)
----------------------------------------------------------------------------------------------------------------
select
    time_frag.year as ano,
    sum(crime_frag_2017.total_theft_cellphone) as furto_cel,
    sum(crime_frag_2017.total_armed_robbery_cellphone) as roubo_cel,
    sum(crime_frag_2017.total_theft_auto) as furto_carro,   
    sum(crime_frag_2017.total_armed_robbery_auto) as roubo_carro
from
    crime_frag_2017, time_frag

where crime_frag_2017.time_id = time_frag.id
    and time_frag.year = 2017
group by time_frag.year
;