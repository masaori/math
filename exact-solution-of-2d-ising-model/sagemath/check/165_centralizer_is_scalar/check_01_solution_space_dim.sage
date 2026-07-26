# ---------------------------------------------------------
# <centralizer_is_scalar>
#   （002_linear_space_general.mjs / linear_space_general_004_lemma_centralizer_is_scalar）
#
# 主張: W in Mat(2,C)^{(x)M} がすべての x と可換なら W = c I。
#
# 独立経路: ランダムな W を試すのではなく（それでは「可換な W が見つからない」ことしか
#   言えない）、**連立一次方程式の解空間そのもの**を調べる。
#   W を 4^M 個の未知数（成分）とみなすと、条件 [W, E_k] = 0 は W について線型である。
#   vec(WE) = (E^T (x) I) vec(W)、vec(EW) = (I (x) E) vec(W) を使って
#       L_k := E_k^T (x) I - I (x) E_k
#   を縦に積んだ行列 L を作れば、条件は L vec(W) = 0。
#   その**零空間の次元がちょうど 1** であり、かつ零空間が単位元 I で張られることを
#   特異値分解で確かめる。これが「全元と可換な W はスカラーに限り、しかもスカラーは
#   実際に可換」という主張の全内容である。
#
# E_k の取り方:
#   - M = 1,2,3 では Mat(2,C)^{(x)M} の**基底全体**（行列単位 E_{I,J}、4^M 個）を使う。
#   - M = 4,5 では基底全体だと L が巨大になるので、生成系
#     {sigma^x_k, sigma^y_k, sigma^z_k : k = 1..M} を使う。生成系と可換なら
#     その生成する多元環（= <Z_Y_generate_algebra> より全体）の全元と可換なので、
#     こちらのほうが条件としては弱い（= 解空間は基底全体を使った場合以上に大きい）。
#     それでも次元 1 なら主張はより強い形で確認できる。
#
# 判定: 特異値のうち sigma_max * 1e-10 以下のものを 0 とみなす。実測では 0 とみなす
#   特異値と最小の非零特異値の間に 15 桁以上の開きがある（ログ参照）。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

import numpy as np

rep = CheckReport("<centralizer_is_scalar>: 全元と可換な元の解空間の次元")

NULL_TOL = 1e-10


def matrix_units(M):
    """行列単位 E_{I,J} = E_{i_1j_1} (x) ... (x) E_{i_Mj_M} をすべて作る。"""
    e = []
    for i in range(2):
        for j in range(2):
            m = np.zeros((2, 2), dtype=complex)
            m[i, j] = 1.0
            e.append(m)
    out = [np.array([[1.0 + 0.0j]])]
    for _ in range(M):
        out = [np.kron(a, b) for a in out for b in e]
    return out


def site_generators(M):
    return [site_op(a, k, M) for k in range(1, M + 1) for a in ['x', 'y', 'z']]


def commutant_nullspace(gens, dim):
    """{W : [W, g] = 0 for all g in gens} の零空間の基底と特異値情報を返す。"""
    n = dim * dim
    Id = np.eye(dim, dtype=complex)
    blocks = []
    for g in gens:
        blocks.append(np.kron(g.T, Id) - np.kron(Id, g))
    L = np.vstack(blocks)
    u, sv, vh = np.linalg.svd(L, full_matrices=True)
    thr = float(sv[0]) * NULL_TOL
    r = int(np.sum(sv > thr))
    nullity = n - r
    smin_nonzero = float(sv[r - 1]) / float(sv[0]) if r > 0 else float('nan')
    return vh[r:, :].conj(), nullity, smin_nonzero


for M in [1, 2, 3]:
    dim = 2 ** M
    gens = matrix_units(M)
    ns, nullity, gap = commutant_nullspace(gens, dim)
    print("  M=%d（基底 %d 個を使用）: 解空間の次元 = %d, 最小非零特異値/最大 = %.3e"
          % (M, len(gens), nullity, gap))
    rep.truth(nullity == 1, "M=%d: 解空間の次元がちょうど 1（実測 %d）" % (M, nullity))
    rep.truth(gap > 1e-8, "M=%d: 零/非零の判別余裕（%.3e）" % (M, gap))
    if nullity == 1:
        W = ns[0].reshape(dim, dim)
        c = complex(W[0, 0])
        rep.truth(abs(c) > 1e-6, "M=%d: 解空間の生成元の (1,1) 成分が 0 でない" % M)
        rep.close(W / c, np.eye(dim, dtype=complex),
                  "M=%d: 解空間は I で張られる（W = c I）" % M)

for M in [4, 5]:
    dim = 2 ** M
    gens = site_generators(M)
    ns, nullity, gap = commutant_nullspace(gens, dim)
    print("  M=%d（生成系 %d 個を使用）: 解空間の次元 = %d, 最小非零特異値/最大 = %.3e"
          % (M, len(gens), nullity, gap))
    rep.truth(nullity == 1, "M=%d: 解空間の次元がちょうど 1（実測 %d）" % (M, nullity))
    rep.truth(gap > 1e-8, "M=%d: 零/非零の判別余裕（%.3e）" % (M, gap))
    if nullity == 1:
        W = ns[0].reshape(dim, dim)
        c = complex(W[0, 0])
        rep.close(W / c, np.eye(dim, dtype=complex),
                  "M=%d: 解空間は I で張られる（W = c I）" % M)

# --- 対照: 生成系を Z, Y に取り替えても解空間は 1 次元（<Z_Y_generate_algebra> と整合）---
for M in [2, 3, 4]:
    dim = 2 ** M
    gens = [Zop(m, M) for m in range(1, M + 1)] + [Yop(m, M) for m in range(1, M + 1)]
    ns, nullity, gap = commutant_nullspace(gens, dim)
    print("  [対照] M=%d（Z, Y のみ %d 個）: 解空間の次元 = %d" % (M, len(gens), nullity))
    rep.truth(nullity == 1,
              "[対照] M=%d: Z, Y と可換な元もスカラーに限る（次元 %d）" % (M, nullity))

# --- 反例探し: 条件を弱めると解空間が広がることを確認する ---
# sigma^z_k とだけ可換な元は「対角行列全体」で、次元は 2^M（1 より真に大きい）。
for M in [2, 3, 4]:
    dim = 2 ** M
    gens = [sz(k, M) for k in range(1, M + 1)]
    ns, nullity, gap = commutant_nullspace(gens, dim)
    print("  [対照] M=%d（sigma^z_k のみ）: 解空間の次元 = %d（期待 2^M = %d）"
          % (M, nullity, dim))
    rep.truth(nullity == dim,
              "[対照] M=%d: sigma^z_k とだけ可換な元は対角行列全体（次元 %d）" % (M, nullity))
    rep.truth(nullity > 1,
              "[対照] M=%d: 条件を弱めると解空間が 1 次元より広くなる" % M)

rep.finish()
