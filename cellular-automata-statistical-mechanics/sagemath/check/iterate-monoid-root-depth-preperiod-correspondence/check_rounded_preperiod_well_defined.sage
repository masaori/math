# 対象ラベル: def_iterate_monoid_rounded_preperiod_depth
# 定義集合 { d ∈ N | μ(y) <= d·λ_F } が m_F を含むこと（well-defined 性の根拠
# μ(y) <= μ_F <= e_F = m_F·λ_F）と、走査で得た r_F(y) が同集合の最小元である
# こと（所属し、かつそれより小さい全ての d は所属しない）を検査する。
# 帰属: 非負整数の乗算・大小比較だけを使う。R/C 脱出なし。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
points = 0
for stage_size, rule, table in exhaustive_instances():
    F, mu, lam, e, m, E, R, Q, fibers, mu_of = correspondence_data(table)
    assert mu <= e
    assert e == m * lam
    for y in range(len(F)):
        mu_y = mu_of[y]
        assert mu_y <= m * lam
        c = rounded_preperiod(mu_y, lam, m)
        assert mu_y <= c * lam
        for d in range(c):
            assert not (mu_y <= d * lam)
        assert c <= m
        points += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("configurations with minimal rounded value: {}".format(points))
print("RESULT: PASS")
