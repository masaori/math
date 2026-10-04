# 対象ラベル: claim_one_s_linearly_independent
# 対象: structured-latex/content/main-text.ts の「一と s の一次独立性」
# 移した逆元の積を代入する
# 式1（本文原文）: 1\cdot s
# 式2（本文原文）: \bigl(\iota(b^{-1})\cdot\iota(b)\bigr)\cdot s
# 帰属: a,b,r は QQ、s は QQbar、iota: QQ -> QQbar。
# 仮定: s*s=iota(2)、b!=0。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

_checked = 0
for a, b, s, r in _osi_nonzero_cases():
    expr1 = QQbar(1) * s
    expr2 = (QQbar(b**-1) * QQbar(b)) * s
    assert expr1 == expr2, "check_root_insert_inverse_product"
    _checked += 1
_osi_report("check_root_insert_inverse_product", _checked)

