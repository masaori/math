# 対象ラベル: polar_multiplication_well_defined
# 主張そのもの（具体の点）: (r,θ) ~ (r~,θ~) かつ (r',θ') ~ (r~',θ~') ならば (rr',θ+θ') ~ (r~r~',θ~+θ~')
# 代表元の組と、同値な別の代表元の組の全てについて確かめる。場合 (b) では角度の差が 2(n+n')π に等しいことも確かめる。
load("../../_shared/polar_representation.sage")

count = 0
cases = {"a": 0, "b": 0}
for p in SAMPLE:
    for q in SAMPLE:
        for pt in [p] + other_reps(p):
            for qt in [q] + other_reps(q):
                assert polar_equiv(p, pt) and polar_equiv(q, qt)
                if (p[0] == 0 and pt[0] == 0) or (q[0] == 0 and qt[0] == 0):
                    cases["a"] += 1
                    assert mul_rep(p, q)[0] == 0 == mul_rep(pt, qt)[0]
                else:
                    cases["b"] += 1
                    assert p[0] == pt[0] and q[0] == qt[0]
                    nn, nnp = angle_witness(p[1], pt[1]), angle_witness(q[1], qt[1])
                    assert (p[1] + q[1]) - (pt[1] + qt[1]) == 2 * (nn + nnp) * pi_
                assert polar_equiv(mul_rep(p, q), mul_rep(pt, qt))
                count += 1
# 対照: 半径が正のとき、角度を π だけずらした（2π の整数倍でない）代表元は同値でなく、積も同値でない
p, q = NONZERO[1], NONZERO[2]
qbad = (q[0], q[1] + pi_)
assert not polar_equiv(q, qbad) and not polar_equiv(mul_rep(p, q), mul_rep(p, qbad))
print(f"well-definedness on {count} pairs of representatives (case a: {cases['a']}, case b: {cases['b']})")
print("RESULT: PASS")
