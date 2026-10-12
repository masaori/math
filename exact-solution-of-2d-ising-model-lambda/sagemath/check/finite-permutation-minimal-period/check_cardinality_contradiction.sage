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
    if len(set(values)) == len(values):
        _checked += 1
assert _checked == 0
print('数値事例なし: N+1 個の反復値がすべて異なるという背理仮定。有限集合の個数の比較と矛盾は Lean 二版で検証する。')
