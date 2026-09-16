load('_prelude.sage')
check_pair(lambda k: (1 / 2) * (exp(k) - exp(-k)) * (exp(k) + exp(-k)),
           lambda k: (exp(k)^2 - exp(-k)^2) / 2,
           'difference of squares')
