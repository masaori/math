# <matrix_norm_vector_bound>: 本文の証明が使う行列 W の構成を再現して検査する
#
# 本文は ||Aw|| <= ||A|| ||w|| を、第 1 列が w で他の列が 0 の行列 W を作り
#   ||AW|| = ||Aw||、||W|| = ||w||
# を経由して <matrix_norm_submultiplicativity> へ帰着させている。
# check_01 は不等式そのもの（直接経路）を見ているので、ここでは
# 「証明のステップ（W の構成）が正しく書けているか」を独立に検査する。
# 書き写しミス（列の位置・共役・転置の取り違え）はここで落ちる。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("matrix_norm_vector_bound: 証明の経路（行列 W の構成）")

def fro(A):
    return float(np.linalg.norm(np.asarray(A, dtype=complex)))
def vec_norm(w):
    w = np.asarray(w, dtype=complex)
    return float(np.sqrt(float(np.sum(np.abs(w)**2))))
def rand_mat(n, seed, scale=1.0):
    g = np.random.default_rng(int(seed))
    return float(scale)*(g.standard_normal((int(n),int(n))) + 1j*g.standard_normal((int(n),int(n))))
def rand_vec(n, seed, scale=1.0):
    g = np.random.default_rng(int(seed))
    return float(scale)*(g.standard_normal(int(n)) + 1j*g.standard_normal(int(n)))
def W_of(w, n):
    """本文の証明で使う行列 W（第 1 列が w、第 2 列以降が 0）。"""
    W = np.zeros((int(n), int(n)), dtype=complex)
    W[:, 0] = np.asarray(w, dtype=complex)
    return W
def le_ok(x, y, slack=1e-12):
    x = float(x); y = float(y)
    return x <= y + float(slack)*max(1.0, abs(x), abs(y))

# 乱数 + 退化行列 + Ising 側の実際の作用素
mats = [("乱数 4x4 #%d" % k, rand_mat(4, 1000+k, 2.0)) for k in range(6)]
mats += [
    ("零行列 4x4", np.zeros((4,4), dtype=complex)),
    ("冪零 Jordan 4x4", np.diag(np.ones(3, dtype=complex), 1)),
    ("非対角化可能 2x2", np.array([[1.0,1.0],[0.0,1.0]], dtype=complex)),
]
for M in [2,3]:
    mats.append(("hatZ^(-)_1 (M=%d)" % M, hatZ_op(1, M, '-')))
    mats.append(("H_1^(-) (M=%d)" % M, H1_op(M, '-')))
    mats.append(("H_2 (M=%d)" % M, H2_op(M)))

best_ratio = 0.0
best = None
count = 0
for nm, A in mats:
    A = np.asarray(A, dtype=complex)
    n = A.shape[1]
    vecs = [("乱数 #%d" % k, rand_vec(n, 11000+k*7+n, 1.5)) for k in range(4)]
    vecs.append(("零ベクトル", np.zeros(n, dtype=complex)))
    for j in range(min(int(n), 3)):
        e = np.zeros(n, dtype=complex); e[j] = 1.0
        vecs.append(("基底 e_%d" % (j+1), e))
    for vn, w in vecs:
        count += 1
        lhs = vec_norm(A @ w)
        W = W_of(w, n)
        rep.close(fro(A @ W), lhs, f"||AW|| = ||Aw||: {nm} / {vn}")
        rep.close(fro(W), vec_norm(w), f"||W|| = ||w||: {nm} / {vn}")
        # W 経由の評価（劣乗法性の適用先）が直接経路の右辺と一致すること
        rep.close(fro(A)*fro(W), fro(A)*vec_norm(w), f"||A||||W|| = ||A||||w||: {nm} / {vn}")
        rhs = fro(A)*vec_norm(w)
        if rhs > 0:
            r = lhs/rhs
            if r > best_ratio:
                best_ratio = r
                best = (nm, vn)

print("検査した (A,w) の組: %d" % count)
print("比 ||Aw||/(||A|| ||w||) の最大値: %.15f  （%s / %s）" % (best_ratio, best[0], best[1]))
rep.truth(le_ok(best_ratio, 1.0), "比の最大値が 1 を超えない")

rep.finish()
