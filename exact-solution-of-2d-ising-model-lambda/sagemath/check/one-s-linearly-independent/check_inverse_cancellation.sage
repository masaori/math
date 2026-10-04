# 対象ラベル: claim_one_s_linearly_independent
# 対象: structured-latex/content/main-text.ts の「一と s の一次独立性」
# 有理数の逆元を消去する
# 式1（本文原文）: \iota(b^{-1}\cdot b)
# 式2（本文原文）: \iota(1)
# 帰属: a,b,r は QQ、s は QQbar、iota: QQ -> QQbar。
# 仮定: s*s=iota(2)、b!=0。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

_checked = 0
for b in _osi_nonzero:
    expr1 = QQbar(b**-1 * b)
    expr2 = QQbar(1)
    assert expr1 == expr2, "check_inverse_cancellation"
    _checked += 1
_osi_report("check_inverse_cancellation", _checked)

