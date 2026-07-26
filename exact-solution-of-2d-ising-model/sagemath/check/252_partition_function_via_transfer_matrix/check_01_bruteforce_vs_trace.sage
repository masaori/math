# <partition_function_via_transfer_matrix>: Z(J,Jp) = tr((V_1 V_2)^M)
# 左辺は全 2^{MN} 配位のブルートフォース、右辺は 2^N x 2^N の転送行列。完全に独立な 2 経路。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import itertools
load(os.path.join(_dir, "_prelude.sage"))
rep = CheckReport("partition_function_via_transfer_matrix", tol=1e-10)
cases = [(2,2),(3,2),(2,3),(4,2),(2,4),(3,3),(4,3),(3,4)]
for (M,N) in cases:
    if M*N > 12:
        continue
    for (J,Jp) in [(0.4,0.9),(0.9,0.4),(0.25,1.3),(0.7,0.7)]:
        lhs = Z_bruteforce(J,Jp,M,N)
        V1,V2 = transfer_matrices(J,Jp,N)
        rhs = np.trace(np.linalg.matrix_power(V1 @ V2, M))
        rep.close(lhs, rhs, f"M={M} N={N} J={J} Jp={Jp}")
        if M != N and abs(J-Jp) > 1e-9:
            W1,W2 = transfer_matrices(Jp,J,N)
            wrong = np.trace(np.linalg.matrix_power(W1 @ W2, M))
            rep.truth(abs(wrong - lhs) > 1e-6*abs(lhs),
                      f"M={M} N={N}: J と Jp を入れ替えると一致しない（割り当てが本質的）")
        rng = np.random.default_rng(int(M*100+N))
        perm = [int(k) for k in rng.permutation(int(2**N))]
        U1,U2 = transfer_matrices(J,Jp,N, order=perm)
        rep.close(np.trace(np.linalg.matrix_power(U1 @ U2, M)), rhs,
                  f"M={M} N={N}: 行・列番号と mu の同一視の取り方に依らない")
rep.finish()
