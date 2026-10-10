# 対象ラベル: claim_quadratic_trichotomy_at_most_one
# 式ペア: rep_s(-ξ)=(-a,-b)
# Lean の対応: hNegZero の最初の等号
# 帰属: 有理数と二次体の厳密計算。浮動小数点は使わない。
import os

if '_qtm_check' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_qtm_check('zero', 0, '逆元の表示')
