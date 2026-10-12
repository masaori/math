# 対象ラベル: claim_positive_rational_in_positive_cone
# 表示の組による正錐への所属。QQ / QQbar の厳密計算。
from pathlib import Path
import sys

if '_prc_cases' not in globals():
    _prc_source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_prc_source.parent / '_prelude.sage').is_file():
        _prc_source = Path(sys.argv[0]).resolve()
    load(str(_prc_source.parent / '_prelude.sage'))

_prc_check('positive_membership', lambda s, q, a, b, coefficients:
    _prc_positive(coefficients))
