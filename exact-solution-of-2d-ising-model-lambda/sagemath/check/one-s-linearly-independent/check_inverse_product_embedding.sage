# 対象ラベル: claim_one_s_linearly_independent
# 対象: structured-latex/content/main-text.ts の「一と s の一次独立性」
# 逆元の積を包含写像の内側へ移す
# 式1（本文原文）: \iota(b^{-1})\cdot\iota(b)
# 式2（本文原文）: \iota(b^{-1}\cdot b)
# 帰属: a,b,r は QQ、s は QQbar、iota: QQ -> QQbar。
# 仮定: s*s=iota(2)、b!=0。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

_checked = 0
for b in _osi_nonzero:
    expr1 = QQbar(b**-1) * QQbar(b)
    expr2 = QQbar(b**-1 * b)
    assert expr1 == expr2, "check_inverse_product_embedding"
    _checked += 1
_osi_report("check_inverse_product_embedding", _checked)

