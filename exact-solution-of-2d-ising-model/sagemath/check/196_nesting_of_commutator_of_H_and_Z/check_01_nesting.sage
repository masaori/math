# <nesting_of_commutator_of_H_and_Z>: n 重交換子の閉じた表示 4 式
# 左辺は再帰（ad を n 回）、右辺は閉じた表示から独立に計算する。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
import numpy as np
rep = CheckReport("nesting_of_commutator_of_H_and_Z: n=0..6")
NMAX = 6
for M in [2,3,4]:
    rng_mu = list(range(-M,0)) + list(range(1,M+1))
    for p in OP_TEST_PARAMS[:3]:
        K1 = p['K1']; K2s = K_star(p['K2'])
        for mu in rng_mu:
            e_m = np.exp(-1j*2*np.pi*mu/M)
            e_p = np.exp(+1j*2*np.pi*mu/M)
            for sgn in ['+','-']:
                X1 = K1 * H1_op(M, sgn)
                Zs = hatZ_op(mu,M,sgn); Ys = hatY_op(mu,M)
                for n in range(0, NMAX+1):
                    # (h1.z)
                    lhs = ad_pow(X1, Zs, n)
                    if n % 2 == 1:
                        rhs = ((-1)**((n-1)//2)) * (2*K1)**n * e_m * Ys
                    else:
                        rhs = ((-1)**(n//2)) * (2*K1)**n * Zs
                    rep.close(lhs, rhs, f"M={M} sgn={sgn} mu={mu} n={n}: (h1.z)")
                    # (h1.y)
                    lhs = ad_pow(X1, Ys, n)
                    if n % 2 == 1:
                        rhs = ((-1)**((n+1)//2)) * (2*K1)**n * e_p * Zs
                    else:
                        rhs = ((-1)**(n//2)) * (2*K1)**n * Ys
                    rep.close(lhs, rhs, f"M={M} sgn={sgn} mu={mu} n={n}: (h1.y)")
            X2 = K2s * H2_op(M)
            Zm = hatZ_op(mu,M,'-'); Ym = hatY_op(mu,M)
            for n in range(0, NMAX+1):
                lhs = ad_pow(X2, Zm, n)
                if n % 2 == 1:
                    rhs = ((-1)**((n+1)//2)) * (2*K2s)**n * Ym
                else:
                    rhs = ((-1)**(n//2)) * (2*K2s)**n * Zm
                rep.close(lhs, rhs, f"M={M} mu={mu} n={n}: (h2.z-)")
                lhs = ad_pow(X2, Ym, n)
                if n % 2 == 1:
                    rhs = ((-1)**((n-1)//2)) * (2*K2s)**n * Zm
                else:
                    rhs = ((-1)**(n//2)) * (2*K2s)**n * Ym
                rep.close(lhs, rhs, f"M={M} mu={mu} n={n}: (h2.y)")
rep.finish()
