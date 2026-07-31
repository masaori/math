# <def_matrix_norm>: ノルムの値を独立な 4 経路で突き合わせる
#
#   (a) 定義そのまま: sqrt(Σ_{i,j} |a_ij|^2) を素の二重ループで
#   (b) numpy.linalg.norm（既定の Frobenius ノルム）
#   (c) sqrt(tr(A^* A))   … Frobenius 内積側の経路
#   (d) sqrt(Σ σ_k^2)     … 特異値分解（(a)-(c) とは全く別のアルゴリズム）
#
# 同語反復を避けるため、(a) 以外は「定義式を書き写したもの」ではない経路を選んである。
# ベクトルのノルムについても (a) 定義 vs (b) numpy を突き合わせる。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("def_matrix_norm: ノルムの値を 4 経路で突き合わせる")

def fro(A):
    return float(np.linalg.norm(np.asarray(A, dtype=complex)))
def fro_naive(A):
    # 定義そのまま（素の二重ループ）。ベクトルにも使える。
    A = np.asarray(A, dtype=complex)
    s = 0.0
    if A.ndim == 1:
        for i in range(A.shape[0]):
            s += float(abs(A[i])**2)
    else:
        for i in range(A.shape[0]):
            for j in range(A.shape[1]):
                s += float(abs(A[i,j])**2)
    return float(np.sqrt(s))
def fro_trace(A):
    A = np.asarray(A, dtype=complex)
    return float(np.sqrt(abs(np.trace(A.conj().T @ A))))
def fro_svd(A):
    A = np.asarray(A, dtype=complex)
    s = np.linalg.svd(A, compute_uv=False)
    return float(np.sqrt(float(np.sum(s**2))))
def rand_mat(n, seed, scale=1.0):
    g = np.random.default_rng(int(seed))
    return float(scale)*(g.standard_normal((int(n),int(n))) + 1j*g.standard_normal((int(n),int(n))))
def rand_vec(n, seed, scale=1.0):
    g = np.random.default_rng(int(seed))
    return float(scale)*(g.standard_normal(int(n)) + 1j*g.standard_normal(int(n)))

# 試験行列: 乱数 + 退化した（一番危ない）行列 + Ising 側の実際の作用素
mats = [("乱数 5x5 #%d" % k, rand_mat(5, 1000+k, 2.0)) for k in range(8)]
mats += [
    ("零行列 4x4", np.zeros((4,4), dtype=complex)),
    ("単位行列 4x4", np.eye(4, dtype=complex)),
    ("冪零 Jordan 4x4", np.diag(np.ones(3, dtype=complex), 1)),
    ("ランク 1 4x4", np.outer(np.array([1.0,2.0,-1.0,0.5], dtype=complex),
                              np.array([0.3,-1.0,2.0,1.0j], dtype=complex).conj())),
    ("非対角化可能 2x2", np.array([[1.0,1.0],[0.0,1.0]], dtype=complex)),
]
for M in [2,3]:
    mats.append(("hatZ^(-)_1 (M=%d)" % M, hatZ_op(1, M, '-')))
    mats.append(("hatY_1 (M=%d)" % M, hatY_op(1, M)))
    mats.append(("H_1^(-) (M=%d)" % M, H1_op(M, '-')))
    mats.append(("H_2 (M=%d)" % M, H2_op(M)))
    for p in OP_TEST_PARAMS:
        mats.append(("V_1 [M=%d,K1=%g]" % (M, p['K1']), V1_op(float(p['K1']), M)))
print("試験行列: %d 個（乱数 + 退化行列 + Ising 作用素）" % len(mats))

for name, A in mats:
    a = fro_naive(A)
    rep.close(a, fro(A), f"||A|| 定義 vs numpy: {name}")
    rep.close(a, fro_trace(A), f"||A|| 定義 vs sqrt(tr(A^*A)): {name}")
    rep.close(a, fro_svd(A), f"||A|| 定義 vs 特異値: {name}")

# ベクトルのノルム（K^d 側の定義）
for k in range(6):
    w = rand_vec(5, 2000+k, 1.5)
    rep.close(float(np.sqrt(float(np.sum(np.abs(w)**2)))), fro_naive(w), f"||w|| numpy vs 定義 #{k}")

# スケールが極端な場合（丸めが効く場所）でも定義と一致するか
for e in [-8,-4,0,4,8]:
    A = rand_mat(4, 3001+e, 10.0**e)
    rep.close(fro_naive(A), fro(A), f"||A|| 定義 vs numpy（scale=1e{e}）")

rep.finish()
