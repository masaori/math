# 対象ラベル: claim_sector_value_duality_at_algebraic_point
# 式ペア: H_L^{a,b}(xi) = (1+xi)^(2L^2) G_L^{a,b}(KW(xi))
# 帰属: QQbar
from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/sector-value-duality-at-self-dual-point' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/sector-value-duality-at-self-dual-point').is_dir())
load(str(_dir / '_prelude.sage'))

points = (QQbar(1) / 2, QQbar(2).sqrt() - 1, QQbar(-2).sqrt() + 2)
for L in (1, 2, 3):
    high, low = sector_polynomials(L)
    for xi in points:
        dual = (1 - xi) * (1 + xi) ** (-1)
        for sector in high:
            assert QQbar(high[sector](xi)) == (1 + xi) ** (2 * L * L) * QQbar(low[sector](dual))
print('RESULT: PASS')
