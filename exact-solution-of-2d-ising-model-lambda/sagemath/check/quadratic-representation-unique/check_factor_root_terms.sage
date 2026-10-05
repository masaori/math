# 対象ラベル: claim_quadratic_representation_unique
# 対象: structured-latex/content/main-text.ts の「二次体の表示の一意性」
# 根を共通因子として取り出す
# 式1（本文原文）: \iota(a')+\Bigl(\bigl(\iota(b')\cdot s+(-\iota(b'))\cdot s\bigr)+(-\iota(a'))\Bigr)
# 式2（本文原文）: \iota(a')+\Bigl(\bigl(\iota(b')+(-\iota(b'))\bigr)\cdot s+(-\iota(a'))\Bigr)
# 帰属: a,b,a',b',alpha,beta は QQ、s は QQbar、iota: QQ -> QQbar。
# 標本: 非同一表示も含む4802組。表示の等号は仮定しない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

_checked = 0
for a,b,ap,bp,s,alpha,beta in _qru_cases(equal_representation=False):
    expr1 = QQbar(ap) + ((QQbar(bp)*s + (-QQbar(bp))*s) + (-QQbar(ap)))
    expr2 = QQbar(ap) + ((QQbar(bp) + (-QQbar(bp)))*s + (-QQbar(ap)))
    assert expr1 == expr2, "check_factor_root_terms"
    _checked += 1
_qru_report("check_factor_root_terms", _checked, False)
