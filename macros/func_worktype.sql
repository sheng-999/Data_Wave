{% macro func_worktype(string) %}

CASE 
    WHEN
        regexp_contains(lower({{string}}), '.*online.*') 
        OR regexp_contains(({{string}}), '.*remote.*') 
        OR regexp_contains(lower({{string}}), '.*en ligne.*')
        OR regexp_contains(lower({{string}}), '.*a distance.*') 
        OR regexp_contains(lower({{string}}), '.*à distance.*')
    THEN 'Remote'
    WHEN
        regexp_contains(lower({{string}}), '.*hybride.*') 
        OR regexp_contains(({{string}}), '.*teletravail.*') 
        OR regexp_contains(lower({{string}}), '.*télétravail.*')
    THEN 'Hybride'
    WHEN
        regexp_contains(lower({{string}}), '.*sur site.*') 
        OR regexp_contains(({{string}}), '.*on site.*') 
    THEN 'Onsite'
    ELSE NULL
    END

{% endmacro %}
/*
        OR regexp_contains(lower(job_location), '.*eu.*')
        OR regexp_contains(lower(job_location), '.*us.*')
        OR regexp_contains(lower(job_location), '.*uk.*')
        OR regexp_contains(lower(job_location), '.*london.*')
        OR regexp_contains(lower(job_location), '.*londres.*')
*/


