# =========================================================================
# (V^{(+)})^{-1} の全固有値正値性を独立に検査する
#
# 対象ラベル: V_plus_inverse_is_positive_definite
# 対象: structured-latex/content/017_even_sector_eigenvalues.ts
# 帰属: CDF 上で数値評価する。有限複素行列の正定値性に対する数値検査であり、
#       実数への脱出は固有値計算の浮動小数点近似だけである。
# =========================================================================
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== (V^{(+)})^{-1} の全固有値正値性 ===")

ok_all = True
max_imaginary_part = RDF(0)
min_inverse_eigenvalue = None

for M in EIG_M:
    O = SpinOps(M)
    for p in EIG_PARAMS:
        _, Vpi = V_plus(O, RDF(p['K1']), RDF(p['K2']))
        for eigenvalue in Vpi.eigenvalues():
            z = CDF(eigenvalue)
            max_imaginary_part = max(max_imaginary_part, RDF(abs(z.imag())))
            real_part = RDF(z.real())
            min_inverse_eigenvalue = (
                real_part if min_inverse_eigenvalue is None
                else min(min_inverse_eigenvalue, real_part)
            )

ok_all &= report(
    "(V^{(+)})^{-1} の固有値の虚部の最大絶対値",
    max_imaginary_part,
    TOL,
)
print(
    "  (V^{(+)})^{-1} の固有値の実部の全体最小 = "
    f"{float(min_inverse_eigenvalue):.3e}  ->  "
    f"{'PASS（正）' if min_inverse_eigenvalue > 0 else 'FAIL'}"
)
ok_all &= min_inverse_eigenvalue > 0

print("RESULT:", "PASS" if ok_all else "FAIL")
if not ok_all:
    raise RuntimeError("(V^{(+)})^{-1} の全固有値正値性検査が失敗しました")
