load('_prelude.sage')
check_pair(lambda k: exp(-log(tanh(k))),
           lambda k: 1 / tanh(k),
           'exp(-log t) = 1/t')
