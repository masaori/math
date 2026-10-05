# 対象ラベル: claim_quadratic_representation_unique
# 対象: structured-latex/content/main-text.ts の「二次体の表示の一意性」
# 定数係数とその逆元を消去する
# 式1（本文原文）: \iota(a')+(-\iota(a'))
# 式2（本文原文）: 0
# 帰属: a,b,a',b',alpha,beta は QQ、s は QQbar、iota: QQ -> QQbar。
# 標本: 非同一表示も含む4802組。表示の等号は仮定しない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

_checked = 0
for a,b,ap,bp,s,alpha,beta in _qru_cases(equal_representation=False):
    expr1 = QQbar(ap) + (-QQbar(ap))
    expr2 = QQbar(0)
    assert expr1 == expr2, "check_cancel_constant_coefficient"
    _checked += 1
_qru_report("check_cancel_constant_coefficient", _checked, False)
