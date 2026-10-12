# 対象ラベル: claim_finite_permutation_period_injective
# 本文の行: 帰還する正の差は最小周期以上である
# 帰属: 有限な自然数の集合と辞書。全て厳密計算。
from pathlib import Path
import sys
if '_fpi_data' not in globals():
    _source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_source.parent / '_prelude.sage').is_file():
        _source = Path(sys.argv[0]).resolve()
    load(str(_source.parent / '_prelude.sage'))

_fpi_check('period_minimal', lambda sigma, i, p, r, t, d, values: p <= d, collision=True)
