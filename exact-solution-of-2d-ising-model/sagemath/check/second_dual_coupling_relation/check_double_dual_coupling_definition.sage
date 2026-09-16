load('_prelude.sage')
check_pair(lambda k: 2 * second_dual_coupling(k),
           lambda k: -log(tanh(k)),
           '2 K2* = -log(tanh K2)')
