load('_prelude.sage')
check_pair(lambda k: (exp(k)^2 - exp(-k)^2) / 2,
           lambda k: (exp(2 * k) - exp(-2 * k)) / 2,
           'combine exponential products')
