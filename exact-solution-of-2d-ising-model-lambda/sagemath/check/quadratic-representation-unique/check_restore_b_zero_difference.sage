# 対象ラベル: claim_quadratic_representation_unique
# 対象: structured-latex/content/main-text.ts の「二次体の表示の一意性」
# 係数 b の復元で係数差が零であることを代入する
# 式1（本文原文）: \beta+b'
# 式2（本文原文）: 0+b'
# 帰属: a,b,a',b',alpha,beta は QQ、s は QQbar、iota: QQ -> QQbar。
# 標本: 表示が等しい98組。等号の仮定と係数差の零性を確認する。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

_checked = 0
for a,b,ap,bp,s,alpha,beta in _qru_cases(equal_representation=True):
    expr1 = beta + bp
    expr2 = QQ(0) + bp
    assert expr1 == expr2, "check_restore_b_zero_difference"
    _checked += 1
_qru_report("check_restore_b_zero_difference", _checked, True)
