# 対象ラベル: claim_finite_permutation_period_injective
# 結論: 最小周期未満の反復回数の一意性
from pathlib import Path
import sys
if '_fpi_data' not in globals():
    _source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_source.parent / '_prelude.sage').is_file():
        _source = Path(sys.argv[0]).resolve()
    load(str(_source.parent / '_prelude.sage'))

checked = 0
for sigma, i, p, values in _fpi_data:
    for r in range(p):
        for t in range(p):
            assert values[r] != values[t] or r == t
            checked += 1
_fpi_totals['interval_injective'] = checked
print('PASS: interval_injective ({} 確認)'.format(checked))
