load('_prelude.sage')
check_pair(lambda k: exp(-log(tanh(k))) * exp(log(tanh(k))),
           lambda k: exp(-log(tanh(k)) + log(tanh(k))),
           'exp(-log t) exp(log t) = exp(-log t + log t)')
