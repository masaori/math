load('_prelude.sage')
check_pair(lambda k: sinh(k) * cosh(k) * ((1 / tanh(k)) - tanh(k)),
           lambda k: sinh(k) * cosh(k) * ((1 / (sinh(k) / cosh(k))) - (sinh(k) / cosh(k))),
           'substitute tanh = sinh/cosh')
