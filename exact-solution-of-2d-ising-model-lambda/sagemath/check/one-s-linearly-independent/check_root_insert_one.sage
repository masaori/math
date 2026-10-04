# 対象ラベル: claim_one_s_linearly_independent
# 対象: structured-latex/content/main-text.ts の「一と s の一次独立性」
# 根に単位元を掛ける
# 式1（本文原文）: s
# 式2（本文原文）: 1\cdot s
# 帰属: a,b,r は QQ、s は QQbar、iota: QQ -> QQbar。
# 仮定: s*s=iota(2)、b!=0。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

_checked = 0
for a, b, s, r in _osi_nonzero_cases():
    expr1 = s
    expr2 = QQbar(1) * s
    assert expr1 == expr2, "check_root_insert_one"
    _checked += 1
_osi_report("check_root_insert_one", _checked)

