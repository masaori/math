# 対象ラベル: claim_one_s_linearly_independent
# 対象: structured-latex/content/main-text.ts の「一と s の一次独立性」
# 根の平方の仮定を代入する
# 式1（本文原文）: s\cdot s
# 式2（本文原文）: \iota(2)
# 帰属: a,b,r は QQ、s は QQbar、iota: QQ -> QQbar。
# 仮定: s*s=iota(2)、b!=0。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

_checked = 0
for s in _osi_roots:
    expr1 = s * s
    expr2 = QQbar(2)
    assert expr1 == expr2, "check_square_root_equation"
    _checked += 1
_osi_report("check_square_root_equation", _checked)

