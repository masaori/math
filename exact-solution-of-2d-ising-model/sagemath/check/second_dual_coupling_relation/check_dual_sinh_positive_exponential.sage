load('_prelude.sage')
check_pair(lambda k: (exp(2 * second_dual_coupling(k)) - exp(-2 * second_dual_coupling(k))) / 2,
           lambda k: ((1 / tanh(k)) - exp(-2 * second_dual_coupling(k))) / 2,
           'replace exp(2 K2*)')
