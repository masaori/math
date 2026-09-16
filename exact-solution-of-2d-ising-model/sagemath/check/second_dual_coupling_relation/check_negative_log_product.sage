load('_prelude.sage')
check_pair(lambda k: exp(-log(tanh(k))) * tanh(k),
           lambda k: 1,
           'exp(-log t) t = 1')
