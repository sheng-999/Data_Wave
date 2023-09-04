{% macro func_location(string) %}

-- mise en minuscule des villes, suppression des chiffres et autres textes 
REGEXP_REPLACE(NORMALIZE(
REPLACE(
    REPLACE(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    REPLACE(
                                        REPLACE(
                                            REPLACE(
                                                REPLACE(
                                                    REPLACE(
                                                        REPLACE(
                                                            REPLACE(
                                                                REPLACE(
                                                                    REPLACE(
                                                                        REPLACE(
                                                                            REPLACE(
                                                                                REPLACE(
                                                                                    REPLACE(
                                                                                        REPLACE(
                                                                                            REPLACE(
                                                                                                REPLACE(
                                                                                                    REPLACE(
                                                                                                        REPLACE(
                                                                                                            REPLACE(
                                                                                                                REPLACE(
                                                                                                                    REPLACE(
                                                                                                                        REPLACE(
                                                                                                                            REPLACE(
                                                                                                                                REPLACE(
                                                                                                                                    REPLACE(
                                                                                                                                        REPLACE(
                                                                                                                                            REPLACE(
                                                                                                                                                REPLACE(
                                                                                                                                                    REPLACE(
                                                                                                                                                        REPLACE(
                                                                                                                                                            REPLACE(
                                                                                                                                                                REPLACE(
                                                                                                                                                                    LOWER({{string}}),
                                                                                                                                                                '1e',''),
                                                                                                                                                            '2e',''),
                                                                                                                                                        '3e',''),
                                                                                                                                                    '4e',''),
                                                                                                                                                '5e',''),
                                                                                                                                            '6e',''),
                                                                                                                                        '7e',''),
                                                                                                                                    '8e',''),
                                                                                                                                '9e',''),
                                                                                                                            '10e',''),
                                                                                                                        '11e',''),
                                                                                                                    '12e',''),
                                                                                                                '13e',''),
                                                                                                            '14e',''),
                                                                                                        '15e',''),
                                                                                                    '16e',''),
                                                                                                '17e',''),
                                                                                            '18e',''),
                                                                                        '19e',''),
                                                                                    '20e',''),
                                                                                '0',''),
                                                                            '1',''),
                                                                        '2',''),
                                                                    '3',''),
                                                                '4',''),
                                                            '5',''),
                                                        '6',''),
                                                    '7',''),
                                                '8',''),
                                            '9',''),
                                        'saint','st'),
                                    "d'","d "),
                                "l'","l "),
                            '(', ''),
                        ' + location',''),
                    ')', ''),
                'télétravail à',''), 
            ' et périphérie',''),
        ', france',''),
    'ville de ',''),
'-',' '),
NFD), r"\pM", '')

{% endmacro %}