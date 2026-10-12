# 対象ラベル: claim_quadratic_trichotomy_at_most_one
# 式ペア: ¬(a=0 ∧ b=0) ⇔ (a,b)≠(0,0)
# Lean の対応: hPair の最後の同値
# 帰属: 有理数と二次体の厳密計算。浮動小数点は使わない。
from pathlib import Path
import sys

if '_qtm_check' not in globals():
    _source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_source.parent / '_prelude.sage').is_file():
        _source = Path(sys.argv[0]).resolve()
    load(str(_source.parent / '_prelude.sage'))

_qtm_check('pair', 3, '元の組の相等へ戻す')
