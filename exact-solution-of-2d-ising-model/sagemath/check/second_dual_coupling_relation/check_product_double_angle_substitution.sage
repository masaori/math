load('_prelude.sage')
check_pair(lambda k: sinh(2 * k) * sinh(2 * second_dual_coupling(k)),
           lambda k: 2 * sinh(k) * cosh(k) * sinh(2 * second_dual_coupling(k)),
           'substitute the double-angle identity')
