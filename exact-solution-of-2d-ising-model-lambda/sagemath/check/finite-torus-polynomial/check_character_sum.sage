# 対象ラベル: claim_finite_torus_polynomial
for c in (0, 1):
    for d in (0, 1):
        direct = sum(ZZ(-1)^((1+a)*c+(1+b)*d+c*d)
                     for a in (0, 1) for b in (0, 1))
        separated = ZZ(-1)^(c+d+c*d) * sum(ZZ(-1)^(a*c) for a in (0, 1)) * sum(ZZ(-1)^(b*d) for b in (0, 1))
        assert direct == separated
        assert separated == 4 * ZZ(c == 0) * ZZ(d == 0)
print('RESULT: PASS four character sums')
