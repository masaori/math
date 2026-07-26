# ---------------------------------------------------------
# <matrix_norm_vector_bound> ‖Aw‖ ≤ ‖A‖·‖w‖。
#
# 独立な 2 経路で確認する:
#   (i) 直接: Aw をベクトルとして計算し、K^n のノルムで比べる。
#   (ii) 本文の証明の経路: 第 1 列が w で他が 0 の行列 W を作り、
#        ‖AW‖ = ‖Aw‖、‖W‖ = ‖w‖ を確認したうえで <matrix_norm_submultiplicativity> を使う。
#   (i) と (ii) が同じ値を与えることは、証明の Step（W の構成）自体の検査になる。
#
# 反例を探す姿勢:
#   - 乱数・退化行列・Ising 作用素、w も乱数/基底ベクトル/零ベクトルを回す。
#   - 等号ケース（A = u v^*, w = v）を明示的に入れる。
#   - 比 ‖Aw‖/(‖A‖‖w‖) の最大値を記録する。
#
# 対象: structured-latex matrix_norm_vector_bound
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '_prelude.sage'))
import numpy as np

rep = CheckReport("matrix_norm_vector_bound: ‖Aw‖ ≤ ‖A‖‖w‖")


def W_of(w, n):
    """本文の証明で使う行列 W（第 1 列が w、第 2 列以降が 0）。"""
    W = np.zeros((int(n), int(n)), dtype=complex)
    W[:, 0] = np.asarray(w, dtype=complex)
    return W


mats = test_matrices(n_random=6, n=4, scale=2.0, with_ising=False)
mats += ising_matrices(Ms=(2, 3))

best_ratio = 0.0
best = None
count = 0
for nm, A in mats:
    A = np.asarray(A)
    n = A.shape[1]
    vecs = [("乱数 #%d" % k, rand_vec(n, 11000 + k * 7 + n, 1.5)) for k in range(4)]
    vecs.append(("零ベクトル", np.zeros(n, dtype=complex)))
    for j in range(min(int(n), 3)):
        e = np.zeros(n, dtype=complex); e[j] = 1.0
        vecs.append(("基底 e_%d" % (j + 1), e))
    for vn, w in vecs:
        count += 1
        lhs = vec_norm(A @ w)
        rhs = fro(A) * vec_norm(w)
        rep.truth(le_ok(lhs, rhs), "‖Aw‖ ≤ ‖A‖‖w‖: %s / %s" % (nm, vn))
        # 証明の経路（W の構成）
        W = W_of(w, n)
        rep.close(fro(A @ W), lhs, "‖AW‖ = ‖Aw‖: %s / %s" % (nm, vn))
        rep.close(fro(W), vec_norm(w), "‖W‖ = ‖w‖: %s / %s" % (nm, vn))
        if rhs > 0:
            r = lhs / rhs
            if r > best_ratio:
                best_ratio = r
                best = (nm, vn, lhs, rhs)

print("検査した (A,w) の組: %d" % count)
print("比 ‖Aw‖/(‖A‖‖w‖) の最大値: %.15f  （%s / %s）" % (best_ratio, best[0], best[1]))
rep.truth(best_ratio <= 1.0 + 1e-12, "比の最大値が 1 を超えない")

# --- 等号ケース: A = u v^*, w = v -----------------------------------
print("等号ケース A = u v^*, w = v:")
for k in range(6):
    n = 2 + (k % 4)
    u = rand_vec(n, 12000 + k, 1.0)
    v = rand_vec(n, 12100 + k, 1.0)
    A = np.outer(u, v.conj())
    lhs = vec_norm(A @ v)
    rhs = fro(A) * vec_norm(v)
    rep.close(lhs, rhs, "等号 A=uv^*, w=v #%d (n=%d)" % (k, n))
    print("   n=%d: ‖Aw‖=%.12e, ‖A‖‖w‖=%.12e, 比=%.15f" % (n, lhs, rhs, lhs / rhs))

rep.finish()
