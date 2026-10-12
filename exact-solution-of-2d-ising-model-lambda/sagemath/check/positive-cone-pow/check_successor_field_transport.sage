# 対象ラベル: claim_quadratic_positive_cone_pow_closed
# 本文の行: 後者の等式から台集合への所属を移す
# QQ / QQbar / 二次数体で厳密に検算する。
from pathlib import Path
import sys
if '_pcp_bases' not in globals():
    _pcp_source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_pcp_source.parent / '_prelude.sage').is_file():
        _pcp_source = Path(sys.argv[0]).resolve()
    load(str(_pcp_source.parent / '_prelude.sage'))

_pcp_check('successor_field_transport', _pcp_steps, lambda c: _pcp_field_mem(c['s'], c['successor'], c['product_pair']))
