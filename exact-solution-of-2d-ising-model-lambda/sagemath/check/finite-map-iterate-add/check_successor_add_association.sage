# 対象ラベル: claim_finite_map_iterate_add
# 本文の行: 自然数の加法の結合則
# 帰属: 自然数の有限集合とその自己写像。丸めなし。
from pathlib import Path
import sys

if '_fma_cases' not in globals():
    _fma_source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_fma_source.parent / '_prelude.sage').is_file():
        _fma_source = Path(sys.argv[0]).resolve()
    load(str(_fma_source.parent / '_prelude.sage'))

_checked = 0
for f, m, n, i in _fma_inputs(True):
    assert _fma_iter(f, m + (n + 1), i) == _fma_iter(f, (m + n) + 1, i), (f, m, n, i)
    _checked += 1
_fma_record('successor_add_association', _checked, 54586)
