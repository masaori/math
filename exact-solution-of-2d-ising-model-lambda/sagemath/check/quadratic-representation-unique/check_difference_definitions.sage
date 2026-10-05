# 対象ラベル: claim_quadratic_representation_unique
# 対象: structured-latex/content/main-text.ts の「二次体の表示の一意性」
# 係数差の定義を展開する
# 式1（本文原文）: \iota(\alpha)+\iota(\beta)\cdot s
# 式2（本文原文）: \iota\bigl(a+(-a')\bigr)+\iota\bigl(b+(-b')\bigr)\cdot s
# 帰属: a,b,a',b',alpha,beta は QQ、s は QQbar、iota: QQ -> QQbar。
# 標本: 非同一表示も含む4802組。表示の等号は仮定しない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

_checked = 0
for a,b,ap,bp,s,alpha,beta in _qru_cases(equal_representation=False):
    expr1 = QQbar(alpha) + QQbar(beta)*s
    expr2 = QQbar(a + (-ap)) + QQbar(b + (-bp))*s
    assert expr1 == expr2, "check_difference_definitions"
    _checked += 1
_qru_report("check_difference_definitions", _checked, False)
