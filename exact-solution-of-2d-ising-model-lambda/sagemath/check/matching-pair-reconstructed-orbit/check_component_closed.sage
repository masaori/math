load(str(_dir / '_prelude.sage'))
for tau, upsilon, p, q, i, C in DATA:
    B = component(tau, p, i)
    for j in B:
        assert component(tau, p, j) == B
        assert tau[j] in B
        assert upsilon[j] == p[tau[j]]
        assert upsilon[j] in B
        assert successor(tau, upsilon, C, j) in B
        assert predecessor(tau, upsilon, C, j) in B
print('PASS component closure', len(DATA))
