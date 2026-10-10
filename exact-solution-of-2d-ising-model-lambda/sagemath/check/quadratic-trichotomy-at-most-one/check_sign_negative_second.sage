# 対象ラベル: claim_quadratic_trichotomy_at_most_one
# 式ペア: -b<0 ⇔ 0<b
# Lean の対応: hNegB
# 帰属: 有理数と二次体の厳密計算。浮動小数点は使わない。
import os

if '_qtm_check' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_qtm_check('sign', 3, '第二成分の負')
