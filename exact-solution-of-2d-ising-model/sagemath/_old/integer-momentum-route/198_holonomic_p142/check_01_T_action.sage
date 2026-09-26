# <ホロノミック量子場_p142下段_1>: T_{(V_1^{(±)})^{1/2}} と T_{V_2} の hatZ^{(-)}, hatY への作用
# 経路1: 行列共役 g X g^{-1} を直接計算
# 経路2: 197 と同じ級数和
# の 2 経路で、本文の閉じた表示と突き合わせる。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import math
rep = CheckReport("holonomic p142: T の hatZ^{(-)}, hatY への作用")
NTERMS = 40
for M in [2,3,4]:
    rng_mu = list(range(-M,0)) + list(range(1,M+1))
    for p in OP_TEST_PARAMS[:4]:
        K1 = p['K1']; K2 = p['K2']; K2s = K_star(K2)
        for mu in rng_mu:
            e_m = np.exp(-1j*2*np.pi*mu/M); e_p = np.exp(+1j*2*np.pi*mu/M)
            Zm = hatZ_op(mu,M,'-'); Ym = hatY_op(mu,M)
            # --- V_1^{(-)} の平方根による共役（本文の hatZ^{(-)} と整合する符号） ---
            g = principal_sqrt_of_V1pm(K1, M, '-')
            rep.close(T_conj(g, Zm), np.cosh(K1)*Zm + 1j*e_m*np.sinh(K1)*Ym,
                      f"M={M} mu={mu} K1={K1}: T_{{V1^(-)^1/2}}(hatZ^(-))")
            rep.close(T_conj(g, Ym), -1j*e_p*np.sinh(K1)*Zm + np.cosh(K1)*Ym,
                      f"M={M} mu={mu} K1={K1}: T_{{V1^(-)^1/2}}(hatY)")
            # 経路2（級数）との一致
            X1 = 1j*(K1/2.0)*H1_op(M,'-')
            s = np.zeros_like(Zm); t = Zm.copy()
            for n in range(NTERMS+1):
                s = s + t/math.factorial(n); t = comm(X1, t)
            rep.close(T_conj(g, Zm), s, f"M={M} mu={mu} K1={K1}: 共役 = 級数（独立2経路）")
            # --- V_2 による共役 ---
            g2 = V2_op(K2, M)
            rep.close(T_conj(g2, Zm), np.cosh(2*K2s)*Zm - 1j*np.sinh(2*K2s)*Ym,
                      f"M={M} mu={mu} K2={K2}: T_{{V2}}(hatZ^(-))")
            rep.close(T_conj(g2, Ym), 1j*np.sinh(2*K2s)*Zm + np.cosh(2*K2s)*Ym,
                      f"M={M} mu={mu} K2={K2}: T_{{V2}}(hatY)")
            # --- V_1^{(+)} の平方根では hatZ^{(-)} が閉じないことの観察（主張ではない） ---
            if M == 3 and mu == 1 and p is OP_TEST_PARAMS[0]:
                gp = principal_sqrt_of_V1pm(K1, M, '+')
                d = np.max(np.abs(T_conj(gp, Zm) - (np.cosh(K1)*Zm + 1j*e_m*np.sinh(K1)*Ym)))
                print(f"  [観察] V_1^(+) の平方根で hatZ^(-) を共役すると本文の閉じた表示から {d:.3e} ずれる")
                print("         （[H_1^(±), hatY] = -2 e^{i theta} hatZ^{(±)} なので軌道が閉じるのは同符号のときだけ）")
rep.finish()
