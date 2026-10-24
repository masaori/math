# 対象ラベル: claim_critical_partition_value_mem_positive_cone
# 対象行: Σ_{m=0}^{2L²} Ω_L(m)x_c^m=S_{2L²}
# 帰属: ZZ / QQ / QQbar（厳密計算）
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), "_prelude.sage"))
for L, omega, terms, partials in fixtures:
    assert sum(terms, R.zero()) == partials[2*L*L]
print("RESULT: PASS (final_partial_sum)")
