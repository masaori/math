# 250-01: Z の定義（def_partition_function_2d_ising）を、1 次元に退化した場合の
#         独立な閉じた表示と突き合わせる。
#
# N = 1 のとき、周期規約 s(i,N+1) = s(i,1) より s(i,1)s(i,2) = s(i,1)^2 = 1 なので
# 第 2 項は定数 J'·M·N に退化し、第 1 項は結合定数 J の 1 次元 Ising 環（M サイト）になる。
# 1 次元 Ising 環の分配関数は転送行列 ((e^J, e^{-J}), (e^{-J}, e^J)) の固有値
# 2cosh J, 2sinh J から
#     Z_1D(M, J) = (2\cosh J)^M + (2\sinh J)^M
# である。これは 2 次元転送行列の議論とは独立な（2×2 の固有値だけを使う）表示なので、
# ブルートフォース和との突き合わせは同語反復にならない。
# M = 1 の場合も対称に確認する。
#
# ついでに Z の値域が R_{>0} であること（本文が Z : R_{>0}×R_{>0} → R_{>0} と宣言している）も見る。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '../252_partition_function_via_transfer_matrix/_prelude.sage'))

import numpy as np

rep = CheckReport("def_partition_function_2d_ising: 1 次元退化の閉じた表示との一致・値域")


def Z_1d_closed(n, K):
    return (2 * np.cosh(K)) ** n + (2 * np.sinh(K)) ** n


for (J, Jp) in JJ_PAIRS:
    for M in [2, 3, 4, 5, 6]:
        # N = 1: J' 方向は定数、J 方向が 1 次元 Ising 環
        lhs = brute_force_Z(M, 1, J, Jp)
        rhs = float(np.exp(Jp * M * 1) * Z_1d_closed(M, J))
        rep.close(lhs, rhs, "N=1 M=%d J=%.4g J'=%.4g" % (M, J, Jp))
        rep.truth(lhs > 0, "N=1 M=%d: Z > 0" % M)
    for N in [2, 3, 4, 5, 6]:
        # M = 1: J 方向は定数、J' 方向が 1 次元 Ising 環
        lhs = brute_force_Z(1, N, J, Jp)
        rhs = float(np.exp(J * 1 * N) * Z_1d_closed(N, Jp))
        rep.close(lhs, rhs, "M=1 N=%d J=%.4g J'=%.4g" % (N, J, Jp))
        rep.truth(lhs > 0, "M=1 N=%d: Z > 0" % N)
    print("  J=%.4g J'=%.4g : N=1 と M=1 の全 M,N∈{2,…,6} で閉じた表示と一致" % (J, Jp))

# 2 次元の場合も、各被加数が R_{>0} の元であること・和が 2^{MN} 項であることを確認する
import itertools
for (M, N) in [(2, 2), (2, 3), (3, 3)]:
    cnt = 0
    mn = float('inf')
    for flat in itertools.product((-1, 1), repeat=M * N):
        s = [[flat[i * N + j] for j in range(N)] for i in range(M)]
        v = float(np.exp(energy_of_config(s, M, N, 0.3, 0.7)))
        mn = min(mn, v)
        cnt += 1
    rep.truth(cnt == 2 ** (M * N), "M=%d N=%d: 被加数の個数 = 2^{MN} = %d" % (M, N, 2 ** (M * N)))
    rep.truth(mn > 0, "M=%d N=%d: すべての被加数が R_{>0} の元" % (M, N))
    print("  M=%d N=%d : 被加数 %d 項、最小値 %.6e > 0" % (M, N, cnt, mn))

rep.finish()
