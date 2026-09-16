load('_prelude.sage')
check_pair(lambda k: exp(-log(tanh(k)) + log(tanh(k))),
           lambda k: exp(0),
           'exp(-log t + log t) = exp(0)')
