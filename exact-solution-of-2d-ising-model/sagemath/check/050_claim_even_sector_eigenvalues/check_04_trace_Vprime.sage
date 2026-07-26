# =========================================================================
# check_04: trace_of_check_Vprime
#
#   (1) V^' (V^')^{-1} = I（可逆性、(V^')^{-1} = exp(-X^)）
#   (2) tr(V^') = prod_{mu=1}^{M} 2 cosh( gamma(theta~_mu) / 2 )
#   (3) tr((V^')^{-1}) = tr(V^')
#   (4) tr(V^') > 0
#
#   009 章の trace_of_Vprime は前因子 2^{M-m} を持つが、半整数運動量では m = M なので
#   2^{M-m} = 1 になる（＝前因子が消える）。そのことも確認する。
# =========================================================================
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== check_04: tr(V^') = prod 2 cosh(gamma/2) ===")

ok_all = True
w_inv = 0
w_tr = 0
w_trinv = 0
min_tr = None

for M in EIG_M:
    O = SpinOps(M)
    Id = identity_matrix(CDF, O.d)
    for p in EIG_PARAMS:
        P = coeffs(p['K1'], p['K2'])
        ns = n_check_all(O, P)
        Vpr, Vpri, X = Vprime_check(O, P, ns)
        w_inv = max(w_inv, opnorm(Vpr * Vpri - Id))
        pred = RDF(1)
        for mu in range(1, M + 1):
            pred = pred * RDF(2 * cosh(gamma_tilde(M, mu, P) / 2))
        tr = Vpr.trace()
        tri = Vpri.trace()
        w_tr = max(w_tr, abs(tr - CDF(pred)) / abs(pred))
        w_trinv = max(w_trinv, abs(tri - tr) / abs(tr))
        min_tr = RDF(tr.real()) if min_tr is None else min(min_tr, RDF(tr.real()))

ok_all &= report("V^' (V^')^{-1} = I", w_inv, TOL)
ok_all &= report("tr(V^') = prod_mu 2 cosh(gamma(theta~_mu)/2)（相対差）", w_tr, TOL)
ok_all &= report("tr((V^')^{-1}) = tr(V^')（相対差）", w_trinv, TOL)
print(f"  tr(V^') の全体最小 = {float(min_tr):.3e}  ->  "
      f"{'PASS（正）' if min_tr > 0 else 'FAIL'}")
ok_all &= (min_tr > 0)
print("  前因子 2^{M-m} は m = M なので 1（009 章の 2^{M-m} が消えることに対応）")

print("check_04:", "PASS" if ok_all else "FAIL")
