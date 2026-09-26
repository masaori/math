# 分配関数と転送行列の共通コード（<def_partition_function_2d_ising>, <def_transfer_matrix>）
#
# 記号は本文に合わせる:
#   N_row : 行数（s(i,j) の第 1 引数 i の周期）      M_col : 列数（第 2 引数 j の周期）
#   K_1   : 同じ行の隣り合うサイト s(i,j) s(i,j+1) の結合定数
#   K_2   : 隣り合う行の同じ列のサイト s(i,j) s(i+1,j) の結合定数
#   V_1, V_2 の行・列番号は <def_row_configuration_numbering> の ord（1 始まり）で指す。
import numpy as np
import itertools
load(os.path.join(_dir, "../../_shared/row_configurations.sage"))


def Z_bruteforce(K1, K2, N_row, M_col):
    """<def_partition_function_2d_ising> をそのまま計算する。全 2^{N_row M_col} 配位の和。
       周期境界 s(N_row+1,j) = s(1,j), s(i,M_col+1) = s(i,1)。"""
    total = 0.0
    for bits in itertools.product([-1, 1], repeat=N_row * M_col):
        s = [[bits[i * M_col + j] for j in range(M_col)] for i in range(N_row)]
        e = 0.0
        for i in range(N_row):
            for j in range(M_col):
                e += K1 * s[i][j] * s[i][(j + 1) % M_col]
                e += K2 * s[i][j] * s[(i + 1) % N_row][j]
        total += np.exp(e)
    return total


def transfer_matrices(K1, K2, M_col):
    """<def_transfer_matrix> の V_1, V_2 を numpy 配列で返す。
       行・列番号 k（1 始まり）の μ は ord の逆（2 進展開）で復元し、配列の添字 k-1 に書く。"""
    n = 2 ** M_col
    V1 = np.zeros((n, n), dtype=complex)
    V2 = np.zeros((n, n), dtype=complex)
    for k in range(1, n + 1):
        mu = [int(v) for v in ord_inverse(k, M_col)]
        V1[k - 1, k - 1] = np.exp(sum(K1 * mu[m] * mu[(m + 1) % M_col] for m in range(M_col)))
        for l in range(1, n + 1):
            mup = [int(v) for v in ord_inverse(l, M_col)]
            V2[k - 1, l - 1] = np.exp(sum(K2 * mu[m] * mup[m] for m in range(M_col)))
    return V1, V2
