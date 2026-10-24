# 対象ラベル: claim_critical_partition_value_mem_positive_cone
# 対象行: Z_L(x_c)=Σ_{m=0}^{2L²} Ω_L(m)x_c^m
# 帰属: ZZ / QQ / QQbar（厳密計算）
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), "_prelude.sage"))
for L, omega, terms, partials in fixtures:
    poly = partition_polynomial(L)
    for s in (QQbar(2).sqrt(), -QQbar(2).sqrt()):
        assert poly(s-1) == sum((QQbar(omega[m])*(s-1)**m for m in range(len(terms))), QQbar(0))
print("RESULT: PASS (polynomial_evaluation)")
