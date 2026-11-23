# 対象ラベル: claim_self_dual_point_low_high_sector_correspondence
# 式ペア: x_sd^2 + 2 x_sd - 1 = (-1+s)^2 + 2(-1+s) - 1 = s*s - 2 = 2 - 2 = 0、
#         その後 claim_kw_self_dual_quadratic_equivalence により KW(x_sd) = x_sd
# 帰属: QQbar
from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/sector-value-duality-at-self-dual-point' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/sector-value-duality-at-self-dual-point').is_dir())
load(str(_dir / '_prelude.sage'))

s = QQbar(2).sqrt()
assert s * s == 2
x_sd = -1 + s
assert x_sd == self_dual_point
assert x_sd ** 2 + 2 * x_sd - 1 == (-1 + s) ** 2 + 2 * (-1 + s) - 1
assert (-1 + s) ** 2 + 2 * (-1 + s) - 1 == s * s - 2
assert s * s - 2 == 2 - 2
assert 2 - 2 == 0
# 同値の左側（不動点）が、右側（二次方程式）から得られることを確かめる。
assert 1 + x_sd != 0
assert (1 - x_sd) * (1 + x_sd) ** (-1) == x_sd
print('RESULT: PASS')
