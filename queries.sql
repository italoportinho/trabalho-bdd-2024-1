----------------------------------------------------------------------------------------------------------------
-- QUERY 1:
-- Qual o total de crimes por tipo e por segmento das ruas do distrito de IGUATEMI durante o ano de 2016?
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
    and segment.final_vertice_id = vertice.id
    and vertice.district_id = district.id
    and district.name = 'IGUATEMI'
    and crime.time_id = time.id
    and time.year = '2016'
    group by crime.segment_id
;


----------------------------------------------------------------------------------------------------------------
-- QUERY 2:
--  Qual o total de crimes por tipo e por segmento das ruas do distrito de IGUATEMI entre 2006 e 2016?
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
;

----------------------------------------------------------------------------------------------------------------
-- QUERY 3:
--  Qual o total de ocorrências de Roubo de Celular e roubo de carro no bairro de SANTA EFIGÊNIA em 2015?
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
    and segment.start_vertice_id = vertice.id
    and vertice.neighborhood_id = neighborhood.id
    --and upper(neighborhood.name) = 'SANTA EFIGÊNIA'
    and neighborhood.id = 6
    and crime.time_id = time.id
    and time.year = 2015
group by neighborhood.name, time.year
;

----------------------------------------------------------------------------------------------------------------
-- QUERY 4:
--  Qual o total de crimes por tipo em vias de mão única da cidade durante o ano de 2012?
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
    and time.year = 2018
    and time.weekday IN ('saturday', 'monday') 
group by segment.id, time.month, time.year order by soma_total DESC LIMIT 100
;