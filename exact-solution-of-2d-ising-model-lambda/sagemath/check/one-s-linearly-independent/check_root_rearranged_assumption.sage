# 対象ラベル: claim_one_s_linearly_independent
# 対象: structured-latex/content/main-text.ts の「一と s の一次独立性」
# 矛盾仮定から得た移項結果を代入する
# 式1（本文原文）: \iota(b^{-1})\cdot\bigl(\iota(b)\cdot s\bigr)
# 式2（本文原文）: \iota(b^{-1})\cdot(-\iota(a))
# 帰属: a,b,r は QQ、s は QQbar、iota: QQ -> QQbar。
# 仮定: s*s=iota(2)、b!=0。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), "_prelude.sage"))

# b!=0 と iota(a)+iota(b)*s=0 を同時に満たす数値例はない。
# 矛盾仮定からの代入は Lean の具体版・必要十分版で確認し、数値通過に数えない。
_osi_assumption("check_root_rearranged_assumption", "hbs による移項結果の代入（rw [hbs]）")

