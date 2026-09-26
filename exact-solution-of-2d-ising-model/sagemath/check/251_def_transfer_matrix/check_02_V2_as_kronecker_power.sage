# <def_transfer_matrix>: V_2 を「2×2 転送行列のクロネッカー積」として独立に構成して突き合わせる
#
# check_01_transfer_matrix_sanity.sage は V_1, V_2 の全成分を定義式 (V_2)_{ord(μ),ord(μ')} = exp(K_2 Σ_m μ(m)μ'(m))
# からそのまま再計算して照合している。ここではそれとは別経路として、
#   t := ((e^{K_2}, e^{-K_2}), (e^{-K_2}, e^{K_2}))   （1 サイト分の 2×2 転送行列）
# の M_col 重クロネッカー積 t^{⊠M_col}（numpy.kron。先頭因子が最上位）が V_2 に一致することを見る。
# 添字の対応は ord のとおり「μ(m) = +1 → 桁 0、μ(m) = -1 → 桁 1、m が上位から下位へ」。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
load(os.path.join(_dir, "_prelude.sage"))

rep = CheckReport("def_transfer_matrix: V_2 = t^(⊠M_col)（2×2 転送行列のクロネッカー積）")

for M_col in [1, 2, 3, 4, 5]:
    for (K1, K2) in [(0.9, 0.4), (0.4, 0.9), (1.3, 0.25), (0.4406868, 0.4406868)]:
        V1, V2 = transfer_matrices(K1, K2, M_col)

        t = np.array([[np.exp(K2), np.exp(-K2)], [np.exp(-K2), np.exp(K2)]], dtype=float)
        V2kron = np.array([[1.0]])
        for _ in range(M_col):
            V2kron = np.kron(V2kron, t)
        rep.close(V2, V2kron, f"M_col={M_col} K_2={K2}: V_2 = t^(⊠M_col)")

        # V_1 は同じ形には分解しない（行内結合が隣接サイトを結ぶため）。
        # 対角成分だけを 1 次元 Ising 環のエネルギーから ord の順に直接組み上げて照合する。
        mus = sorted(row_configurations(M_col), key=ord_number)
        rep.truth(len(mus) == 2 ** M_col, f"M_col={M_col}: |𝔐| = 2^M_col = {2 ** M_col}")
        diag_direct = np.array([
            float(np.exp(sum(K1 * int(mu[j]) * int(mu[(j + 1) % M_col]) for j in range(M_col))))
            for mu in mus
        ])
        rep.close(np.diag(V1), diag_direct, f"M_col={M_col} K_1={K1}: V_1 の対角成分（1 次元 Ising 環のエネルギー）")
    print("  M_col=%d : |𝔐|=%d, V_2 = t^(⊠M_col) を全パラメータで確認" % (M_col, 2 ** M_col))

rep.finish()
