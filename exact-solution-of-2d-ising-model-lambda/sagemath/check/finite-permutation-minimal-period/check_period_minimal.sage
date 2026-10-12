# 本文の行: 任意の正の帰還時刻との比較
# 対象ラベル: claim_finite_permutation_positive_return, def_finite_permutation_minimal_period
# 有限辞書と自然数の厳密計算。反復を一歩ずつ計算する。
from pathlib import Path
import sys
if '_fpm_cases' not in globals():
    _source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_source.parent / '_prelude.sage').is_file():
        _source = Path(sys.argv[0]).resolve()
    load(str(_source.parent / '_prelude.sage'))

_checked = 0
for points, sigma, i, period in _fpm_periods:
    for n in range(1, 3*len(points)+2):
        if _fpm_iter(sigma, n, i) == i:
            assert period is not None and period <= n
            _checked += 1
_fpm_record('period_minimal', _checked)
