load('_prelude.sage')
check_pair(lambda k: exp(log(tanh(k))),
           lambda k: tanh(k),
           'exp(log t) = t')
