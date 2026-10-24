# 対象ラベル: claim_critical_partition_value_mem_positive_cone
# 対象行: Ω_L(0)x_c⁰∈P_s
# 帰属: ZZ / QQ / QQbar（厳密計算）
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), "_prelude.sage"))
for L, omega, terms, partials in fixtures:
    assert positive(omega[0]*xc**0)
print("RESULT: PASS (initial_term)")
