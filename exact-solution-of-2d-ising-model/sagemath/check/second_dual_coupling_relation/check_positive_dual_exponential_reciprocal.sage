load('_prelude.sage')
check_pair(lambda k: exp(2 * second_dual_coupling(k)),
           lambda k: 1 / tanh(k),
           'exp(2 K2*) = 1/tanh(K2)')
