# 対象ラベル: claim_one_s_linearly_independent
# 対象: structured-latex/content/main-text.ts の「一と s の一次独立性」
# 加法の逆元の和を挿入する
# 式1（本文原文）: 0+\iota(b)\cdot s
# 式2（本文原文）: \bigl((-\iota(a))+\iota(a)\bigr)+\iota(b)\cdot s
# 帰属: a,b,r は QQ、s は QQbar、iota: QQ -> QQbar。
# 仮定: s*s=iota(2)、b!=0。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

_checked = 0
for a, b, s, r in _osi_nonzero_cases():
    expr1 = QQbar(0) + QQbar(b) * s
    expr2 = (-QQbar(a) + QQbar(a)) + QQbar(b) * s
    assert expr1 == expr2, "check_rearrange_insert_additive_inverse"
    _checked += 1
_osi_report("check_rearrange_insert_additive_inverse", _checked)

