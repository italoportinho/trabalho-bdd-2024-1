----------------------------------------------------------------------------------------------------------------
-- QUERY 1:
-- Qual o total de crimes por tipo e por segmento das ruas do distrito de IGUATEMI durante o ano de 2016?
-- Time taken: 72.778 seconds, Fetched: 926 row(s)
----------------------------------------------------------------------------------------------------------------

select
    crime_frag_2016.segment_id,
    sum(crime_frag_2016.total_feminicide),
    sum(crime_frag_2016.total_homicide),
    sum(crime_frag_2016.total_felony_murder),
    sum(crime_frag_2016.total_bodily_harm),
    sum(crime_frag_2016.total_theft_cellphone),
    sum(crime_frag_2016.total_armed_robbery_cellphone),
    sum(crime_frag_2016.total_theft_auto),
    sum(crime_frag_2016.total_armed_robbery_auto)
from
    vertice_frag_1, district_frag, segment_frag_1, crime_frag_2016, time_frag

where 
    time_frag.year = 2016
    and time_frag.id = crime_frag_2016.time_id
    and crime_frag_2016.segment_id = segment_frag_1.id
    and segment_frag_1.start_vertice_id = vertice_frag_1.id
    and vertice_frag_1.district_id = district_frag.id
    and district_frag.name = 'IGUATEMI'
    group by crime_frag_2016.segment_id
UNION
select
    crime_frag_2016.segment_id,
    sum(crime_frag_2016.total_feminicide),
    sum(crime_frag_2016.total_homicide),
    sum(crime_frag_2016.total_felony_murder),
    sum(crime_frag_2016.total_bodily_harm),
    sum(crime_frag_2016.total_theft_cellphone),
    sum(crime_frag_2016.total_armed_robbery_cellphone),
    sum(crime_frag_2016.total_theft_auto),
    sum(crime_frag_2016.total_armed_robbery_auto)
from
    vertice_frag_1, district_frag, segment_frag_1, crime_frag_2016, time_frag

where 
time_frag.year = 2016
    and time_frag.id = crime_frag_2016.time_id
    and crime_frag_2016.segment_id = segment_frag_1.id
    and segment_frag_1.final_vertice_id = vertice_frag_1.id
    and vertice_frag_1.district_id = district_frag.id
    and district_frag.name = 'IGUATEMI'
    group by crime_frag_2016.segment_id
;