----------------------------------------------------------------------------------------------------------------
-- QUERY 2:
--  Qual o total de crimes por tipo e por segment_frag_1o das ruas do distrito de IGUATEMI entre 2006 e 2016?
-- Time taken: 88.297 seconds, Fetched: 1554 row(s) UNION
-- Time taken: 44.255 seconds, Fetched: 1554 row(s) OR
----------------------------------------------------------------------------------------------------------------
select
    crime_frag_2.segment_id,
    sum(crime_frag_2.total_feminicide),
    sum(crime_frag_2.total_homicide),
    sum(crime_frag_2.total_felony_murder),
    sum(crime_frag_2.total_bodily_harm),
    sum(crime_frag_2.total_theft_cellphone),
    sum(crime_frag_2.total_armed_robbery_cellphone),
    sum(crime_frag_2.total_theft_auto),
    sum(crime_frag_2.total_armed_robbery_auto)
from
    vertice_frag_1, district, segment_frag_1, crime_frag_2, time_frag

where 
    crime_frag_2.segment_id = segment_frag_1.id
    and (segment_frag_1.start_vertice_id = vertice_frag_1.id OR segment_frag_1.final_vertice_id = vertice_frag_1.id)
    and vertice_frag_1.district_id = district.id
    and district.name = 'IGUATEMI'
    and crime_frag_2.time_id = time_frag.id
    and time_frag.year between 2006 and 2016 
    group by crime_frag_2.segment_id
UNION
select
    crime_frag_2.segment_id,
    sum(crime_frag_2.total_feminicide),
    sum(crime_frag_2.total_homicide),
    sum(crime_frag_2.total_felony_murder),
    sum(crime_frag_2.total_bodily_harm),
    sum(crime_frag_2.total_theft_cellphone),
    sum(crime_frag_2.total_armed_robbery_cellphone),
    sum(crime_frag_2.total_theft_auto),
    sum(crime_frag_2.total_armed_robbery_auto)
from
    vertice_frag_1, district, segment_frag_1, crime_frag_2, time_frag

where 
    crime_frag_2.segment_id = segment_frag_1.id
    and segment_frag_1.final_vertice_id = vertice_frag_1.id
    and vertice_frag_1.district_id = district.id
    and district.name = 'IGUATEMI'
    and crime_frag_2.time_id = time_frag.id
    and time_frag.year between 2006 and 2016 
    group by crime_frag_2.segment_id
;
