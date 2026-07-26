# ---------------------------------------------------------
# <matrix_norm_submultiplicativity> ‖AB‖ ≤ ‖A‖·‖B‖。
#
# 反例を探す姿勢:
#   - 乱数・退化行列（零・冪零・ランク1・非対角化可能）・Ising 作用素の全ペアを検査する。
#   - 「比 ‖AB‖/(‖A‖‖B‖) の最大値」を記録する。これが 1 を超えたら反例である。
#   - 等号に近づくランク 1 の族は check_02 で別に扱う。
#
# 対象: structured-latex matrix_norm_submultiplicativity
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '_prelude.sage'))
import numpy as np

rep = CheckReport("matrix_norm_submultiplicativity: ‖AB‖ ≤ ‖A‖‖B‖")

mats = test_matrices(n_random=6, n=4, scale=2.0, with_ising=False)
mats += ising_matrices(Ms=(2, 3))

best_ratio = 0.0
best_pair = None
npairs = 0
for na, A in mats:
    for nb, B in mats:
        A = np.asarray(A); B = np.asarray(B)
        if A.shape[1] != B.shape[0]:
            continue
        npairs += 1
        lhs = fro(A @ B)
        rhs = fro(A) * fro(B)
        rep.truth(le_ok(lhs, rhs), "‖AB‖ ≤ ‖A‖‖B‖: %s / %s" % (na, nb))
        if rhs > 0:
            r = lhs / rhs
            if r > best_ratio:
                best_ratio = r
                best_pair = (na, nb, lhs, rhs)

print("検査したペア数: %d" % npairs)
print("比 ‖AB‖/(‖A‖‖B‖) の最大値: %.15f" % best_ratio)
print("  達成ペア: %s / %s  (‖AB‖=%.6e, ‖A‖‖B‖=%.6e)"
      % (best_pair[0], best_pair[1], best_pair[2], best_pair[3]))
rep.truth(best_ratio <= 1.0 + 1e-12, "比の最大値が 1 を超えない（%.15f）" % best_ratio)

# 冪への繰り返し適用（<matrix_exp_series_converges> Step 1 が使う ‖A^m‖ ≤ ‖A‖^m）
for nm, A in mats[:14]:
    A = np.asarray(A)
    P = np.eye(A.shape[0], dtype=complex)
    for m in range(1, 9):
        P = P @ A
        rep.truth(le_ok(fro(P), fro(A) ** m), "‖A^%d‖ ≤ ‖A‖^%d: %s" % (m, m, nm))

rep.finish()
