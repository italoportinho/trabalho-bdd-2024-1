INSERT OVERWRITE TABLE time_frag
partition(year)
SELECT 
    id, 
    period, 
    day,     
    month, 
    weekday,
    year
    FROM time;

INSERT OVERWRITE TABLE neighborhood_frag
partition(name)
SELECT 
    id, 
    name
    FROM neighborhood where id = 6;

INSERT OVERWRITE TABLE district_frag
partition(name)
SELECT 
    id, 
    name
    FROM district;

INSERT OVERWRITE TABLE vertice_frag_1
SELECT 
    vertice.id, vertice.label, vertice.district_id, vertice.neighborhood_id, vertice.zone_id 
    FROM vertice, district 
        WHERE vertice.district_id = district.id
        AND district.id = 33;

INSERT OVERWRITE TABLE vertice_frag_2
SELECT 
    vertice.id, vertice.label, vertice.district_id, vertice.neighborhood_id, vertice.zone_id 
    FROM vertice, district 
        WHERE vertice.district_id = district.id
        AND district.id != 33;

INSERT OVERWRITE TABLE segment_frag_1
SELECT 
    segment.id, geometry, segment.oneway, segment.length, segment.final_vertice_id, segment.start_vertice_id
    FROM segment, vertice_frag_1
    WHERE segment.start_vertice_id = vertice_frag_1.id
UNION
SELECT 
    segment.id, geometry, segment.oneway, segment.length, segment.final_vertice_id, segment.start_vertice_id
    FROM segment, vertice_frag_1
    WHERE segment.final_vertice_id = vertice_frag_1.id
;

INSERT OVERWRITE TABLE segment_frag_2
SELECT 
    segment.id, segment.geometry, segment.oneway, segment.length, segment.final_vertice_id, segment.start_vertice_id
    FROM segment, vertice_frag_2
    WHERE segment.start_vertice_id = vertice_frag_2.id
    AND segment.final_vertice_id IN (SELECT 
    s.id
    FROM segment s, vertice_frag_2 v2
    WHERE s.final_vertice_id = v2.id)
;

INSERT OVERWRITE TABLE crime_frag_1
SELECT 
    crime.* 
    FROM crime, time
    WHERE crime.time_id = time.id
    and time.year < 2006;

INSERT OVERWRITE TABLE crime_frag_2
SELECT 
    crime.* 
    FROM crime, time
    WHERE crime.time_id = time.id
    and time.year >= 2006 and time.year <= 2016;

INSERT OVERWRITE TABLE crime_frag_3
SELECT 
    crime.* 
    FROM crime, time
    WHERE crime.time_id = time.id
    and time.year > 2016;

INSERT OVERWRITE TABLE crime_frag_2016
SELECT 
    crime.* 
    FROM crime, time
    WHERE crime.time_id = time.id
    and time.year = 2016;