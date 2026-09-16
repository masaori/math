load('_prelude.sage')
check_pair(lambda k: 2 * sinh(k) * cosh(k) * (1 / 2) * ((1 / tanh(k)) - tanh(k)),
           lambda k: sinh(k) * cosh(k) * ((1 / tanh(k)) - tanh(k)),
           'cancel two times one half')
