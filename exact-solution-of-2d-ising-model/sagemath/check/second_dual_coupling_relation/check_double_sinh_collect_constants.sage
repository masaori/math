load('_prelude.sage')
check_pair(lambda k: 2 * ((exp(k) - exp(-k)) / 2) * ((exp(k) + exp(-k)) / 2),
           lambda k: (1 / 2) * (exp(k) - exp(-k)) * (exp(k) + exp(-k)),
           'collect constants in double-angle derivation')
