# <calc_of_TxT_hatZxhatY>: (T x T)(hatZ^{(-)}, hatY) = (hatZ^{(-)}, hatY) B  の行列表示 B_1, B_2
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("calc_of_TxT_hatZxhatY: 直積作用の 2x2 行列表示")
for M in [2,3,4]:
    rng_mu = list(range(-M,0)) + list(range(1,M+1))
    for p in OP_TEST_PARAMS[:4]:
        K1 = p['K1']; K2 = p['K2']
        for mu in rng_mu:
            th = theta_mu_of(mu, M)
            Zm = hatZ_op(mu,M,'-'); Ym = hatY_op(mu,M)
            B1 = B1_of(th, K1); B2 = B2_of(K2)
            g1 = principal_sqrt_of_V1pm(K1, M, '-')
            g2 = V2_op(K2, M)
            # 列ごとに (hatZ, hatY) B の各成分と突き合わせる
            rep.close(T_conj(g1, Zm), B1[0,0]*Zm + B1[1,0]*Ym, f"M={M} mu={mu}: B_1 の第1列")
            rep.close(T_conj(g1, Ym), B1[0,1]*Zm + B1[1,1]*Ym, f"M={M} mu={mu}: B_1 の第2列")
            rep.close(T_conj(g2, Zm), B2[0,0]*Zm + B2[1,0]*Ym, f"M={M} mu={mu}: B_2 の第1列")
            rep.close(T_conj(g2, Ym), B2[0,1]*Zm + B2[1,1]*Ym, f"M={M} mu={mu}: B_2 の第2列")
            # 線型性 <linearity_of_T>
            a, b = 0.37+0.21j, -1.1+0.6j
            rep.close(T_conj(g1, a*Zm + b*Ym), a*T_conj(g1,Zm) + b*T_conj(g1,Ym), f"M={M} mu={mu}: T の線型性(V1)")
            rep.close(T_conj(g2, a*Zm + b*Ym), a*T_conj(g2,Zm) + b*T_conj(g2,Ym), f"M={M} mu={mu}: T の線型性(V2)")
rep.finish()
