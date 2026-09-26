# =========================================================================
# check_01: epsilon_is_sign_flip_permutation
#   本文 019 章の第 1 段。ε は標準基底を標準基底へ写す 0/1 の置換行列であり、
#   その置換 π は不動点をもたない対合である。成分では (εx)_k = x_{π(k)}。
#
#   (1) ε の成分はすべて 0 または 1
#   (2) 各行・各列にちょうど 1 個の 1 がある（置換行列）
#   (3) π(π(k)) = k（対合）かつ π(k) ≠ k（不動点なし）
#   (4) 任意の x について (εx)_k = x_{π(k)}
#   (5) ε^T = ε, ε^2 = I
#   (6) F^{(-)} ∩ R^{2^M} は {0} でない（c_−(M) を定める集合が空でないこと）
# =========================================================================
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== check_01: ε は不動点をもたない対合置換の置換行列 ===")

ok_all = True
set_random_seed(20260727)

w_01 = w_perm = w_pi = w_act = w_sym = 0
n_empty = 0
for M in SEC_M:
    O = SpinOps(M)
    d = O.d
    E = eps_real(O)

    # (1) 成分が 0/1
    for i in range(d):
        for j in range(d):
            w_01 = max(w_01, min(abs(E[i, j]), abs(E[i, j] - 1)))

    # (2) 各行・各列の和がちょうど 1
    for i in range(d):
        w_perm = max(w_perm, abs(sum(E[i, j] for j in range(d)) - 1))
        w_perm = max(w_perm, abs(sum(E[j, i] for j in range(d)) - 1))

    # π: ε e_l = e_{π(l)}、すなわち E[π(l), l] = 1
    pi = [None] * d
    for l in range(d):
        pi[l] = max(range(d), key=lambda i: E[i, l])
    # (3) 対合・不動点なし。さらに flip_index と一致すること
    for k in range(d):
        w_pi = max(w_pi, abs(pi[pi[k]] - k))
        w_pi = max(w_pi, abs(pi[k] - flip_index(M, k)))
        if pi[k] == k:
            w_pi = max(w_pi, RDF(1))

    # (4) (εx)_k = x_{π(k)}（π は対合なので添字は π(k) でよい）
    for _ in range(5):
        x = vector(RDF, [RDF(random() * 2 - 1) for _ in range(d)])
        y = E * x
        for k in range(d):
            w_act = max(w_act, abs(y[k] - x[pi[k]]))

    # (5) ε^T = ε, ε^2 = I
    w_sym = max(w_sym, RDF(max([abs(z) for z in (E.transpose() - E).list()])))
    w_sym = max(w_sym, RDF(max([abs(z) for z in (E * E - identity_matrix(RDF, d)).list()])))

    # (6) F^{(-)} ∩ R^{2^M} が {0} でない: 次元 = 2^{M-1}
    Bm = sector_basis(M, -1)
    if Bm.ncols() != 2 ** (M - 1):
        n_empty += 1
    for c in range(Bm.ncols()):
        v = Bm.column(c)
        w_sym = max(w_sym, RDF((E * v + v).norm()))

ok_all &= report("(1) ε の成分は 0 か 1", RDF(w_01), TOL)
ok_all &= report("(2) 各行・各列の成分和は 1（置換行列）", RDF(w_perm), TOL)
ok_all &= report("(3) π は不動点なしの対合で flip_index に一致", RDF(w_pi), TOL)
ok_all &= report("(4) (εx)_k = x_{π(k)}", RDF(w_act), TOL)
ok_all &= report("(5) ε^T = ε, ε^2 = I, および F^{(-)} 基底が εv = −v", RDF(w_sym), TOL)
print(f"  (6) dim(F^{{(-)}} ∩ R^{{2^M}}) = 2^{{M-1}} の違反件数: {n_empty}  ->  "
      f"{'PASS' if n_empty == 0 else 'FAIL'}")
ok_all &= (n_empty == 0)

print("=== check_01: " + ("ALL PASS" if ok_all else "FAIL") + " ===")
