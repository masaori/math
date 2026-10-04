# 対象ラベル: claim_one_s_linearly_independent
# 対象: structured-latex/content/main-text.ts の「一と s の一次独立性」
# 零になるという矛盾仮定を代入する
# 式1（本文原文）: (-\iota(a))+\bigl(\iota(a)+\iota(b)\cdot s\bigr)
# 式2（本文原文）: (-\iota(a))+0
# 帰属: a,b,r は QQ、s は QQbar、iota: QQ -> QQbar。
# 仮定: s*s=iota(2)、b!=0。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

# b!=0 と iota(a)+iota(b)*s=0 を同時に満たす数値例はない。
# 矛盾仮定からの代入は Lean の具体版・必要十分版で確認し、数値通過に数えない。
_osi_assumption("check_rearrange_zero_assumption", "hab による移項の代入（rw [hab]）")

