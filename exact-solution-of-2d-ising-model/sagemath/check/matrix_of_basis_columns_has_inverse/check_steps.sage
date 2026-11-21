# 対象ラベル: matrix_of_basis_columns_has_inverse
# ℂ^n の基底 (v_1, …, v_n)（乱数の可逆行列の列）を列に並べた P について:
#   準備 (L) の 6 行の鎖（乱数の y、全成分）、Step 1 の 7 行の鎖（c_{jk} は e_k の係数を解いて求める）と PC = I、
#   Step 2 の 6 行の鎖（y := (CP)e_l − e_l）、y = O、(CP)_{jl} の 7 行の鎖、CP = I を確かめる。
# 帰属: K = QQ(i)。添字は 0 始まり。
load("../../_shared/linear_algebra_families.sage")
import random
rng = random.Random(int(47))
d = lambda i, j: K(1) if i == j else K(0)
for n in [1, 2, 3, 4]:
    for _ in range(3):
        P = rand_mat(rng, n, n)
        while P.det() == 0:
            P = rand_mat(rng, n, n)
        vs = [P.column(j).column() for j in range(n)]
        es = standard_basis(n)
        I = identity_matrix(K, n)
        # (L)
        y = rand_mat(rng, n, 1)
        Py = P * y
        for i in range(n):
            chain = [Py[i, 0], fsum([P[i, j] * y[j, 0] for j in range(n)]), fsum([vs[j][i, 0] * y[j, 0] for j in range(n)]),
                     fsum([y[j, 0] * vs[j][i, 0] for j in range(n)]), fsum([(y[j, 0] * vs[j])[i, 0] for j in range(n)]),
                     fsum([y[j, 0] * vs[j] for j in range(n)])[i, 0], lincomb([y[j, 0] for j in range(n)], vs, n, 1)[i, 0]]
            for t in range(len(chain) - 1):
                ok(chain[t] == chain[t + 1], ("(L)", t))
        # Step 1
        cols = [coefficients_in(es[k], vs, n, 1) for k in range(n)]
        C = matrix(K, n, n, lambda j, k: cols[k][j])
        PC = P * C
        for i in range(n):
            for k in range(n):
                ck = C.column(k).column()
                chain = [PC[i, k], fsum([P[i, j] * C[j, k] for j in range(n)]), fsum([P[i, j] * ck[j, 0] for j in range(n)]),
                         (P * ck)[i, 0], lincomb(cols[k], vs, n, 1)[i, 0], es[k][i, 0], d(i, k), I[i, k]]
                for t in range(len(chain) - 1):
                    ok(chain[t] == chain[t + 1], ("Step1", t))
        ok(PC == I, "PC = I")
        # Step 2
        for l in range(n):
            y = (C * P) * es[l] - es[l]
            chain = [P * y, P * ((C * P) * es[l]) - P * es[l], (P * (C * P)) * es[l] - P * es[l],
                     ((P * C) * P) * es[l] - P * es[l], (I * P) * es[l] - P * es[l], P * es[l] - P * es[l], zero(n, 1)]
            for t in range(len(chain) - 1):
                ok(chain[t] == chain[t + 1], ("Step2", t))
            ok(lincomb([y[j, 0] for j in range(n)], vs, n, 1) == P * y, "(L) で Σ y_j v_j = Py")
            ok(y == zero(n, 1) and (C * P) * es[l] == es[l], "y = O")
            CP = C * P
            for j in range(n):
                chain = [CP[j, l], CP[j, l] * K(1), CP[j, l] * es[l][l, 0], fsum([CP[j, k] * es[l][k, 0] for k in range(n)]),
                         (CP * es[l])[j, 0], es[l][j, 0], d(j, l), I[j, l]]
                for t in range(len(chain) - 1):
                    ok(chain[t] == chain[t + 1], ("(CP)_jl", t))
        ok(C * P == I, "CP = I")
# 対照: 基底でない（階数の落ちた）列の行列は逆行列を持たない
P = matrix(K, [[1, 2], [2, 4]])
ok(P.det() == 0 and not is_independent([P.column(0).column(), P.column(1).column()], 2, 1), "対照")
print("checked", count(), "items")
print("RESULT: PASS")
