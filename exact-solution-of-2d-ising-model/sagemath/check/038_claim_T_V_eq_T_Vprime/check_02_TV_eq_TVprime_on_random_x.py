# 038: 任意 x で T_(V)(x)=T_(V')(x) (= T_(V)=T_(V') 全空間)
import os; exec(open(os.path.join(os.path.dirname(__file__),'common_full.py')).read())
import numpy as np
allok=True
for M in MS:
    for (a,b) in PARS:
        d=build(M,a,b); TV=lambda A:d['V']@A@d['Vinv']; TVp=lambda A:d['Vp']@A@d['Vpinv']
        rng=np.random.default_rng(0); D=d['D']
        e=0
        for _ in range(3):
            xr=rng.standard_normal((D,D))+1j*rng.standard_normal((D,D))
            e=max(e,np.max(np.abs(TV(xr)-TVp(xr))))
        ok=e<1e-7; allok=allok and ok
        print(f"M={M} K=({a},{b}): max|T_V(x)-T_Vp(x)| (3 random x)={e:.1e} {'PASS' if ok else 'FAIL'}")
print("ALL PASS" if allok else "SOME FAIL")
