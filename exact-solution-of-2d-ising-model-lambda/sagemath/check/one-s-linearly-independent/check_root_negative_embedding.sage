# 対象ラベル: claim_one_s_linearly_independent
# 対象: structured-latex/content/main-text.ts の「一と s の一次独立性」
# 加法の逆元を包含写像の内側へ移す
# 式1（本文原文）: \iota(b^{-1})\cdot(-\iota(a))
# 式2（本文原文）: \iota(b^{-1})\cdot\iota(-a)
# 帰属: a,b,r は QQ、s は QQbar、iota: QQ -> QQbar。
# 仮定: s*s=iota(2)、b!=0。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

_checked = 0
for a, b, s, r in _osi_nonzero_cases():
    expr1 = QQbar(b**-1) * (-QQbar(a))
    expr2 = QQbar(b**-1) * QQbar(-a)
    assert expr1 == expr2, "check_root_negative_embedding"
    _checked += 1
_osi_report("check_root_negative_embedding", _checked)

