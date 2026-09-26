# 038: T_(V)(Z_m)=T_(V')(Z_m), T_(V)(Y_m)=T_(V')(Y_m) (生成元上の一致, 038 Step2)
import os; exec(open(os.path.join(os.path.dirname(__file__),'common_full.py')).read())
import numpy as np
allok=True
for M in MS:
    for (a,b) in PARS:
        d=build(M,a,b); TV=lambda A:d['V']@A@d['Vinv']; TVp=lambda A:d['Vp']@A@d['Vpinv']
        e=0
        for m in range(1,M+1):
            e=max(e,np.max(np.abs(TV(d['Zm'](m,M))-TVp(d['Zm'](m,M)))),
                    np.max(np.abs(TV(d['Ym'](m,M))-TVp(d['Ym'](m,M)))))
        ok=e<TOL; allok=allok and ok
        print(f"M={M} K=({a},{b}): max|T_V(Z,Y)-T_Vp(Z,Y)|={e:.1e} {'PASS' if ok else 'FAIL'}")
print("ALL PASS" if allok else "SOME FAIL")
