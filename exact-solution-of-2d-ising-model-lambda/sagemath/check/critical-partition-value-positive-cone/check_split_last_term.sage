# 対象ラベル: claim_critical_partition_value_mem_positive_cone
# 対象行: Σ_{m=0}^{n+1} Ω_L(m)x_c^m=Σ_{m=0}^n Ω_L(m)x_c^m+Ω_L(n+1)x_c^{n+1}
# 帰属: ZZ / QQ / QQbar（厳密計算）
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), "_prelude.sage"))
for L, omega, terms, partials in fixtures:
    for n in range(len(terms)-1):
        assert sum(terms[:n+2], R.zero()) == sum(terms[:n+1], R.zero())+terms[n+1]
print("RESULT: PASS (split_last_term)")
