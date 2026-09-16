load('_prelude.sage')
check_pair(lambda k: second_dual_coupling(k),
           lambda k: -log(tanh(k)) / 2,
           'K2* = -log(tanh K2)/2')
