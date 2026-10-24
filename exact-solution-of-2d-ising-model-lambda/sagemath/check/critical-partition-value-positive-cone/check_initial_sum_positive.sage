# 対象ラベル: claim_critical_partition_value_mem_positive_cone
# 対象行: S₀∈P_s
# 帰属: ZZ / QQ / QQbar（厳密計算）
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), "_prelude.sage"))
for L, omega, terms, partials in fixtures:
    assert positive(partials[0])
print("RESULT: PASS (initial_sum_positive)")
