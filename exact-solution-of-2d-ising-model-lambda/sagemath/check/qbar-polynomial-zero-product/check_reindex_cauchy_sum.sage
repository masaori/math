# 対象ラベル: claim_qbar_polynomial_zero_product
# 対象行: Σ_{i=0}^{m+n} f_i g_{m+n-i}=Σ_{(i,j)∈B} f_i g_j
# 帰属: QQbar[t] / QQbar / ZZ。浮動小数点を使わない。
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
for f, g, m, n, pairs in fixtures:
    bound = m+n
    lhs = sum((f[a]*g[bound-a] for a in range(bound+1)), zero)
    rhs = sum((f[a]*g[b] for a in range(bound+1) for b in range(bound+1) if a+b == bound), zero)
    assert lhs == rhs
print('RESULT: PASS (reindex_cauchy_sum)')
