# 対象ラベル: claim_finite_permutation_period_injective
from pathlib import Path
import sys
if '_fpi_data' not in globals():
    _source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_source.parent / '_prelude.sage').is_file():
        _source = Path(sys.argv[0]).resolve()
    load(str(_source.parent / '_prelude.sage'))

for path in sorted(_source.parent.glob('check_*.sage')):
    load(str(path))
assert len(_fpi_totals) == 10
print('TOTAL: {} 行検算と結論、{} 確認、{} 置換、{} 始点'.format(
    len(_fpi_totals)-1, sum(_fpi_totals.values()), _fpi_permutations, len(_fpi_data)))
