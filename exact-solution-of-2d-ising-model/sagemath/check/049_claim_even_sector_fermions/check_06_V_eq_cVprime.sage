# =========================================================================
# check_06: V_plus_eq_c_check_Vprime
#
#   W := (V^')^{-1} V^{(+)} がスカラー行列 c I になり、c != 0 である。
#   したがって V^{(+)} = c V^'。
#
#  併せて（本章では証明しないが次章で扱う）c の値が (2 sinh 2K_2)^{M/2} に一致することも
#  数値で見ておく。
# =========================================================================
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== check_06: V^{(+)} = c V^' ===")

ok_all = True
w_scalar = 0
w_eq = 0
w_cval = 0
min_abs_c = None
rows = []

for M in FERMI_M:
    O = SpinOps(M)
    Id = identity_matrix(CDF, O.d)
    for p in FERMI_PARAMS:
        P = coeffs(p['K1'], p['K2'])
        Vp, _ = V_plus(O, p['K1'], p['K2'])
        Vpr, Vpri, _ = Vprime_check(O, P)
        W = Vpri * Vp
        c = W[0, 0]
        w_scalar = max(w_scalar, opnorm(W - c * Id))
        w_eq = max(w_eq, opnorm(Vp - c * Vpr))
        min_abs_c = abs(c) if min_abs_c is None else min(min_abs_c, abs(c))
        c_pred = CDF((2 * RDF(sinh(2 * RDF(p['K2'])))) ** (RDF(M) / 2))
        w_cval = max(w_cval, abs(c - c_pred) / abs(c_pred))
        rows.append((M, param_label(p), c, c_pred))

ok_all &= report("W := (V^')^{-1} V^{(+)} がスカラー行列", w_scalar, TOL)
ok_all &= report("V^{(+)} - c V^' = O", w_eq, TOL)
print(f"  |c| の全体最小 = {float(min_abs_c):.3e}  ->  "
      f"{'PASS（c != 0）' if min_abs_c > 1e-3 else 'FAIL'}")
ok_all &= (min_abs_c > 1e-3)
ok_all &= report("（参考・次章の内容）c = (2 sinh 2K_2)^{M/2} との相対差", w_cval, 1e-10)

print()
print("  c の実測値（虚部は丸め誤差の範囲）:")
for M, lab, c, c_pred in rows[:8]:
    print(f"    M={M} {lab}: c = {float(c.real()):.10g} (虚部 {float(c.imag()):.1e}), "
          f"(2 sinh 2K_2)^(M/2) = {float(c_pred.real()):.10g}")

print("check_06:", "PASS" if ok_all else "FAIL")
