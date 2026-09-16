load('_prelude.sage')
check_pair(lambda k: 2 * sinh(k) * cosh(k) * sinh(2 * second_dual_coupling(k)),
           lambda k: 2 * sinh(k) * cosh(k) * (1 / 2) * ((1 / tanh(k)) - tanh(k)),
           'substitute the dual sinh formula')
