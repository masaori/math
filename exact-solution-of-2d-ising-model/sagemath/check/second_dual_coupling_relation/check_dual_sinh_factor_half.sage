load('_prelude.sage')
check_pair(lambda k: ((1 / tanh(k)) - tanh(k)) / 2,
           lambda k: (1 / 2) * ((1 / tanh(k)) - tanh(k)),
           'factor one half')
