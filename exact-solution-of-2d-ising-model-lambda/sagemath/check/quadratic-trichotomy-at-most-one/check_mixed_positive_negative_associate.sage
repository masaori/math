# 対象ラベル: claim_quadratic_trichotomy_at_most_one
# 式ペア: 2(bb)=(2b)b
# Lean の対応: 第二・第三の場合の hForward の結合則
# 帰属: 有理数と二次体の厳密計算。浮動小数点は使わない。
# 背理仮定を使わない恒等式として検算する。九場合の成立例とは数えない。
import os

if '_qtm_check' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_qtm_check('associate', 0, '元が第二条件の結合等号')
