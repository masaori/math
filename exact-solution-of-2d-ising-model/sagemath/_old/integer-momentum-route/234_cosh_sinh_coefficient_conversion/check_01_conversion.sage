# <cosh_sinh_coefficient_conversion>: (i/2)K_1 H_1^{(±)} 版と i K_2^* H_2 版の n 重交換子
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
import math
rep = CheckReport("cosh_sinh_coefficient_conversion")
for M in [2,3,4]:
    for p in OP_TEST_PARAMS[:3]:
        K1 = p['K1']; K2s = K_star(p['K2'])
        for mu in list(range(-M,0)) + list(range(1,M+1)):
            e_m = np.exp(-1j*2*np.pi*mu/M)
            for sgn in ['+','-']:
                X1 = 1j*(K1/2.0)*H1_op(M, sgn)
                Zs = hatZ_op(mu,M,sgn); Ys = hatY_op(mu,M)
                for n in range(0, 7):
                    lhs = ad_pow(X1, Zs, n)
                    rhs = (1j*K1**n*e_m*Ys) if n % 2 == 1 else (K1**n*Zs)
                    rep.close(lhs, rhs, f"M={M} sgn={sgn} mu={mu} n={n}: (h1.z)")
            X2 = 1j*K2s*H2_op(M)
            Zm = hatZ_op(mu,M,'-'); Ym = hatY_op(mu,M)
            for n in range(0, 7):
                lhs = ad_pow(X2, Zm, n)
                rhs = (-1j*(2*K2s)**n*Ym) if n % 2 == 1 else ((2*K2s)**n*Zm)
                rep.close(lhs, rhs, f"M={M} mu={mu} n={n}: (h2.z-)")
rep.finish()
