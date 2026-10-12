# 対象ラベル: claim_quadratic_trichotomy_at_most_one
# 式ペア: (2b)b=2(bb)
# Lean の対応: 第三・第二の場合の hForward の結合則
# 帰属: 有理数と二次体の厳密計算。浮動小数点は使わない。
# 背理仮定を使わない恒等式として検算する。九場合の成立例とは数えない。
from pathlib import Path
import sys

if '_qtm_check' not in globals():
    _source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_source.parent / '_prelude.sage').is_file():
        _source = Path(sys.argv[0]).resolve()
    load(str(_source.parent / '_prelude.sage'))

_qtm_check('associate', 1, '元が第三条件の結合等号')
