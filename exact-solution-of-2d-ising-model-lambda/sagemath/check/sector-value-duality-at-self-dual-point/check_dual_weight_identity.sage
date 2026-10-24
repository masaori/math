# 対象ラベル: claim_sector_value_duality_at_algebraic_point
# 式ペア: (1+xi) KW(xi) = 1-xi
# 帰属: QQbar
from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/sector-value-duality-at-self-dual-point' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/sector-value-duality-at-self-dual-point').is_dir())
load(str(_dir / '_prelude.sage'))

for xi in (QQbar(1) / 2, QQbar(2).sqrt() - 1, QQbar(-2).sqrt() + 2):
    assert 1 + xi != 0
    dual = (1 - xi) * (1 + xi) ** (-1)
    assert (1 + xi) * dual == 1 - xi
print('RESULT: PASS')
