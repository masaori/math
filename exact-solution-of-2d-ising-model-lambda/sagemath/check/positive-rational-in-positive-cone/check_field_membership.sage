# 対象ラベル: claim_positive_rational_in_positive_cone
# 有理係数の証人による台集合への所属。QQ / QQbar の厳密計算。
from pathlib import Path
import sys

if '_prc_cases' not in globals():
    _prc_source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_prc_source.parent / '_prelude.sage').is_file():
        _prc_source = Path(sys.argv[0]).resolve()
    load(str(_prc_source.parent / '_prelude.sage'))

_prc_check('field_membership', lambda s, q, a, b, coefficients:
    q in QQ and QQ(0) in QQ and QQbar(q) == QQbar(q) + QQbar(QQ(0))*s)
