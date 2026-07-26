# <def_partition_function_2d_ising>: 定義の健全性と独立な近似との整合
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import itertools
load(os.path.join(_dir, "_prelude.sage"))
rep = CheckReport("def_partition_function_2d_ising")
for (M,N) in [(2,2),(3,2),(2,3),(3,3)]:
    for (J,Jp) in [(0.4,0.9),(0.9,0.4)]:
        Zv = Z_bruteforce(J,Jp,M,N)
        rep.truth(np.isreal(Zv) and Zv > 0, f"M={M} N={N}: Z は正の実数 (Z={Zv:.6e})")
    rep.close(Z_bruteforce(0.0,0.0,M,N), float(2**(M*N)), f"M={M} N={N}: J=Jp=0 で Z = 2^(MN)")
    # 高温展開の先頭項との比較は、周期境界（N=2 では同じ対を 2 回数える等）で
    # 補正項が大きく、有意な検証にならないので採らない。代わりに下の独立経路を使う。
# 独立経路 1: N=1 では行内結合が s(i,1)^2 = 1 で定数になるので
#   Z = e^{Jp*M} * (周期 M の 1 次元 Ising の分配関数 tr(T^M))
for M in [2,3,4,5]:
    J, Jp = 0.6, 0.3
    exact = Z_bruteforce(J,Jp,M,1)
    T = np.array([[np.exp(J), np.exp(-J)],[np.exp(-J), np.exp(J)]])
    ising1d = np.trace(np.linalg.matrix_power(T, M))
    rep.close(exact, np.exp(Jp*M) * ising1d, f"M={M} N=1: 1 次元 Ising の厳密解と一致")
# 独立経路 2: 行と列を入れ替えると Z(J,Jp) の M,N と J,Jp が同時に入れ替わる
for (M,N) in [(2,3),(3,2),(2,4),(4,2),(3,4)]:
    if M*N > 12: continue
    for (J,Jp) in [(0.4,0.9),(0.25,1.3)]:
        rep.close(Z_bruteforce(J,Jp,M,N), Z_bruteforce(Jp,J,N,M),
                  f"M={M} N={N}: Z(J,Jp;M,N) = Z(Jp,J;N,M)（転置対称性）")

# 独立経路 3: M=1 では行間結合が s(1,j)s(1,j)=1 になるので
#   Z = e^{J*N} * (周期 N の 1 次元 Ising の分配関数)
for N in [2,3,4,5]:
    J, Jp = 0.7, 0.35
    T = np.array([[np.exp(Jp), np.exp(-Jp)],[np.exp(-Jp), np.exp(Jp)]])
    rep.close(Z_bruteforce(J,Jp,1,N), np.exp(J*N)*np.trace(np.linalg.matrix_power(T,N)),
              f"M=1 N={N}: 1 次元 Ising の厳密解と一致")

rep.finish()
