# 対象ラベル: linear_combination_of_subspace_elements_stays_in_subspace（部分空間の元の線型結合は部分空間に属する）
# 部分空間 U を QQ(i) の乱数行列 g_1, …, g_k の線型結合の全体として作り（def_subspace の (i)〜(iii) を満たすことも確かめる）、
# 証明の帰納法の各段: p = 0 で Σ^0 = O ∈ U、p → p+1 の 1 行の鎖 Σ^{p+1} = Σ^p + c_{p+1}u_{p+1} と、右辺の二項・和が U に属することを確かめる。
# 帰属: K = QQ(i)（厳密計算）。U への所属は平らにした行列の階数で判定する。
load("../../_shared/linear_algebra_families.sage")
import random
rng = random.Random(int(11))
for (m, n) in [(1, 1), (2, 1), (3, 1), (2, 2), (2, 3)]:
    for k in range(0, 4):
        gens = [rand_mat(rng, m, n) for _ in range(k)]
        inU = lambda x: in_span(x, gens, m, n)
        # def_subspace (i)〜(iii)
        ok(inU(zero(m, n)), "(i)")
        for _ in range(3):
            A = lincomb(rand_vec_list(rng, k), gens, m, n); B = lincomb(rand_vec_list(rng, k), gens, m, n)
            ok(inU(A + B), "(ii)"); ok(inU(small_K(rng) * A), "(iii)")
        for p in range(0, 5):
            us = [lincomb(rand_vec_list(rng, k), gens, m, n) for _ in range(p + 1)]
            cs = rand_vec_list(rng, p + 1)
            if p == 0:
                ok(lincomb([], [], m, n) == zero(m, n) and inU(zero(m, n)), "p=0")
            L = lincomb(cs[:p], us[:p], m, n)
            ok(inU(L), ("帰納法の仮定", p))
            ok(lincomb(cs, us, m, n) == L + cs[p] * us[p], ("splits_off_last_term", p))
            ok(inU(cs[p] * us[p]) and inU(L + cs[p] * us[p]), ("(iii),(ii)", p))
# 対照: U に属さない元を混ぜると、線型結合は一般に U から出る
gens = [matrix(K, [[1], [0]])]
x = matrix(K, [[0], [1]])
ok(not in_span(lincomb([K(1), K(1)], [gens[0], x], 2, 1), gens, 2, 1), "対照")
print("checked", count(), "items")
print("RESULT: PASS")
