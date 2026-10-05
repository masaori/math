# 対象ラベル: claim_quadratic_representation_unique
# 対象: structured-latex/content/main-text.ts の「二次体の表示の一意性」
# 表示が等しいという仮定を代入する
# 式1（本文原文）: \bigl(\iota(a)+\iota(b)\cdot s\bigr)+\bigl((-\iota(b'))\cdot s+(-\iota(a'))\bigr)
# 式2（本文原文）: \bigl(\iota(a')+\iota(b')\cdot s\bigr)+\bigl((-\iota(b'))\cdot s+(-\iota(a'))\bigr)
# 帰属: a,b,a',b',alpha,beta は QQ、s は QQbar、iota: QQ -> QQbar。
# 標本: 表示が等しい98組。等号の仮定と係数差の零性を確認する。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

_checked = 0
for a,b,ap,bp,s,alpha,beta in _qru_cases(equal_representation=True):
    expr1 = (QQbar(a) + QQbar(b)*s) + ((-QQbar(bp))*s + (-QQbar(ap)))
    expr2 = (QQbar(ap) + QQbar(bp)*s) + ((-QQbar(bp))*s + (-QQbar(ap)))
    assert expr1 == expr2, "check_substitute_equal_representation"
    _checked += 1
_qru_report("check_substitute_equal_representation", _checked, True)
