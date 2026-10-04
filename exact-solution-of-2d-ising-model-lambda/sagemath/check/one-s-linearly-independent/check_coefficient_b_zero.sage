# 対象ラベル: claim_one_s_linearly_independent
# 対象: structured-latex/content/main-text.ts の「一と s の一次独立性」
# 証明済みの b の零性を代入する
# 式1（本文原文）: \iota(a)+\iota(0)\cdot s
# 式2（本文原文）: \iota(a)+\iota(b)\cdot s
# 帰属: a,b,r は QQ、s は QQbar、iota: QQ -> QQbar。
# 仮定: s*s=iota(2)、b=0。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

_checked = 0
for a, b, s in _osi_zero_cases():
    expr1 = QQbar(a) + QQbar(0) * s
    expr2 = QQbar(a) + QQbar(b) * s
    assert expr1 == expr2, "check_coefficient_b_zero"
    _checked += 1
_osi_report("check_coefficient_b_zero", _checked)

