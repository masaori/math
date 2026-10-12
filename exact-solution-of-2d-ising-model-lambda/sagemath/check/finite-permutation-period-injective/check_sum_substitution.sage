# 対象ラベル: claim_finite_permutation_period_injective
# 本文の行: 反復回数の等式を代入する
# 帰属: 有限な自然数の集合と辞書。全て厳密計算。
from pathlib import Path
import sys
if '_fpi_data' not in globals():
    _source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_source.parent / '_prelude.sage').is_file():
        _source = Path(sys.argv[0]).resolve()
    load(str(_source.parent / '_prelude.sage'))

_fpi_check('sum_substitution', lambda sigma, i, p, r, t, d, values: _fpi_iter(sigma, r+d, i) == values[t])
