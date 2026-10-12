# 本文の行: 相異なる添字での反復値の一致
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
for points, sigma, i, values in _fpm_cases:
    assert any(r < t and values[t] == values[r] for r, t in combinations(range(len(values)), 2))
    _checked += 1
_fpm_record('collision_exists', _checked)
