load(str(_dir / '_prelude.sage'))
for tau, upsilon, p, q, i, C in DATA:
    S = successor_orbit(tau, upsilon, C, i)
    B = component(tau, p, i)
    assert i in S and tau[i] in S
    assert orbit(p, i) <= S
    assert orbit(p, tau[i]) <= S
    assert B <= S
    assert S <= B
    assert S == B
print('PASS two inclusions', len(DATA))
