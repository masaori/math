load('_prelude.sage')
check_pair(lambda k: exp(2 * second_dual_coupling(k)),
           lambda k: exp(-log(tanh(k))),
           'exp(2 K2*) = exp(-log t)')
