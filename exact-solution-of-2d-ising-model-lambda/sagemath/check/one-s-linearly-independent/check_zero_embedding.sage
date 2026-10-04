# 対象ラベル: claim_one_s_linearly_independent
# 対象: structured-latex/content/main-text.ts の「一と s の一次独立性」
# 零元を包含写像の像として書く
# 式1（本文原文）: 0
# 式2（本文原文）: \iota(0)
# 帰属: a,b,r は QQ、s は QQbar、iota: QQ -> QQbar。
# 仮定: s*s=iota(2)、b!=0。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

_checked = 0
for _ in [None]:
    expr1 = QQbar.zero()
    expr2 = QQbar(QQ(0))
    assert expr1 == expr2, "check_zero_embedding"
    _checked += 1
_osi_report("check_zero_embedding", _checked)

