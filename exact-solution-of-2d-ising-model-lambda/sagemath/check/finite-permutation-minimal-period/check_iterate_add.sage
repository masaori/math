# 本文の行: 反復の加法則を逆向きに使う
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
for sigma, i, r, t, d in _fpm_collisions:
    assert _fpm_iter(sigma, r, _fpm_iter(sigma, d, i)) == _fpm_iter(sigma, r+d, i)
    _checked += 1
_fpm_record('iterate_add', _checked)
