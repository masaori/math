# 039: W := V'^(-1) V = c I (c in CC^×). 中心性経由で V = c V'。
import os
exec(open(os.path.join(os.path.dirname(__file__),'..','038_claim_T_V_eq_T_Vprime','common_full.py')).read())
import numpy as np
allok=True
for M in MS:
    for (a,b) in PARS:
        d=build(M,a,b); W=d['Vpinv']@d['V']; c=W[0,0]; I=d['Imat']
        e=np.max(np.abs(W-c*I)); ok=(e<TOL) and (abs(c)>1e-9); allok=allok and ok
        print(f"M={M} K=({a},{b}): |c|={abs(c):.4f} c={c:.4f} max|W-cI|={e:.1e} {'PASS' if ok else 'FAIL'}")
print("ALL PASS" if allok else "SOME FAIL")
