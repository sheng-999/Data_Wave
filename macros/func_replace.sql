{% macro func_replace(string) %}

{% set string = string | lower %}

{{ return(string)}}

{% endmacro %}