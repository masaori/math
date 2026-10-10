# 対象ラベル: claim_quadratic_trichotomy_at_most_one
# 式ペア: (-a,-b)≠(0,0) ⇔ ¬(-a=0 ∧ -b=0)
# Lean の対応: hPair の最初の同値
# 帰属: 有理数と二次体の厳密計算。浮動小数点は使わない。
import os

if '_qtm_check' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_qtm_check('pair', 0, '負の組の相等')
