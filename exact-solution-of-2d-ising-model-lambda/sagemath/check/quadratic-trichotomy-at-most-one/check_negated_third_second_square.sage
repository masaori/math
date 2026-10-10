# 対象ラベル: claim_quadratic_trichotomy_at_most_one
# 式ペア: aa<2((-b)(-b)) ⇔ aa<2(bb)
# Lean の対応: hThird の第二成分の平方
# 帰属: 有理数と二次体の厳密計算。浮動小数点は使わない。
import os

if '_qtm_check' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_qtm_check('third', 2, '逆元の第三条件の第二平方')
