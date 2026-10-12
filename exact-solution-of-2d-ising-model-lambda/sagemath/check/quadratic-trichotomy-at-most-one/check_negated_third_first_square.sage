# 対象ラベル: claim_quadratic_trichotomy_at_most_one
# 式ペア: (-a)(-a)<(2(-b))(-b) ⇔ aa<(2(-b))(-b)
# Lean の対応: hThird の第一成分の平方
# 帰属: 有理数と二次体の厳密計算。浮動小数点は使わない。
from pathlib import Path
import sys

if '_qtm_check' not in globals():
    _source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_source.parent / '_prelude.sage').is_file():
        _source = Path(sys.argv[0]).resolve()
    load(str(_source.parent / '_prelude.sage'))

_qtm_check('third', 0, '逆元の第三条件の第一平方')
