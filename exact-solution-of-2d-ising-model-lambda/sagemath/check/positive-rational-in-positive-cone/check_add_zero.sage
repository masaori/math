# 対象ラベル: claim_positive_rational_in_positive_cone
# 代数的数の加法単位元。QQ / QQbar の厳密計算。
from pathlib import Path
import sys

if '_prc_cases' not in globals():
    _prc_source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_prc_source.parent / '_prelude.sage').is_file():
        _prc_source = Path(sys.argv[0]).resolve()
    load(str(_prc_source.parent / '_prelude.sage'))

_prc_check('add_zero', lambda s, q, a, b, coefficients:
    QQbar(q) == QQbar(q) + QQbar(0))
