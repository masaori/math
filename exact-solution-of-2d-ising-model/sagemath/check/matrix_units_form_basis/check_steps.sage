# 対象ラベル: matrix_units_form_basis
# 行列単位 E^{(m,n)}_{ij} を全単射 π（乱数で並べた順と、辞書式の順）で並べた族 (F_1, …, F_N) について:
#   Step 1 の t ≠ t_0 の 3 行の鎖と、(C) の 7 行の鎖（乱数の係数 b）を、全ての (k, l) で一行ずつ
#   Step 2: A = Σ b_t F_t（b_t := A_{π(t)}）、Step 3: Σ c_t F_t = O なら c_{t_0} = (Σ c_t F_t)_{π(t_0)} = 0
#   n = 1、π(t) = (t, 1) の標準基底 (e_1, …, e_m) が ℂ^m の基底であること
# 帰属: K = QQ(i)。添字は 0 始まりで持つ。
load("../../_shared/linear_algebra_families.sage")
import random
rng = random.Random(int(17))
d = lambda i, j: K(1) if i == j else K(0)
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        N = m * n
        pairs = [(i, j) for i in range(m) for j in range(n)]
        for perm in [list(pairs), rng.sample(pairs, len(pairs))]:
            pi = lambda t: perm[t]
            F = [matrix_unit(m, n, *pi(t)) for t in range(N)]
            for (i, j) in pairs:
                E = matrix_unit(m, n, i, j)
                ok(all(E[k, l] == d(i, k) * d(j, l) for k in range(m) for l in range(n)), "E の定め方")
            b = rand_vec_list(rng, N)
            S = lincomb(b, F, m, n)
            for (k, l) in pairs:
                t0 = perm.index((k, l))
                for t in range(N):
                    if t != t0:
                        chain = [b[t] * F[t][k, l], b[t] * (d(pi(t)[0], k) * d(pi(t)[1], l)), b[t] * K(0), K(0)]
                        for s in range(len(chain) - 1):
                            ok(chain[s] == chain[s + 1], ("t≠t0", s))
                chain = [S[k, l], fsum([b[t] * F[t] for t in range(N)])[k, l], fsum([(b[t] * F[t])[k, l] for t in range(N)]),
                         fsum([b[t] * F[t][k, l] for t in range(N)]), b[t0] * F[t0][k, l], b[t0] * (d(k, k) * d(l, l)),
                         b[t0] * (K(1) * K(1)), b[t0]]
                for s in range(len(chain) - 1):
                    ok(chain[s] == chain[s + 1], ("(C)", s))
            A = rand_mat(rng, m, n)
            ok(A == lincomb([A[pi(t)[0], pi(t)[1]] for t in range(N)], F, m, n), "Step 2")
            ok(is_independent(F, m, n), "Step 3（階数 N）")
    E = [matrix_unit(m, 1, t, 0) for t in range(m)]
    ok(E == standard_basis(m) and is_independent(E, m, 1) and rank_of(E, m, 1) == m, "標準基底")
# 対照: 行列単位を一つ除くと全体を張らない
F = [matrix_unit(2, 2, i, j) for i in range(2) for j in range(2)][:3]
ok(not in_span(matrix_unit(2, 2, 1, 1), F, 2, 2), "対照")
print("checked", count(), "items")
print("RESULT: PASS")
