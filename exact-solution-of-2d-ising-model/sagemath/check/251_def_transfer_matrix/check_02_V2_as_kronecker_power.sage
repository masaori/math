# <def_transfer_matrix>: V_2 を「2×2 転送行列のクロネッカー積」として独立に構成して突き合わせる
#
# check_01_transfer_matrix_sanity.sage は V_1, V_2 の全成分を定義式 (V_2)_{μ,μ'} = exp(Σ_j J μ(j)μ'(j))
# からそのまま再計算して照合している。ここではそれとは別経路として、
#   t := ((e^J, e^{-J}), (e^{-J}, e^J))   （1 サイト分の 2×2 転送行列）
# の N 重クロネッカー積 t^{⊠N} が V_2 に一致することを見る。
# 添字の対応は「μ(j) = -1 → ビット 0, μ(j) = +1 → ビット 1、j が上位から下位へ」であり、
# これは _prelude.sage の transfer_matrices が既定で使う itertools.product([-1,1], repeat=N) の順に一致する。
# 定義式の和 Σ_j が積 Π_j へ分解すること（サイトごとに独立であること）を、
# 成分ごとの再計算ではなくクロネッカー積という構成レベルで確かめる経路になっている。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import itertools
load(os.path.join(_dir, "_prelude.sage"))

rep = CheckReport("def_transfer_matrix: V_2 = t^(⊠N)（2×2 転送行列のクロネッカー積）")

for N in [1, 2, 3, 4, 5]:
    for (J, Jp) in [(0.4, 0.9), (0.9, 0.4), (0.25, 1.3), (0.4406868, 0.4406868)]:
        V1, V2 = transfer_matrices(J, Jp, N)

        t = np.array([[np.exp(J), np.exp(-J)], [np.exp(-J), np.exp(J)]], dtype=float)
        V2kron = np.array([[1.0]])
        for _ in range(N):
            V2kron = np.kron(V2kron, t)
        rep.close(V2, V2kron, f"N={N} J={J}: V_2 = t^(⊠N)")

        # V_1 は同じ形には分解しない（行内結合が隣接サイトを結ぶため）。
        # 対角成分だけを 1 次元 Ising 環のエネルギーから直接組み上げて照合する。
        mus = list(itertools.product([-1, 1], repeat=N))
        rep.truth(len(mus) == 2 ** N, f"N={N}: |M| = 2^N = {2 ** N}")
        diag_direct = np.array([
            float(np.exp(sum(Jp * mu[j] * mu[(j + 1) % N] for j in range(N))))
            for mu in mus
        ])
        rep.close(np.diag(V1), diag_direct, f"N={N} Jp={Jp}: V_1 の対角成分（1 次元 Ising 環のエネルギー）")
    print("  N=%d : |M|=%d, V_2 = t^(⊠N) を全パラメータで確認" % (N, 2 ** N))

rep.finish()
