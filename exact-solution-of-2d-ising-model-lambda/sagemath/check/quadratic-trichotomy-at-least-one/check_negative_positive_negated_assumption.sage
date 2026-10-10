# 対象ラベル: claim_quadratic_trichotomy_at_least_one
# 対象: main-text.ts の二次体の三分律（少なくとも一つ）、負正混合の逆元の平方比較の仮定
# 式ペア: 2(bb)<aa
# 帰属: a, b は QQ。比較も QQ の順序を使い、浮動小数点を使わない。
import os

if '_qta_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_qta_check_pair('negative_positive_negated', lambda a, b: QQ(2)*(b*b), lambda a, b: a*a,
                '<', 'negative_positive_negated_assumption')
