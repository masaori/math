# 対象ラベル: linear_combination_splits_off_last_term（Σ_{t=1}^{p+1} c_t u_t = (Σ_{t=1}^{p} c_t u_t) + c_{p+1} u_{p+1}）
# 証明の p = 0 の 4 行の鎖と p ≥ 1 の 3 行の鎖を、式どおりに別々に組んで隣り合う項が等しいことを確かめる。
# u_t は K = QQ(i) の乱数行列、係数 c_t は K 上の多項式環の不定元。線型結合は def_linear_combination のとおり（p = 0 は O）。
load("../../_shared/linear_algebra_families.sage")
import random
rng = random.Random(int(20261121))
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        for p in range(0, 5):
            R = PolynomialRing(K, ["c%d" % t for t in range(1, p + 2)])
            cs = list(R.gens())
            us = [rand_mat(rng, m, n).change_ring(R) for _ in range(p + 1)]
            Z = zero(m, n, R)
            if p == 0:
                chain = [lincomb(cs, us, m, n, R), fsum([cs[0] * us[0]]), cs[0] * us[0], Z + cs[0] * us[0],
                         lincomb([], [], m, n, R) + cs[0] * us[0]]
            else:
                chain = [lincomb(cs, us, m, n, R), fsum([cs[t] * us[t] for t in range(p + 1)]),
                         fsum([cs[t] * us[t] for t in range(p)]) + cs[p] * us[p],
                         lincomb(cs[:p], us[:p], m, n, R) + cs[p] * us[p]]
            for t in range(len(chain) - 1):
                ok(chain[t] == chain[t + 1], (m, n, p, t))
# 対照: 最後の項を落とすと一般には等しくない
u = matrix(K, [[1]]); ok(lincomb([K(1), K(1)], [u, u], 1, 1) != lincomb([K(1)], [u], 1, 1), "対照")
print("checked", count(), "items")
print("RESULT: PASS")
