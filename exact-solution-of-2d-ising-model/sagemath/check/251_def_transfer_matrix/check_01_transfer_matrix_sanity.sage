# <def_transfer_matrix>: V_1 は対角、V_2 は対称、成分は正、サイズは 2^N x 2^N
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import itertools
load(os.path.join(_dir, "_prelude.sage"))
rep = CheckReport("def_transfer_matrix")
for N in [2,3,4]:
    for (J,Jp) in [(0.4,0.9),(0.9,0.4),(0.25,1.3)]:
        V1,V2 = transfer_matrices(J,Jp,N)
        n = 2**N
        rep.truth(V1.shape == (n,n) and V2.shape == (n,n), f"N={N}: サイズ 2^N x 2^N")
        rep.close(V1, np.diag(np.diag(V1)), f"N={N}: V_1 は対角行列（delta_(mu=mu')）")
        rep.close(V2, V2.T, f"N={N}: V_2 は対称")
        rep.truth(np.all(np.real(np.diag(V1)) > 0) and np.all(np.real(V2) > 0), f"N={N}: 成分は正")
        rep.truth(abs(np.imag(V1)).max() < 1e-15 and abs(np.imag(V2)).max() < 1e-15, f"N={N}: 実行列")
        mus = list(itertools.product([-1,1], repeat=N))
        for a,mu in enumerate(mus):
            rep.close(V1[a,a], np.exp(sum(Jp*mu[j]*mu[(j+1)%N] for j in range(N))), f"N={N} a={a}: V_1 の成分")
            for b,mup in enumerate(mus):
                rep.close(V2[a,b], np.exp(sum(J*mu[j]*mup[j] for j in range(N))), f"N={N} ({a},{b}): V_2 の成分")
rep.finish()
