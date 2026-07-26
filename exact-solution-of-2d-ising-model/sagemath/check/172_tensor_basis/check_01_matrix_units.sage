# <tensor_basis>: 行列単位のクロネッカー積 E_{I,J} が Mat(2^M,C) の基底、標準基底 f_I が C^{2^M} の基底
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import math
import itertools
rep = CheckReport("tensor_basis")
E = {(i,j): np.array([[1.0 if (a==i and b==j) else 0.0 for b in range(2)] for a in range(2)], dtype=complex)
     for i in range(2) for j in range(2)}
e = [np.array([1,0], dtype=complex), np.array([0,1], dtype=complex)]
for M in [1,2,3,4]:
    n = 2**M
    units = []
    for I_ in itertools.product([0,1], repeat=M):
        for J_ in itertools.product([0,1], repeat=M):
            units.append(kron_list([E[(I_[k],J_[k])] for k in range(M)]).reshape(-1))
    A = np.array(units)
    rep.truth(A.shape[0] == n*n, f"M={M}: E_(I,J) の個数 = 4^M = {n*n}")
    rep.truth(np.linalg.matrix_rank(A, tol=1e-9) == n*n, f"M={M}: E_(I,J) は一次独立（基底）")
    # E_{I,J} はちょうど 1 成分だけ 1 の行列単位になる
    for row in units[:min(len(units), 32)]:
        nz = int(np.sum(np.abs(row) > 1e-12))
        rep.truth(nz == 1, f"M={M}: E_(I,J) は成分が 1 つだけ非零")
    # f_I = e_{i_1} ⊠ ... ⊠ e_{i_M} が C^{2^M} の基底
    vecs = [kron_list([e[I_[k]].reshape(2,1) for k in range(M)]).reshape(-1) for I_ in itertools.product([0,1], repeat=M)]
    B = np.array(vecs)
    rep.truth(B.shape[0] == n, f"M={M}: f_I の個数 = 2^M = {n}")
    rep.close(B, np.eye(n), f"M={M}: f_I は標準基底そのもの")
    # dim = n^m
    rep.truth(np.linalg.matrix_rank(B, tol=1e-9) == n, f"M={M}: dim C^(2^M) = 2^M")
rep.finish()
