{% macro func_salary(string) %}
CASE
    WHEN
        regexp_contains(
        {{string}},
        "[0-9][0-9] [0-9][0-9][0-9] € à [0-9][0-9][0-9] [0-9][0-9][0-9] €"
        )
    THEN
        Regexp_extract(
        {{string}},
        "[0-9][0-9] [0-9][0-9][0-9] € à [0-9][0-9][0-9] [0-9][0-9][0-9] €"
        )
    WHEN
        Regexp_contains(
        {{string}},
        "[0-9][0-9] [0-9][0-9][0-9] € à [0-9][0-9] [0-9][0-9][0-9] €"
        )
    THEN
        Regexp_extract(
        {{string}},
        "[0-9][0-9] [0-9][0-9][0-9] € à [0-9][0-9] [0-9][0-9][0-9] €"
        )
    WHEN
        Regexp_contains(
        {{string}}, "[0-9] [0-9][0-9][0-9] € à [0-9] [0-9][0-9][0-9] €"
        )
    THEN
        Regexp_extract(
        {{string}}, "[0-9] [0-9][0-9][0-9] € à [0-9] [0-9][0-9][0-9] €"
        )
    WHEN
        Regexp_contains(
        {{string}}, "[0-9][0-9][0-9] € à [0-9] [0-9][0-9][0-9] €"
        )
    THEN
        Regexp_extract(
        {{string}}, "[0-9][0-9][0-9] € à [0-9] [0-9][0-9][0-9] €"
        )
    WHEN
        regexp_contains({{string}}, "[0-9][0-9][0-9] € à [0-9][0-9][0-9] €")
    THEN
        regexp_extract({{string}}, "[0-9][0-9][0-9] € à [0-9][0-9][0-9] €")
    WHEN
        regexp_contains({{string}}, "[0-9][0-9] [0-9][0-9][0-9] €")
    THEN
        regexp_extract({{string}}, "[0-9][0-9] [0-9][0-9][0-9] €")
    WHEN
        regexp_contains({{string}}, "[0-9] [0-9][0-9][0-9] €")
    THEN
        regexp_extract({{string}}, "[0-9] [0-9][0-9][0-9] €")
    WHEN
        regexp_contains({{string}}, "[0-9][0-9][0-9] €")
    THEN
        regexp_extract({{string}}, "[0-9][0-9][0-9] €")
    WHEN
        regexp_contains({{string}}, "[0-9][0-9],[0-9][0-9] €")
    THEN
        regexp_extract({{string}}, "[0-9][0-9],[0-9][0-9] €")
    ELSE NULL
    END
{% endmacro %}