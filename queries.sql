----------------------------------------------------------------------------------------------------------------
-- QUERY 1:
-- Qual o total de crimes por tipo e por segmento das ruas do distrito de IGUATEMI durante o ano de 2016?
----------------------------------------------------------------------------------------------------------------
select
    crime.segment_id,
    crime.total_feminicide,
    crime.total_homicide,
    crime.total_felony_murder,
    crime.total_bodily_harm,
    crime.total_theft_cellphone,
    crime.total_armed_robbery_cellphone,
    crime.total_theft_auto,
    crime.total_armed_robbery_auto,
from
    vertice, district, segment, crime, "time"

where 
    crime.segment_id = segment.id
    and segment.start_vertice = vertice.id
    and vertice.district_id = district.id
    and district.name = 'IGUATEMI'
    and crime.time_id = "time".id
    and "time"."year" = '2016'
;


----------------------------------------------------------------------------------------------------------------
-- QUERY 2:
--  Qual o total de crimes por tipo e por segmento das ruas do distrito de IGUATEMI entre 2006 e 2016?
----------------------------------------------------------------------------------------------------------------
select
    crime.segment_id,
    crime.total_feminicide,
    crime.total_homicide,
    crime.total_felony_murder,
    crime.total_bodily_harm,
    crime.total_theft_cellphone,
    crime.total_armed_robbery_cellphone,
    crime.total_theft_auto,
    crime.total_armed_robbery_auto,
from
    vertice, district, segment, crime, "time"

where 
    crime.segment_id = segment.id
    and segment.start_vertice = vertice.id
    and vertice.district_id = district.id
    and district.name = 'IGUATEMI'
    and crime.time_id = "time".id
    and "time"."year" between 2006 and 2016 
;

----------------------------------------------------------------------------------------------------------------
-- QUERY 3:
--  Qual o total de ocorrências de Roubo de Celular e roubo de carro no bairro de SANTA EFIGÊNIA em 2015?
----------------------------------------------------------------------------------------------------------------
select
    neighborhood.name,
    "time"."year",
    sum(crime.total_theft_cellphone),
    sum(crime.total_armed_robbery_cellphone),
    sum(crime.total_theft_auto),
    sum(crime.total_armed_robbery_auto),
from
    vertice, neighborhood, segment, crime, "time"

where 
    crime.segment_id = segment.id
    and segment.start_vertice = vertice.id
    and vertice.neighborhood_id = neighborhood.id
    and upper(neighborhood.name) = 'SANTA EFIGÊNIA'
    and crime.time_id = "time".id
    and "time"."year" = 2015
group by neighborhood.name, "time"."year"
;

----------------------------------------------------------------------------------------------------------------
-- QUERY 4:
--  Qual o total de crimes por tipo em vias de mão única da cidade durante o ano de 2012?
----------------------------------------------------------------------------------------------------------------
select    
    "time"."year",
    segment.oneway,
    sum(crime.total_feminicide),
    sum(crime.total_homicide),
    sum(crime.total_felony_murder),
    sum(crime.total_bodily_harm),
    sum(crime.total_theft_cellphone),
    sum(crime.total_armed_robbery_cellphone),
    sum(crime.total_theft_auto),
    sum(crime.total_armed_robbery_auto),
from
    segment, crime, "time"

where 
    crime.segment_id = segment.id
    and segment.oneway = 'yes'
    and crime.time_id = "time".id
    and "time"."year" = 2012
group by "time"."year"
;

----------------------------------------------------------------------------------------------------------------
-- QUERY 5:
--  Qual o total de roubos de carro e celular em todos os segmentos durante o ano de 2017?
----------------------------------------------------------------------------------------------------------------
select
    "time"."year",
    sum(crime.total_theft_cellphone),
    sum(crime.total_armed_robbery_cellphone),
    sum(crime.total_theft_auto),
    sum(crime.total_armed_robbery_auto),
from
    crime, "time"

where crime.time_id = "time".id
    and "time"."year" = 2017
group by "time"."year"
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
    sum(crime.total_armed_robbery_auto)
from
    segment, crime, "time"

where 
    crime.segment_id = segment.id
    and crime.time_id = "time".id
    and "time"."year" = 2010
    and "time"."month" = 11
group by segment.id, "time"."month", "time"."year"
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
    sum(crime.total_armed_robbery_auto)
from
    segment, crime, "time"

where 
    crime.segment_id = segment.id
    and crime.time_id = "time".id
    and "time"."year" = 2018
    and "time"."weekday" IN ('saturday', 'monday') 
group by segment.id, "time"."month", "time"."year"
;