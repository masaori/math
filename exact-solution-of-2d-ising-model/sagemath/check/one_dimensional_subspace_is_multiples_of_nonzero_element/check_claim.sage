# 対象ラベル: one_dimensional_subspace_is_multiples_of_nonzero_element
# 1 次元の部分空間 U（0 でない乱数の行列 g の倍数の全体）について、基底 (q)（g の 0 でない倍数をいくつか取る）が
# q ≠ O を満たし、U の元 u（g の乱数倍）が u = Σ_{t=1}^{1} c_t q = Σ_{t=1}^{1}(c_t q) = c_1 q と書けること（3 行の鎖）、
# 逆に cq ∈ U を確かめる。帰属: K = QQ(i)。
load("../../_shared/linear_algebra_families.sage")
import random
rng = random.Random(int(53))
for (m, n) in [(1, 1), (2, 1), (3, 1), (2, 2)]:
    for _ in range(4):
        g = rand_mat(rng, m, n)
        while g == zero(m, n):
            g = rand_mat(rng, m, n)
        U = [g]
        ok(rank_of(U, m, n) == 1, "dim U = 1")
        s = small_K(rng)
        while s == 0:
            s = small_K(rng)
        q = s * g
        ok(is_independent([q], m, n) and in_span(q, U, m, n) and q != zero(m, n), "基底 (q) と q ≠ O")
        u = small_K(rng) * g
        c = coefficients_in(u, [q], m, n)
        chain = [u, lincomb(c, [q], m, n), fsum([c[0] * q]), c[0] * q]
        for t in range(len(chain) - 1):
            ok(chain[t] == chain[t + 1], ("u = c q", t))
        ok(in_span(small_K(rng) * q, U, m, n), "cq ∈ U")
# 対照: 2 次元の部分空間は一つの元の倍数の全体ではない
U = [matrix(K, [[1], [0]]), matrix(K, [[0], [1]])]
ok(rank_of(U, 2, 1) == 2 and all(not in_span(U[1], [U[0]], 2, 1) for _ in [0]), "対照")
print("checked", count(), "items")
print("RESULT: PASS")
