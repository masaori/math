load('_prelude.sage')
check_pair(lambda k: 2 * sinh(k) * cosh(k),
           lambda k: 2 * ((exp(k) - exp(-k)) / 2) * ((exp(k) + exp(-k)) / 2),
           'expand sinh and cosh')
