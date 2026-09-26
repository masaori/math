# 030(+033): T_(V)(psi_mu^†)=e^{γ(θ_mu)} psi_mu^†, T_(V)(psi_mu)=e^{-γ} psi_mu (全空間)
# これが土台。038/039 の正しさはこの 030 + 037 から従う。
import os
exec(open(os.path.join(os.path.dirname(__file__),'..','038_claim_T_V_eq_T_Vprime','common_full.py')).read())
import numpy as np, math, cmath
allok=True
for M in MS:
    for (a,b) in PARS:
        d=build(M,a,b); TV=lambda A:d['V']@A@d['Vinv']
        e=0
        for mu in range(1,M+1):
            t=d['th'](mu); gam=math.acosh(d['g1'](t).real)
            pd=d['psidag'](mu)
            e=max(e,np.max(np.abs(TV(pd)-cmath.exp(gam)*pd))/max(np.max(np.abs(pd)),1e-30))
        ok=e<TOL; allok=allok and ok
        print(f"M={M} K=({a},{b}): max rel |T_V(psi^†)-e^γ psi^†|={e:.1e} {'PASS' if ok else 'FAIL'}")
print("ALL PASS" if allok else "SOME FAIL")
