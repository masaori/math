# 分配関数と転送行列の共通コード（<def_partition_function_2d_ising>, <def_transfer_matrix>）
import numpy as np
import itertools

def Z_bruteforce(J, Jp, M, N):
    """定義そのまま。全 2^{MN} 配位を足す。周期境界 s(M+1,j)=s(1,j), s(i,N+1)=s(i,1)。
       J は第1引数方向（周期 M、行間）、Jp は第2引数方向（周期 N、行内）の結合定数。"""
    total = 0.0
    for bits in itertools.product([-1, 1], repeat=M*N):
        s = [[bits[i*N + j] for j in range(N)] for i in range(M)]
        e = 0.0
        for i in range(M):
            for j in range(N):
                e += J  * s[i][j] * s[(i+1) % M][j]
                e += Jp * s[i][j] * s[i][(j+1) % N]
        total += np.exp(e)
    return total

def transfer_matrices(J, Jp, N, order=None):
    """V_1 は行内（第2引数方向）で Jp、V_2 は行間（第1引数方向）で J を持つ。
       order は mu の並べ方（行・列番号との同一視）。None なら itertools の既定順。"""
    mus = list(itertools.product([-1, 1], repeat=N))
    if order is not None:
        mus = [mus[k] for k in order]
    n = len(mus)
    V1 = np.zeros((n, n), dtype=complex)
    V2 = np.zeros((n, n), dtype=complex)
    for a, mu in enumerate(mus):
        V1[a, a] = np.exp(sum(Jp * mu[j] * mu[(j+1) % N] for j in range(N)))
        for b, mup in enumerate(mus):
            V2[a, b] = np.exp(sum(J * mu[j] * mup[j] for j in range(N)))
    return V1, V2
