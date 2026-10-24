# 対象ラベル: claim_critical_partition_value_mem_positive_cone
# 対象行: S_{n+1}=Σ_{m=0}^{n+1} Ω_L(m)x_c^m
# 帰属: ZZ / QQ / QQbar（厳密計算）
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), "_prelude.sage"))
for L, omega, terms, partials in fixtures:
    for n in range(len(terms)-1):
        assert partials[n+1] == sum((reduced(omega[m]*xc**m) for m in range(n+2)), R.zero())
print("RESULT: PASS (successor_definition)")
