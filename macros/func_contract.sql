{% macro func_contract(string) %}
CASE
    WHEN
        regexp_contains(lower({{string}}), 'cdi')
        OR regexp_contains(lower({{string}}), 'temps plein')
    THEN "CDI"
    WHEN regexp_contains(lower({{string}}), 'cdd')
    THEN "CDD"
    WHEN regexp_contains(lower({{string}}), 'consultant')
    THEN "Consultant"
    WHEN
        regexp_contains(lower({{string}}), 'stage')
        OR regexp_contains(lower({{string}}), 'stagiaire')
        OR regexp_contains(lower({{string}}), 'internship')
        OR regexp_contains(lower({{string}}), 'intern')
        OR regexp_contains(lower({{string}}), 'alternance')
        OR regexp_contains(lower({{string}}), 'alternant')
    THEN "Stage & Alternance"
    WHEN
        regexp_contains(lower({{string}}), 'intérim')
        OR regexp_contains(lower({{string}}), 'interim')
    THEN "Intérim"
    WHEN
        regexp_contains(lower({{string}}), 'independent')
        OR regexp_contains(lower({{string}}), 'freelance')
    THEN 'Independent & Freelance'
    ELSE NULL
END
{% endmacro %}

