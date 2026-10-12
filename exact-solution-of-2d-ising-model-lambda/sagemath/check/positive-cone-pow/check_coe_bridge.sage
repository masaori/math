# 対象ラベル: claim_quadratic_positive_cone_pow_closed
# 本文の行: 二次数体の冪の像と通常の代数的数の冪との橋
# QQ / QQbar / 二次数体で厳密に検算する。
from pathlib import Path
import sys
if '_pcp_bases' not in globals():
    _pcp_source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_pcp_source.parent / '_prelude.sage').is_file():
        _pcp_source = Path(sys.argv[0]).resolve()
    load(str(_pcp_source.parent / '_prelude.sage'))

_pcp_check('coe_bridge', _pcp_powers, lambda c: c['represented'] == c['value'])
