# ---------------------------------------------------------
# <matrix_norm_triangle_inequality> (3) 三角不等式 ‖A+B‖ ≤ ‖A‖+‖B‖。
#
# 反例を探す姿勢で書く:
#   - 乱数・退化行列・Ising 作用素の全ペアで不等式を検査し、破れがないか探す。
#   - 等号ぎりぎり（B = cA, c>0 real）を明示的に入れる。ここが一番危ない。
#   - 逆向きの不等式 ‖A+B‖ ≥ ‖A‖+‖B‖ は破れること（＝主張が自明でないこと）を確認する。
#   - 「B = cA, c<0」では ‖A+B‖ < ‖A‖+‖B‖ が真に成り立つ（余裕がある）ことも記録する。
#
# 対象: structured-latex matrix_norm_triangle_inequality
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '_prelude.sage'))
import numpy as np

rep = CheckReport("matrix_norm_triangle_inequality (3) 三角不等式")

mats = test_matrices(n_random=6, n=4, scale=2.0, with_ising=False)
mats += [(nm, A) for nm, A in ising_matrices(Ms=(2,)) ]

# --- 全ペアで検査（形が合うものだけ） --------------------------------
worst_slack = float('inf')
worst_pair = None
npairs = 0
for na, A in mats:
    for nb, B in mats:
        A = np.asarray(A); B = np.asarray(B)
        if A.shape != B.shape:
            continue
        npairs += 1
        lhs = fro(A + B)
        rhs = fro(A) + fro(B)
        rep.truth(le_ok(lhs, rhs), "(3) ‖A+B‖ ≤ ‖A‖+‖B‖: %s / %s" % (na, nb))
        slack = rhs - lhs
        if slack < worst_slack:
            worst_slack = slack
            worst_pair = (na, nb, lhs, rhs)
print("検査したペア数: %d" % npairs)
print("最も等号に近いペア: %s / %s  (lhs=%.12e, rhs=%.12e, 余裕=%.3e)"
      % (worst_pair[0], worst_pair[1], worst_pair[2], worst_pair[3], worst_slack))

# --- 等号ケース B = cA (c > 0 実数) ----------------------------------
for nm, A in mats[:12]:
    A = np.asarray(A)
    for c in [1.0, 0.25, 7.0]:
        rep.close(fro(A + c * A), fro(A) + fro(c * A),
                  "(3) 等号 B=cA (c=%g): %s" % (c, nm))

# --- 逆向きの不等式は破れる（主張が自明でないことの確認）-------------
A = rand_mat(4, 7001, 1.0)
B = -A
rep.truth(fro(A + B) < fro(A) + fro(B) - 1.0,
          "(3) 逆向き ‖A+B‖ ≥ ‖A‖+‖B‖ は破れる（B=-A: lhs=%.3e, rhs=%.3e）"
          % (fro(A + B), fro(A) + fro(B)))
B = rand_mat(4, 7002, 1.0)
rep.truth(fro(A + B) < fro(A) + fro(B),
          "(3) 乱数ペアでも真の不等号（lhs=%.6f < rhs=%.6f）" % (fro(A + B), fro(A) + fro(B)))

# --- 有限和への一般化（証明 Step 1 の Σ|z_k| 版を行列で） -------------
mats_sum = [rand_mat(4, 7100 + k, 1.0) for k in range(7)]
S = sum(mats_sum)
rep.truth(le_ok(fro(S), sum(fro(X) for X in mats_sum)),
          "(3) 有限和 ‖ΣA_k‖ ≤ Σ‖A_k‖（7 項: %.6f ≤ %.6f）"
          % (fro(S), sum(fro(X) for X in mats_sum)))

rep.finish()
