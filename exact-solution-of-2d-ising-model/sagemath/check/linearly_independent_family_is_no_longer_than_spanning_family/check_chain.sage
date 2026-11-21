# 対象ラベル: linearly_independent_family_is_no_longer_than_spanning_family
# p > q ≥ 1 で u_i = Σ_j a_ij w_j のとき、0 でない c（Σ_i c_i a_ij = 0。係数行列の左核から取る）について
# 証明の 9 行の鎖を式どおりに組み、隣り合う項が等しく最後が O であることを確かめる（u は線型独立でない）。
# 主張そのもの: 線型独立な族 u が w の線型結合なら p ≤ q（乱数で w の線型結合を作り、独立なら個数 ≤ q）。帰属: K = QQ(i)。
load("../../_shared/linear_algebra_families.sage")
import random
rng = random.Random(int(9))
for (m, n) in [(1, 1), (2, 1), (2, 2), (3, 1)]:
    for q in range(1, 4):
        for p in range(q + 1, q + 3):
            ws = [rand_mat(rng, m, n) for _ in range(q)]
            a = matrix(K, p, q, [small_K(rng) for _ in range(p * q)])
            us = [fsum([a[i, j] * ws[j] for j in range(q)]) for i in range(p)]
            for i in range(p):
                ok(us[i] == lincomb([a[i, j] for j in range(q)], ws, m, n), "u_i の表示")
            c = a.left_kernel().basis()[0]
            ok(any(x != 0 for x in c), "c ≠ 0")
            O = zero(m, n)
            chain = [
                lincomb(list(c), us, m, n),
                fsum([c[i] * us[i] for i in range(p)]),
                fsum([c[i] * fsum([a[i, j] * ws[j] for j in range(q)]) for i in range(p)]),
                fsum([fsum([c[i] * (a[i, j] * ws[j]) for j in range(q)]) for i in range(p)]),
                fsum([fsum([(c[i] * a[i, j]) * ws[j] for j in range(q)]) for i in range(p)]),
                fsum([fsum([(c[i] * a[i, j]) * ws[j] for i in range(p)]) for j in range(q)]),
                fsum([fsum([c[i] * a[i, j] for i in range(p)]) * ws[j] for j in range(q)]),
                fsum([K(0) * ws[j] for j in range(q)]),
                fsum([O] * q),
                O,
            ]
            for t in range(len(chain) - 1):
                ok(chain[t] == chain[t + 1], (m, n, p, q, t))
            ok(not is_independent(us, m, n), "u は線型独立でない")
        # 主張: 独立な族は個数 ≤ q
        for p in range(1, q + 1):
            ws = [rand_mat(rng, m, n) for _ in range(q)]
            us = [lincomb(rand_vec_list(rng, q), ws, m, n) for _ in range(p)]
            if is_independent(us, m, n):
                ok(p <= q, "主張")
# 対照: w の線型結合でない元を許すと、p > q でも線型独立になりうる
ws = [matrix(K, [[1], [0]])]
us = [matrix(K, [[1], [0]]), matrix(K, [[0], [1]])]
ok(is_independent(us, 2, 1) and len(us) > len(ws), "対照")
print("checked", count(), "items")
print("RESULT: PASS")
