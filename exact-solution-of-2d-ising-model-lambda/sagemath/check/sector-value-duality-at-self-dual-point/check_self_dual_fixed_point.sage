# 対象ラベル: claim_self_dual_point_low_high_sector_correspondence
# 式ペア: KW(x_sd) = x_sd
# 帰属: QQbar
from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/sector-value-duality-at-self-dual-point' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/sector-value-duality-at-self-dual-point').is_dir())
load(str(_dir / '_prelude.sage'))

assert 1 + self_dual_point != 0
assert (1 - self_dual_point) * (1 + self_dual_point) ** (-1) == self_dual_point
print('RESULT: PASS')
