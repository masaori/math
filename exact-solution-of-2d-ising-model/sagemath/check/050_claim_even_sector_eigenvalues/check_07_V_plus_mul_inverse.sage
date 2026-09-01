# =========================================================================
# check_07: V_plus_is_invertible の右逆検査
#
#   本文の明示式で作った R^{(+)} について V^{(+)} R^{(+)} = I を検査する。
#   左逆は check_08 で独立に検査する。
# =========================================================================
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== check_07: V^{(+)} R^{(+)} = I ===")

ok_all = True
w_right_inverse = 0

for M in EIG_M:
    O = SpinOps(M)
    Id = identity_matrix(CDF, O.d)
    for p in EIG_PARAMS:
        Vp, Rplus = V_plus(O, RDF(p['K1']), RDF(p['K2']))
        w_right_inverse = max(
            w_right_inverse,
            opnorm(Vp * Rplus - Id) / opnorm(Id),
        )

ok_all &= report("V^{(+)} R^{(+)} = I（相対差）", w_right_inverse, TOL)
print("check_07:", "PASS" if ok_all else "FAIL")
