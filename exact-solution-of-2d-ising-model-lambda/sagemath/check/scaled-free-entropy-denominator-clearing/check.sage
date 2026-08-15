# 対象ラベル: claim_scaled_free_entropy_denominator_clearing
# 帰属: QQ と有限台辞書だけを使う厳密計算。

from itertools import product


def smul(c, v):
    return {p: QQ(c) * a for p, a in v.items() if QQ(c) * a != 0}


samples = [
    {},
    {2: QQ(1)},
    {3: QQ(-2)},
    {2: QQ(3), 5: QQ(-1)},
]

count = 0
for L, M, lam, mu in product([1, 2, 3, 5], [1, 2, 4], samples, samples):
    common = QQ(L**2 * M**2)
    left_density = smul(QQ(1) / L**2, lam)
    right_density = smul(QQ(1) / M**2, mu)
    assert smul(common, left_density) == smul(M**2, lam)
    assert smul(common, right_density) == smul(L**2, mu)
    # 整数倍と ι の交換: n·ι(ν) = ι(nν)（Λ 側は ZZ の積、Λ_Q 側は QQ の積）
    for n, nu in [(M**2, lam), (L**2, mu)]:
        z_side = {p: ZZ(n) * ZZ(a) for p, a in nu.items() if ZZ(n) * ZZ(a) != 0}
        assert smul(n, nu) == {p: QQ(a) for p, a in z_side.items()}
    count += 4

print("PASS: scaled-free-entropy-denominator-clearing (%d checks)" % count)
