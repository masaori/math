# 対象ラベル: concatenated_bases_of_direct_sum_form_basis
# V = ℂ^n、U = im Q、W = ker Q（Q := P D P^{-1}、D は対角に 1 を r 個・0 を n − r 個並べた冪等行列）で V = U ⊕ W
# （def_direct_sum_of_two_subspaces の (i) x = Qx + (x − Qx) と (ii) U ∩ W = {O}）を確かめ、U, W の基底をつないだ族について:
#   Step 1 の 4 行の鎖（乱数の x）、Step 2: Σ c_t v_t = O から u + w の 3 行の鎖・u = −w = (−1)w の 2 行・w の 3 行の鎖、
#   主張（つないだ族は基底、dim V = dim U + dim W）を確かめる。r = 0, n（片方が零部分空間）も含める。
# Step 2 の鎖は、仮定 Σ c_t v_t = O を満たさない乱数の c でも成り立つ行（u + w = Σ c_t v_t まで）を確かめ、
# 残りの行は線型独立性（階数）で確かめる。帰属: K = QQ(i)。
load("../../_shared/linear_algebra_families.sage")
import random
rng = random.Random(int(43))
for n in [1, 2, 3, 4]:
    for r in range(0, n + 1):
        P = rand_mat(rng, n, n)
        while P.det() == 0:
            P = rand_mat(rng, n, n)
        D = diagonal_matrix(K, [1] * r + [0] * (n - r))
        Q = P * D * P.inverse()
        ok(Q * Q == Q, "冪等")
        ub = [matrix(K, n, 1, list(v)) for v in Q.column_space().basis()]
        wb = [matrix(K, n, 1, list(v)) for v in Q.right_kernel().basis()]
        ok(len(ub) == r and len(wb) == n - r, "基底の個数")
        # 直和の (i)(ii)
        x = rand_mat(rng, n, 1)
        ok(x == Q * x + (x - Q * x) and Q * (x - Q * x) == zero(n, 1), "(i)")
        ok(rank_of(ub + wb, n, 1) == len(ub) + len(wb), "(ii) U ∩ W = {O}")
        vs = ub + wb
        # Step 1
        u = Q * x; w = x - Q * x
        a = coefficients_in(u, ub, n, 1); b = coefficients_in(w, wb, n, 1)
        c = list(a) + list(b)
        chain = [lincomb(c, vs, n, 1), lincomb(c[:r], vs[:r], n, 1) + lincomb(c[r:], vs[r:], n, 1),
                 lincomb(a, ub, n, 1) + lincomb(b, wb, n, 1), u + w, x]
        for t in range(len(chain) - 1):
            ok(chain[t] == chain[t + 1], ("Step1", t))
        # Step 2 の前半（任意の c で成り立つ行）
        c = rand_vec_list(rng, n)
        uu = lincomb(c[:r], ub, n, 1); ww = lincomb(c[r:], wb, n, 1)
        ok(in_span(uu, ub, n, 1) and in_span(ww, wb, n, 1), "u ∈ U, w ∈ W")
        ok(uu + ww == lincomb(c[:r], vs[:r], n, 1) + lincomb(c[r:], vs[r:], n, 1) == lincomb(c, vs, n, 1), "u + w の鎖")
        # u + w = O なら u = −w = (−1)w、w = O + w = u + w（u = O のとき）
        uu2 = -ww
        ok(uu2 + ww == zero(n, 1) and uu2 == (-K(1)) * ww, "u = −w = (−1)w")
        ok(zero(n, 1) + ww == ww, "O + w = w")
        # 主張
        ok(is_independent(vs, n, 1) and len(vs) == n, "つないだ族は基底")
        ok(len(ub) + len(wb) == n, "dim V = dim U + dim W")
# 対照: U ∩ W ≠ {O} のとき（同じ部分空間を二つ）つないだ族は線型独立でない
ub = [matrix(K, [[1], [0]])]
ok(not is_independent(ub + ub, 2, 1), "対照")
print("checked", count(), "items")
print("RESULT: PASS")
