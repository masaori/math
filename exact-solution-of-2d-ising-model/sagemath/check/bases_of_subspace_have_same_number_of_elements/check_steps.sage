# 対象ラベル: bases_of_subspace_have_same_number_of_elements
# 部分空間 U（乱数の生成元の線型結合の全体）について、二通りの基底（階段形の行から作るものと、それに可逆な QQ(i) 行列を
# 掛けて作るもの、生成元から順に足して作るもの）の元の個数が等しいことを確かめる。
# Step 1: 零部分空間では、O が元を持たない族の線型結合であり、O を含む族は線型独立でない（p ≥ 1 の基底は無い）。
# Step 2: 一方の基底の元は他方の基底の線型結合で、個数は互いに ≤（両方向）。帰属: K = QQ(i)。
load("../../_shared/linear_algebra_families.sage")
import random
rng = random.Random(int(23))
for (m, n) in [(1, 1), (2, 1), (3, 1), (2, 2)]:
    N = m * n
    for k in range(0, N + 2):
        gens = [rand_mat(rng, m, n) for _ in range(k)]
        if k == 0:
            ok(lincomb([], [], m, n) == zero(m, n), "Step 1: 元を持たない族の線型結合は O")
            ok(not is_independent([zero(m, n)], m, n), "Step 1: O を含む族は線型独立でない")
            continue
        G = matrix(K, [flat(g) for g in gens])
        rows = G.echelon_form().rows()
        b1 = [matrix(K, m, n, list(r)) for r in rows if r != 0]
        r = len(b1)
        T = random_matrix(K, r, r) if r > 0 else matrix(K, 0, 0)
        while r > 0 and T.det() == 0:
            T = random_matrix(K, r, r)
        b2 = [lincomb(list(T.row(s)), b1, m, n) for s in range(r)]
        b3 = []
        for g in gens:
            if not in_span(g, b3, m, n):
                b3.append(g)
        for B in [b1, b2, b3]:
            ok(is_independent(B, m, n), "線型独立")
            ok(all(in_span(g, B, m, n) for g in gens), "U を張る")
        for (B, C) in [(b1, b2), (b2, b3), (b1, b3)]:
            ok(all(in_span(u, C, m, n) for u in B), "Step 2: 他方の線型結合")
            ok(len(B) <= len(C) and len(C) <= len(B), "Step 2: 両方向の ≤")
# 対照: 線型独立でない張る族は基底より多くの元を持ちうる
g = [matrix(K, [[1]]), matrix(K, [[2]])]
ok(len(g) > 1 and in_span(g[1], g[:1], 1, 1), "対照")
print("checked", count(), "items")
print("RESULT: PASS")
