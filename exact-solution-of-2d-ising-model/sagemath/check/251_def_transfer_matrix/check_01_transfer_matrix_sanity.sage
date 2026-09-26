# <def_transfer_matrix>: V_1 は対角、V_2 は対称、成分は正、サイズは 2^{M_col} x 2^{M_col}、全成分の値
# 行列は _prelude.sage が「番号 k → μ = ord^{-1}(k)」の向きで作る。ここでは逆向き
# 「μ → 番号 ord(μ)」（<def_row_configuration_numbering> の式そのもの）で成分を引いて照合する。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
load(os.path.join(_dir, "_prelude.sage"))
rep = CheckReport("def_transfer_matrix")
for M_col in [2,3,4]:
    for (K1,K2) in [(0.9,0.4),(0.4,0.9),(1.3,0.25)]:
        V1,V2 = transfer_matrices(K1,K2,M_col)
        n = 2**M_col
        rep.truth(V1.shape == (n,n) and V2.shape == (n,n), f"M_col={M_col}: サイズ 2^M_col x 2^M_col")
        rep.close(V1, np.diag(np.diag(V1)), f"M_col={M_col}: V_1 は対角行列（delta_(mu=mu')）")
        rep.close(V2, V2.T, f"M_col={M_col}: V_2 は対称")
        rep.truth(np.all(np.real(np.diag(V1)) > 0) and np.all(np.real(V2) > 0), f"M_col={M_col}: 成分は正")
        rep.truth(abs(np.imag(V1)).max() < 1e-15 and abs(np.imag(V2)).max() < 1e-15, f"M_col={M_col}: 実行列")
        for mu in row_configurations(M_col):
            a = int(ord_number(mu)) - 1
            m_ = [int(v) for v in mu]
            rep.close(V1[a,a], np.exp(sum(K1*m_[j]*m_[(j+1)%M_col] for j in range(M_col))), f"M_col={M_col} ord={a+1}: V_1 の成分")
            for mup in row_configurations(M_col):
                b = int(ord_number(mup)) - 1
                mp_ = [int(v) for v in mup]
                rep.close(V2[a,b], np.exp(sum(K2*m_[j]*mp_[j] for j in range(M_col))), f"M_col={M_col} ({a+1},{b+1}): V_2 の成分")
rep.finish()
