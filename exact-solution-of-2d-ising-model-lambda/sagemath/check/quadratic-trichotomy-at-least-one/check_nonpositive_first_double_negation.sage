# 対象ラベル: claim_quadratic_trichotomy_at_least_one
# 対象: main-text.ts の二次体の三分律（少なくとも一つ）、非正の場合の第一係数の二重負号
# 式ペア: a=-(-a)
# 帰属: a, b は QQ。比較も QQ の順序を使い、浮動小数点を使わない。
import os

if '_qta_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

_qta_check_pair('nonpositive', lambda a, b: a, lambda a, b: -(-a),
                '=', 'nonpositive_first_double_negation')
