# =========================================================================
# check_08: V_plus_is_invertible の左逆検査
#
#   本文の明示式で作った R^{(+)} について R^{(+)} V^{(+)} = I を検査する。
#   右逆は check_07 で独立に検査する。
# =========================================================================
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== check_08: R^{(+)} V^{(+)} = I ===")

ok_all = True
w_left_inverse = 0

for M in EIG_M:
    O = SpinOps(M)
    Id = identity_matrix(CDF, O.d)
    for p in EIG_PARAMS:
        Vp, Rplus = V_plus(O, RDF(p['K1']), RDF(p['K2']))
        w_left_inverse = max(
            w_left_inverse,
            opnorm(Rplus * Vp - Id) / opnorm(Id),
        )

ok_all &= report("R^{(+)} V^{(+)} = I（相対差）", w_left_inverse, TOL)
print("check_08:", "PASS" if ok_all else "FAIL")
