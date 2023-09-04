{% macro func_replace(string) %}
replace( 
    replace(
        replace(
            replace(
                replace(
                    replace(
                        replace(
                            replace(
                                replace(
                                    replace(
                                        replace(    
                                            replace(
                                                replace(
                                                    lower({{string}}),
                                                'é', 'e'), 
                                            'è', 'e'),
                                        '(f/h/n)',''),
                                    '(m/f/d)',''),
                                '(h/f)',''),
                            'h/f',''),
                        'f/m',''),
                    'm/f',''),
                'f/h',''),
            'w/m',''),
        'm/w',''),
    '()',''),
'-','')
{% endmacro %}

