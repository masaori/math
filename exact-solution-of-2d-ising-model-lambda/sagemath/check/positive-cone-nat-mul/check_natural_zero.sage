# 対象ラベル: claim_quadratic_positive_cone_nat_mul
# 本文の行: ι(ν(0_N))ξ=ι(0_Q)ξ
# 帰属: ZZ / QQ / QQbar の厳密計算。
from pathlib import Path
import sys

if '_pn_check' not in globals():
    _source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_source.parent / '_prelude.sage').is_file():
        _source = Path(sys.argv[0]).resolve()
    load(str(_source.parent / '_prelude.sage'))

_pn_check('natural_zero')
