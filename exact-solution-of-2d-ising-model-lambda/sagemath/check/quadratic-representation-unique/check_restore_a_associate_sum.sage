# 対象ラベル: claim_quadratic_representation_unique
# 対象: structured-latex/content/main-text.ts の「二次体の表示の一意性」
# 係数 a の復元で加法を結合する
# 式1（本文原文）: a+\bigl((-a')+a'\bigr)
# 式2（本文原文）: \bigl(a+(-a')\bigr)+a'
# 帰属: a,b,a',b',alpha,beta は QQ、s は QQbar、iota: QQ -> QQbar。
# 標本: 非同一表示も含む4802組。表示の等号は仮定しない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

_checked = 0
for a,b,ap,bp,s,alpha,beta in _qru_cases(equal_representation=False):
    expr1 = a + ((-ap) + ap)
    expr2 = (a + (-ap)) + ap
    assert expr1 == expr2, "check_restore_a_associate_sum"
    _checked += 1
_qru_report("check_restore_a_associate_sum", _checked, False)
