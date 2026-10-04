# 対象ラベル: claim_one_s_linearly_independent
# 対象: structured-latex/content/main-text.ts の「一と s の一次独立性」
# 有理数の平方を包含写像で移す
# 式1（本文原文）: \iota(r\cdot r)
# 式2（本文原文）: \iota(r)\cdot\iota(r)
# 帰属: a,b,r は QQ、s は QQbar、iota: QQ -> QQbar。
# 仮定: s*s=iota(2)、b!=0。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

_checked = 0
for r in _osi_samples:
    expr1 = QQbar(r * r)
    expr2 = QQbar(r) * QQbar(r)
    assert expr1 == expr2, "check_square_product_embedding"
    _checked += 1
_osi_report("check_square_product_embedding", _checked)

