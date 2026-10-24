# 対象ラベル: claim_critical_partition_value_mem_positive_cone
# 対象行: S₀=Σ_{m=0}⁰ Ω_L(m)x_c^m
# 帰属: ZZ / QQ / QQbar（厳密計算）
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), "_prelude.sage"))
for L, omega, terms, partials in fixtures:
    assert partials[0] == sum((reduced(omega[m]*xc**m) for m in range(1)), R.zero())
print("RESULT: PASS (initial_sum_definition)")
