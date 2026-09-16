load('_prelude.sage')
check_pair(lambda k: sinh(2 * second_dual_coupling(k)),
           lambda k: (exp(2 * second_dual_coupling(k)) - exp(-2 * second_dual_coupling(k))) / 2,
           'sinh(2 K2*) definition')
