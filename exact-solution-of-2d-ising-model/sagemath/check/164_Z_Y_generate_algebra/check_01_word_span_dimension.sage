# ---------------------------------------------------------
# <Z_Y_generate_algebra>
#   （004_transfer_matrix.mjs / transfer_matrix_015_claim_Z_Y_generate_algebra）
#
# 主張: S = {Z_1,...,Z_M, Y_1,...,Y_M} を含む最小の単位的 C-部分多元環 A は
#       Mat(2,C)^{(x)M} 全体に一致する（したがって dim_C A = 4^M）。
#
# 独立経路: S の元の**語（word）**を長さ順に生成し、それらが張る C-線型部分空間の次元を
#   特異値によるランク計算で数える。すなわち
#       A_0 = span{I}
#       A_{L+1} = span( A_L  ∪  { a g : a in A_L の基底, g in S } )
#   と有限回で単調増加する部分空間の列を作り、その次元が 4^M に達することを見る。
#   本文の証明は「sigma^x_k, sigma^y_k, sigma^z_k を S から具体的に書き下し、
#   行列単位の基底を作る」という構成的な議論であり、こちらは語を機械的に総当たりして
#   次元だけを数える独立な経路である。
#
# 補足: A_L は単調増加で 4^M で頭打ちになるので、次元が増えなくなった時点で
#   A = A_L（積で閉じている）が確定する。これも数値で確認する
#   （A_L の基底どうしの積がすべて A_L に入ることを、ランクが増えないことで判定）。
#
# 判定に使う許容誤差: ランク判定のしきい値は sigma_max * 1e-10。
#   語の行列は成分の絶対値が 1 か 0 の unitary（Pauli 文字列の積）なので条件数はよく、
#   実測でも 0 でない特異値と 0 の特異値の間には 15 桁以上の開きがある。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))

import numpy as np

rep = CheckReport("<Z_Y_generate_algebra>: Z, Y が生成する部分多元環の次元")

RANK_TOL = 1e-10


def span_basis(mats, dim):
    """行列の集まりが張る空間の直交基底（行ベクトルの形）と次元を返す。"""
    A = np.array([m.reshape(-1) for m in mats], dtype=complex)
    u, sv, vh = np.linalg.svd(A, full_matrices=False)
    if sv.size == 0:
        return np.zeros((0, dim * dim), dtype=complex), 0, 0.0
    thr = float(sv[0]) * RANK_TOL
    r = int(np.sum(sv > thr))
    gap = float(sv[r - 1]) / float(sv[0]) if r > 0 else 0.0
    return vh[:r, :], r, gap


for M in [1, 2, 3]:
    dim = 2 ** M
    S = [Zop(m, M) for m in range(1, M + 1)] + [Yop(m, M) for m in range(1, M + 1)]
    basis, d, gap = span_basis([eye_M(M)], dim)
    dims = [d]
    L = 0
    while True:
        L += 1
        cand = [b.reshape(dim, dim) for b in basis]
        for b in list(cand):
            for g in S:
                cand.append(b @ g)
        basis, d_new, gap = span_basis(cand, dim)
        dims.append(d_new)
        if d_new == dims[-2]:
            break
        if L > 4 * M + 4:
            break
    print("  M=%d: 語の長さごとの次元 %s（目標 4^M = %d）, 最小非零特異値/最大 = %.3e"
          % (M, dims, 4 ** M, gap))
    rep.truth(dims[-1] == 4 ** M,
              "M=%d: 生成される部分多元環の次元 = 4^M = %d（実測 %d）"
              % (M, 4 ** M, dims[-1]))
    rep.truth(dims[-1] == dims[-2],
              "M=%d: 語の長さを 1 増やしても次元が増えない（積で閉じている）" % M)
    rep.truth(gap > 1e-8,
              "M=%d: ランク判定の余裕（最小非零特異値の比 %.3e）" % (M, gap))
    # 単調増加であること
    rep.truth(all(dims[k] <= dims[k + 1] for k in range(len(dims) - 1)),
              "M=%d: 次元列が単調増加" % M)

# --- 反例探し: 生成元を減らすと 4^M に届かないこと ---
# Z だけ（Y を落とす）では、Z_m どうしは反交換するだけなので生成される代数は真に小さい。
for M in [2, 3]:
    dim = 2 ** M
    S = [Zop(m, M) for m in range(1, M + 1)]
    basis, d, _ = span_basis([eye_M(M)], dim)
    dims = [d]
    for L in range(1, 4 * M + 4):
        cand = [b.reshape(dim, dim) for b in basis]
        for b in list(cand):
            for g in S:
                cand.append(b @ g)
        basis, d_new, _ = span_basis(cand, dim)
        dims.append(d_new)
        if d_new == dims[-2]:
            break
    print("  [対照] M=%d: Z のみ -> 次元 %s（4^M = %d）" % (M, dims, 4 ** M))
    rep.truth(dims[-1] < 4 ** M,
              "[対照] M=%d: Z だけでは全体を生成しない（次元 %d < %d）"
              % (M, dims[-1], 4 ** M))

rep.finish()
