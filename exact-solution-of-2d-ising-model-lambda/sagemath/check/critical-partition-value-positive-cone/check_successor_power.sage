# 対象ラベル: claim_critical_partition_value_mem_positive_cone
# 対象行: x_c^{n+1}∈P_s
# 帰属: ZZ / QQ / QQbar（厳密計算）
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), "_prelude.sage"))
for L, omega, terms, partials in fixtures:
    for n in range(len(terms)-1):
        assert positive(xc**(n+1))
print("RESULT: PASS (successor_power)")
