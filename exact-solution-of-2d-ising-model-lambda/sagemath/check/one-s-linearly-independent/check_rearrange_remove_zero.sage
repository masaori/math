# 対象ラベル: claim_one_s_linearly_independent
# 対象: structured-latex/content/main-text.ts の「一と s の一次独立性」
# 移項後の零元を除く
# 式1（本文原文）: (-\iota(a))+0
# 式2（本文原文）: -\iota(a)
# 帰属: a,b,r は QQ、s は QQbar、iota: QQ -> QQbar。
# 仮定: s*s=iota(2)、b!=0。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

_checked = 0
for a, b, s, r in _osi_nonzero_cases():
    expr1 = -QQbar(a) + QQbar(0)
    expr2 = -QQbar(a)
    assert expr1 == expr2, "check_rearrange_remove_zero"
    _checked += 1
_osi_report("check_rearrange_remove_zero", _checked)

