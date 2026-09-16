load('_prelude.sage')
check_pair(lambda k: (exp(2 * k) - exp(-2 * k)) / 2,
           lambda k: sinh(2 * k),
           'identify sinh(2 K2)')
