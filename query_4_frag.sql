----------------------------------------------------------------------------------------------------------------
-- QUERY 4:
--  Qual o total de crime_frag_2s por tipo em vias de mão única da cidade durante o ano de 2012?
-- com crime_frag_2 (>= 2006 AND <= 2016)
-- 2012	yes	0	1625	160	0	210770	177610	80885	74665
-- Time taken: 65.205 seconds, Fetched: 1 row(s) 
--  com crime_frag_2012:
-- 2012	yes	0	1625	160	0	210770	177610	80885	74665
-- Time taken: 22.875 seconds, Fetched: 1 row(s)
----------------------------------------------------------------------------------------------------------------
select    
    time.year as ano,
    segment.oneway as mao_dupla,
    sum(crime_frag_2.total_feminicide) as feminicidio,
    sum(crime_frag_2.total_homicide) as homicidio,
    sum(crime_frag_2.total_felony_murder) as assassinato,
    sum(crime_frag_2.total_bodily_harm) as lesao_corporal,
    sum(crime_frag_2.total_theft_cellphone) as furto_celular,
    sum(crime_frag_2.total_armed_robbery_cellphone) as roubo_celular,
    sum(crime_frag_2.total_theft_auto) as furto_carro,
    sum(crime_frag_2.total_armed_robbery_auto) as roubo_carro
from
    segment, crime_frag_2, time

where 
    crime_frag_2.segment_id = segment.id
    and segment.oneway = 'yes'
    and crime_frag_2.time_id = time.id
    and time.year = 2012
group by time.year, segment.oneway
;

select    
    time.year as ano,
    segment.oneway as mao_dupla,
    sum(crime_frag_2012.total_feminicide) as feminicidio,
    sum(crime_frag_2012.total_homicide) as homicidio,
    sum(crime_frag_2012.total_felony_murder) as assassinato,
    sum(crime_frag_2012.total_bodily_harm) as lesao_corporal,
    sum(crime_frag_2012.total_theft_cellphone) as furto_celular,
    sum(crime_frag_2012.total_armed_robbery_cellphone) as roubo_celular,
    sum(crime_frag_2012.total_theft_auto) as furto_carro,
    sum(crime_frag_2012.total_armed_robbery_auto) as roubo_carro
from
    segment, crime_frag_2012, time

where 
    crime_frag_2012.segment_id = segment.id
    and segment.oneway = 'yes'
    and crime_frag_2012.time_id = time.id
    and time.year = 2012
group by time.year, segment.oneway
;